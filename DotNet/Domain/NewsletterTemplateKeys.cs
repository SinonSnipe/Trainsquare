﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class NewsletterTemplateKeys
    {
        public int Id { get; set; }
        public LookUp KeyTypeId { get; set; }
        public int TemplateId { get; set; }
        public string KeyName { get; set; }

    }
}
