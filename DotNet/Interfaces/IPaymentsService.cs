using Sabio.Models.AppSettings;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Stripe;
using Stripe;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public interface IPaymentsService
    {
        Stripe.Checkout.Session NewSession(List<Models.Domain.Product> cartItems, int orderID, string chargeId, StripePaymentConfig keys);
        public Stripe.Checkout.Session getSession(string sessionId);
        Stripe.Account NewAccount();
        Stripe.AccountLink NewAccountLink(AccountLinkCreateRequest accountData);
        Stripe.Account GetAccount(string accountId);
    }
}
