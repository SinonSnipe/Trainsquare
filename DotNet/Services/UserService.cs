using Newtonsoft.Json;
using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests;
using Sabio.Models.Requests.Users;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public class UserService : IUserService
    {
        private IAuthenticationService<int> _authenticationService;
        private IDataProvider _dataProvider;


        public UserService(IAuthenticationService<int> authService, IDataProvider dataProvider)
        {

            _authenticationService = authService;
            _dataProvider = dataProvider;
        }

        public bool ChangePasswordTaxi(UserPasswordChangeRequest model, int userId)
        {
            bool isMatch = false;
          UserChangePassword hashOriginalPw = GetById(userId);
            if (hashOriginalPw != null)
            {
                 isMatch = BCrypt.BCryptHelper.CheckPassword(model.OldPassword, hashOriginalPw.OriginalPassword);
            }
         
            if (isMatch == true)
            {
                ResetPassword(model, userId);
            }
         return    isMatch;
        }

        public UserChangePassword GetById(int Id)
        {
            string procName = "[dbo].[Users_PasswordChange_ById]";

            UserChangePassword originalPw = null;

            _dataProvider.ExecuteCmd(
                procName,
                 inputParamMapper: delegate (SqlParameterCollection param)
                 {
                     param.AddWithValue("@Id", Id);
                 },
                 singleRecordMapper: delegate (IDataReader reader, short set)
                 {
                     int startingindex = 0;

                     originalPw = new UserChangePassword();

                     originalPw.OriginalPassword = reader.GetSafeString(startingindex++);
                 }
            );
            return originalPw;
        }

        public bool ChangePasswordForLoggedIn(string originalPw, string oldPassword)
        {
            bool isSuccessful = false;

            IUserAuthData existingUser = Get(originalPw, oldPassword);

            if (existingUser != null)
            {
                isSuccessful = true;
            }

            return isSuccessful;
        }

        public async Task<bool> LogInAsync(string email, string password)
        {
            bool isSuccessful = false;

            IUserAuthData response = Get(email, password);

            if (response != null)
            {
                await _authenticationService.LogInAsync(response);
                isSuccessful = true;
            }

            return isSuccessful;
        }

        public async Task<bool> LogInTest(string email, string password, int id, string[] roles = null)
        {
            bool isSuccessful = false;
            var testRoles = new[] { "User", "Super", "Content Manager" };

            var allRoles = roles == null ? testRoles : testRoles.Concat(roles);

            IUserAuthData response = new UserBase
            {
                Id = id
                ,
                Name = email
                ,
                Roles = allRoles
                ,
                TenantId = "Acme Corp UId"
            };

            Claim fullName = new Claim("CustomClaim", "Sabio Bootcamp");
            await _authenticationService.LogInAsync(response, new Claim[] { fullName });

            return isSuccessful;
        }

        public int Create(UserAddRequest userModel)
        {

            int userId = 0;
            string procName = "[dbo].[Users_Insert]";
            _dataProvider.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection sqlParams)
            {

                string password = userModel.Password;
                string salt = BCrypt.BCryptHelper.GenerateSalt();
                string hashedPassword = BCrypt.BCryptHelper.HashPassword(password, salt);
                sqlParams.AddWithValue("@Email", userModel.Email);
                sqlParams.AddWithValue("@Password", hashedPassword);
                SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;
                sqlParams.Add(idOut);
            },
              returnParameters: delegate (SqlParameterCollection returnCollection)
              {
                  object oId = returnCollection["@Id"].Value;

                  int.TryParse(oId.ToString(), out userId);
              });

            return userId;
        }

        public void InsertToken(string token, int userId, int tokenType)
        {

            string procName = "[dbo].[UserTokens_Insert]";
            _dataProvider.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Token", token);
                col.AddWithValue("@UserId", userId);
                col.AddWithValue("@TokenType", tokenType);

            });

        }

        private IUserAuthData Get(string email, string password)
        {

            string passwordFromDb = "";
            UserBase user = null;
            string procName = "[dbo].[Users_Select_AuthData]";
            int index = 0;

            _dataProvider.ExecuteCmd(procName,
                inputParamMapper: delegate (SqlParameterCollection param)
                {
                    param.AddWithValue("@Email", email);
                },
                singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    passwordFromDb = reader.GetSafeString(index++);

                    bool isValidCredentials = BCrypt.BCryptHelper.CheckPassword(password, passwordFromDb);

                    if (isValidCredentials)
                    {
                        user = MapUser(reader, ref index);
                    }
                });

            return user;
        }

        public int GetUserIdByEmail(string email)
        {
            int userId = 0;
            string procName = "[dbo].[Users_SelectId_ByEmail]";


            _dataProvider.ExecuteCmd(procName,
                inputParamMapper: delegate (SqlParameterCollection param)
                {
                    param.AddWithValue("@Email", email);
                },
                singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    userId = reader.GetSafeInt32(0);

                });

            return userId;
        }


        private static UserBase MapUser(IDataReader reader, ref int index)
        {
            UserBase user = new UserBase();

            user.Id = reader.GetInt32(index++);
            user.Name = reader.GetSafeString(index++);
            string rolesJson = reader.GetSafeString(index++);
            List<Role> roles = JsonConvert.DeserializeObject<List<Role>>(rolesJson);
            user.Roles = roles.Select(r => r.Name).ToList();

            user.TenantId = "U02PS0W6YU8";
            return user;
        }

        public void ConfirmNewUserToken(string token)
        {
            string procName = "[dbo].[UserTokens_VerifyToken]";
            _dataProvider.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Token", token);

            }, returnParameters: null);


        }

        public int ConfirmResetPasswordToken(string token)
        {

            int Id = 0;

            string procName = "[dbo].[UserTokens_VerifyResetPasswordToken]";
            _dataProvider.ExecuteCmd(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Token", token);

            }, singleRecordMapper: delegate (IDataReader reader, short set)
            {
                Id = reader.GetSafeInt32(0);

            });

            return Id;
        }

        public int ResetPassword(UserResetPasswordRequest model, int userId)
        {
            int Id = 0;

            string procName = "[dbo].[User_PasswordReset]";
            string salt = BCrypt.BCryptHelper.GenerateSalt();
            string hashPassword = BCrypt.BCryptHelper.HashPassword(model.Password, salt);

            _dataProvider.ExecuteCmd(
                procName,
                inputParamMapper: delegate (SqlParameterCollection paramCollection)
                {
                    paramCollection.AddWithValue("@Id", userId);
                    paramCollection.AddWithValue("@Password", hashPassword);
                },
                singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    Id = reader.GetSafeInt32(0);
                }
            );
            return Id;
        }

        public Paged<UserBase> GetAll(int pageIndex, int pageSize)
        {
            string procName = "[dbo].[Users_SelectAll]";
            List<UserBase> list = null;
            Paged<UserBase> page = null;
            int total = 0;

            _dataProvider.ExecuteCmd(procName
                , inputParamMapper: delegate (SqlParameterCollection param)
                {
                    param.AddWithValue("@pageIndex", pageIndex);
                    param.AddWithValue("@pageSize", pageSize);
                }
                , singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    int index = 0;
                    UserBase user = MapUser(reader, ref index);
                    total = reader.GetSafeInt32(index++);
                    if (list == null)
                    {
                        list = new List<UserBase>();
                    }
                    list.Add(user);
                }
                );
            if (list != null)
            {
                page = new Paged<UserBase>(list, pageIndex, pageSize, total);
            }

            return page;
        }


    }
}
