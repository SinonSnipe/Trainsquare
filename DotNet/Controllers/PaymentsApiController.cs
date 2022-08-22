
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Sabio.Services;
using Stripe;
using Sabio.Web.Controllers;
using Stripe.Checkout;
using System.Collections.Generic;
using Sabio.Web.Models.Responses;
using System;
using Sabio.Models.AppSettings;
using Microsoft.Extensions.Options;
using Sabio.Services.Interfaces;
using Sabio.Models.Requests.Stripe;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Order;
using Sabio.Models.Requests.OrderItem;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/payments")]
    [ApiController]
    public class PaymentsApiController : BaseApiController
    {
        private IAuthenticationService<int> _authService = null;
        private IPaymentsService _service = null;
        private ICartService _cartService = null;
        private ICartItemService _cartItemService = null;
        private IOrderService _orderService = null;
        private IOrderItemService _orderItemService = null;
        private StripePaymentConfig _stripeKeys;

        public PaymentsApiController(IAuthenticationService<int> authService, IPaymentsService service, ICartItemService cartItemService
        , IOptions<StripePaymentConfig> stripeConfig, ICartService cartService, IOrderService orderService, IOrderItemService orderItemService, ILogger<PaymentsApiController> logger) : base(logger)
        {
            _service = service;
            _cartItemService = cartItemService;
            _authService = authService;
            _stripeKeys = stripeConfig.Value;
            _cartService = cartService;
            _orderService = orderService;
            _orderItemService = orderItemService;

            StripeConfiguration.ApiKey = _stripeKeys.SecretKey;
        }

        #region CreateCheckoutSession
        [HttpPost("session")]
        public ActionResult<ItemResponse<Stripe.Checkout.Session>> CreateSession()
        {

            ObjectResult result = null;

            try
            {

                int userId = _authService.GetCurrentUserId();

                BaseCart cart = _cartService.GetBaseCartByUserId(userId);

                if (cart == null)
                {
                    ErrorResponse response = new ErrorResponse("User has no cart");

                    result = StatusCode(404, response);

                }
                else
                {
                   List<Sabio.Models.Domain.Product> products = _cartItemService.GetCartItemsByCartIdV3(cart.Id);

                    try
                    {

                        decimal total = GetTotal(products);

                        Guid guid = Guid.NewGuid();
                        string chargeId = "charge_" + guid.ToString();

                        OrderAddRequest orderAddRequest = new OrderAddRequest()
                        {
                            PaymentStatusId = 1,
                            Total = total,
                            ChargeId = chargeId,
                        };

                        int newOrderId = _orderService.Add(orderAddRequest, userId);

                        List<OrderItemAddRequest> newOrderItems = GetOrderItems(products, newOrderId);

                        _orderItemService.AddOrderItems(newOrderItems, userId);

                        // TO DO: UPDATE INVENTORY

                        Stripe.Checkout.Session session = _service.NewSession(products, newOrderId, chargeId, _stripeKeys);

                        if (session == null)
                        {
                            ErrorResponse response = new ErrorResponse("Error creating a checkout session");

                            result = StatusCode(404, response);
                        }
                        else
                        {
                            ItemResponse<Stripe.Checkout.Session> response = new ItemResponse<Stripe.Checkout.Session>() { Item = session };
                            result = StatusCode(201, response);
                        }
                    }
                    catch (Exception ex)
                    {
                        Logger.LogError(ex.ToString());
                        ErrorResponse response = new ErrorResponse(ex.Message);

                        result = StatusCode(500, response);
                    }
                }

            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);

                result = StatusCode(500, response);
            }

            return result;

        }

        [HttpGet("session/{sessionId}")]
        public ActionResult<ItemResponse<Stripe.Checkout.Session>> Get(string sessionId)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                Stripe.Checkout.Session session = _service.getSession(sessionId);

                if (session == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application Resource not found.");
                }
                else
                {
                    response = new ItemResponse<Stripe.Checkout.Session> { Item = session };
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

        private static List<OrderItemAddRequest> GetOrderItems(List<Sabio.Models.Domain.Product> products, int newOrderId)
        {
            List<OrderItemAddRequest> orderItems = new List<OrderItemAddRequest>();

            products.ForEach(p =>
            {

                OrderItemAddRequest orderItemAddRequest = new OrderItemAddRequest()
                {
                    OrderId = newOrderId,
                    InventoryId = p.CartItem.InventoryId,
                    Quantity = p.CartItem.Quantity,
                };

                orderItems.Add(orderItemAddRequest);

            }
            );

            return orderItems;
        }

        private static decimal GetTotal(List<Sabio.Models.Domain.Product> products)
        {
            decimal total = 0;

            products.ForEach(p =>
            {
                total += p.CartItem.BasePrice * p.CartItem.Quantity;
            });

            return total;
        }
        #endregion

        #region CreateAccount
        [HttpPost("account")]
        public ActionResult<ItemResponse<Account>> CreateAccount()
        {

            ObjectResult result = null;

            try
            {
                Account account = _service.NewAccount();

                if (account == null)
                {
                    ErrorResponse response = new ErrorResponse("Account not found");

                    result = StatusCode(404, response);
                }
                else
                {
                    ItemResponse<Account> response = new ItemResponse<Account>() { Item = account };
                    result = StatusCode(201, response);
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);

                result = StatusCode(500, response);
            }

            return result;
        }
        #endregion

        #region GetAccount
        [HttpGet("account/{accountId}")]
        public ActionResult<ItemResponse<Account>> GetAccount(string accountId)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                Account account = _service.GetAccount(accountId);

                if (account == null)
                {
                    code = 404;

                    response = new ErrorResponse("resource not found");
                }
                else
                {
                    response = new ItemResponse<Account>() { Item = account };
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                code = 500;
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);
        }
        #endregion

        #region CreateAccountLink
        [HttpPost("account-link")]
        public ActionResult<ItemResponse<AccountLink>> CreateAccountLink(AccountLinkCreateRequest accountData)
        {

            ObjectResult result = null;

            try
            {
                AccountLink accountLink = _service.NewAccountLink(accountData);

                if (accountLink == null)
                {
                    ErrorResponse response = new ErrorResponse("Account link not created");

                    result = StatusCode(404, response);
                }
                else
                {
                    ItemResponse<AccountLink> response = new ItemResponse<AccountLink>() { Item = accountLink };
                    result = StatusCode(201, response);

                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);

                result = StatusCode(500, response);
            }

            return result;
        }
        #endregion

    }
}











