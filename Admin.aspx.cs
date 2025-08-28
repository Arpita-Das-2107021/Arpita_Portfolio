using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portfolio
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["admin"] != "1")
            {
                Response.Redirect("Default.aspx");
            }

            if (!IsPostBack)
            {
                if (Session["IsAdmin"] != null && (bool)Session["IsAdmin"])
                {
                    ShowAdminPanel();
                    BindNotes();
                }
                else
                {
                    pnlLogin.Visible = true;
                    btnLogout.Visible = false;
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string user = ConfigurationManager.AppSettings["AdminUser"];
            string pass = ConfigurationManager.AppSettings["AdminPass"];

            if (txtUser.Text == user && txtPass.Text == pass)
            {
                Session["IsAdmin"] = true;
                ShowAdminPanel();
            }
            else
            {
                lblMsg.Text = "Invalid login!";
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("MainContent.aspx");
        }

        private void ShowAdminPanel()
        {
            pnlLogin.Visible = false;
            pnlAdmin.Visible = true;
            pnlEdit.Visible = false;
            btnLogout.Visible = true;
            BindSkills();
            BindNotes();
        }

        #region Skills CRUD
        private void BindSkills()
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Skills ORDER BY Category, Name", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptSkills.DataSource = dt;
                rptSkills.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtNewSkill.Text) &&
                !string.IsNullOrWhiteSpace(txtCategory.Text) &&
                !string.IsNullOrWhiteSpace(txtDescription.Text) &&
                !string.IsNullOrWhiteSpace(txtIconUrl.Text))
            {
                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "INSERT INTO Skills (Category, Name, Description, IconUrl) VALUES (@Category, @Name, @Description, @IconUrl)";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Category", txtCategory.Text.Trim());
                        cmd.Parameters.AddWithValue("@Name", txtNewSkill.Text.Trim());
                        cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@IconUrl", txtIconUrl.Text.Trim());
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                txtCategory.Text = "";
                txtNewSkill.Text = "";
                txtDescription.Text = "";
                txtIconUrl.Text = "";
                BindSkills();
            }
        }

        protected void rptSkills_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int skillId = Convert.ToInt32(e.CommandArgument);
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

            if (e.CommandName == "Delete")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "DELETE FROM Skills WHERE SkillId=@SkillId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@SkillId", skillId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindSkills();
            }
            else if (e.CommandName == "Edit")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "SELECT * FROM Skills WHERE SkillId=@SkillId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@SkillId", skillId);
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                hfEditSkillId.Value = skillId.ToString();
                                txtEditCategory.Text = reader["Category"].ToString();
                                txtEditName.Text = reader["Name"].ToString();
                                txtEditDescription.Text = reader["Description"].ToString();
                                txtEditIconUrl.Text = reader["IconUrl"].ToString();
                                pnlEdit.Visible = true;

                                // Scroll to edit panel
                                ScriptManager.RegisterStartupScript(
                                    this,
                                    this.GetType(),
                                    "scrollToEdit",
                                    "setTimeout(function(){ document.getElementById('" + pnlEdit.ClientID + "').scrollIntoView({ behavior: 'smooth' }); }, 200);",
                                    true
                                );
                            }
                        }
                    }
                }
            }
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int skillId = int.Parse(hfEditSkillId.Value);
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "UPDATE Skills SET Category=@Category, Name=@Name, Description=@Description, IconUrl=@IconUrl WHERE SkillId=@SkillId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Category", txtEditCategory.Text.Trim());
                    cmd.Parameters.AddWithValue("@Name", txtEditName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Description", txtEditDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@IconUrl", txtEditIconUrl.Text.Trim());
                    cmd.Parameters.AddWithValue("@SkillId", skillId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            pnlEdit.Visible = false;
            BindSkills();
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            pnlEdit.Visible = false;
        }
        #endregion

        #region Notes CRUD
        private void BindNotes()
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Id, Name, Message, DrawingImage FROM db_tblPortfolioCanvas ORDER BY Id DESC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        rptNotes.DataSource = dt;
                        rptNotes.DataBind();
                    }
                }
            }
        }

        protected void rptNotes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteNote")
            {
                int noteId = Convert.ToInt32(e.CommandArgument);
                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "DELETE FROM db_tblPortfolioCanvas WHERE Id=@Id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", noteId);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindNotes(); // Refresh notes
            }
        }
        #endregion
    }
}
