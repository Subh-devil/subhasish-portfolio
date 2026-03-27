// Basic helpers
const qs = (s, p = document) => p.querySelector(s);
const qsa = (s, p = document) => [...p.querySelectorAll(s)];

// Mobile nav hamburger
function closeMobileMenu() {
    qs('#nav-hamburger')?.classList.remove('open');
    qs('#nav-mobile-menu')?.classList.remove('open');
}

document.addEventListener('DOMContentLoaded', () => {
    const hamburger = qs('#nav-hamburger');
    const mobileMenu = qs('#nav-mobile-menu');
    if (hamburger && mobileMenu) {
        hamburger.addEventListener('click', () => {
            hamburger.classList.toggle('open');
            mobileMenu.classList.toggle('open');
        });
    }
});

// Loader and init
window.addEventListener("load", () => {
    document.body.classList.add("js-ready");

    let lenis = null;

    // Smooth scroll (Lenis) — optional, graceful fallback
    try {
        lenis = new Lenis({ lerp: 0.08, wheelMultiplier: 0.9, smoothTouch: false });
        function raf(time) { lenis.raf(time); requestAnimationFrame(raf); }
        requestAnimationFrame(raf);
    } catch (e) { lenis = null; }

    // GSAP + ScrollTrigger — optional
    try {
        if (lenis) {
            lenis.on("scroll", ScrollTrigger.update);
            gsap.ticker.add((time) => { lenis.raf(time * 1000); });
            gsap.ticker.lagSmoothing(0);
        }
        initReveals();
        initSkillBars();
        initParallax();
        initHeroEntrance();
        initCounters();
    } catch (e) {
        // GSAP unavailable — make everything visible immediately
        document.querySelectorAll(
            ".hero-content,.hero-side,.showreel-wrapper,.about-image,.about-content," +
            ".skills-grid,.portfolio-masonry,.timeline,.services-grid,.testimonial-carousel,.contact-grid,.nav," +
            ".stats-grid,.process-steps,.tools-grid"
        ).forEach(el => { el.style.opacity = "1"; el.style.transform = "none"; });
    }

    try { initCursor(); } catch (e) {}
    try { if (lenis) initScrollProgress(lenis); } catch (e) {}
    try { initThreeBackground(); } catch (e) {}
    initModals();
    initTestimonials();
    initTilt();
    initPortfolioFilter();
    initContactForm();
    setYear();
});

// Custom cursor
function initCursor() {
    const dot = qs(".cursor-dot");
    const outline = qs(".cursor-outline");
    let mouseX = window.innerWidth / 2;
    let mouseY = window.innerHeight / 2;
    let outlineX = mouseX;
    let outlineY = mouseY;

    window.addEventListener("mousemove", (e) => {
        mouseX = e.clientX;
        mouseY = e.clientY;
        dot.style.transform = `translate(${mouseX}px, ${mouseY}px)`;
    });

    function animate() {
        outlineX += (mouseX - outlineX) * 0.15;
        outlineY += (mouseY - outlineY) * 0.15;
        outline.style.transform = `translate(${outlineX}px, ${outlineY}px)`;
        requestAnimationFrame(animate);
    }
    animate();

    // Link hover enlargement
    qsa("a, button, .portfolio-item, .showreel-video").forEach((el) => {
        el.addEventListener("mouseenter", () => {
            outline.style.width = "44px";
            outline.style.height = "44px";
            outline.style.border = "1px solid rgba(255, 30, 30, 0.8)";
        });
        el.addEventListener("mouseleave", () => {
            outline.style.width = "32px";
            outline.style.height = "32px";
            outline.style.border = "1px solid rgba(255, 30, 30, 0.4)";
        });
    });
}

// Scroll progress
function initScrollProgress(lenis) {
    const bar = qs("#scroll-progress-bar");
    lenis.on("scroll", ({ scroll, limit }) => {
        const progress = limit ? scroll / limit : 0;
        bar.style.width = `${progress * 100}%`;
    });
}

// Contact form — Formspree
function initContactForm() {
    const form = qs("#contact-form");
    if (!form) return;

    const btn = qs("#form-submit-btn");
    const btnText = qs("#form-btn-text");
    const status = qs("#form-status");

    form.addEventListener("submit", async (e) => {
        e.preventDefault();

        // Basic validation
        const name    = form.name.value.trim();
        const email   = form.email.value.trim();
        const message = form.message.value.trim();

        if (!name || !email || !message) {
            status.textContent = "Please fill in Name, Email, and Message.";
            status.style.color = "#ff5a5a";
            return;
        }

        // Loading state
        btn.disabled = true;
        btnText.textContent = "Sending…";
        status.textContent = "";

        try {
            const res = await fetch("https://formspree.io/f/YOUR_FORM_ID", {
                method: "POST",
                headers: { "Accept": "application/json" },
                body: new FormData(form)
            });

            if (res.ok) {
                status.textContent = "✓ Message sent! I'll get back to you soon.";
                status.style.color = "#22c55e";
                form.reset();
            } else {
                throw new Error("Server error");
            }
        } catch {
            status.textContent = "Something went wrong. Try emailing directly at sahosubhasish@gmail.com";
            status.style.color = "#ff5a5a";
        } finally {
            btn.disabled = false;
            btnText.textContent = "Send Inquiry";
        }
    });
}


function setYear() {
    const y = qs("#year");
    if (y) y.textContent = new Date().getFullYear();
}

// Three.js background particles
function initThreeBackground() {
    const canvas = qs("#webgl-bg");
    if (!canvas) return;

    const renderer = new THREE.WebGLRenderer({
        canvas,
        antialias: true,
        alpha: true
    });
    renderer.setPixelRatio(window.devicePixelRatio || 1);
    renderer.setSize(window.innerWidth, window.innerHeight);

    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 1, 2000);
    camera.position.z = 400;

    // Particles
    const count = 800;
    const geometry = new THREE.BufferGeometry();
    const positions = new Float32Array(count * 3);
    const colors = new Float32Array(count * 3);

    for (let i = 0; i < count; i++) {
        const i3 = i * 3;
        const radius = 260 + Math.random() * 250;
        const angle = Math.random() * Math.PI * 2;
        const y = (Math.random() - 0.5) * 260;

        positions[i3 + 0] = Math.cos(angle) * radius;
        positions[i3 + 1] = y;
        positions[i3 + 2] = Math.sin(angle) * radius;

        const r = 0.9 + Math.random() * 0.1;
        const g = 0.3 * Math.random();
        const b = 0.3 * Math.random();
        colors[i3 + 0] = r;
        colors[i3 + 1] = g;
        colors[i3 + 2] = b;
    }

    geometry.setAttribute("position", new THREE.BufferAttribute(positions, 3));
    geometry.setAttribute("color", new THREE.BufferAttribute(colors, 3));

    const material = new THREE.PointsMaterial({
        size: 3,
        vertexColors: true,
        transparent: true,
        opacity: 0.6,
        depthWrite: false
    });

    const points = new THREE.Points(geometry, material);
    scene.add(points);

    // Subtle light glow sphere
    const glowGeo = new THREE.SphereGeometry(100, 32, 32);
    const glowMat = new THREE.MeshBasicMaterial({
        color: 0xff1e1e,
        transparent: true,
        opacity: 0.09
    });
    const glow = new THREE.Mesh(glowGeo, glowMat);
    scene.add(glow);

    const mouse = { x: 0, y: 0 };
    window.addEventListener("mousemove", (e) => {
        mouse.x = (e.clientX / window.innerWidth - 0.5) * 2;
        mouse.y = (e.clientY / window.innerHeight - 0.5) * 2;
    });

    function animate() {
        requestAnimationFrame(animate);
        points.rotation.y += 0.0008;
        points.rotation.x += 0.0004;

        camera.position.x += (mouse.x * 40 - camera.position.x) * 0.04;
        camera.position.y += (-mouse.y * 40 - camera.position.y) * 0.04;
        camera.lookAt(scene.position);

        renderer.render(scene, camera);
    }
    animate();

    window.addEventListener("resize", () => {
        const w = window.innerWidth;
        const h = window.innerHeight;
        renderer.setSize(w, h);
        camera.aspect = w / h;
        camera.updateProjectionMatrix();
    });
}

// Custom Video Player
function initModals() {
    const overlay     = qs('#modal-overlay');
    const video       = qs('#modal-video');
    const source      = video.querySelector('source');
    const titleEl     = qs('#vp-title');
    const closeBtn    = qs('#vp-close');
    const playPauseBtn= qs('#vp-playpause');
    const iconPlay    = playPauseBtn.querySelector('.vp-icon-play');
    const iconPause   = playPauseBtn.querySelector('.vp-icon-pause');
    const backBtn     = qs('#vp-back');
    const fwdBtn      = qs('#vp-fwd');
    const curEl       = qs('#vp-cur');
    const durEl       = qs('#vp-dur');
    const progressBar = qs('#vp-progress');
    const fill        = qs('#vp-fill');
    const buf         = qs('#vp-buf');
    const thumb       = qs('#vp-thumb');
    const muteBtn     = qs('#vp-mute');
    const iconVol     = muteBtn.querySelector('.vp-icon-vol');
    const iconMuted   = muteBtn.querySelector('.vp-icon-muted');
    const volSlider   = qs('#vp-vol');
    const speedBtn    = qs('#vp-speed');
    const speedMenu   = qs('#vp-speed-menu');
    const fsBtn       = qs('#vp-fs');
    const iconFs      = fsBtn.querySelector('.vp-icon-fs');
    const iconExitFs  = fsBtn.querySelector('.vp-icon-exit-fs');
    const centerPlay  = qs('#vp-center-play');
    const spinner     = qs('#vp-spinner');
    const screen      = qs('.vp-screen');

    const fmt = s => {
        s = Math.floor(s || 0);
        return `${Math.floor(s/60)}:${String(s%60).padStart(2,'0')}`;
    };

    // ── Open / Close ──
    function openModal(src, label) {
        source.src = src || '';
        video.load();
        titleEl.textContent = label || 'Playing';
        // Reset UI
        fill.style.width = '0%';
        buf.style.width  = '0%';
        thumb.style.left = '0%';
        curEl.textContent = '0:00';
        durEl.textContent = '0:00';
        speedBtn.textContent = '1x';
        video.playbackRate = 1;
        speedMenu.querySelectorAll('button').forEach(b => b.classList.toggle('active', b.dataset.speed === '1'));
        updatePlayIcon(false);
        overlay.classList.add('active');
        // Lock body scroll
        document.body.style.overflow = 'hidden';
        if (src) video.play().catch(() => {});
    }

    function closeModal() {
        overlay.classList.remove('active');
        video.pause();
        source.src = '';
        video.load();
        speedMenu.classList.remove('open');
        // Restore body scroll
        document.body.style.overflow = '';
    }

    // ── Play / Pause ──
    function updatePlayIcon(playing) {
        iconPlay.style.display  = playing ? 'none'  : 'block';
        iconPause.style.display = playing ? 'block' : 'none';
        // Show center icon only when paused and not at start
        if (playing) {
            centerPlay.classList.remove('visible');
        } else {
            centerPlay.classList.add('visible');
        }
    }

    playPauseBtn.addEventListener('click', () => video.paused ? video.play() : video.pause());

    // Click on screen (but not on controls)
    screen.addEventListener('click', e => {
        if (e.target === screen || e.target === video || e.target === centerPlay) {
            video.paused ? video.play() : video.pause();
        }
    });

    video.addEventListener('play',  () => updatePlayIcon(true));
    video.addEventListener('pause', () => updatePlayIcon(false));
    video.addEventListener('ended', () => { updatePlayIcon(false); });

    // ── Skip ──
    backBtn.addEventListener('click', () => { video.currentTime = Math.max(0, video.currentTime - 10); });
    fwdBtn.addEventListener('click',  () => { video.currentTime = Math.min(video.duration || 0, video.currentTime + 10); });

    // ── Keyboard ──
    document.addEventListener('keydown', e => {
        if (!overlay.classList.contains('active')) return;
        switch(e.key) {
            case 'Escape':      closeModal(); break;
            case ' ': case 'k': e.preventDefault(); video.paused ? video.play() : video.pause(); break;
            case 'ArrowLeft':   e.preventDefault(); video.currentTime = Math.max(0, video.currentTime - 10); break;
            case 'ArrowRight':  e.preventDefault(); video.currentTime = Math.min(video.duration||0, video.currentTime + 10); break;
            case 'ArrowUp':     e.preventDefault(); video.volume = Math.min(1, video.volume + 0.1); volSlider.value = video.volume; updateVolIcon(); break;
            case 'ArrowDown':   e.preventDefault(); video.volume = Math.max(0, video.volume - 0.1); volSlider.value = video.volume; updateVolIcon(); break;
            case 'm': case 'M': muteBtn.click(); break;
            case 'f': case 'F': fsBtn.click(); break;
        }
    });

    // ── Progress ──
    video.addEventListener('timeupdate', () => {
        if (!video.duration) return;
        const pct = (video.currentTime / video.duration) * 100;
        fill.style.width = pct + '%';
        // Clamp thumb so it doesn't overflow
        thumb.style.left = Math.min(pct, 99.5) + '%';
        curEl.textContent = fmt(video.currentTime);
    });
    video.addEventListener('durationchange', () => { durEl.textContent = fmt(video.duration); });
    video.addEventListener('progress', () => {
        if (!video.duration || !video.buffered.length) return;
        buf.style.width = (video.buffered.end(video.buffered.length - 1) / video.duration * 100) + '%';
    });

    // Seek
    let seeking = false;
    function doSeek(clientX) {
        const rect = progressBar.getBoundingClientRect();
        const pct  = Math.max(0, Math.min(1, (clientX - rect.left) / rect.width));
        video.currentTime = pct * (video.duration || 0);
    }
    progressBar.addEventListener('mousedown',  e => { seeking = true; doSeek(e.clientX); e.preventDefault(); });
    document.addEventListener('mousemove',     e => { if (seeking) doSeek(e.clientX); });
    document.addEventListener('mouseup',       () => { seeking = false; });
    progressBar.addEventListener('touchstart', e => { seeking = true; doSeek(e.touches[0].clientX); }, { passive: true });
    document.addEventListener('touchmove',     e => { if (seeking) doSeek(e.touches[0].clientX); }, { passive: true });
    document.addEventListener('touchend',      () => { seeking = false; });

    // ── Spinner ──
    video.addEventListener('waiting', () => spinner.classList.add('active'));
    video.addEventListener('canplay', () => spinner.classList.remove('active'));
    video.addEventListener('playing', () => spinner.classList.remove('active'));

    // ── Volume ──
    volSlider.addEventListener('input', () => {
        video.volume = parseFloat(volSlider.value);
        video.muted  = video.volume === 0;
        updateVolIcon();
    });
    muteBtn.addEventListener('click', () => {
        video.muted = !video.muted;
        volSlider.value = video.muted ? 0 : (video.volume || 1);
        updateVolIcon();
    });
    function updateVolIcon() {
        const muted = video.muted || video.volume === 0;
        iconVol.style.display   = muted ? 'none'  : 'block';
        iconMuted.style.display = muted ? 'block' : 'none';
    }

    // ── Speed ──
    speedBtn.addEventListener('click', e => {
        e.stopPropagation();
        speedMenu.classList.toggle('open');
    });
    speedMenu.querySelectorAll('button').forEach(btn => {
        btn.addEventListener('click', e => {
            e.stopPropagation();
            const s = parseFloat(btn.dataset.speed);
            video.playbackRate = s;
            speedBtn.textContent = s + 'x';
            speedMenu.querySelectorAll('button').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            speedMenu.classList.remove('open');
        });
    });
    document.addEventListener('click', e => {
        if (!speedMenu.contains(e.target) && e.target !== speedBtn) {
            speedMenu.classList.remove('open');
        }
    });

    // ── Fullscreen ──
    fsBtn.addEventListener('click', () => {
        const el = qs('.modal');
        if (!document.fullscreenElement) {
            (el.requestFullscreen || el.webkitRequestFullscreen).call(el);
        } else {
            (document.exitFullscreen || document.webkitExitFullscreen).call(document);
        }
    });
    document.addEventListener('fullscreenchange', () => {
        const isFs = !!document.fullscreenElement;
        iconFs.style.display     = isFs ? 'none'  : 'block';
        iconExitFs.style.display = isFs ? 'block' : 'none';
    });

    // ── Trigger from cards ──
    // Support both data-open-modal (no value) and data-open-modal="mg" etc.
    qsa('[data-open-modal]').forEach(el => {
        el.addEventListener('click', () => {
            const src   = el.dataset.videoSrc || '';
            const label = el.querySelector('h3, h4')?.textContent?.trim() || 'Playing';
            openModal(src, label);
        });
    });

    closeBtn.addEventListener('click', closeModal);
    overlay.addEventListener('click', e => { if (e.target === overlay) closeModal(); });
}

// Testimonials carousel
function initTestimonials() {
    const track = qs(".testimonial-track");
    const dots = qsa(".testimonial-dot");
    if (!track || !dots.length) return;

    let index = 0;
    const length = dots.length;

    function goTo(i) {
        index = i;
        track.style.transform = `translateX(-${i * 100}%)`;
        dots.forEach((d, idx) => d.classList.toggle("active", idx === i));
    }

    dots.forEach((dot) => {
        dot.addEventListener("click", () => {
            const i = Number(dot.dataset.index || 0);
            goTo(i);
        });
    });

    setInterval(() => {
        const next = (index + 1) % length;
        goTo(next);
    }, 7000);
}

// Section reveals with GSAP
function initReveals() {
    const groups = [
        ".hero-content",
        ".hero-side",
        ".sr-wrap",
        ".about-image",
        ".about-content",
        ".skills-grid",
        ".stats-grid",
        ".portfolio-filters",
        ".portfolio-masonry",
        ".process-steps",
        ".tools-grid",
        ".timeline",
        ".services-grid",
        ".testimonial-carousel",
        ".contact-grid"
    ];

    groups.forEach((selector) => {
        const el = qs(selector);
        if (!el) return;
        gsap.fromTo(
            el,
            { opacity: 0, y: 40 },
            {
                opacity: 1,
                y: 0,
                duration: 1,
                ease: "power3.out",
                scrollTrigger: { trigger: el, start: "top 80%" }
            }
        );
    });
}

// Animated counters
function initCounters() {
    qsa(".stat-number").forEach((el) => {
        const target = parseInt(el.dataset.target, 10);
        gsap.fromTo(el, { innerText: 0 }, {
            innerText: target,
            duration: 2,
            ease: "power2.out",
            snap: { innerText: 1 },
            scrollTrigger: { trigger: el, start: "top 85%" }
        });
    });
}

// Portfolio filter
function initPortfolioFilter() {
    const btns = qsa(".pf-btn");
    const cards = qsa(".portfolio-card");
    btns.forEach((btn) => {
        btn.addEventListener("click", () => {
            btns.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");
            const filter = btn.dataset.filter;
            cards.forEach((card) => {
                const match = filter === "all" || card.dataset.category === filter;
                card.classList.toggle("hidden", !match);
            });
        });
    });
}

function initSkillBars() {
    qsa(".skill-card").forEach((card) => {
        const bar = qs(".skill-bar-fill", card);
        const target = bar?.style.getPropertyValue("--target-width") || "80%";
        gsap.fromTo(
            bar,
            { width: "0%" },
            {
                width: target,
                duration: 1.1,
                ease: "power2.out",
                scrollTrigger: {
                    trigger: card,
                    start: "top 85%"
                }
            }
        );
    });
}

// Parallax on key elements
function initParallax() {
    qsa("[data-parallax]").forEach((el) => {
        gsap.to(el, {
            yPercent: -8,
            ease: "none",
            scrollTrigger: {
                trigger: el,
                start: "top bottom",
                end: "bottom top",
                scrub: 0.6
            }
        });
    });
}

// Minimal tilt on portfolio thumbnails
function initTilt() {
    qsa("[data-tilt]").forEach((card) => {
        let bounds = card.getBoundingClientRect();

        function handleMove(e) {
            const x = e.clientX - bounds.left;
            const y = e.clientY - bounds.top;
            const midX = bounds.width / 2;
            const midY = bounds.height / 2;
            const rotateX = ((y - midY) / midY) * -6;
            const rotateY = ((x - midX) / midX) * 6;

            gsap.to(card, {
                rotationX: rotateX,
                rotationY: rotateY,
                transformPerspective: 800,
                transformOrigin: "center",
                duration: 0.3
            });
        }

        function reset() {
            gsap.to(card, {
                rotationX: 0,
                rotationY: 0,
                duration: 0.4,
                ease: "power3.out"
            });
        }

        card.addEventListener("mouseenter", () => {
            bounds = card.getBoundingClientRect();
        });
        card.addEventListener("mousemove", handleMove);
        card.addEventListener("mouseleave", reset);
    });
}

// Hero entrance animation
function initHeroEntrance() {
    const tl = gsap.timeline();
    tl.fromTo(".nav",
        { opacity: 0, y: -20 },
        { opacity: 1, y: 0, duration: 0.7, ease: "power2.out" }
    )
    .fromTo(".hero-availability",
        { opacity: 0, y: 16 },
        { opacity: 1, y: 0, duration: 0.6, ease: "power3.out" }, "-=0.3"
    )
    .fromTo(".hero-label",
        { opacity: 0, y: 16 },
        { opacity: 1, y: 0, duration: 0.5, ease: "power3.out" }, "-=0.4"
    )
    .fromTo(".hero-title-line",
        { opacity: 0, y: 40 },
        { opacity: 1, y: 0, duration: 0.8, ease: "power3.out", stagger: 0.12 }, "-=0.3"
    )
    .fromTo(".hero-tagline",
        { opacity: 0, y: 20 },
        { opacity: 1, y: 0, duration: 0.7, ease: "power3.out" }, "-=0.4"
    )
    .fromTo(".hero-cta",
        { opacity: 0, y: 20 },
        { opacity: 1, y: 0, duration: 0.6, ease: "power3.out" }, "-=0.4"
    )
    .fromTo(".hero-skills-row",
        { opacity: 0, y: 16 },
        { opacity: 1, y: 0, duration: 0.5, ease: "power3.out" }, "-=0.4"
    )
    .fromTo(".hero-visual",
        { opacity: 0, scale: 0.88 },
        { opacity: 1, scale: 1, duration: 1, ease: "power3.out" }, "-=0.9"
    )
    .fromTo(".hero-badge",
        { opacity: 0, x: 24 },
        { opacity: 1, x: 0, duration: 0.6, ease: "power3.out", stagger: 0.12 }, "-=0.6"
    );
}
