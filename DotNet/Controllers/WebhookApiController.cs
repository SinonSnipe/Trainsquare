using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using Stripe;
using System;
using System.IO;
using System.Threading.Tasks;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/webhook")]
    [ApiController]
    public class WebhookApiController : BaseApiController
    {
        private IAuthenticationService<int> _authService = null;

        public WebhookApiController(IAuthenticationService<int> authService
        , ILogger<WebhookApiController> logger) : base(logger)
        {
            _authService = authService;
            StripeConfiguration.ApiKey = "sk_test_51KjutoLZfwOj2LUsWSmnLcvHdHTY1E64Qm7ZEbuQEyRv14IWPI2OYVMGrp1RcqPg7QSuoyoJ6KTJShZkBj9kRUOW00V2m2U3wN";
        }


        const string endpointSecret = "whsec_4bc0b00704aa5dd6fdeafb6f5afc461e7b61db32937a69e1ac3ebbdad7790a8e";

        [HttpPost]
        public async Task<IActionResult> Index()
        {
            int code = 200;
            BaseResponse response = null;

            var json = await new StreamReader(HttpContext.Request.Body).ReadToEndAsync();
            try
            {
                var stripeEvent = EventUtility.ParseEvent(json);

                if (stripeEvent.Type == Events.PaymentIntentSucceeded)
                {
                    var paymentIntent = stripeEvent.Data.Object as PaymentIntent;
                    Console.WriteLine("A successful payment for {0} was made.", paymentIntent.Amount);
                    // Then define and call a method to handle the successful payment intent.
                    // handlePaymentIntentSucceeded(paymentIntent);
                }
                else if (stripeEvent.Type == Events.PaymentMethodAttached)
                {
                    var paymentMethod = stripeEvent.Data.Object as PaymentMethod;
                    // Then define and call a method to handle the successful attachment of a PaymentMethod.
                    // handlePaymentMethodAttached(paymentMethod);
                }
                else
                {
                    Console.WriteLine("Unhandled event type: {0}", stripeEvent.Type);
                }
                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);
        }
    }
}

