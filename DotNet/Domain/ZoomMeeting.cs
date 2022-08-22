using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class ZoomMeeting
    {
        public string uuid { get; set; }
        public float id { get; set; }
        public string host_id { get; set; }
        public string host_email { get; set; }
        public string topic { get; set; }
        public int type { get; set; }
        public string status { get; set; }
        public DateTime start_time { get; set; }
        public int duration { get; set; }
        public string timezone { get; set; }
        public DateTime created_at { get; set; }
        public string start_url { get; set; }
        public string join_url { get; set; }
        public ZoomSettingsResponse settings { get; set; }
        public bool pre_schedule { get; set; }
    
    }
}
