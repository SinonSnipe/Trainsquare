using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Cart;
using Sabio.Services;
using Sabio.Services.Interfaces;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/cart-items")]
    [ApiController]
    public class CartItemApiController : BaseApiController
    {
        private ICartItemService _service = null;
        private ICartService _cartService = null;
        private IInventoryService _inventoryService = null;
        private IAuthenticationService<int> _authService = null;

        public CartItemApiController(ICartItemService service, ICartService cartService, IInventoryService inventoryService
        , ILogger<CartApiController> logger
        , IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _authService = authService;
            _inventoryService = inventoryService;
            _cartService = cartService;
        }

        [HttpPut("{id:int}")]
        public ActionResult<SuccessResponse> Update(CartItemUpdateRequest model)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                _service.UpdateCartItem(model);
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

        [HttpDelete("{id:int}")]
        public ActionResult<SuccessResponse> Delete(int id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                _service.DeleteById(id);
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

        [HttpPost("add")]
        public ActionResult<ItemResponse<int>> Create(CartItemAddRequest model)
        {

            ObjectResult result = null;
            int userId = _authService.GetCurrentUserId();

            try
            {

                Inventory inventory = _inventoryService.Get(model.InventoryId);

                if (inventory != null && inventory.Quantity >= model.Quantity)
                {

                    int newCartItemId = 0;

                    BaseCart cart = _cartService.GetBaseCartByUserId(userId);

                    if (cart == null)
                    {
                        int newCartId = _cartService.Add(userId);
                        model.CartId = newCartId;
                    }

                    if (cart != null)
                    {
                        model.CartId = cart.Id;

                        List<BaseCartItem> cartItems = _service.GetBaseCartItemsByCartId(cart.Id);

                        BaseCartItem cartItem = null;

                        if (cartItems != null && cartItems.Count > 0)
                        {

                           cartItem = cartItems.Find(item => item.InventoryId == model.InventoryId);

                        }

                        if (cartItem != null)
                        {
                            CartItemUpdateRequest cartItemUpdateRequest = new CartItemUpdateRequest()
                            {
                                Id = cartItem.Id,
                                InventoryId = cartItem.InventoryId,
                                CartId = cartItem.CartId,
                                Quantity = cartItem.Quantity + model.Quantity,
                            };

                            if (cartItemUpdateRequest.Quantity <= inventory.Quantity)
                            {

                                _service.UpdateCartItem(cartItemUpdateRequest);
                                result = StatusCode(200, new SuccessResponse());

                            }
                            else
                            {

                                result = StatusCode(400, new ErrorResponse("Not enough stock"));

                            }
                        }
                    }

                    if (result == null)
                    {
                        newCartItemId = _service.Add(model);
                        ItemResponse<int> response = new ItemResponse<int>() { Item = newCartItemId };
                        result = Created201(response);
                    }

                }
                else
                {
                    ErrorResponse response = new ErrorResponse("Not enough stock");
                    result = StatusCode(400, response);
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

    }
}
