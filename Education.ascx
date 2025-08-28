<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Education.ascx.cs" Inherits="finalPortfolio.Education" %>
<section class="education">
    <div class="dummy" id="eduDummy"></div>
    <div class="tab-buttons">
        <button type="button" class="tab-btn active" data-tab="hobby" onclick="switchTab('hobby')"><i class="fa-solid fa-bars-progress"></i>&nbsp;&nbsp;Hobby</button>
        <button type="button" class="tab-btn" data-tab="education" onclick="switchTab('education')"><i class="fa-solid fa-user-graduate"></i>&nbsp;&nbsp;Education</button>
    </div>


    <!-- Hobby Tab -->
    <div id="hobby" class="tab-content active">
        <div class="hobby-list">
            <h3>I like..</h3>
            <ul>
                <li>Solving logical and coding puzzles</li>
                <li>Maintaining streaks on any platform</li>
                <li>Learning new programming languages and tools</li>
                <li>Exploring new educational YouTube channels</li>
                <li>Reading comics, watching anime</li>

            </ul>
        </div>
    </div>

    <!-- Education Tab -->
    <div id="education" class="tab-content">
        <div class="timeline-container">
            <!-- Reversed Timeline -->
            <div class="timeline-entry leftEdu">
                <h3>Undergraduate</h3>
                <p>Institution: <a href="https://www.kuet.ac.bd" target="_blank">Khulna University of Engineering & Technology</a></p>
                <p>Department: CSE</p>
                <p>Year: 3rd</p>
                <p>CGPA: 3.86 (as of 2nd year 1st term)</p>
                <p>Year: 2023–ongoing</p>
            </div>

            <div class="timeline-entry rightEdu">
                <h3>HSC</h3>
                <p>Institution: <a href="https://mugmc.edu.bd/" target="_blank">Muminunnisa Govt. Women's College</a></p>
                <p>Department: Science</p>
                <p>GPA: 5.00 (out of 5)</p>
                <p>Scholarship: General</p>
                <p>Year: 2016</p>
            </div>

            <div class="timeline-entry leftEdu">
                <h3>SSC</h3>
                <p>Institution: <a href="https://premieridealhighschool.edu.bd/" target="_blank">Premier Ideal High School</a></p>
                <p>Department: Science</p>
                <p>GPA: 5.00 (out of 5)</p>
                <p>Scholarship: General</p>
                <p>Year: 2019</p>
            </div>

            <div class="timeline-entry rightEdu">
                <h3>JSC</h3>
                <p>Institution: <a href="https://premieridealhighschool.edu.bd/" target="_blank">Premier Ideal High School</a></p>
                <p>GPA: 5.00 (out of 5)</p>
                <p>Scholarship: General</p>
                <p>Year: 2016</p>
            </div>

            <div class="timeline-entry leftEdu">
                <h3>PSC</h3>
                <p>Institution: <a href="#">Majhukhan Govt. Primary School</a></p>
                <p>GPA: 5.00 (out of 5)</p>
                <p>Scholarship: Talent-pool</p>
                <p>Year: 2013</p>
            </div>
        </div>
    </div>
</section>
<script>
    function switchTab(tabId) {
        // Save selected tab
        localStorage.setItem('activeTab', tabId);

        // Switch tab content and buttons
        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelectorAll('.tab-content').forEach(tab => tab.classList.remove('active'));

        document.getElementById(tabId).classList.add('active');

        // Set active button (match by innerText)
        document.querySelectorAll('.tab-btn').forEach(btn => {
            if (btn.getAttribute('data-tab') === tabId.toLowerCase()) {
                btn.classList.add('active');
            }
        });
    }

    // On page load, restore active tab (default to hobby if nothing stored)
    window.onload = function () {
        const savedTab = localStorage.getItem('activeTab');
        if (savedTab === 'hobby' || savedTab === 'education') {
            switchTab(savedTab);
        } else {
            switchTab('hobby'); // initial default
        }

        // Animate the education section when it comes into view
        const educationSection = document.querySelector('.education');
        //if (!educationSection) return;

        const observer = new IntersectionObserver(function (entries, observer) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    educationSection.classList.add('animate-in');
                    observer.disconnect(); // Animate only once
                }
            });
        }, { threshold: 0.1 });

        observer.observe(educationSection);

    };


</script>
