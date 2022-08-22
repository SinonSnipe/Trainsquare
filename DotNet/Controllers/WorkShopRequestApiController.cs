using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain.WorkShopRequest;
using Sabio.Models.Requests.WorkShopRequest;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/workshoprequestform")]
    [ApiController]
    public class WorkShopRequestApiController : BaseApiController
    {

        private IWorkShopRequest _service = null;
     

        public WorkShopRequestApiController(IWorkShopRequest service, ILogger<WorkShopRequestApiController> logger)  : base(logger)
        {
            _service = service;
            
        }

        [HttpGet("search")]
        public ActionResult<ItemResponse<WorkShopRequest>> SearchPaginate(int pageIndex, int pageSize, string q)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                Paged<WorkShopRequest> paged = _service.SearchPaginate(pageIndex, pageSize, q);

                if (paged == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("App resource not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<WorkShopRequest>> { Item = paged };
                }
            }
            catch (Exception ex)
            {
                iCode = 500;
                Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(iCode, response);
        }
        [HttpGet("creator/paginate")]
        public ActionResult<ItemResponse<Paged<WorkShopRequest>>> GetByCreatedBy(int pageIndex, int pageSize, int currentRequest)
        {
         
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                
                Paged<WorkShopRequest> paged = _service.GetByCreatedBy(pageIndex, pageSize, currentRequest);

                if (paged == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Record not found.");
                }
                else
                {
                    response = new ItemResponse<Paged<WorkShopRequest>> { Item = paged };
                }
            }
            catch (Exception ex)
            {
                iCode = 500;
                Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(iCode, response);
        }


        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<WorkShopRequest>> Get(int id)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                WorkShopRequest request = _service.Get(id);

                if (request == null)

                {
                    iCode = 404;
                    response = new ErrorResponse("Record not found.");
                }
                else
                {
                    response = new ItemResponse<WorkShopRequest> { Item = request };
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
        public ActionResult<ItemResponse<Paged<WorkShopRequest>>> Pagination(int pageIndex, int pageSize)
        {
            ActionResult result = null;

            try
            {
                Paged<WorkShopRequest> paged = _service.Pagination(pageIndex, pageSize);

                if (paged == null)
                {

                    result = NotFound404(new ErrorResponse("Records not found."));
                }
                else
                {
                    ItemResponse<Paged<WorkShopRequest>> response = new ItemResponse<Paged<WorkShopRequest>>();

                    response.Item = paged;
                    result = Ok200(response);
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                result = StatusCode(500, new ErrorResponse(ex.ToString()));
            }


            return result;

        }
       











        [HttpPost("")]
        public ActionResult<ItemResponse<int>> Add(WorkShopAddRequest model)
        {

            ObjectResult result = null;

            try
            {
                int id = _service.Add(model);
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
        public ActionResult<SuccessResponse> Delete(int Id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                _service.Delete(Id);

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
