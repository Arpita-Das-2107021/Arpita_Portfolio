<%@ Page Title="" Language="C#" MasterPageFile="~/BaseWrapper.Master" AutoEventWireup="true" CodeBehind="MainContent.aspx.cs" Inherits="finalPortfolio.MainContent" %>

<%@ Register Src="~/Home.ascx" TagName="Home" TagPrefix="uc" %>
<%@ Register Src="~/Skills.ascx" TagName="Skills" TagPrefix="uc" %>
<%@ Register Src="~/Projects.ascx" TagPrefix="uc" TagName="Projects" %>
<%@ Register Src="~/Education.ascx" TagPrefix="uc" TagName="Education" %>
<%@ Register Src="~/Contact.ascx" TagPrefix="uc" TagName="Contact" %>
<%@ Register Src="~/Note.ascx" TagPrefix="uc" TagName="Note" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div id="home">
        <uc:Home runat="server" ID="ucHome" />
    </div>
    <div id="skills">
        <uc:Skills runat="server" ID="ucSkills" />
    </div>
    <div id="projects">
        <uc:Projects ID="ucProjects" runat="server" />
    </div>
    <div id="educationSection">
        <uc:Education ID="ucEducation" runat="server" />
    </div>
    <div id="contact">
        <uc:Contact ID="ucContact" runat="server" />
    </div>
    <div id="note">
        <uc:Note ID="ucNote" runat="server" />
    </div>

</asp:Content>
