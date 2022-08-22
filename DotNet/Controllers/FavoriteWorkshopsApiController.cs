using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using Sabio.Services;
using Sabio.Services.Interfaces;
using Sabio.Web.Controllers;
using Sabio.Web.Models.Responses;
using System;
using System.Collections.Generic;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/favoriteWorkshops")]
    [ApiController]
    public class FavoriteWorkshopsApiController : BaseApiController
    {
        private IFavoriteWorkshopService _service = null;
        private IAuthenticationService<int> _authService = null;

        public FavoriteWorkshopsApiController(IFavoriteWorkshopService service, ILogger<FavoriteWorkshopsApiController> logger, IAuthenticationService<int> authService) : base(logger)
        {
            _service = service;
            _authService = authService;
        }

        [HttpPost]
        public ActionResult<ItemResponse<int>> Create(FavoriteWorkshopAddRequest model)
        {
            ObjectResult result = null;

            try
            {
                int userId = _authService.GetCurrentUserId();

                int id = _service.Add(model, userId);
                ItemResponse<int> response = new ItemResponse<int> { Item = id};

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

        [HttpGet("current")]
        public ActionResult<ItemResponse<Paged<WorkShop>>> GetAllByUserId(int pageIndex, int pageSize)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                IUserAuthData user = _authService.GetCurrentUser();
                Paged<WorkShop> favoriteWorkshop = _service.GetAllByUserId(user.Id, pageIndex, pageSize);

                if(favoriteWorkshop == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application resource not found");
                }
                else
                {
                    response = new ItemResponse<Paged<WorkShop>> { Item = favoriteWorkshop };
                }
            }
            catch(Exception ex)
            {
                iCode = 500;
                base.Logger.LogError(ex.ToString());
                response = new ErrorResponse(ex.Message);
            }
            return StatusCode(iCode, response);
        }

        [HttpGet("topFavorited")]
        public ActionResult<ItemResponse<Paged<WorkshopWithFavoriteCount>>> GetAllFavoriteWorkshops(int pageIndex, int pageSize)
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                Paged<WorkshopWithFavoriteCount> workshop = _service.GetAllFavoriteWorkshops(pageIndex, pageSize);

                if(workshop == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application resource not found");
                } else
                {
                    response= new ItemResponse<Paged<WorkshopWithFavoriteCount>> { Item = workshop };
                }
            }
            catch (Exception ex)
            {
                iCode = 500;
                base.Logger.LogError(ex.ToString());
                response= new ErrorResponse(ex.Message);
            }
            return StatusCode(iCode, response);
        }

        [HttpGet("search")]
        public ActionResult<ItemResponse<Paged<WorkshopWithFavoriteCount>>> Search(int pageIndex, int pageSize, string query)
        {
            int code = 200;
            BaseResponse response = null;
            try
            {
                Paged<WorkshopWithFavoriteCount> paged = _service.Search(pageIndex, pageSize, query);
                if (paged == null)
                {
                    code = 404;
                    response = new ErrorResponse("Records Not Found");
                }
                else
                {
                    response = new ItemResponse<Paged<WorkshopWithFavoriteCount>>() { Item = paged };

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

        [HttpGet("favoriteWorkShopIds")]
        public ActionResult<ItemResponse<List<WorkshopId>>> GetFavoriteWorkshopIds()
        {
            int iCode = 200;
            BaseResponse response = null;

            try
            {
                IUserAuthData user = _authService.GetCurrentUser();
                List<WorkshopId> workshopIds = _service.GetFavoriteWorkshopIds(user.Id);

                if(workshopIds == null)
                {
                    iCode = 404;
                    response = new ErrorResponse("Application resource not found");
                }
                else
                {
                    response = new ItemResponse<List<WorkshopId>> { Item = workshopIds };
                }
            }
            catch (Exception ex)
            {
                iCode = 500;
                base.Logger.LogError(ex.ToString());
                response= new ErrorResponse(ex.Message);
            }
            return StatusCode(iCode, response);
        }

        [HttpDelete("{workShopId:int}")]
        public ActionResult<SuccessResponse> Delete(int workShopId, int userId)
        {
            int code = 200;
            BaseResponse response = null;

            try
            {
                IUserAuthData user = _authService.GetCurrentUser();
                _service.Delete(workShopId, user.Id);
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
