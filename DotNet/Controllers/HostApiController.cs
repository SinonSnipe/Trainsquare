using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Domain.WorkShopRequest;
using Sabio.Services;
using Sabio.Services.Interfaces;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/HostDash")]
    [ApiController]
    public class HostApiController : BaseApiController
    {
        private IAuthenticationService<int> _authService;
        private IHostService _service = null;
        public HostApiController(IHostService service,
            IAuthenticationService<int> authService,
            ILogger<HostApiController> logger) : base(logger)
        {
            _service = service;
            _authService = authService;
        }
        
        [HttpGet("workshops")]
        public ActionResult<ItemsResponse<HostWorkShop>> GetWorkshops()
        {
            int code = 200;
            BaseResponse response = null;//do not declare an instance.

            try
            {
                int HostId = _authService.GetCurrentUserId();
                List<HostWorkShop> list = _service.GetWorkshops(HostId);

                if (list == null || list.Count == 0)
                {
                    code = 404;
                    response = new ErrorResponse("No Workshop Requests found.");
                }
                else
                {
                    response = new ItemsResponse<HostWorkShop> { Items = list };
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

        [HttpGet("sessions")]
        public ActionResult<ItemResponse<Paged<HostSession>>> GetSessions(int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                int HostId = _authService.GetCurrentUserId();
                Paged<HostSession> page = _service.GetSessions(HostId, pageIndex, pageSize);

                if (page == null)
                {
                    code = 404;
                    response = new ErrorResponse("No sessions found.");
                }
                else
                {
                    response = new ItemResponse<Paged<HostSession>> { Item = page };
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

        [HttpGet]
        public ActionResult<ItemResponse<HostProfile>> Get(int hostId)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                int HostId = _authService.GetCurrentUserId();
                HostProfile profile = _service.GetProfile(HostId);

                if (profile == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Bing Bong Nothing Here!");
                }
                else
                {
                    response = new ItemResponse<HostProfile> { Item = profile };
                }
            }
            catch (Exception ex)
            {

                iCode = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: {ex.Message}");
            }

            return StatusCode(iCode, response);

        }
        [HttpGet("requests")]
        public ActionResult<ItemsResponse<HostWorkshopRequests>> GetWorkshopRequests()
        {
            int code = 200;
            BaseResponse response = null;//do not declare an instance.

            try
            {
                int HostId = _authService.GetCurrentUserId();
                List <HostWorkshopRequests> list = _service.GetWorkshopRequests(HostId);

                if (list == null || list.Count == 0)
                {
                    code = 404;
                    response = new ErrorResponse("No Workshop Requests found.");
                }
                else
                {
                    response = new ItemsResponse<HostWorkshopRequests> { Items = list };
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

    }
}

