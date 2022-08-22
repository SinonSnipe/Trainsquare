using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Services;
using Sabio.Web.Controllers;
using System;
using Sabio.Models.Requests.NewsletterTemplateKeys;
using Sabio.Web.Models.Responses;
using Sabio.Models.Domain;
using System.Collections.Generic;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/newsletter/templatekeys")]
    [ApiController]
    public class NewsletterTemplateKeysApiController : BaseApiController
    {
        private INewsletterTemplateKeysService _service = null;
        private IAuthenticationService<int> _authService = null;

        public NewsletterTemplateKeysApiController(INewsletterTemplateKeysService service,
            
            ILogger<NewsletterTemplateKeysApiController> logger,
            IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _authService = authService;
        }
        
        [HttpPost]
        public ActionResult<ItemResponse<int>> Create(NewsletterTemplateKeyAddRequest model)
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
        public ActionResult<SuccessResponse> Update (NewsletterTemplateKeyUpdateRequest model)
        {
            int userId = _authService.GetCurrentUserId();
            int code = 200;
            BaseResponse response = null;
            try
            {
                _service.Update(model, userId);
                response = new SuccessResponse();

            }
            catch(Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);

            }
            return StatusCode(code, response);
        }

        [HttpGet("{id:int}")]
        public ActionResult<ItemsResponse<NewsletterTemplateKeys>> GetByTemplateId(int id)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                List<NewsletterTemplateKeys> aNewsletterTemplateKey = _service.GetByTemplateId(id);
                if (aNewsletterTemplateKey == null)
                {
                    code = 404;
                    response = new ErrorResponse("Application Resource Not Found");
                }
                else
                {
                    response = new ItemsResponse<NewsletterTemplateKeys> { Items = aNewsletterTemplateKey };
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
    }
}
