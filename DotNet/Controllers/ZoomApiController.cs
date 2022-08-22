using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Sabio.Models.AppSettings;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Zoom;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/zoom")]
    [ApiController]
    public class ZoomApiController : BaseApiController
    {
        private IZoomService _service = null;
        private IAuthenticationService<int> _authService = null;
        private ZoomTokenConfig _zoomKeys;
   
        public ZoomApiController(IOptions<ZoomTokenConfig> zoomKeys,IZoomService service, ILogger<ZoomApiController> logger,
            IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _authService = authService;
            _zoomKeys = zoomKeys.Value;
 

        }
        [HttpPost("request")]
        public ActionResult<ItemResponse<ZoomMeeting>> Create(ZoomAddRequest payload)
        {
            int iCode = 201;
            BaseResponse response;
            try
            {
               ZoomMeeting meeting = _service.CreateMeeting(_zoomKeys, payload);
               
                if (meeting == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("App resources not found.");
                }
                else
                {
                    response = new ItemResponse<ZoomMeeting> { Item = meeting };
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

        [HttpPost("token")]
        public ActionResult<ItemResponse<string>> GetZoomToken(ZoomSdkRequest payload)
        {
            int iCode = 201;
            BaseResponse response;
            try
            {
                string zoomSdkToken = _service.GenerateZoomSdkToken(_zoomKeys, payload);

                if (zoomSdkToken == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("App resources not found.");
                }
                else
                {
                    response = new ItemResponse<string> { Item = zoomSdkToken };
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
    }
}
