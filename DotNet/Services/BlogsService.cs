using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
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
    public class BlogsService : IBlogService
    {
        IDataProvider _data = null;
        IUserMapper _userMapper = null;
        ILookUp _lookMapper = null;
        public BlogsService(IDataProvider data, IUserMapper mapper, ILookUp lookMapper)
        {
            _data = data;
            _userMapper = mapper;
            _lookMapper = lookMapper;
        }

        public Blog Get(int id)
        {
            string procName = "[dbo].[Blogs_Select_ById]";

            Blog blog = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Id", id);

            }, delegate (IDataReader reader, short set)
            {
                int Index = 0;

                blog = MapBlog(reader, ref Index);
            });

            return blog;
        }
        public Paged<Blog> GetAllPagination(int pageIndex, int pageSize)
        {
            Paged<Blog> blogList = null;
            List<Blog> list = null;
            int totalCount = 0;

            string procName = "[dbo].[Blogs_SelectAll]";

            _data.ExecuteCmd(procName, (col) =>
            {
                col.AddWithValue("@pageIndex", pageIndex);
                col.AddWithValue("@pageSize", pageSize);
            },
            (reader, recordSetIndex) =>
            {
                int Index = 0;
                Blog aBlog = MapBlog(reader, ref Index);

                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(Index++);
                }

                if (list == null)
                {
                    list = new List<Blog>();
                }
                list.Add(aBlog);
            });
            if (list != null)
            {
                blogList = new Paged<Blog>(list, pageIndex, pageSize, totalCount);
            }

            return blogList;
        }
        public Paged<Blog> PaginateType(int pageIndex, int pageSize, string query, int blogTypeId)
        {
            Paged<Blog> blogList = null;
            List<Blog> list = null;
            int totalCount = 0;

            string procName = "[dbo].[Blogs_Select_BlogCategory]";

            _data.ExecuteCmd(procName, (col) =>
            {
                col.AddWithValue("@pageIndex", pageIndex);
                col.AddWithValue("@pageSize", pageSize);
                col.AddWithValue("@query", query);
                col.AddWithValue("@blogTypeId", blogTypeId);

            }, (reader, recordSetIndex) =>
            {
                int Index = 0;

                Blog blog = MapBlog(reader, ref Index);

                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(Index);
                }

                if (list == null)
                {
                    list = new List<Blog>();
                }
                list.Add(blog);
            });

            if (list != null)
            {
                blogList = new Paged<Blog>(list, pageIndex, pageSize, totalCount);
            }

            return blogList;
        }

        private Blog MapBlog(IDataReader reader, ref int Index)
        {
            Blog myBlog = new Blog();

            myBlog.Id = reader.GetSafeInt32(Index++);
            myBlog.Type = _lookMapper.MapLookup(reader, ref Index);
            myBlog.Author = _userMapper.Map(reader, ref Index);
            myBlog.Title = reader.GetSafeString(Index++);
            myBlog.Subject = reader.GetSafeString(Index++);
            myBlog.Content = reader.GetSafeString(Index++);
            myBlog.IsPublished = reader.GetSafeBool(Index++);
            myBlog.ImageUrl = reader.GetSafeString(Index++);
            myBlog.DateCreated = reader.GetSafeDateTime(Index++);
            myBlog.DateModified = reader.GetSafeDateTime(Index++);
            myBlog.DatePublished = reader.GetSafeDateTime(Index++);
            myBlog.Status = _lookMapper.MapLookup(reader, ref Index);
                                                                        
            return myBlog;
        }
    }

}

