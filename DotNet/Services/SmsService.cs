using Microsoft.Extensions.Options;
using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models.AppSettings;
using Sabio.Models.Domain;
using Sabio.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Twilio;
using Twilio.Rest.Api.V2010.Account;
using Twilio.Types;

namespace Sabio.Services
{
    public class SmsService : ISmsService
    {
        private IDataProvider _dataProvider;
        private AppKeys _appKeys;
        IUserMapper _userMapper = null;
        ILookUp _lookMapper = null;

        public SmsService(IDataProvider dataProvider,
            IOptions<AppKeys> appKeys,
            IUserMapper mapper, ILookUp lookMapper)
        {
            _dataProvider = dataProvider;
            _appKeys = appKeys.Value;
            _userMapper = mapper;
            _lookMapper = lookMapper;
        }




        public void TestSendSms(string code)
        {
            string accountSid = new(_appKeys.TWILIO_ACCOUNT_SID);
            string authToken = new(_appKeys.TWILIO_AUTH_TOKEN);

            TwilioClient.Init(accountSid, authToken);

            var twoFactorMessage = "Your Code is: ";

            var to = new PhoneNumber("+19292440524");
            var message = MessageResource.Create(
                to,
                from: new PhoneNumber("+19147682867"),
                body: twoFactorMessage + code);
        }



        public int Add(int userId, string code)
        {   

            string procName = "[dbo].[TwoFactorAuthenticationCodes_Insert]";
            int id = 0;           

            _dataProvider.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                AddCommonParams(col, userId, code);
                
                SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                idOut.Direction = ParameterDirection.Output;
                col.Add(idOut);
            },
            returnParameters: delegate (SqlParameterCollection returnCollection)
            {
                object oId = returnCollection["@Id"].Value;

                int.TryParse(oId.ToString(), out id);
            });
            return id;            
        }

        public void Delete(int userId)
        {

            string procName = "[dbo].[TwoFactorAuthenticationCodes_Delete]";

            _dataProvider.ExecuteNonQuery(procName, delegate (SqlParameterCollection paramCollection)
            {

                paramCollection.AddWithValue("@UserId", userId);

            });

        }

        public TwoFactorAuthentication GetById(int userId)
        {
            string procName = "dbo.TwoFactorAuthentication_Select_ByUserId";
            TwoFactorAuthentication twoFactorAuthentication = null;

            _dataProvider.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@UserId", userId);
            }, delegate (IDataReader reader, short set)
            {
                int startidx = 0;
                twoFactorAuthentication = MapTfa(reader, ref startidx);
            });
            return twoFactorAuthentication;
        }

        public string GenerateRandomNumber()
        {
            Random random = new Random();
            var secretNumber = random.Next(0, 999999);
            var s = secretNumber.ToString("000000");

            return s;
        }

        private TwoFactorAuthentication MapTfa(IDataReader reader, ref int startingIndex)
        {
            TwoFactorAuthentication aTfa = new TwoFactorAuthentication();

            aTfa.Id = reader.GetSafeInt32(startingIndex++);
            aTfa.User = _userMapper.Map(reader, ref startingIndex);
            aTfa.PhoneNumber = reader.GetSafeString(startingIndex++);
            aTfa.Status = _lookMapper.MapLookup(reader, ref startingIndex);
            aTfa.IsTwoFactorEnabled = reader.GetSafeBool(startingIndex++);
            aTfa.TwoFactorType = _lookMapper.MapLookup(reader, ref startingIndex);
            aTfa.Code = reader.GetSafeString(startingIndex++);
            aTfa.Attempt = reader.GetSafeString(startingIndex++);            
            aTfa.DateCreated = reader.GetSafeDateTime(startingIndex++);
            aTfa.DateModified = reader.GetSafeDateTime(startingIndex++);
            
            return aTfa;
        }


        private static void AddCommonParams(SqlParameterCollection col, int userId, string code)
        {
            col.AddWithValue("@UserId", userId);
            col.AddWithValue("@Code", code);
            
        }

    }
}
