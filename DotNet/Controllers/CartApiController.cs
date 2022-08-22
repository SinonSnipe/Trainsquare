using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models.Domain;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/carts")]
    [ApiController]
    public class CartApiController : BaseApiController
    {
        private ICartService _service = null;
        private ICartItemService _cartItemService = null;
        private IAuthenticationService<int> _authService = null;

        public CartApiController(ICartService service
            , ICartItemService cartItemService
        , ILogger<CartApiController> logger
        , IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _cartItemService = cartItemService;
            _authService = authService;
        }


        [HttpGet("my-cart")]
        public ActionResult<ItemsResponse<CartItem>> GetByCustomerId()
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                int userId = _authService.GetCurrentUserId();

                BaseCart cart = _service.GetBaseCartByUserId(userId);

                if (cart == null)
                {
                    code = 404;
                    response = new ErrorResponse("User has no cart");
                }
                else
                {
                    List<CartItem> cartItems = _cartItemService.GetCartItemsByCartId(cart.Id);
                    response = new ItemsResponse<CartItem> { Items = cartItems };
                }
            }
            catch (Exception ex)
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Error: {ex.Message}");
            }

            return StatusCode(code, response);

        }

    }
}
