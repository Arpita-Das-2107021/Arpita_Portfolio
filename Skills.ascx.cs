using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace finalPortfolio
{
    public partial class Skills : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindSkills();
            }
        }

        private void BindSkills()
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    // Languages
                    SqlDataAdapter da1 = new SqlDataAdapter("SELECT * FROM Skills WHERE Category='Languages' ORDER BY Name", con);
                    DataTable dt1 = new DataTable();
                    da1.Fill(dt1);
                    rptLanguages.DataSource = dt1;
                    rptLanguages.DataBind();

                    // Current Technologies
                    SqlDataAdapter da2 = new SqlDataAdapter("SELECT * FROM Skills WHERE Category='Current Technologies' ORDER BY Name", con);
                    DataTable dt2 = new DataTable();
                    da2.Fill(dt2);
                    rptTechnologies.DataSource = dt2;
                    rptTechnologies.DataBind();

                    // Tools
                    SqlDataAdapter da3 = new SqlDataAdapter("SELECT * FROM Skills WHERE Category='Tools' ORDER BY Name", con);
                    DataTable dt3 = new DataTable();
                    da3.Fill(dt3);
                    rptTools.DataSource = dt3;
                    rptTools.DataBind();
                }
            }
            catch (Exception ex)
            {
                // For debugging only: display error on page
                Response.Write("<div style='color:red'>" + ex.Message + "</div>");
            }
        }
    }
}
