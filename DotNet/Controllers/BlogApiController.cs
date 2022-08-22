using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Services;
using Sabio.Services.Interfaces;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;

namespace Sabio.Web.Api.Controllers

{
    [Route("api/blogs")]
    [ApiController]
    public class BlogApiController : BaseApiController
    {
        private IBlogService _service = null;
        private IAuthenticationService<int> _authService = null;

        public BlogApiController(IBlogService service,
            ILogger<PingApiController> logger,
            IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _authService = authService;
        }

        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<Blog>> Get(int id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                Blog blog = _service.Get(id);

                if (blog == null)
                {
                    code = 404;
                    response = new ErrorResponse("Application Resource Not Found");
                }
                else
                {
                    response = new ItemResponse<Blog> { Item = blog };
                }
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }

        [HttpGet("paginate")]
        public ActionResult<ItemResponse<Paged<Blog>>> GetAllPagination(int pageIndex, int pageSize)
        {
            ActionResult result = null;

            try
            {
                Paged<Blog> blog= _service.GetAllPagination(pageIndex, pageSize);

                if (blog == null)
                {                    
                    result = NotFound404(new ErrorResponse("Application Resource Not Found"));
                }
                else
                {
                    ItemResponse<Paged<Blog>> response = new ItemResponse<Paged<Blog>>();
                    response.Item = blog;
                    result = Ok200(response);
                }
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                result = StatusCode(500, new ErrorResponse(ex.Message.ToString()));
                
            }
            return result;

        }

        [HttpGet("paginateType")]
        public ActionResult<ItemResponse<Paged<Blog>>> PaginateType(int pageIndex, int pageSize, string query, int type)
        {
            ActionResult result = null;

            try
            {
                Paged<Blog> blog = _service.PaginateType(pageIndex, pageSize, query, type);

                if (blog == null)
                {
                    result = NotFound404(new ErrorResponse("Application Resource Not Found/No Matching Query"));
                }
                else
                {
                    ItemResponse<Paged<Blog>> response = new ItemResponse<Paged<Blog>>();
                    response.Item = blog;
                    result = Ok200(response);
                }
            }
            catch (Exception ex)
            {
                base.Logger.LogError(ex.ToString());
                result = StatusCode(500, new ErrorResponse(ex.Message.ToString()));

            }
            return result;

        }

    }
}
