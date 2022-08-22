using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using Sabio.Services;
using Sabio.Services.Interfaces;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/userprofiles")]
    [ApiController]
    public class UserProfileApiController : BaseApiController
    {
        private IUserProfileService _service = null;
        private IAuthenticationService<int> _authService = null;
   
        public UserProfileApiController(IUserProfileService service,
            ILogger<PingApiController> logger,
            IAuthenticationService<int> authService) : base(logger)    
        {
            _service = service;
            _authService = authService;
        }

        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<UserProfile>> GetByUserId (int id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                UserProfile profile = _service.GetProfileByUserId(id);

                if (profile == null)
                {
                    code = 404;
                    response = new ErrorResponse("The application is not found.");
                }
                else
                {
                    response = new ItemResponse<UserProfile> { Item = profile };
                }
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }

        [HttpPut("{id:int}")]
        public ActionResult<SuccessResponse> Update(UserProfileUpdateRequest model)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {

                _service.Update(model);

                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);
        }

        [HttpGet("profile/{id:int}")]
        public ActionResult<ItemResponse<UserProfile>> GetProfileById(int id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                UserProfile profile = _service.GetProfileById(id);

                if (profile == null)
                {
                    code = 404;
                    response = new ErrorResponse("Application Resource not found.");
                }
                else
                {
                    response = new ItemResponse<UserProfile> { Item = profile };
                }
            }
            catch (Exception ex)
            {

                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: {ex.Message}");
            }

            return StatusCode(code, response);

        }
    }
}
