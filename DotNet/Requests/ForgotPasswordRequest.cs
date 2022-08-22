﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Requests
{
    public class ForgotPasswordRequest
    {
        [Required]
        [StringLength(100, MinimumLength = 2)]
        public string Email { get; set; }
    }
}