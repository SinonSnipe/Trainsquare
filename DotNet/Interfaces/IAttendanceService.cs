﻿using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Attendance;

namespace Sabio.Services
{
    public interface IAttendanceService
    {
        int Add(AttendanceAddRequest model);
        Attendance GetById(int id);

        void Update(AttendanceUpdateRequest model);

        void Delete(int id);

        Paged<Attendance> Pagination(int pageIndex, int pageSize, int sessionId);

        Paged<Attendance> GetAll(int pageIndex, int pageSize);

        Paged<Attendance> GetByUserId(int pageIndex, int pageSize, int currentUserId);


    }
}