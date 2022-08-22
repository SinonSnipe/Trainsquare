using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models.Domain;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using Twilio.Types;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/sms")]
    [ApiController]
    public class SmsApiController : BaseApiController
    {
        private ISmsService _smsSerivce = null;
        private IAuthenticationService<int> _authService = null;

        public SmsApiController(ISmsService smsSerivce      
            , ILogger<SmsApiController> logger
            , IAuthenticationService<int> authService) : base(logger)
        {
            _smsSerivce = smsSerivce;
            _authService = authService;
        }               


        [HttpPost("sending")]
        public ActionResult<ItemResponse<int>> Create()
        {
            ObjectResult result = null;

            try
            {                
                
                int userId = _authService.GetCurrentUserId();
                
                string code = _smsSerivce.GenerateRandomNumber();
                int id = _smsSerivce.Add(userId, code);

                _smsSerivce.TestSendSms(code);


                ItemResponse<int> response = new ItemResponse<int>() { Item = id };

                result = Created201(response);
            }
            catch (Exception ex)
            {

                base.Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);

                result = StatusCode(500, response);
            }

            return result;
        }

        [HttpGet("current")]
        public ActionResult<ItemResponse<TwoFactorAuthentication>> GetById()
        {

            int iCode = 200;
            BaseResponse response = null;

            try
            {
                int user = _authService.GetCurrentUserId();
                TwoFactorAuthentication tfa = _smsSerivce.GetById(user);

                if (tfa == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Records Not Found");
                }
                else
                {
                    response = new ItemResponse<TwoFactorAuthentication> { Item = tfa };
                }
            }

            catch (Exception ex)
            {
                iCode = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Errors: {ex.Message}");
            }

            return StatusCode(iCode, response);
        }

    }


}
