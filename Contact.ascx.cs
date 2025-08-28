using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace finalPortfolio
{
    public partial class Contact : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //this.Page.MaintainScrollPositionOnPostBack = true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //System.IO.File.AppendAllText(Server.MapPath("~/log.txt"), "Button clicked at " + DateTime.Now + "\n");


            //System.Diagnostics.Debug.WriteLine("button1_Click fired");


            //lblMessage.Text = "Inside button click";
            try
            {
                string name = Request.Form["txtName"];
                string email = Request.Form["txtEmail"];
                string subject = Request.Form["txtSubject"];
                string comments = Request.Form["txtComments"];

                // Read from web.config
                string smtpUser = ConfigurationManager.AppSettings["GmailUsername"];
                string smtpPass = ConfigurationManager.AppSettings["GmailPassword"];

                MailMessage mailMessage = new MailMessage();
                mailMessage.From = new MailAddress(smtpUser);
                mailMessage.To.Add(smtpUser);
                mailMessage.Subject = "From Portfolio: " + subject;
                mailMessage.Body = "<b>Sender Name : </b>" + name + "<br/>"
                                 + "<b>Sender Email : </b>" + email + "<br/>"
                                 + "<b>Comments : </b>" + comments;
                mailMessage.IsBodyHtml = true;

                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                smtpClient.EnableSsl = true;
                smtpClient.Credentials = new System.Net.NetworkCredential(smtpUser, smtpPass);
                smtpClient.Send(mailMessage);

                lblMessage.ForeColor = System.Drawing.Color.Blue;
                lblMessage.Text = "Thank you for contacting us";
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "There is an unknown problem. Error: " + ex.Message;
            }
        }
    }

}