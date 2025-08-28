<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Portfolio.Admin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Panel</title>
    <link rel="icon" href="/assets/Crime-Man-Riot-1--Streamline-Ultimate.png" alt="Portfolio logo of Arpita Das" type="image/svg+xml" />
    <link href="/stylesheets/admin.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager2" runat="server" />
        <div class="container">
            <!-- Login Panel -->
            <asp:Panel ID="pnlLogin" runat="server">
                <h2>Admin Login</h2>
                <asp:Label Text="Username" runat="server" /><br />
                <asp:TextBox ID="txtUser" runat="server" CssClass="input" /><br />
                <asp:Label Text="Password" runat="server" /><br />
                <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="input" /><br />
                <br />
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn" />
                <asp:Label ID="lblMsg" runat="server" ForeColor="Red" />
            </asp:Panel>

            <!-- Logout Button -->
            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="btnLogout_Click" Visible="false" />

            <!-- Admin Panel -->
            <asp:UpdatePanel ID="upAdmin" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="pnlAdmin" runat="server" Visible="false">
                        <h2>Manage Skills</h2>
                        <asp:Repeater ID="rptSkills" runat="server" OnItemCommand="rptSkills_ItemCommand">
                            <ItemTemplate>
                                <div class="skill">
                                    <strong><%# Eval("Category") %></strong> -
                                    <asp:Label runat="server" Text='<%# Eval("Name") %>' />
                                    (<%# Eval("Description") %>)
                                    <img src='<%# Eval("IconUrl") %>' alt="icon" style="height: 24px; vertical-align: middle;" />
                                    <asp:Button runat="server" CommandName="Edit" CommandArgument='<%# Eval("SkillId") %>' Text="Edit" CssClass="btn-edit" />
                                    <asp:Button runat="server" CommandName="Delete" CommandArgument='<%# Eval("SkillId") %>'
                                        Text="Delete" CssClass="btn-delete"
                                        OnClientClick="return confirm('Are you sure you want to delete this skill?');" />
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <h3>Add Skill</h3>
                        <asp:TextBox ID="txtCategory" runat="server" CssClass="input" Placeholder="Category" />
                        <asp:TextBox ID="txtNewSkill" runat="server" CssClass="input" Placeholder="Name" />
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="input" Placeholder="Description" />
                        <asp:TextBox ID="txtIconUrl" runat="server" CssClass="input" Placeholder="Icon URL" />
                        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" CssClass="btn" />

                        <asp:Panel ID="pnlEdit" runat="server" Visible="false">
                            <h3>Edit Skill</h3>
                            <asp:HiddenField ID="hfEditSkillId" runat="server" />
                            <asp:TextBox ID="txtEditCategory" runat="server" CssClass="input" Placeholder="Category" />
                            <asp:TextBox ID="txtEditName" runat="server" CssClass="input" Placeholder="Name" />
                            <asp:TextBox ID="txtEditDescription" runat="server" CssClass="input" Placeholder="Description" />
                            <asp:TextBox ID="txtEditIconUrl" runat="server" CssClass="input" Placeholder="Icon URL" />
                            <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CssClass="btn" />
                            <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" OnClick="btnCancelEdit_Click" CssClass="btn" />
                        </asp:Panel>

                        <!-- Notes Management -->
                        <h2>Manage Notes</h2>
                        <asp:Repeater ID="rptNotes" runat="server" OnItemCommand="rptNotes_ItemCommand">
                            <ItemTemplate>
                                <div class="note-admin">
                                    <strong><%# Eval("Name") %>:</strong> <%# Eval("Message") %><br />
                                    <img src='<%# Eval("DrawingImage") %>' alt="canvas" class="note-image" />

                                    <asp:Button runat="server"
                                        CommandName="DeleteNote"
                                        CommandArgument='<%# Eval("Id") %>'
                                        Text="Delete"
                                        CssClass="btn-delete"
                                        OnClientClick="return confirm('Are you sure you want to delete this note?');" />
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>


                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
