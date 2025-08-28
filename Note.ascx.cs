using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace finalPortfolio
{
    public partial class Note : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)

        {
            this.Page.MaintainScrollPositionOnPostBack = true;

            if (!IsPostBack)
            {
                LoadNotes();
            }
        }
        protected void noteForm_Submit(object sender, EventArgs e)
        {
            System.IO.File.AppendAllText(Server.MapPath("~/log.txt"), "noteButton clicked at " + DateTime.Now + "\n");

            System.Diagnostics.Debug.WriteLine("notesubmit_Click fired");
            string name = Request.Form["noteName"];
            string msg = Request.Form["noteMsg"];
            string drawing = Request.Form["drawingData"];

            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO db_tblPortfolioCanvas (Name, Message, DrawingImage) VALUES (@name, @msg, @img)", conn);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@msg", msg);
                cmd.Parameters.AddWithValue("@img", drawing);
                cmd.ExecuteNonQuery();
            }

            LoadNotes(); // Refresh notes after insert
                         // Redirect to avoid duplicate submissions on refresh
                         //Response.Redirect(Request.RawUrl);
        }

        private void LoadNotes()
        {
            System.IO.File.AppendAllText(Server.MapPath("~/log.txt"), "loadclicked at " + DateTime.Now + "\n");

            System.Diagnostics.Debug.WriteLine("loadnotes_Click fired");
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
            int totalCount = 0;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(
                    "SELECT Name, Message, DrawingImage FROM db_tblPortfolioCanvas ORDER BY CreatedAt DESC", conn);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    // ❗ FIX: Clear Literal text before appending
                    notesBoard.Text = "";

                    string notesHtml = "";
                    while (reader.Read())
                    {
                        string name = reader["Name"].ToString();
                        string msg = reader["Message"].ToString();
                        string img = reader["DrawingImage"].ToString();

                        notesHtml += $@"
                            <div class='note-card'>
                                <img src='{img}' style='width:140px;height:100px;background:#fff;border-radius:5px;margin-bottom:10px;box-shadow:0 1px 6px #0005;' />
                                <div class='note-name'>{Server.HtmlEncode(name)}</div>
                                <div class='note-msg'>{Server.HtmlEncode(msg)}</div>
                            </div>";

                        totalCount++;
                    }

                    notesBoard.Text = notesHtml;
                }

                noteCount.Text = totalCount.ToString();
            }
        }
    }
}