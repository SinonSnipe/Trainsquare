﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests.Comments
{
    public class CommentsUpdateRequest : CommentsAddRequest , IModelIdentifier
    {
        public int Id { get; set; }
    }
}
