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
using System.Collections.Generic;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/privateBooking")]
    [ApiController]
    public class PrivateBookingApiController : BaseApiController  
    {
        private IPrivateBookingService _service = null;
        private IAuthenticationService<int> _authService = null;
        public PrivateBookingApiController(IPrivateBookingService service
            ,ILogger<PrivateBookingApiController> logger
            ,IAuthenticationService<int> authService) : base(logger) 
        {
            _service = service;
            _authService = authService;
        }
        
        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<PrivateBooking>> Get(int id, int startingIndex)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                PrivateBooking privateBooking = _service.Get(id, startingIndex);

                if (privateBooking == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application Resource Not Found!");
                } 
                else
                {
                    response = new ItemResponse<PrivateBooking> { Item = privateBooking };
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

        [HttpGet]
        public ActionResult<ItemResponse<PrivateBooking>> GetAll(int startingIndex) 
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                List<PrivateBooking> list = _service.GetAll(startingIndex);

                if (list == null)
                {
                    code = 404;
                    response = new ErrorResponse("App Resource Not Found"); 
                }
                else
                {
                    response = new ItemsResponse<PrivateBooking> { Items = list };
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

        [HttpPost]
        public ActionResult<ItemResponse<int>> Add(PrivateBookingAddRequest model)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                int userId = _authService.GetCurrentUserId();

                int id = _service.Add(model);

                response = new ItemResponse<int>() { Item = id };

                
            }
            catch (ArgumentException argEx)
            {
                code = 500;
                response = new ErrorResponse($"ArgumentException Error: {argEx.Message}");
            }
            catch (Exception ex)
            {   
                Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);                                                       

               
            }
            return StatusCode(code, response);
        } 

        [HttpPut("{id:int}")]
        public ActionResult<SuccessResponse> Update(PrivateBookingUpdateRequest model)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                int userId = _authService.GetCurrentUserId();

                _service.Update(model, userId);

                response = new SuccessResponse();
            }
            catch (ArgumentException argEx)
            {
                code = 500;
                response = new ErrorResponse($"ArgumentException Error: {argEx.Message}");
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);
        }

        [HttpDelete("{id:int}")]
         
        public ActionResult<SuccessResponse> Delete(int id, int startingIndex)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                _service.Delete(id, startingIndex);

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
        public ActionResult<ItemResponse<Paged<PrivateBooking>>> Pagination(int pageIndex, int pageSize, int startingIndex)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                Paged<PrivateBooking> page = _service.Pagination(pageIndex, pageSize, startingIndex);
                 
                if (page == null)
                {
                    code = 404;
                    response = new ErrorResponse("App Resource not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<PrivateBooking>> { Item = page };
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

        [HttpGet("search")]
        public ActionResult<ItemResponse<Paged<PrivateBooking>>> Search(int pageIndex, int pageSize, string query, int startingIndex)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<PrivateBooking> page = _service.Search(pageIndex, pageSize, query, startingIndex);

                if (page == null)
                {
                    code = 404;
                    response = new ErrorResponse("App Resource not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<PrivateBooking>> { Item = page };
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
