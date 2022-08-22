using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public enum EntityBusinessType : int
    {
        NotSet = 0,
        PrivateNonCommercial = 1,
        InformationAndCommunicationsTechnology = 2,
        Publishing = 3,
        InvestmentAndFinance = 4,
        Travel = 5,
        Entertainment = 6,
        SportsAndOutdoors = 7,
        Training = 8,
        Workshop = 9,
        NGO = 10,
    }
}
