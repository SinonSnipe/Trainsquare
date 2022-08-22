using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models.Domain;
using Sabio.Services;
using Sabio.Services.Interfaces;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/WorkshopRequests")]
    [ApiController]
    public class WorkshopRequestsApiController : BaseApiController
    {
        private IPrivateBookingService _service = null;
        private IAuthenticationService<int> _authService = null;
        public WorkshopRequestsApiController(IPrivateBookingService service
            , ILogger<WorkshopRequestsApiController> logger
            , IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _authService = authService;
        }

        [HttpGet("{userId:int}")]
        public ActionResult<ItemResponse<WorkshopRequests>> GetByUserId(int userId)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                WorkshopRequests workshopRequests = _service.GetByUserId(userId);               

                if (workshopRequests == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application Resource Not Found!");
                }
                else
                {
                    response = new ItemResponse<WorkshopRequests> { Item = workshopRequests };
                }
            }
            catch (Exception ex)
            {
                iCode = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"SqlException Error: ${ex.Message}");
            }

            return StatusCode(iCode, response);
        }
    }
}
