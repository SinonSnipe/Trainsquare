using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models.Domain;
using Sabio.Models.Requests.NewsletterContent;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/newsletter/content")]
    [ApiController]
    public class NewsletterContentApiController : BaseApiController

    {
        private INewsletterContentService _service = null;
        private IAuthenticationService<int> _authService = null;
        
        public NewsletterContentApiController(INewsletterContentService service,
           ILogger<NewsletterContentApiController> logger,
           IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _authService = authService; 
        }
        [HttpPost]
        public ActionResult<ItemResponse<int>> Create(NewsletterContentAddRequest model)
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
        public ActionResult<SuccessResponse> Update(NewsletterContentUpdateRequest model)
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
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);

            }
            return StatusCode(code, response);
        }

        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<NewsletterContent>> Get(int id)
        {
            int iCode = 200;
            BaseResponse response = null;
            try
            {

                NewsletterContent newsletterContent = _service.Get(id);


                if (newsletterContent == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application Resource Not Found");

                }
                else
                {
                    response = new ItemResponse<NewsletterContent> { Item = newsletterContent };
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

    }
}
