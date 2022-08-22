using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using Sabio.Models.Requests.Comments;
using Sabio.Services;
using Sabio.Services.Interfaces;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/ratings")]
    [ApiController]
    public class RatingApiController : BaseApiController
    {
        private IRatingService _service = null;
        private IAuthenticationService<int> _authService = null;

        public RatingApiController(IRatingService service, IAuthenticationService<int> authService, ILogger<RatingApiController> logger) : base(logger)
        {
            _service = service;
            _authService = authService;
        }    

        [HttpPost]
        public ActionResult<ItemResponse<int>> AddRating(RatingAddRequest model)
        {
            ObjectResult result = null;

            try
            {
                int userId = _authService.GetCurrentUserId();

                int id = _service.AddRating(model, userId);
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
               
        [HttpGet("CreatedByPaginated")]
        public ActionResult<ItemResponse<Paged<RatingsDetails>>> CreatedByPagination(int pageIndex, int pageSize)
        {
            int iCode = 200;     
            BaseResponse response = null; 
                                      
            try 
            {
                IUserAuthData user = _authService.GetCurrentUser();
                Paged<RatingsDetails> rating = _service.CreatedByPagination(user.Id, pageIndex, pageSize);

                if (rating == null)  
                {
                    iCode = 404;
                    response = new ErrorResponse("Application Resource not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<RatingsDetails>> { Item = rating };
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

        [HttpGet("CreatedBy/{CreatedBy:int}")]
        public ActionResult<ItemResponse<RatingsDetails>> CreatedByV2(int createdBy)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                List<RatingsDetails> rating = _service.CreatedByV2(createdBy);

                if (rating == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application Resource not found.");
                }
                else
                {
                    response = new ItemResponse<List<RatingsDetails>> { Item = rating };
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

        [HttpGet("entity/{entityId:int}/{entityTypeId:int}")]
        public ActionResult<ItemResponse<RatingsDetails>> SelectByEntityId(int EntityId, int EntityTypeId, int pageIndex, int pageSize)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                Paged<RatingsDetails> rating = _service.SelectByEntityId(EntityId, EntityTypeId, pageIndex, pageSize);

                if (rating == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application Resource not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<RatingsDetails>> { Item = rating };
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

        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<Ratings>> SelectById(int Id)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                Ratings rating = _service.SelectById(Id);
                if (rating == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application resource not found.");
                }
                else
                {
                    response = new ItemResponse<Ratings> { Item = rating };
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

        [HttpGet("paginate")]
        public ActionResult<ItemResponse<Paged<Ratings>>> SelectAllPaginated(int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                Paged<Ratings> pagedrating = _service.SelectAllPaginated(pageIndex, pageSize);

                if (pagedrating == null)
                {
                    code = 404;
                    response = new ErrorResponse("Record not found.");
                }
                else
                {
                    ItemResponse<Paged<Ratings>> itemResponse = new ItemResponse<Paged<Ratings>>();
                    itemResponse.Item = pagedrating;
                    response = new ItemResponse<Paged<Ratings>> { Item = pagedrating };
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
        public ActionResult<SuccessResponse> Update(RatingUpdateRequest model, int Id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                int userId = _authService.GetCurrentUserId();
                _service.Update(model, userId, Id);

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
