<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Home.ascx.cs" Inherits="finalPortfolio.Home" %>

<section id="heroSection" class="hero-section">
    <div class="leftSide animated">
        <div class="personal-intro">
            <div class="profile-img">
                <img id="profile-img" src="/assets/profile.jpg" alt="Picture- Arpita Das"></div>
            <div class="name-location">
                <h3 class="animated-text">Hey, I'm Arpita Das</h3>
                <div class="location">
                    <a href="https://maps.app.goo.gl/uXFnMh9ZKjxd7gtB6" target="_blank"><i
                        class="fa-solid fa-location-dot"></i></a>
                    <span>Gazipur, Bangladesh</span>
                </div>
            </div>
        </div>
        <div class="professional-intro">
            <p id="short-desc">
                I'm a 3rd year CSE undergraduate student studying in Khulna University of Engineering and
                    Technology aiming to be a Machine Learning Engineer.
            </p>
        </div>
        <div class="social-cv">
            <!-- <div class="social-icon-btn"> -->
            <a href="https://github.com/Arpita-Das-2107021" target="_blank">
                <i class="fa-brands fab fa-github"></i></a>
            <a href="https://www.facebook.com/arpita.das.500316/" target="_blank"><i
                class="fab fa-facebook"></i></a>
            <a href="https://t.me/arpitadas321 " target="_blank"><i class="fab fa-telegram"></i></a>
            <a href="/assets/Arpita_Das_Resume.pdf" class="download-btn" download>
                <i class="fa-solid fa-download"></i>
                <span>Download CV</span>
            </a>

            <!-- </div> -->
            <!-- <div class="social-shelf">

                </div> -->
        </div>
    </div>
    <div class="rightSide animated">
        <div class="code-card">
            <div class="header">
                <div class="circles">
                    <div class="circle red"></div>
                    <div class="circle yellow"></div>
                    <div class="circle green"></div>
                </div>
                <span style="color: white;">webdev.js</span>
            </div>
            <div class="code">
                <p>// CSE Student</p>
                <p>const mlEngineer = {</p>
                <p class="move">name: 'Arpita Das',</p>
                <p class="move">project: 'Portfolio',</p>
              <div class="move" id="lineB" style="display: flex;"> <p >techs: ['HTML', 'CSS',</p><p id="spaceB"> 'JS', '.net'],</p></div> 
                <p class="move">tools: 'Visual Studio'</p>
                <p>};</p>
            </div>

        </div>
    </div>
</section>
