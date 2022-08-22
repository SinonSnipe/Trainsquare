using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Sabio.Models.AppSettings;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Addresses;
using Sabio.Models.Requests.Order;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using Stripe;
using System;
using System.Collections.Generic;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/orders")]
    [ApiController]
    public class OrderApiController : BaseApiController
    {
        private IOrderService _service = null;
        private IOrderItemService _orderItemService = null;
        private ICartItemService _cartItemService = null;
        private ICartService _cartService = null;
        private IPaymentsService _paymentsService = null;
        private IAuthenticationService<int> _authService = null;
        private IAddressService _addressService = null;
        private StripePaymentConfig _stripeKeys;

        public OrderApiController(IOrderService service, IPaymentsService paymentsService, ILogger<CartApiController> logger
        , IOptions<StripePaymentConfig> stripeConfig, ICartService cartService, IOrderItemService orderItemService, ICartItemService cartItemService, IAddressService addressService, IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _orderItemService = orderItemService;
            _cartItemService = cartItemService;
            _paymentsService = paymentsService;
            _cartService = cartService;
            _authService = authService;
            _addressService = addressService;
            _stripeKeys = stripeConfig.Value;


            StripeConfiguration.ApiKey = _stripeKeys.SecretKey;
        }

        [HttpGet]
        public ActionResult<ItemsResponse<Sabio.Models.Domain.Order>> GetAll()
        {
            int code = 200;
            BaseResponse response = null;

            int userId = _authService.GetCurrentUserId();

            try
            {
                List<Sabio.Models.Domain.Order> list = _service.GetAllByUserId(userId);

                if (list == null)
                {
                    code = 404;
                    response = new ErrorResponse("App Resource not found.");
                }
                else
                {
                    response = new ItemsResponse<Sabio.Models.Domain.Order> { Items = list };
                }
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
                base.Logger.LogError(ex.ToString());
            }


            return StatusCode(code, response);

        }
        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<OrderDetails>> Get(int id)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                OrderDetails order = _service.GetByIdV2(id);

                if (order == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application Resource not found.");
                }
                else
                {
                    response = new ItemResponse<OrderDetails> { Item = order };
                }
            }
            catch (Exception ex)
            {

                iCode = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: {ex.Message}");
            }

            return StatusCode(iCode, response);

        }

        [HttpPut("{sessionId}")]
        public ActionResult<SuccessResponse> Update(string sessionId)
        {
            int code = 200;
            BaseResponse response = null;

            int userId = _authService.GetCurrentUserId();

            Stripe.Checkout.Session session = _paymentsService.getSession(sessionId);

            Sabio.Models.Domain.Order order = _service.GetByChargeId(session.ClientReferenceId);

            OrderUpdateRequest orderUpdateRequest = new OrderUpdateRequest()
            {
                Id = order.Id,
                PaymentStatusId = order.PaymentStatusId,
                Total = order.Total,
                ChargeId = order.ChargeId
            };

            if (session.PaymentStatus == "paid")
            {
                int addressId = 0;

                if (session.CustomerDetails != null)
                {
                    AddressAddRequest newAddress = new AddressAddRequest()
                    {
                        AddressLine1 = session.CustomerDetails.Address.Line1,
                        AddressLine2 = session.CustomerDetails.Address.Line2,
                        City = session.CustomerDetails.Address.City,
                        Country = session.CustomerDetails.Address.Country,
                        State = session.CustomerDetails.Address.State,
                        PostalCode = session.CustomerDetails.Address.PostalCode,
                    };

                    addressId = _addressService.Add(newAddress);
                }

                orderUpdateRequest.TrackingCode = order.TrackingCode;
                orderUpdateRequest.TrackingUrl = order.TrackingUrl;
                orderUpdateRequest.ShippingAddressId = order.ShippingAddressId;
                orderUpdateRequest.BillingAddressId = addressId;
                orderUpdateRequest.PaymentMethod = session.PaymentMethodTypes[0];
                orderUpdateRequest.PhoneNumber = session.CustomerDetails.Phone;
                orderUpdateRequest.SessionId = session.Id;

                BaseCart baseCart = _cartService.GetBaseCartByUserId(userId);
                _cartItemService.DeleteByCartId(baseCart.Id);

                orderUpdateRequest.PaymentStatusId = 2;

            }
            if (session.PaymentStatus != "paid")
            {
                orderUpdateRequest.PaymentStatusId = 3;
            }

            try
            {
                _service.Update(orderUpdateRequest, userId);
                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);
        }


    }
}
