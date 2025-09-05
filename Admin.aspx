<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Portfolio.Admin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Panel</title>
    <link rel="icon" href="/assets/Crime-Man-Riot-1--Streamline-Ultimate.png" alt="Portfolio logo of Arpita Das" type="image/svg+xml" />
    <link href="/stylesheets/admin.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager2" runat="server" />
        <div class="container">
            <!-- Login Panel -->
            <asp:Panel ID="pnlLogin" runat="server">
                <div class="admin-container">
                    <h2 style="text-align: center;"><i class="fa-solid fa-user-tie"></i>&nbsp;Admin Login</h2>
                    <div style="margin-bottom: 15px;">
                        <asp:Label Text="Username" runat="server" /><br />
                        <asp:TextBox ID="txtUser" runat="server" CssClass="input" />
                    </div>
                    <div style="margin-bottom: 15px;">
                        <asp:Label Text="Password" runat="server" /><br />
                        <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="input" />
                    </div>
                    <div class="rememberMe">
                        <asp:CheckBox ID="chkRememberMe" runat="server" CssClass="remMe"/>
                        <label for="chkRememberMe">Remember Me</label>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn" />
                    <br />
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red" /> <br />
                    <asp:Button ID="btnForgotPassword" runat="server" Text="Forgot Password?" CssClass="btnForgot" OnClick="btnForgotPassword_Click" />
                </div>
            </asp:Panel>
            <!-- End Login Panel -->

            <!-- Admin Panel -->
            <asp:Panel ID="pnlAdmin" runat="server" Visible="false">
                <div class="admin-dashboard-header">
                    <i class="fa-solid fa-user-tie"></i>&nbsp;Admin Dashboard
                </div>
                <div class="admin-wrapper">
                    <!-- Sidebar -->
                    <nav class="admin-sidebar">
                        <button type="button" id="btnShowSkills" class="active"><i class="fa-solid fa-user-gear"></i>&nbspManage Skills</button>
                        <button type="button" id="btnShowNotes"><i class="fa-solid fa-note-sticky"></i>&nbspManage Notes</button>
                        <button type="button" id="btnPortfolioSidebar"><i class="fa-regular fa-user"></i>&nbspPortfolio</button>
                        <button type="button" id="btnLogoutSidebar"><i class="fa-solid fa-right-from-bracket"></i>&nbspLogout</button>
                        <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="btnLogout_Click" Style="display: none;" />
                        <asp:Button ID="btnPortfolio" runat="server" Text="Logout" CssClass="btn-logout" OnClick="btnPortfolio_Click" Style="display: none;" />
                    </nav>
                    <!-- Main Content -->
                    <div class="admin-content">
                        <div id="addSkillSection">
                            <h3><i class="fa-solid fa-pen"></i>&nbsp;Add Skill</h3>
                            <asp:TextBox ID="txtCategory" runat="server" CssClass="input" Placeholder="Category" />
                            <asp:TextBox ID="txtNewSkill" runat="server" CssClass="input" Placeholder="Name" />
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="input" Placeholder="Description" />
                            <asp:TextBox ID="txtIconUrl" runat="server" CssClass="input" Placeholder="Icon URL" />
                            <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" CssClass="btn" />
                        </div>
                        <div id="skillsSection">
                            <h2><i class="fa-solid fa-user-gear"></i>&nbsp;Manage Skills</h2>
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
                            <asp:Panel ID="pnlEdit" runat="server" Visible="false">
                                <h3><i class="fa-solid fa-pen-to-square"></i>&nbsp;Edit Skill</h3>
                                <asp:HiddenField ID="hfEditSkillId" runat="server" />
                                <asp:TextBox ID="txtEditCategory" runat="server" CssClass="input" Placeholder="Category" />
                                <asp:TextBox ID="txtEditName" runat="server" CssClass="input" Placeholder="Name" />
                                <asp:TextBox ID="txtEditDescription" runat="server" CssClass="input" Placeholder="Description" />
                                <asp:TextBox ID="txtEditIconUrl" runat="server" CssClass="input" Placeholder="Icon URL" />
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CssClass="btn" />
                                <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" OnClick="btnCancelEdit_Click" CssClass="btn" />
                            </asp:Panel>
                        </div>
                        <div id="notesSection" style="display: none;">
                            <h2><i class="fa-solid fa-note-sticky"></i>&nbsp;Manage Notes</h2>
                            <asp:Repeater ID="rptNotes" runat="server" OnItemCommand="rptNotes_ItemCommand">
                                <ItemTemplate>
                                    <div class="note-admin">
                                        <div class='note-info'>
                                            <strong><%# Eval("Name") %>:</strong> <%# Eval("Message") %>
                                            <div class="note-delete">
                                                <asp:Button runat="server"
                                                    CommandName="DeleteNote"
                                                    CommandArgument='<%# Eval("Id") %>'
                                                    Text="Delete"
                                                    CssClass="btn-delete"
                                                    OnClientClick="return confirm('Are you sure you want to delete this note?');" />
                                            </div>
                                        </div>
                                        <br />
                                        <img src='<%# Eval("DrawingImage") %>' alt="canvas" class="note-image" />
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <!-- End Admin Panel -->
        </div>
    </form>
    <script type="text/javascript">
        window.onload = function () {
            document.getElementById('notesSection').style.display = 'none';

            function setActive(btnId) {
                var buttons = document.querySelectorAll('.admin-sidebar button');
                buttons.forEach(function (btn) { btn.classList.remove('active'); });
                var activeBtn = document.getElementById(btnId);
                if (activeBtn) activeBtn.classList.add('active');
            }

            var btnShowSkills = document.getElementById('btnShowSkills');
            var btnShowNotes = document.getElementById('btnShowNotes');
            var btnLogoutSidebar = document.getElementById('btnLogoutSidebar');
            var btnPortfolioSidebar = document.getElementById('btnPortfolioSidebar');

            if (btnShowSkills) {
                btnShowSkills.onclick = function () {
                    setActive('btnShowSkills');
                    document.getElementById('addSkillSection').style.display = '';
                    document.getElementById('skillsSection').style.display = '';
                    document.getElementById('notesSection').style.display = 'none';
                };
            }
            if (btnShowNotes) {
                btnShowNotes.onclick = function () {
                    setActive('btnShowNotes');
                    document.getElementById('addSkillSection').style.display = 'none';
                    document.getElementById('skillsSection').style.display = 'none';
                    document.getElementById('notesSection').style.display = '';
                };
            }
            if (btnPortfolioSidebar) {
                btnPortfolioSidebar.onclick = function () {
                    var aspBtn0 = document.getElementById('<%= btnPortfolio.ClientID %>');
                    if (aspBtn0) aspBtn0.click();
                };
            }
            if (btnLogoutSidebar) {
                btnLogoutSidebar.onclick = function () {
                    var aspBtn = document.getElementById('<%= btnLogout.ClientID %>');
                    if (aspBtn) aspBtn.click();
                };
            }
        };
    </script>
</body>
</html>