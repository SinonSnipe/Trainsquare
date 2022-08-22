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
    [Route("api/venues")]
    [ApiController]
    public class VenuesApiController : BaseApiController
    {
        private IVenuesServices _service = null;
        private IAuthenticationService<int> _authService = null;

        public VenuesApiController(IVenuesServices service, ILogger<VenuesApiController> logger,
            IAuthenticationService<int> authService):base(logger)
        {
            _service = service;
            _authService = authService;
        }

        [HttpPost]
        public ActionResult<ItemResponse<int>> Create(VenuesAddRequest model)
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
            catch(Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }

        [HttpGet("createdBy/paginate")]
        public ActionResult<ItemResponse<Paged<Venue>>> Pagination(int createdBy,int pageindex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                Paged<Venue> page = _service.Pagination(createdBy, pageindex, pageSize);

                if (page == null)
                {
                    code = 404;
                    response = new ErrorResponse("Venue Resource not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<Venue>> { Item = page };
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

        [HttpGet("")]
        public ActionResult<ItemsResponse<Venue>> GetAll()
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                List<Venue> list = _service.GetAll();

                if (list == null)
                {
                    code = 404;
                    response = new ErrorResponse("Venue Resource Not Found.");
                }
                else
                {
                    response = new ItemsResponse<Venue> { Items = list };
                }
            }
            catch(Exception ex)
            {
                code =500;
                response = new ErrorResponse(ex.Message);
                base.Logger.LogError(ex.ToString());
            }
            return StatusCode(code, response);

        }

        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<Venue>> Get(int id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                Venue venue = _service.Get(id);

                if (venue == null)
                {
                    code = 404;
                    response = new ErrorResponse("Venue not Found.");

                }
                else
                {
                    response = new ItemResponse<Venue> { Item = venue };
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

        [HttpPut("{id:int}")]
        public ActionResult<SuccessResponse> Update(VenuesUpdateRequest model)
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

        [HttpGet("paginate")]
        public ActionResult<ItemResponse<Paged<Venue>>> GetAll(int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<Venue> paged = _service.GetAll(pageIndex, pageSize);

                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("Record not found.");
                }
                else
                {
                    ItemResponse<Paged<Venue>> itemResponse = new ItemResponse<Paged<Venue>>();
                    itemResponse.Item = paged;
                    response = new ItemResponse<Paged<Venue>> { Item = paged };
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
