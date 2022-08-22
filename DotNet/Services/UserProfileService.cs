using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using Sabio.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class UserProfileService : IUserProfileService
    {
        private IAuthenticationService<int> _authenticationService;
        private IDataProvider _dataProvider;

        public UserProfileService(IAuthenticationService<int> authSerice, IDataProvider dataProvider)
        {
            _authenticationService = authSerice;
            _dataProvider = dataProvider;
        }

        public UserProfile GetProfileByUserId(int id)
        {
            string procName = "[dbo].[UserProfiles_Select_ByUserId]";
            UserProfile aUser = null;

            _dataProvider.ExecuteCmd(procName,
                inputParamMapper: delegate (SqlParameterCollection param)
                {
                    param.AddWithValue("@UserId", id);
                },
                singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    int startIndex = 0;
                    aUser = MapUserProfile(reader, ref startIndex);
                });

            return aUser;
        }

        public UserProfile GetProfileById(int Id)
        {
            string procName = "[dbo].[UserProfiles_Select_ById]";
            UserProfile aUser = null;

            _dataProvider.ExecuteCmd(procName,
                inputParamMapper: delegate (SqlParameterCollection param)
                {
                    param.AddWithValue("@Id", Id);
                },
                singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    int startIndex = 0;
                    aUser = MapUserProfile(reader, ref startIndex);
                });

            return aUser;
        }

        private UserProfile MapUserProfile(IDataReader reader, ref int startIndex)
        {
            UserProfile aUser = new UserProfile();

            aUser.Id = reader.GetSafeInt32(startIndex++);
            aUser.UserId = reader.GetSafeInt32(startIndex++);
            aUser.FirstName = reader.GetSafeString(startIndex++);
            aUser.LastName = reader.GetSafeString(startIndex++);
            aUser.MiddleName = reader.GetSafeString(startIndex++);
            aUser.AvatarUrl = reader.GetSafeString(startIndex++);
            aUser.DateCreated = reader.GetSafeDateTime(startIndex++);
            aUser.DateModified = reader.GetSafeDateTime(startIndex++);
            return aUser;
        }

        public void Update(UserProfileUpdateRequest model)
        {
            string procName = "[dbo].[UserProfiles_Update]";
            _dataProvider.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@FirstName", model.FirstName);
                col.AddWithValue("@LastName", model.LastName);
                col.AddWithValue("@Mi", model.MiddleName);
                col.AddWithValue("@AvatarUrl", model.AvatarUrl);

                col.AddWithValue("@UserId", model.Id);
            }, returnParameters: null);
        }














    }
}
