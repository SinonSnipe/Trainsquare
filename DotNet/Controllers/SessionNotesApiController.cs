using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Notes;
using Sabio.Models.Requests.SessionNotes;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/sessionnotes")]
    [ApiController]
    public class SessionNotesApiController : BaseApiController
    {
        private ISessionNotesService _service = null;
        private IAuthenticationService<int> _authService = null;
        public SessionNotesApiController(ISessionNotesService service, ILogger<SessionNotesApiController> logger, IAuthenticationService<int> authService):base(logger)
        {
            _authService = authService;
            _service = service; 
        }


        [HttpPost]
        public ActionResult<ItemResponse<int>> Create(SessionNoteAddRequest model)
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

        [HttpGet("paginate")]
        public ActionResult<ItemResponse<Paged<SessionNote>>> Paginated(int pageIndex, int pageSize)
        {
            ActionResult result = null;

            try
            {
                Paged<SessionNote> paged = _service.Paginated(pageIndex, pageSize);
                if (paged== null)
                {
                    result = NotFound404(new ErrorResponse("Records not found"));
                }
                else
                {
                    ItemResponse<Paged<SessionNote>> response = new ItemResponse<Paged<SessionNote>>();
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

        [HttpGet("{id:int}")]
        public ActionResult<ItemResponse<SessionNote>> Get(int id)
        {
            int iCode = 200;
            BaseResponse response = null;
            try
            {

                SessionNote n = _service.Get(id);


                if (n == null)
                {
                    iCode = 400;
                    response = new ErrorResponse("Note not found");
                    return NotFound404(response);
                }
                else
                {

                    response = new ItemResponse<SessionNote> { Item = n };
                }
            }
            catch (SqlException sqlEx)
            {
                iCode = 500;
                base.Logger.LogError(sqlEx.ToString());
                response = new ErrorResponse($"SqlExceptionError Error: {sqlEx.Message}");

            }
            catch (ArgumentException argEx)
            {
                iCode = 500;

                response = new ErrorResponse($"ArgumentExceptionError Error: {argEx.Message}");
            }
            catch (Exception ex)
            {
                iCode = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse($"Generic Error: {ex.Message}");

            }
            return StatusCode(iCode, response);
        }

        [HttpPut("{id:int}")]
        public ActionResult<SuccessResponse> Update(SessionNoteUpdateRequest model)
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




    }
}
