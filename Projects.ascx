<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Projects.ascx.cs" Inherits="finalPortfolio.projects" %>
<section class="projects">
    <div class="dummy"></div>
    <div class="projects-stack">
        <div class="my-blank">
            <h2 class="my-blank"><i class="fa-solid fa-building-shield"></i>&nbsp; My projects:</h2>
        </div>
        <asp:Repeater ID="projectRepeater" runat="server">
            <ItemTemplate>
                <div class="project-card <%# Container.ItemIndex % 2 == 0 ? "left" : "right" %>">
                    <div class="project-image" style="background-image: url('<%# Eval("image") %>');"></div>
                    <div class="project-details">
                        <div class="type"><%# string.Join(" / ", (List<string>)Eval("tech")) %></div>
                        <h2><%# Eval("title") %></h2>
                        <p><%# Eval("description") %></p>
                        <a href='<%# Eval("link") %>' target="_blank">View on GitHub</a>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</section>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const projectCards = document.querySelectorAll('.project-card');

        const observerOptions = {
            root: null,
            rootMargin: '0px',
            threshold: 0.15
        };

        const observer = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                    observer.unobserve(entry.target); // Animate only once
                }
            });
        }, observerOptions);

        projectCards.forEach(card => {
            observer.observe(card);
        });
    });
</script>
