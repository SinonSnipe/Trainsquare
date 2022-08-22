﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public  class UserChangePassword
    {
        [Required]
        [DataType(DataType.Password)]
        [RegularExpression(@"^.*(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!*@#$%^&+=]).*$",
         ErrorMessage = "OldPassword must be a minimum of 8 characters and contain at least one letter, one number, and one special character")]
        [StringLength(100, MinimumLength = 2)]
        public string OriginalPassword { get; set; }
    }
}
