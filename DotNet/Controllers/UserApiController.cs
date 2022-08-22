using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Enums;
using Sabio.Models.Requests;
using Sabio.Models.Requests.Users;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Threading.Tasks;


namespace Sabio.Web.Api.Controllers
{
    [Route("api/users")]
    [ApiController]
    public class UserApiController : BaseApiController
    {
        private IUserService _service = null;
        private IAuthenticationService<int> _authService = null;
        private IEmailService _emailService = null;
        private ISmsService _smsService = null;
        public UserApiController(IUserService service,
            ISmsService smsService,
            ILogger<UserApiController> logger,
            IAuthenticationService<int> authService,
            IEmailService emailService) : base(logger)
        {
            _service = service;
            _authService = authService;
            _emailService = emailService;
            _smsService = smsService;
        }

        [HttpPost("register")]
        [AllowAnonymous]
        public ActionResult<ItemResponse<int>> Create(UserAddRequest model)
        {

            ObjectResult result = null;

            try
            {
                int id = _service.Create(model);

                if (id > 0)
                {
                    string token = Guid.NewGuid().ToString();
                    int tokenType = (int)TokenType.NewUser;

                    _service.InsertToken(token, id, tokenType);

                    _emailService.SendRegistrationConfirmation(model.Email, token);

                    ItemResponse<int> response = new ItemResponse<int>() { Item = id };

                    result = Created201(response);
                }
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);
                result = StatusCode(500, response);
            }

            return result;
        }

        [HttpPost("login")]
        [AllowAnonymous]
        public ActionResult<SuccessResponse> LoginAsync(LoginRequest model)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                bool isUser = _service.LogInAsync(model.Email, model.Password).Result;

                if (isUser)
                {
                    response = new SuccessResponse();
                }
                else
                {
                    code = 404;
                    response = new ErrorResponse("Invalid Credentials");
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

        [HttpGet("current")]
        public ActionResult<ItemResponse<IUserAuthData>> GetCurrrent()
        {
            IUserAuthData user = _authService.GetCurrentUser();
            ItemResponse<IUserAuthData> response = new ItemResponse<IUserAuthData>();
            response.Item = user;

            return Ok200(response);
        }

        [HttpGet("logout")]
        public async Task<ActionResult<SuccessResponse>> LogoutAsync()
        {
            int user = _authService.GetCurrentUserId();
            await _authService.LogOutAsync();
            _smsService.Delete(user);
            SuccessResponse response = new SuccessResponse();
            return Ok200(response);
        }

        [HttpPut("{token}")]
        [AllowAnonymous]
        public ActionResult<ItemResponse<SuccessResponse>> VerifyNewUserToken(string token)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                _service.ConfirmNewUserToken(token);

                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);
        }

        [HttpPut("forgotpassword")]
        [AllowAnonymous]
        public ActionResult<SuccessResponse> forgotPassword(ForgotPasswordRequest model)
        {
            int iCode = 200;
            BaseResponse response = null;
            int userId = 0;

            try
            {
                userId = _service.GetUserIdByEmail(model.Email);

                if (userId > 0)
                {
                    string token = Guid.NewGuid().ToString();
                    int tokenType = (int)TokenType.ResetPassword;

                    _service.InsertToken(token, userId, tokenType);

                    _emailService.SendPasswordResetEmail(model.Email, token);

                    response = new SuccessResponse();
                }
                else
                {
                    iCode = 404;
                    response = new ErrorResponse("User account with this email not found.");
                }
            }
            catch (Exception ex)
            {
                iCode = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: ${ ex.Message }");
            }

            return StatusCode(iCode, response);
        }

        [HttpPut("resetpassword/{token}")]
        [AllowAnonymous]
        public ActionResult<SuccessResponse> verifyResetPasswordToken(UserResetPasswordRequest model, string token)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {

                int userId = _service.ConfirmResetPasswordToken(token);

                if (userId != 0)
                {
                    int Id = _service.ResetPassword(model, userId);


                    if (Id != 0)
                    {
                        response = new SuccessResponse();
                    }
                    else
                    {
                        iCode = 404;
                        response = new ErrorResponse("Password could not be reset");
                    }

                }
                else
                {
                    iCode = 404;
                    response = new ErrorResponse("Could not locate UserId with this token");
                }

            }
            catch (Exception ex)
            {
                iCode = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: ${ ex.Message }");
            }

            return StatusCode(iCode, response);
        }

        [HttpGet]
        public ActionResult<ItemResponse<Paged<UserBase>>> GetAll(int pageIndex, int pageSize)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                Paged<UserBase> paged = _service.GetAll(pageIndex, pageSize);
                if (paged == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application resource not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<UserBase>> { Item = paged };
                }
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);
                iCode = 500;
            }

            return StatusCode(iCode, response);
        }


        [HttpPut("changepassword")]
        [AllowAnonymous]
        public ActionResult<SuccessResponse> ChangePasswordForLoggedIn(UserPasswordChangeRequest model)
        {
            int iCode = 200;
            BaseResponse response = null;
            int userId = 0;

            try
            {

                userId = _authService.GetCurrentUserId();

                bool hasUpdated = _service.ChangePasswordTaxi(model, userId);
                if (hasUpdated)
                {
                    response = new SuccessResponse();
                }
                else
                {
                    response = new ErrorResponse("Password and Confirm Password do not match.");
                }
            }

            catch (Exception ex)
            {
                iCode = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: ${ ex.Message }");
            }
            return StatusCode(iCode, response);
        }




    }
}
