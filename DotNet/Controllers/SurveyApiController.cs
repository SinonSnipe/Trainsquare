using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Domain.Survey;
using Sabio.Models.Requests.Surveys;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/surveys")]
    [ApiController]
    public class SurveyApiController : BaseApiController
    {
        private ISurveysService _service = null;
        private ISurveysInstancesService _serviceInstances = null;
        private ISurveyQuestionService _surveyQuestionService = null;
        private IAuthenticationService<int> _authService = null;

        public SurveyApiController(ISurveysService service
            ,ISurveysInstancesService serviceInstances
            ,ISurveyQuestionService surveyQuestionService
            ,ILogger<SurveyApiController> logger
            ,IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _serviceInstances = serviceInstances;
            _surveyQuestionService = surveyQuestionService;
            _authService = authService;
        }        

        [HttpPost("")]
        public ActionResult<ItemResponse<int>> Create(SurveyAddRequest surveyAdd)
        {                      

            ObjectResult result = null;

            try
            {
                int userId = _authService.GetCurrentUserId();
                int id = _service.Add(surveyAdd, userId);

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
        public ActionResult<SuccessResponse> Update(SurveyUpdateRequest surveyUpdate)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                int userId = _authService.GetCurrentUserId();
                _service.Update(surveyUpdate, userId);

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

        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<Surveys>> GetById(int id)
        {

            int iCode = 200;
            BaseResponse response = null;

            try
            {
                Surveys surveys = _service.GetById(id);

                if (surveys == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application Resource not found.");
                }
                else
                {
                    response = new ItemResponse<Surveys> { Item = surveys };
                }
            }

            catch (Exception ex)
            {
                iCode = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Errors: {ex.Message}");
            }

            return StatusCode(iCode, response);
        }

        [HttpGet("current")]
        public ActionResult<ItemResponse<Paged<Surveys>>> GetCurrent(int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                int user = _authService.GetCurrentUserId();
                Paged<Surveys> paged = _service.GetCurrentPaged(pageIndex, pageSize, user);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("Records Not Found");
                }
                else
                {
                    response = new ItemResponse<Paged<Surveys>>() { Item = paged };
                    

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

        [HttpGet("paginate")]
        public ActionResult<ItemResponse<Paged<Surveys>>> Pagination(int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<Surveys> paged = _service.Pagination(pageIndex, pageSize);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("Records Not Found");
                }
                else
                {
                    response = new ItemResponse<Paged<Surveys>>() { Item = paged };                    

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
        public ActionResult<ItemResponse<Paged<Surveys>>> Search(int pageIndex, int pageSize, string query)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<Surveys> paged = _service.Search(pageIndex, pageSize, query);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("Records Not Found");
                }
                else
                {
                    response = new ItemResponse<Paged<Surveys>>() { Item = paged };

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
        [HttpGet("filter")]
        public ActionResult<ItemResponse<Paged<Surveys>>> Filter(int pageIndex, int pageSize, string query)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<Surveys> paged = _service.FilterByStatus(pageIndex, pageSize, query);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("Records Not Found");
                }
                else
                {
                    response = new ItemResponse<Paged<Surveys>>() { Item = paged };

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

        [HttpPost("instances/{surveyId:int}")]
        public ActionResult<ItemResponse<int>> Create(int surveyId)
        {

            int code = 200;
            BaseResponse response = null;

            try
            {
                int userId = _authService.GetCurrentUserId();
                int id = _serviceInstances.Add(surveyId, userId);
                response = new ItemResponse<int>() { Item = id };
            }
            catch (SqlException argEx)
            {
                code = 500;
                response = new ErrorResponse($"SqlException Error: {argEx.Message}");
            }
            catch (Exception ex)
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: {ex.Message}");
            }


            return StatusCode(code, response);
        }

        [HttpPut("instances/{id:int}/{surveyId:int}")]
        public ActionResult<SuccessResponse> Update(int id, int surveyId)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                int userId = _authService.GetCurrentUserId();
                _serviceInstances.Update(id, surveyId, userId);

                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);
        }
        
        [HttpDelete("instances/{id:int}")]
        public ActionResult<SuccessResponse> DeleteSurveyInstance(int id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                _serviceInstances.Delete(id);

                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);
        }

        [HttpGet("instances/{id:int}")]
        public ActionResult<ItemResponse<SurveyInstance>> GetByIdSurveyInstance(int id)
        {

            int code = 200;
            BaseResponse response = null;

            try
            {
                SurveyInstance instance = _serviceInstances.GetById(id);

                if (instance == null)
                {
                    code = 404;
                    response = new ErrorResponse("Application Resource not found.");
                }
                else
                {
                    response = new ItemResponse<SurveyInstance> { Item = instance };
                }
            }

            catch (SqlException argEx)
            {
                code = 500;
                response = new ErrorResponse($"SqlException Error: {argEx.Message}");
            }
            catch (Exception ex)
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: {ex.Message}");
            }

            return StatusCode(code, response);
        }

        [HttpGet("instances/paginate")]
        public ActionResult<ItemResponse<Paged<SurveyInstance>>> PaginationSurveyInstance(int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<SurveyInstance> paged = _serviceInstances.Pagination(pageIndex, pageSize);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("Records Not Found");
                }
                else
                {
                    response = new ItemResponse<Paged<SurveyInstance>>() { Item = paged };

                }
            }
            catch (SqlException argEx)
            {
                code = 500;
                response = new ErrorResponse($"SqlException Error: {argEx.Message}");
            }
            catch (Exception ex)
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: {ex.Message}");
            }
            return StatusCode(code, response);
        }

        [HttpGet("instances/createdby/{createdById:int}")]
        public ActionResult<ItemResponse<Paged<SurveyInstance>>> GetByCreatedBy(int createdById, int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                
                Paged<SurveyInstance> paged = _serviceInstances.GetByCreatedBy(pageIndex, pageSize, createdById);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("Records Not Found");
                }
                else
                {
                    response = new ItemResponse<Paged<SurveyInstance>>() { Item = paged };

                }
            }
            catch (SqlException argEx)
            {
                code = 500;
                response = new ErrorResponse($"SqlException Error: {argEx.Message}");
            }
            catch (Exception ex)
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: {ex.Message}");
            }
            return StatusCode(code, response);
        }

        [HttpGet("instances")]
        public ActionResult<ItemsResponse<SurveyInstance>> GetAll()
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                List<SurveyInstance> instanceList = _serviceInstances.GetAll();

                if (instanceList == null)
                {
                    code = 404;
                    response = new ErrorResponse("App Resource not found.");
                }
                else
                {
                    response = new ItemsResponse<SurveyInstance> { Items = instanceList };
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

        [HttpPost("createquestions")]
        public ActionResult<ItemResponse<int>> Create(SurveyQuestionAddRequest model)
        {

            int code = 200;
            BaseResponse response = null;

            try
            {
                int userId = _authService.GetCurrentUserId();
                int id = _surveyQuestionService.Add(model, userId);
                response = new ItemResponse<int>() { Item = id };
            }
            catch (SqlException argEx)
            {
                code = 500;
                response = new ErrorResponse($"SqlException Error: {argEx.Message}");
            }
            catch (Exception ex)
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: {ex.Message}");
            }


            return StatusCode(code, response);
        }

        [HttpPut("questions/{id:int}")]
        public ActionResult<SuccessResponse> Update(SurveyQuestionUpdateRequest model)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                int userId = _authService.GetCurrentUserId();
                _surveyQuestionService.Update(model, userId);

                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);
        }

        [HttpDelete("questions/{id:int}")]
        public ActionResult<SuccessResponse> DeleteQuestion(int id)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                _surveyQuestionService.Delete(id);

                response = new SuccessResponse();
            }
            catch (Exception ex)
            {
                code = 500;
                response = new ErrorResponse(ex.Message);
            }

            return StatusCode(code, response);
        }

        [HttpGet("questions/{id:int}")]
        public ActionResult<ItemResponse<SurveyQuestion>> GetByQuestionId(int id)
        {

            int code = 200;
            BaseResponse response = null;

            try
            {
                SurveyQuestion question = _surveyQuestionService.GetById(id);

                if (question == null)
                {
                    code = 404;
                    response = new ErrorResponse("Application Resource not found.");
                }
                else
                {
                    response = new ItemResponse<SurveyQuestion> { Item = question };
                }
            }

            catch (Exception ex)
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Errors: {ex.Message}");
            }

            return StatusCode(code, response);
        }

        [HttpGet("questions/paginate")]
        public ActionResult<ItemResponse<Paged<SurveyQuestion>>> PaginationSurveyQuestions(int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<SurveyQuestion> paged = _surveyQuestionService.Pagination(pageIndex, pageSize);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("Records Not Found");
                }
                else
                {
                    response = new ItemResponse<Paged<SurveyQuestion>>() { Item = paged };

                }
            }
            catch (SqlException argEx)
            {
                code = 500;
                response = new ErrorResponse($"SqlException Error: {argEx.Message}");
            }
            catch (Exception ex)
            {
                code = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: {ex.Message}");
            }
            return StatusCode(code, response);
        }

        [HttpGet("questions/createdby/{createdById:int}")]
        public ActionResult<ItemResponse<Paged<SurveyQuestion>>> GetByCreatedByQuestions(int createdById, int pageIndex, int pageSize)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {

                Paged<SurveyQuestion> paged = _surveyQuestionService.GetByCreatedBy(pageIndex, pageSize, createdById);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("Records Not Found");
                }
                else
                {
                    response = new ItemResponse<Paged<SurveyQuestion>>() { Item = paged };

                }
            }
            catch (SqlException argEx)
            {
                code = 500;
                response = new ErrorResponse($"SqlException Error: {argEx.Message}");
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
