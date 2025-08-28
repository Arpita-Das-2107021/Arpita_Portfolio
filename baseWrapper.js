function getSectionElements() {
    return [
        { id: "home", element: document.getElementById("home") },
        { id: "skills", element: document.getElementById("skills") },
        { id: "projects", element: document.getElementById("projects") },
        { id: "education", element: document.getElementById("educationSection") },
        { id: "contact", element: document.getElementById("contact") }
    ];
}

function setActiveNav(pathname) {
    document.querySelectorAll(".navbar a[data-route]").forEach(link => {
        const route = link.getAttribute("data-route").toLowerCase();
        if (route === pathname.toLowerCase()) {
            link.classList.add("active");
        } else {
            link.classList.remove("active");
        }
    });
}

function scrollToSectionByRoute(pathname) {
    const routeToId = {
        "/": "home",
        "/maincontent.aspx": "home",
        "/home": "home",
        "/skills": "skills",
        "/projects": "projects",
        "/education": "education",
        "/contact": "contact"
    };

    const targetId = routeToId[pathname.toLowerCase()];
    if (targetId) {
        const section = getSectionElements().find(s => s.id === targetId);
        if (section && section.element) {
            section.element.scrollIntoView({ behavior: "smooth" });
            setActiveNav("/" + targetId);
        }
    }
}

function highlightNavLinkOnScroll() {
    const sections = getSectionElements();
    const scrollPosition = window.scrollY || window.pageYOffset;

    if (scrollPosition < 10) {
        pushRouteIfNeeded("/home");
        setActiveNav("/home");
        return;
    }

    for (let i = sections.length - 1; i >= 0; i--) {
        const section = sections[i];
        if (section.element) {
            const rect = section.element.getBoundingClientRect();
            if (rect.top <= 80) {
                let routePath = "/" + section.id;
                if (section.id === "educationSection") routePath = "/education";
                pushRouteIfNeeded(routePath);
                setActiveNav(routePath);
                break;
            }
        }
    }
}

// Push new URL state only if different to avoid history clutter
function pushRouteIfNeeded(newPath) {
    if (window.location.pathname.toLowerCase() !== newPath.toLowerCase()) {
        history.pushState({}, "", newPath);
    }
}

// Show splash only if on home route
function shouldShowSplash(pathname) {
    const homePaths = ["/", "/maincontent.aspx", "/home"];
    return homePaths.includes(pathname.toLowerCase());
}

// Splash + content logic
function handleSplashAndContent() {
    const splash = document.getElementById("splash");
    const mainForm = document.getElementById("form1");
    const navbar = document.getElementById("head-navbar");

    const pathname = window.location.pathname.toLowerCase();
    const showSplash = shouldShowSplash(pathname);

    if (showSplash) {
        // Always show splash on home, no sessionStorage check
        splash.style.display = "flex";
        splash.style.opacity = "1";

        mainForm.style.display = "none";
        mainForm.style.opacity = "0";
        mainForm.style.pointerEvents = "none";

        navbar.style.display = "none";
        navbar.style.opacity = "0";
        navbar.style.pointerEvents = "none";

        setTimeout(() => {
            splash.style.opacity = "0"; // fade out splash

            setTimeout(() => {
                splash.style.display = "none";

                mainForm.style.display = "flex";
                navbar.style.display = "flex";

                setTimeout(() => {
                    mainForm.style.opacity = "1";
                    mainForm.style.pointerEvents = "auto";
                    navbar.style.opacity = "1";
                    navbar.style.pointerEvents = "auto";

                    highlightNavLinkOnScroll();
                }, 100);
            }, 900);
        }, 2200);
    } else {
        // For other pages — no splash, show content immediately
        splash.style.display = "none";
        splash.style.opacity = "0";

        mainForm.style.display = "flex";
        mainForm.style.opacity = "1";
        mainForm.style.pointerEvents = "auto";

        navbar.style.display = "flex";
        navbar.style.opacity = "1";
        navbar.style.pointerEvents = "auto";

        highlightNavLinkOnScroll();
    }
}

//🔍 history.replaceState(stateObj, title, url)
//stateObj  --> A JavaScript object associated with the new history entry.Often { } if not used.
//title --> Currently ignored by most browsers.Use "".
//url -->	The new URL to show in the address bar, without reloading the page.
window.addEventListener("load", () => {
    // If on root or MainContent.aspx, update URL to /home without reload
    const pathname = window.location.pathname.toLowerCase();
    if (pathname === "/" || pathname === "/maincontent.aspx") {
        history.replaceState({}, "", "/home");
    }

    handleSplashAndContent();
});

window.addEventListener("scroll", highlightNavLinkOnScroll);

// Nav click handler
document.querySelectorAll(".navbar a[data-route]").forEach(link => {
    link.addEventListener("click", function (e) {
        e.preventDefault();
        const route = link.getAttribute("data-route");
        history.pushState({}, "", route);
        scrollToSectionByRoute(route);
    });
});

// Back/forward buttons
window.addEventListener("popstate", () => {
    scrollToSectionByRoute(window.location.pathname);
});

// --- Cookie helpers ---
function setCookie(name, value, days) {
    let expires = "";
    if (days) {
        const date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + encodeURIComponent(value) + expires + "; path=/";
}

function getCookie(name) {
    const nameEQ = name + "=";
    const ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) === 0) return decodeURIComponent(c.substring(nameEQ.length, c.length));
    }
    return null;
}

// Theme toggle logic
const root = document.documentElement;
const themeToggle = document.getElementById("dark-toggle");
const icon = themeToggle.querySelector("i");

if (getCookie("theme") === "light") {
    root.classList.add("light-theme");
    icon.classList.remove("fa-moon", "fa-solid");
    icon.classList.add("fa-sun", "fa-regular");
}

themeToggle.addEventListener("click", () => {
    root.classList.toggle("light-theme");
    const isLight = root.classList.contains("light-theme");
    const currentTheme = isLight ? "light" : "dark";
    setCookie("theme", currentTheme, 365);

    // Update icon
    if (isLight) {
        icon.classList.remove("fa-moon", "fa-solid");
        icon.classList.add("fa-sun", "fa-regular");
    } else {
        icon.classList.remove("fa-sun", "fa-regular");
        icon.classList.add("fa-moon", "fa-solid");
    }
});