using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;
using Sabio.Models.AppSettings;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Zoom;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class ZoomService : IZoomService
    {
        public ZoomMeeting CreateMeeting(ZoomTokenConfig keys, ZoomAddRequest payload)
        {
            var tokenHandler = new System.IdentityModel.Tokens.Jwt.JwtSecurityTokenHandler();
            var now = DateTime.UtcNow;
            byte[] symmetricKey = Encoding.ASCII.GetBytes(keys.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Issuer = keys.Issuer,
                Expires = now.AddSeconds(100000),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(symmetricKey), SecurityAlgorithms.HmacSha256),
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenString = tokenHandler.WriteToken(token);

            var client = new RestClient("https://api.zoom.us/v2/users/lXv7uTOlRqmdyUUIz4yCDw/meetings");
            var request = new RestRequest("https://api.zoom.us/v2/users/lXv7uTOlRqmdyUUIz4yCDw/meetings", Method.Post);
            request.AddHeader("authorization", String.Format("Bearer {0}", tokenString));
            request.AddJsonBody(new { topic = $"{payload.Topic}", duration = $"{payload.Duration}", start_time = $"{payload.Date}:00", type = $"{payload.Type}", timezone = "America/Los_Angeles" });
            Task<RestResponse> response = client.ExecuteAsync(request);

            ZoomMeeting result = JsonConvert.DeserializeObject<ZoomMeeting>(response.Result.Content);

            return result;
        }
        public string GenerateZoomSdkToken(ZoomTokenConfig keys, ZoomSdkRequest payload)
        {
            long now = DateTimeOffset.Now.ToUnixTimeSeconds();

            //long ts = ToTimestamp(now);

            long tsExp = now + 10000;

            //long tsExp = ToTimestamp(expiry);

            var securityKey = new Microsoft.IdentityModel.Tokens.SymmetricSecurityKey(Encoding.UTF8.GetBytes(keys.SdkSecret));

            var credentials = new Microsoft.IdentityModel.Tokens.SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256Signature);

            var header = new JwtHeader(credentials);

            var zoomPayload = new JwtPayload{
                {"appKey",keys.SdkKey},
                {"sdkKey", keys.SdkKey},
                {"mn", payload.MeetingId},
                {"role", payload.Role},
                {"iat", now},
                {"exp", tsExp},
                { "tokenExp", tsExp + 1000}
            };

            var secToken = new JwtSecurityToken(header, zoomPayload);
            var handler = new JwtSecurityTokenHandler();

            var tokenString = handler.WriteToken(secToken);

            return tokenString;

            // BELOW RETURNS INVALID SIGNATURE
            /*
            char[] padding = { '=' };

            String ts = (ToTimestamp(DateTime.UtcNow.ToUniversalTime()) - 30000).ToString();

            string message = String.Format("{0}{1}{2}{3}", keys.Issuer, payload.MeetingId, ts, payload.Role);
            keys.SdkSecret = keys.SdkSecret ?? "";
            var encoding = new System.Text.ASCIIEncoding();
            byte[] keyByte = encoding.GetBytes(keys.SdkSecret);
            byte[] messageBytesTest = encoding.GetBytes(message);
            string msgHashPreHmac = System.Convert.ToBase64String(messageBytesTest);
            byte[] messageBytes = encoding.GetBytes(msgHashPreHmac);
            using (var hmacsha256 = new HMACSHA256(keyByte))
            {
                byte[] hashmessage = hmacsha256.ComputeHash(messageBytes);
                string msgHash = System.Convert.ToBase64String(hashmessage);
                string token = String.Format("{0}.{1}.{2}.{3}.{4}", keys.SdkKey, payload.MeetingId, ts, payload.Role, msgHash);
                var tokenBytes = System.Text.Encoding.UTF8.GetBytes(token);
                return System.Convert.ToBase64String(tokenBytes).TrimEnd(padding);
            }

            */
        }


        public static long ToTimestamp(DateTime value)
        {
            long epoch = (value.Ticks - 621355968000000000) / 10000;
            return epoch;
        }
    }
}

