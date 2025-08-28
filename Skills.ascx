<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Skills.ascx.cs" Inherits="finalPortfolio.Skills" %>

<section id="skills">
    <div class="dummy" id="skillDummy"></div>
    <div class="my-blank">
        <h2 class="my-blank"><i class="fa-solid fa-gears"></i>&nbsp;My skills:</h2>
    </div>

    <!-- Languages -->
    <div class="skill-div">
        <h2>Languages</h2>
        <p>These are some of the languages that I am proficient at.</p>
        <div class="tech-grid">
            <asp:Repeater ID="rptLanguages" runat="server">
                <ItemTemplate>
                    <div class="tech-card">
                        <div class="tech-icon">
                            <img src='<%# Eval("IconUrl") %>' alt='<%# Eval("Name") %>' />
                        </div>
                        <div>
                            <h2><%# Eval("Name") %></h2>
                            <p><%# Eval("Description") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- Current Technologies -->
    <div class="skill-div">
        <h2>Current Technologies</h2>
        <p>These are some of my main technologies.</p>
        <div class="tech-grid">
            <asp:Repeater ID="rptTechnologies" runat="server">
                <ItemTemplate>
                    <div class="tech-card">
                        <div class="tech-icon">
                            <img src='<%# Eval("IconUrl") %>' alt='<%# Eval("Name") %>' />
                        </div>
                        <div>
                            <h2><%# Eval("Name") %></h2>
                            <p><%# Eval("Description") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- Tools -->
    <div class="skill-div">
        <h2>Tools</h2>
        <p>These are some of the tools I am currently using.</p>
        <div class="tech-grid">
            <asp:Repeater ID="rptTools" runat="server">
                <ItemTemplate>
                    <div class="tech-card">
                        <div class="tech-icon">
                            <img src='<%# Eval("IconUrl") %>' alt='<%# Eval("Name") %>' />
                        </div>
                        <div>
                            <h2><%# Eval("Name") %></h2>
                            <p><%# Eval("Description") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</section>

<script>
    // animation observer (same as before)
    document.addEventListener('DOMContentLoaded', function () {
        const skillDivs = document.querySelectorAll('.skill-div');

        const observer = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                    observer.unobserve(entry.target);
                }
            });
        }, { threshold: 0.15 });

        skillDivs.forEach(div => observer.observe(div));
    });
</script>
