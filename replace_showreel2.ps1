$file = "c:\Users\lenovo\OneDrive\Desktop\subhport\index.html"
$html = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

$oldBlock = @'
        <!-- SHOWREEL -->'@

$newBlock = @'
        <!-- SHOWREEL -->'@

# Find start marker
$startMarker = "        <!-- SHOWREEL -->"
$endMarker = "        <!-- ABOUT -->"

$startIdx = $html.IndexOf($startMarker)
$endIdx   = $html.IndexOf($endMarker)

if ($startIdx -lt 0 -or $endIdx -lt 0) {
    Write-Host "Markers not found. Start=$startIdx End=$endIdx"
    exit 1
}

$before = $html.Substring(0, $startIdx)
$after  = $html.Substring($endIdx)

$newSection = @'
        <!-- SHOWREEL -->
        <section id="showreel" class="section showreel">

            <!-- Ambient noise overlay -->
            <div class="sr-noise"></div>

            <div class="section-header sr-section-header">
                <div class="sr-eyebrow"><span class="sr-eyebrow-dot"></span>Showreel 2025</div>
                <h2>Every Format.<br /><span class="sr-title-accent">Every Frame.</span></h2>
                <p>Main reel, long-format films, and vertical reels &mdash; crafted for every screen.</p>
            </div>

            <div class="showreel-layout">

                <!-- ═══ HERO REEL ═══ -->
                <div class="sr-hero" data-open-modal="showreel">
                    <div class="sr-hero-inner">
                        <!-- Film grain overlay -->
                        <div class="sr-film-grain"></div>
                        <!-- Scan line -->
                        <div class="sr-scanline"></div>
                        <!-- Poster -->
                        <div class="sr-hero-poster"></div>
                        <!-- Vignette gradient -->
                        <div class="sr-hero-vignette"></div>
                        <!-- Corner brackets -->
                        <div class="sr-corner sr-corner--tl"></div>
                        <div class="sr-corner sr-corner--tr"></div>
                        <div class="sr-corner sr-corner--bl"></div>
                        <div class="sr-corner sr-corner--br"></div>
                        <!-- Info -->
                        <div class="sr-hero-info">
                            <div class="sr-hero-top">
                                <span class="sr-live-dot"></span>
                                <span class="sr-live-label">Director&rsquo;s Cut</span>
                                <span class="sr-hero-year">2025</span>
                            </div>
                            <h3 class="sr-hero-title">Subhasish Sahoo<br /><em>Showreel</em></h3>
                            <p class="sr-hero-desc">Commercial, YouTube, short-form &mdash; every style in one cut.</p>
                            <div class="sr-hero-actions">
                                <button class="sr-play-btn">
                                    <span class="sr-play-icon">
                                        <span class="sr-play-ripple"></span>
                                        <span class="sr-play-triangle"></span>
                                    </span>
                                    <span class="sr-play-label">Play Reel</span>
                                </button>
                                <span class="sr-duration-pill">&#9654;&nbsp;2:45</span>
                            </div>
                        </div>
                        <!-- Format badge -->
                        <div class="sr-format-badge">
                            <span class="sr-format-dot"></span>
                            <span>16:9 &nbsp;·&nbsp; 4K</span>
                        </div>
                    </div>
                </div>

                <!-- ═══ TICKER ═══ -->
                <div class="sr-ticker" aria-hidden="true">
                    <div class="sr-ticker-track">
                        <span>Long Format</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>Brand Films</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>YouTube Series</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>Corporate</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>Reels &amp; Shorts</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>Motion Graphics</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>Color Grading</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>Long Format</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>Brand Films</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>YouTube Series</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>Corporate</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>Reels &amp; Shorts</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>Motion Graphics</span><span class="sr-ticker-sep">&#9679;</span>
                        <span>Color Grading</span><span class="sr-ticker-sep">&#9679;</span>
                    </div>
                </div>

                <!-- ═══ LONG FORMAT ═══ -->
                <div class="sr-row-header">
                    <div class="sr-row-label">
                        <span class="sr-row-num">01</span>
                        <span class="sr-row-title">Long Format</span>
                    </div>
                    <div class="sr-row-line"></div>
                </div>

                <div class="sr-long-row">

                    <div class="sr-long-card" data-open-modal="showreel">
                        <div class="sr-long-thumb">
                            <div class="sr-long-poster sr-long-poster-1"></div>
                            <div class="sr-long-overlay"></div>
                            <div class="sr-long-play"><span class="sr-play-triangle"></span></div>
                            <div class="sr-long-chrome">
                                <span class="sr-badge sr-badge--youtube">YouTube</span>
                                <span class="sr-long-dur">12:30</span>
                            </div>
                            <div class="sr-long-hover-info">
                                <span>IoT Academy &mdash; Full Lecture Series</span>
                            </div>
                        </div>
                        <div class="sr-long-meta">
                            <span class="sr-long-cat">Educational</span>
                            <h4>IoT Academy &mdash; Lecture Series</h4>
                            <p>Deep-dives with motion graphics and chapter markers.</p>
                        </div>
                    </div>

                    <div class="sr-long-card" data-open-modal="showreel">
                        <div class="sr-long-thumb">
                            <div class="sr-long-poster sr-long-poster-2"></div>
                            <div class="sr-long-overlay"></div>
                            <div class="sr-long-play"><span class="sr-play-triangle"></span></div>
                            <div class="sr-long-chrome">
                                <span class="sr-badge sr-badge--brand">Brand Film</span>
                                <span class="sr-long-dur">4:15</span>
                            </div>
                            <div class="sr-long-hover-info">
                                <span>UniConverge &mdash; Product Story</span>
                            </div>
                        </div>
                        <div class="sr-long-meta">
                            <span class="sr-long-cat">Brand</span>
                            <h4>UniConverge &mdash; Product Story</h4>
                            <p>Cinematic brand narrative cut for emotional impact.</p>
                        </div>
                    </div>

                    <div class="sr-long-card" data-open-modal="showreel">
                        <div class="sr-long-thumb">
                            <div class="sr-long-poster sr-long-poster-3"></div>
                            <div class="sr-long-overlay"></div>
                            <div class="sr-long-play"><span class="sr-play-triangle"></span></div>
                            <div class="sr-long-chrome">
                                <span class="sr-badge sr-badge--corp">Corporate</span>
                                <span class="sr-long-dur">6:00</span>
                            </div>
                            <div class="sr-long-hover-info">
                                <span>Tech Mahindra &mdash; Internal Comms</span>
                            </div>
                        </div>
                        <div class="sr-long-meta">
                            <span class="sr-long-cat">Corporate</span>
                            <h4>Tech Mahindra &mdash; Internal Comms</h4>
                            <p>Clean corporate film with lower-thirds and colour grade.</p>
                        </div>
                    </div>

                </div>

                <!-- ═══ REELS ROW ═══ -->
                <div class="sr-row-header">
                    <div class="sr-row-label">
                        <span class="sr-row-num">02</span>
                        <span class="sr-row-title">Reels &amp; Shorts</span>
                    </div>
                    <div class="sr-row-line"></div>
                </div>

                <div class="sr-reels-row">

                    <div class="sr-reel-card" data-open-modal="showreel">
                        <div class="sr-reel-device">
                            <div class="sr-reel-device-shell">
                                <div class="sr-reel-notch"></div>
                                <div class="sr-reel-screen">
                                    <div class="sr-reel-poster sr-reel-poster-1"></div>
                                    <div class="sr-reel-overlay"></div>
                                    <div class="sr-reel-play"><span class="sr-play-triangle"></span></div>
                                    <div class="sr-reel-ui">
                                        <span class="sr-badge sr-badge--reel">Reel</span>
                                        <span class="sr-reel-dur">0:28</span>
                                    </div>
                                    <!-- TikTok-style side actions -->
                                    <div class="sr-reel-actions">
                                        <div class="sr-reel-action">&#10084;</div>
                                        <div class="sr-reel-action">&#128172;</div>
                                        <div class="sr-reel-action">&#8594;</div>
                                    </div>
                                </div>
                                <div class="sr-reel-home-bar"></div>
                            </div>
                            <div class="sr-reel-glow"></div>
                        </div>
                        <div class="sr-reel-info">
                            <h4>Brand Hook Reel</h4>
                            <p>Stop-scroll opener for product launch.</p>
                        </div>
                    </div>

                    <div class="sr-reel-card" data-open-modal="showreel">
                        <div class="sr-reel-device">
                            <div class="sr-reel-device-shell">
                                <div class="sr-reel-notch"></div>
                                <div class="sr-reel-screen">
                                    <div class="sr-reel-poster sr-reel-poster-2"></div>
                                    <div class="sr-reel-overlay"></div>
                                    <div class="sr-reel-play"><span class="sr-play-triangle"></span></div>
                                    <div class="sr-reel-ui">
                                        <span class="sr-badge sr-badge--shorts">Shorts</span>
                                        <span class="sr-reel-dur">0:58</span>
                                    </div>
                                    <div class="sr-reel-actions">
                                        <div class="sr-reel-action">&#10084;</div>
                                        <div class="sr-reel-action">&#128172;</div>
                                        <div class="sr-reel-action">&#8594;</div>
                                    </div>
                                </div>
                                <div class="sr-reel-home-bar"></div>
                            </div>
                            <div class="sr-reel-glow"></div>
                        </div>
                        <div class="sr-reel-info">
                            <h4>YouTube Short &mdash; Ed-tech</h4>
                            <p>Fast-cut educational short with bold typography.</p>
                        </div>
                    </div>

                    <div class="sr-reel-card" data-open-modal="showreel">
                        <div class="sr-reel-device">
                            <div class="sr-reel-device-shell">
                                <div class="sr-reel-notch"></div>
                                <div class="sr-reel-screen">
                                    <div class="sr-reel-poster sr-reel-poster-3"></div>
                                    <div class="sr-reel-overlay"></div>
                                    <div class="sr-reel-play"><span class="sr-play-triangle"></span></div>
                                    <div class="sr-reel-ui">
                                        <span class="sr-badge sr-badge--reel">Reel</span>
                                        <span class="sr-reel-dur">0:30</span>
                                    </div>
                                    <div class="sr-reel-actions">
                                        <div class="sr-reel-action">&#10084;</div>
                                        <div class="sr-reel-action">&#128172;</div>
                                        <div class="sr-reel-action">&#8594;</div>
                                    </div>
                                </div>
                                <div class="sr-reel-home-bar"></div>
                            </div>
                            <div class="sr-reel-glow"></div>
                        </div>
                        <div class="sr-reel-info">
                            <h4>Lifestyle Reel &mdash; Paraayan</h4>
                            <p>Mood-driven vertical cut with colour-graded aesthetic.</p>
                        </div>
                    </div>

                    <div class="sr-reel-card" data-open-modal="showreel">
                        <div class="sr-reel-device">
                            <div class="sr-reel-device-shell">
                                <div class="sr-reel-notch"></div>
                                <div class="sr-reel-screen">
                                    <div class="sr-reel-poster sr-reel-poster-4"></div>
                                    <div class="sr-reel-overlay"></div>
                                    <div class="sr-reel-play"><span class="sr-play-triangle"></span></div>
                                    <div class="sr-reel-ui">
                                        <span class="sr-badge sr-badge--shorts">Shorts</span>
                                        <span class="sr-reel-dur">0:45</span>
                                    </div>
                                    <div class="sr-reel-actions">
                                        <div class="sr-reel-action">&#10084;</div>
                                        <div class="sr-reel-action">&#128172;</div>
                                        <div class="sr-reel-action">&#8594;</div>
                                    </div>
                                </div>
                                <div class="sr-reel-home-bar"></div>
                            </div>
                            <div class="sr-reel-glow"></div>
                        </div>
                        <div class="sr-reel-info">
                            <h4>Tech Explainer Short</h4>
                            <p>Motion-graphics-led short for IoT product awareness.</p>
                        </div>
                    </div>

                </div>

            </div>
        </section>
'@

$result = $before + $newSection + "`r`n        " + $after
[System.IO.File]::WriteAllText($file, $result, [System.Text.Encoding]::UTF8)
Write-Host "Done"
