using Sabio.Models.AppSettings;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Zoom;
using System;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public interface IZoomService
    {
        ZoomMeeting CreateMeeting(ZoomTokenConfig keys, ZoomAddRequest payload);
        string GenerateZoomSdkToken(ZoomTokenConfig keys, ZoomSdkRequest payload);
    }
}