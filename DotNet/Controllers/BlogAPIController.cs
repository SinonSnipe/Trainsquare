using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Blogs;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/blogs/admin")]
    [ApiController]
    public class BlogAPIController : BaseApiController
    {
        private IBlogsServices _service = null;
        private IAuthenticationService<int> _authService = null;
        public BlogAPIController(IBlogsServices service
            , ILogger<BlogAPIController> logger
            , IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _authService = authService;

        }

        //POST-CREATE
        [HttpPost("")]
        public ActionResult<ItemResponse<int>> Create(BlogAddRequest model)
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

        //PaginateAUTHOR
        [HttpGet("paginateAuthor")]
        public ActionResult<ItemResponse<Paged<Blog>>> PaginateAuthor(int pageIndex, int pageSize)
        {
            ActionResult result = null;
            try
            {
                int authorId = _authService.GetCurrentUserId();

                Paged<Blog> paged = _service.PaginateAuthor(pageIndex, pageSize, authorId);
                if (paged == null)
                {
                    result = NotFound404(new ErrorResponse("Records Not Found"));
                }
                else
                {
                    ItemResponse<Paged<Blog>> response = new ItemResponse<Paged<Blog>>();
                    response.Item = paged;
                    result = Ok200(response);
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                result = StatusCode(500, new ErrorResponse(ex.Message.ToString()));
            }
            return result;
        }

        //PaginateAUTHORQUERY
        [HttpGet("paginateAuthorQuery")]
        public ActionResult<ItemResponse<Paged<Blog>>> PaginateAuthorQuery(int pageIndex, int pageSize, string query)
        {
            ActionResult result = null;
            try
            {
                int authorId = _authService.GetCurrentUserId();

                Paged <Blog> paged = _service.PaginateAuthorQuery(pageIndex, pageSize, query, authorId);
                if (paged == null)
                {
                    result = NotFound404(new ErrorResponse("Records Not Found"));
                }
                else
                {
                    ItemResponse<Paged<Blog>> response = new ItemResponse<Paged<Blog>>();
                    response.Item = paged;
                    result = Ok200(response);
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                result = StatusCode(500, new ErrorResponse(ex.Message.ToString()));
            }
            return result;
        }


        //PaginateBLOGTYPE 
        [HttpGet("paginateBlog")]
        public ActionResult<ItemResponse<Paged<Blog>>> PaginateType(int pageIndex, int pageSize, int blogTypeId)
        {
            ActionResult result = null;
            try
            {
                //int typeId = _authService.GetCurrentUserId();

                Paged<Blog> paged = _service.PaginateType(pageIndex, pageSize, blogTypeId);
                if (paged == null)
                {
                    result = NotFound404(new ErrorResponse("Records Not Found"));
                }
                else
                {
                    ItemResponse<Paged<Blog>> response = new ItemResponse<Paged<Blog>>();
                    response.Item = paged;
                    result = Ok200(response);
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                result = StatusCode(500, new ErrorResponse(ex.Message.ToString()));
            }
            return result;
        }


        //PUT
        [HttpPut("{id:int}")]
        public ActionResult<ItemResponse<int>> Update(BlogUpdateRequest model)
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

    }
}
