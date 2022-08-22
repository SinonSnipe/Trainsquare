using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.VenueRequest;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Sabio.Web.Api.Controllers; 

[Route("api/venuerequests")]
[ApiController]
public class VenueRequestApiController : BaseApiController 
{
    private IVenueRequestService _service = null; 
    private IAuthenticationService<int> _authService = null; 

    public VenueRequestApiController(IVenueRequestService service   
        , ILogger<VenueRequestApiController> logger 
        , IAuthenticationService<int> authService) : base(logger) 
    {
        _service = service;  
        _authService = authService;
    }


    [HttpPost]  
    public ActionResult<ItemsResponse<int>> Create(AddVenueRequest model) 
    {
        ObjectResult result = null;
        try
        {
            int userId = _authService.GetCurrentUserId();
            int id = _service.AddVenueRequest(model, userId);

           
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

    [HttpPut("{id:int}")]
    public ActionResult<SuccessResponse> Update(UpdateVenueRequest model, int currentUserId)
    {
        int code = 200;
        BaseResponse response = null;
        
        try
        {
            int userId = _authService.GetCurrentUserId();
            _service.UpdateVenueRequest(model, userId);
            response = new SuccessResponse();
        }
        catch (Exception ex)
        {
            code = 500;
            response = new ErrorResponse(ex.Message);
        }
        return StatusCode (code, response);
    }

    [HttpDelete("{id:int}")]
    public ActionResult<SuccessResponse> Delete (int id)
    {
        int code = 200;
        BaseResponse response = null;

        try
        {
            _service.DeleteVenueRequest(id);
            response = new SuccessResponse();
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
    public ActionResult<ItemResponse<Paged<VenueRequest>>> GetAll(int pageIndex, int pageSize)
    {

        int iCode = 200;
        BaseResponse response = null;

        try
        {
            Paged<VenueRequest> paged = _service.GetAll(pageIndex, pageSize);
            if (paged == null)
            {
                iCode = 404;
                response = new ErrorResponse("Application resource not found.");
            }
            else
            {
                ItemResponse<Paged<VenueRequest>> itemResponse = new ItemResponse<Paged<VenueRequest>>();
                itemResponse.Item = paged;
                response = new ItemResponse<Paged<VenueRequest>> { Item = paged };
            }
        }
        catch (Exception ex)
        {
            iCode = 500;
            response = new ErrorResponse(ex.Message);
            base.Logger.LogError(ex.ToString());
        }

        return StatusCode(iCode, response);
    }

    [HttpGet("byvenue/{id:int}")]
    public ActionResult<ItemResponse<Paged<VenueRequest>>> GetByVenueId(int id, int pageIndex, int pageSize)
    {

        int iCode = 200;
        BaseResponse response = null;

        try
        {
            Paged<VenueRequest> venue = _service.GetByVenueId(id, pageIndex, pageSize);
            if (venue == null)
            {
                iCode = 404;
                response = new ErrorResponse("Venue not found.");
            }
            else
            {
                response = new ItemResponse<Paged<VenueRequest>>
                {
                    Item = venue
                };
            }
        }
        catch (Exception ex)
        {
            iCode = 500;
            response = new ErrorResponse(ex.Message);
            base.Logger.LogError(ex.ToString());
        }

        return StatusCode(iCode, response);
    }

    [HttpGet("byuser/{userId:int}")]
    public ActionResult<ItemResponse<VenueRequest>> GetByRequester(int userId)
    {

        int iCode = 200;
        BaseResponse response = null;

        try
        {
            VenueRequest venue = _service.GetByRequester(userId);
            if (venue == null)
            {
                iCode = 404;
                response = new ErrorResponse("User not found.");
            }
            else
            {
                response = new ItemResponse<VenueRequest>
                {
                    Item = venue
                };
            }
        }
        catch (Exception ex)
        {
            iCode = 500;
            response = new ErrorResponse(ex.Message);
            base.Logger.LogError(ex.ToString());
        }

        return StatusCode(iCode, response);
    }


}
