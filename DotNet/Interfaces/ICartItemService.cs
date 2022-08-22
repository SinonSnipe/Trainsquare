using Sabio.Models.Domain;
using Sabio.Models.Requests.Cart;
using System.Collections.Generic;

namespace Sabio.Services
{
    public interface ICartItemService
    {
        void UpdateCartItem(CartItemUpdateRequest cartItem);
        void DeleteById(int id);
        void DeleteByCartId(int cartId);
        int Add(CartItemAddRequest model);
        void AddCartItems(List<CartItemAddRequest> cartItems);
        List<BaseCartItem> GetBaseCartItemsByCartId(int cartId);
        List<CartItem> GetCartItemsByCartId(int cartId);
        List<Product> GetCartItemsByCartIdV3(int cartId);
    }
}
