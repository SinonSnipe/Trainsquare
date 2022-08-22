using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Sabio.Models.AppSettings;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Stripe;
using Sabio.Services.Interfaces;
using Stripe;
using Stripe.Checkout;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class PaymentService : IPaymentsService
    {
        public Stripe.Checkout.Session NewSession(List<Models.Domain.Product> products, int orderId, string chargeId, StripePaymentConfig keys)
        {

            var lineItems = AddLineItems(products);

            string transferGroupString = "order_" + orderId.ToString();

            var options = new SessionCreateOptions
            {
                LineItems = lineItems,
                Mode = "payment",
                SuccessUrl = keys.SuccessDomain + "?session_id={CHECKOUT_SESSION_ID}" + "&orderId=" + orderId,
                CancelUrl = keys.ErrorDomain + "?session_id={CHECKOUT_SESSION_ID}" + "&orderId=" + orderId,
                ClientReferenceId = chargeId,
                BillingAddressCollection = "required",
                PhoneNumberCollection = new SessionPhoneNumberCollectionOptions()
                {
                    Enabled = true,
                },
                PaymentIntentData = new SessionPaymentIntentDataOptions()
                {
                    TransferGroup = transferGroupString
                }
            };

            var service = new Stripe.Checkout.SessionService();
            Stripe.Checkout.Session session = service.Create(options);

            CreateTransfers(products, transferGroupString);

            return session;
        }

        public Stripe.Checkout.Session getSession(string sessionId)
        {
            Stripe.Checkout.Session session = null;

            var service = new Stripe.Checkout.SessionService();

            session = service.Get(sessionId);

            StripeList<LineItem> lineItems = service.ListLineItems(sessionId);

            session.LineItems = lineItems;

            return session;
        }

        public Stripe.Account NewAccount()
        {

            var accountOptions = new AccountCreateOptions { Type = "express" };
            var accountService = new AccountService();

            Stripe.Account account = accountService.Create(accountOptions);

            return account;
        }
        public Stripe.Account GetAccount(string accountId)
        {

            var accountOptions = new AccountCreateOptions { Type = "express" };
            var accountService = new AccountService();

            Stripe.Account account = accountService.Get(accountId);

            return account;
        }
        public Stripe.AccountLink NewAccountLink(AccountLinkCreateRequest accountData)
        {

            var accountLinkOptions = new AccountLinkCreateOptions
            {
                Account = accountData.AccountId,
                RefreshUrl = Convert.ToString(accountData.RefreshUrl),
                ReturnUrl = Convert.ToString(accountData.ReturnUrl),
                Type = "account_onboarding",
            };

            var accountLinkService = new AccountLinkService();
            Stripe.AccountLink accountLink = accountLinkService.Create(accountLinkOptions);


            return accountLink;
        }
        private static List<SessionLineItemOptions> AddLineItems(List<Models.Domain.Product> products)
        {
            var lineItems = new List<SessionLineItemOptions>();

            products.ForEach(product =>
            {

                var newLineItem = new SessionLineItemOptions
                {

                    PriceData = new SessionLineItemPriceDataOptions
                    {
                        Currency = "USD",
                        UnitAmountDecimal = product.CartItem.BasePrice * 100,
                        ProductData = new SessionLineItemPriceDataProductDataOptions
                        {
                            Name = product.CartItem.Name,
                            Images = new List<string>
                            {
                                product.CartItem.ImageUrl
                            },
                            Description = product.CartItem.Summary

                        }
                    },
                    Quantity = product.CartItem.Quantity,

                };

                lineItems.Add(newLineItem);

            });

            return lineItems;
        }
        private static void CreateTransfers(List<Models.Domain.Product> products, string transferGroupString)
        {
            products.ForEach(product =>
            {
                int totalPrice = Convert.ToInt32(product.CartItem.BasePrice * product.CartItem.Quantity * 100);
                int fee = Convert.ToInt32(totalPrice * 5 / 100);

                int amount = totalPrice - fee;

                var transferOptions = new TransferCreateOptions
                {
                    Amount = amount,
                    Currency = "usd",
                    Destination = product.AccountId,
                    TransferGroup = transferGroupString,
                    Description = product.CartItem.Name + " x " + product.CartItem.Quantity
                };

                var transferService = new TransferService();
                var transfer = transferService.Create(transferOptions);

            });
        }
    }
}








