using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Venues;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/venueLocation")]
    [ApiController]
    public class VenueLocationController : BaseApiController
    {
        private IVenueLocationService _service = null;
        private IAuthenticationService<int> _authService = null;

        public VenueLocationController(IVenueLocationService service, ILogger<VenueLocationController> logger,
            IAuthenticationService<int> authService):base(logger)
        {
            _service = service;
            _authService = authService;
        }



        [HttpPost]
        public ActionResult<ItemResponse<int>> Create(VenueLocationAddRequest model)
        {
            ObjectResult result = null;


            try
            {
                int userId = _authService.GetCurrentUserId();

                int id = _service.Add(model, userId);

                ItemResponse<int> response = new ItemResponse<int>() { Item = id };

                result = Created201(response);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);
                result = StatusCode(500, response);
            }
            return result;

        }


        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<VenueLocation>> Get(int id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                VenueLocation venue = _service.Get(id);

                if (venue == null)
                {
                    code = 404;
                    response = new ErrorResponse("Venue not Found.");

                }
                else
                {
                    response = new ItemResponse<VenueLocation> { Item = venue };
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

        [HttpGet("paginate")]
        public ActionResult<ItemResponse<Paged<VenueLocation>>> GetAll(int pageindex, int pagesize)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<VenueLocation> paged = _service.GetAll(pageindex, pagesize);

                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("record not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<VenueLocation>> { Item = paged };
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

        [HttpGet("createdBy")]
        public ActionResult<ItemResponse<Paged<VenueLocation>>> CreatedBy(int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                int userId = _authService.GetCurrentUserId();
                Paged<VenueLocation> page = _service.CreatedBy(pageIndex, pageSize, userId);


                if (page == null)
                {
                    code = 404;
                    response = new ErrorResponse("App Resource not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<VenueLocation>> { Item = page };
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



        [HttpPut("{id:int}")]
        public ActionResult<SuccessResponse> Update(VenueLocationUpdateRequest model)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                int userId = _authService.GetCurrentUserId();
                _service.Update(model, userId);

                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }




        [HttpDelete("{id:int}")]
        public ActionResult<SuccessResponse> Delete(int id)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                _service.Delete(id);
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
