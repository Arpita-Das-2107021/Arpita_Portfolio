using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace finalPortfolio
{
    public partial class projects : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string url = ConfigurationManager.AppSettings["MyProjectList"];
                using (WebClient client = new WebClient())
                {
                    try
                    {
                        string json = client.DownloadString(url);
                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        List<Project> projects = serializer.Deserialize<List<Project>>(json);
                        projectRepeater.DataSource = projects;
                        projectRepeater.DataBind();
                    }
                    catch (Exception ex)
                    {
                        // Handle errors (log or show fallback message)
                        Response.Write("<p style='color:red;'>Error loading projects: " + ex.Message + "</p>");
                    }
                }
            }
        }
    }
}