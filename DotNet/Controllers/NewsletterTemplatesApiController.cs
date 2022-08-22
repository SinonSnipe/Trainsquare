using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.NewsletterTemplates;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/newsletter/templates")]
    [ApiController]
    public class NewsletterTemplatesApiController : BaseApiController
    {
        private INewsletterTemplatesService _service = null;
        private IAuthenticationService<int> _authService = null;

        public NewsletterTemplatesApiController(INewsletterTemplatesService service,
            ILogger<NewsletterTemplatesApiController> logger,
            IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _authService = authService;

        }
        [HttpPost]
        public ActionResult<ItemResponse<int>> Create(NewsletterTemplatesAddRequest model)
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
                base.Logger.LogError(ex.ToString());
                ErrorResponse response = new ErrorResponse(ex.Message);
                result = StatusCode(500, response);
            }
            return result;
        }
        [HttpPut("{id:int}")]
        public ActionResult<SuccessResponse> Update(NewsletterTemplatesUpdateRequest model)
        {
            int userId = _authService.GetCurrentUserId();
            int code = 200;
            BaseResponse response = null;
            try
            {
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

        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<NewsletterTemplates>> Get(int id)
        {
            int iCode = 200;
            BaseResponse response = null;
            try
            {

                NewsletterTemplates newsletterTemplates = _service.Get(id);


                if (newsletterTemplates == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application Resource Not Found");
                
                }
                else
                {
                    response = new ItemResponse<NewsletterTemplates> { Item = newsletterTemplates };
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

        [HttpGet("paginate")]
        public ActionResult<ItemResponse<Paged<NewsletterTemplates>>> GetAllPaginated(int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                Paged<NewsletterTemplates> paged = _service.GetAllPaginated(pageIndex, pageSize);
            
                if (paged == null)
                {
                     code = 404;
                     response = new ErrorResponse("Records Not Found.");
                 }
                else
                {
                    response = new ItemResponse<Paged<NewsletterTemplates>> {Item = paged }; 
                }

            }
            catch (Exception ex) 
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(code, response);
        }

        [HttpGet("search")]
        public ActionResult<ItemResponse<Paged<NewsletterTemplates>>> SearchPaginated(int pageIndex, int pageSize, string query)
        {
            int code = 200;
            BaseResponse response = null; 

            try
            {
                Paged<NewsletterTemplates> paged = _service.SearchPaginated(pageIndex, pageSize, query);



                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("Records Not Found.");

                }
                else
                {

                    response = new ItemResponse<Paged<NewsletterTemplates>> { Item = paged };

                }
            }
            catch (Exception ex)
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);

        }
    }

    
}
