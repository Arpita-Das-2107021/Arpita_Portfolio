<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Contact.ascx.cs" Inherits="finalPortfolio.Contact" %>
<section class="contact-info-form" id="contact-section">
    <asp:UpdatePanel ID="up1" runat="server">
        <ContentTemplate>
            <!-- Left Info Panel -->
            <div class="contact-info">
                <h2>Lets talk<br>
                    on something <span>great</span><br>
                    together...</h2>
                <ul class="info-list">
                    <li><a href="mailto:arpitadas59321@gmail.com" class="email-btn"><i class="fas fa-envelope"></i>arpitadas59321@gmail.com</a></li>
                    <li><a href="tel:+8801234567890" class="call-btn"><i class="fas fa-phone"></i>+8801*****5509</a></li>
                    <li><a href="https://maps.app.goo.gl/uXFnMh9ZKjxd7gtB6" target="_blank"><i class="fas fa-map-marker-alt"></i>Gazipur, Bangladesh</a></li>
                    <!-- WG23+8G3 KUET, Khulna 9203 -->
                </ul>
                <div class="social-icons">
                    <a href="https://www.facebook.com/arpita.das.500316/" target="_blank"><i
                        class="fab fa-facebook"></i></a>
                    <a href="https://t.me/arpitadas321 " target="_blank"><i class="fab fa-telegram"></i></a>
                    <a href="https://m.me/arpita.das.500316 " target="_blank"><i class="fab fa-facebook-messenger"></i></a>
                </div>
            </div>
            <div class="formFun">
                <fieldset class="field" style="border: none; padding: 0;">
                    <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Text="Let's connect..." Style="width: 300px; display: flex; justify-content: center; color: var(--base-text-color); margin-bottom: 15px;" />
                    <div class="input-fields">
                        <input type="text" id="txtName" name="txtName" placeholder="Your name" />
                        <span id="errName" class="error">*</span>
                    </div>

                    <div class="input-fields">
                        <input type="email" id="txtEmail" name="txtEmail" placeholder="Your email" />
                        <span id="errEmail" class="error">*</span>
                    </div>

                    <div class="input-fields">
                        <input type="text" id="txtSubject" name="txtSubject" placeholder="Your subject" />
                        <span id="errSubject" class="error">*</span>
                    </div>

                    <img src="/assets/keyboard-meme-2.png" alt="Typing animation" />

                    <!-- <img src="/assets/fast-typing.gif" alt="Typing animation" /> -->


                    <div class="input-fields">
                        <textarea id="txtComments" name="txtComments" rows="5" placeholder="Your message"></textarea>
                        <span id="errComments" class="error">*</span>
                    </div>
                    <asp:Button ID="Button1" runat="server" Text="SubmitForm" OnClick="Button1_Click" CausesValidation="false"
                        Style="display: none;" />
                    <button type="button" onclick="submitIfValid()">Send</button>
                </fieldset>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="Button1" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</section>


<script type="text/javascript">
    function validateForm() {
        var isValid = true;

        var name = document.getElementById("txtName").value.trim();
        var email = document.getElementById("txtEmail").value.trim();
        var subject = document.getElementById("txtSubject").value.trim();
        var comments = document.getElementById("txtComments").value.trim();

        // Clear all errors
        document.getElementById("errName").innerText = "";
        document.getElementById("errEmail").innerText = "";
        document.getElementById("errSubject").innerText = "";
        document.getElementById("errComments").innerText = "";

        if (name === "") {
            document.getElementById("errName").innerText = "*";
            isValid = false;
        }
        if (email === "") {
            document.getElementById("errEmail").innerText = "*";
            isValid = false;
        }
        if (subject === "") {
            document.getElementById("errSubject").innerText = "*";
            isValid = false;
        }
        if (comments === "") {
            document.getElementById("errComments").innerText = "*";
            isValid = false;
        }

        return isValid;
    }

    function submitIfValid() {
        if (validateForm()) {
            // Trigger ASP.NET button click
            document.getElementById("<%= Button1.ClientID %>").click();
            console.log("clicked");
        }
    }
</script>
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        var contactSection = document.getElementById("contact-section");
        var contactInfo = contactSection.querySelector(".contact-info");
        var formFun = contactSection.querySelector(".formFun");

        var observer = new window.IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    contactInfo.classList.add("slide-in-left");
                    formFun.classList.add("slide-in-right");
                    observer.disconnect();
                }
            });
        }, { threshold: 0.3 });

        observer.observe(contactSection);
    });
    // Add this to a JS file loaded on the page (e.g., baseWrapper.js or note.js)
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
        document.querySelectorAll('.contact-info').forEach(function (el) {
            el.style.opacity = "1";
            el.style.transform = "translateX(0)";
        });
        document.querySelectorAll('.formFun').forEach(function (el) {
            el.style.opacity = "1";
            el.style.transform = "translateX(0)";
        });
    });
</script>
