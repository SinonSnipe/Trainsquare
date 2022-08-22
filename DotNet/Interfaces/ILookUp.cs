﻿using Sabio.Models.Domain;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
    public interface ILookUp
    {
        LookUp MapLookup(IDataReader reader, ref int startingIndex);
    }
}