$file = "c:\Users\lenovo\OneDrive\Desktop\subhport\index.html"
$html = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

$startMarker = "        <!-- SHOWREEL -->"
$endMarker   = "        <!-- ABOUT -->"

$startIdx = $html.IndexOf($startMarker)
$endIdx   = $html.IndexOf($endMarker)

if ($startIdx -lt 0 -or $endIdx -lt 0) { Write-Host "Markers not found"; exit 1 }

$before = $html.Substring(0, $startIdx)
$after  = $html.Substring($endIdx)

$newSection = @'
        <!-- SHOWREEL -->
        <section id="showreel" class="section showreel">

            <div class="sr-header">
                <div class="sr-eyebrow">
                    <span class="sr-eyebrow-pip"></span>
                    <span>Showreel 2025</span>
                </div>
                <h2 class="sr-heading">Every Format.<br /><em>Every Frame.</em></h2>
                <p class="sr-subhead">Main reel &middot; Long-format films &middot; Vertical reels &mdash; crafted for every screen.</p>
            </div>

            <div class="showreel-layout">

                <!-- ═══ HERO REEL ═══ -->
                <div class="sr-hero" data-open-modal="showreel">
                    <div class="sr-hero-inner">
                        <div class="sr-grain"></div>
                        <div class="sr-scanline"></div>
                        <div class="sr-hero-poster"></div>
                        <div class="sr-hero-vignette"></div>
                        <div class="sr-corner sr-corner--tl"></div>
                        <div class="sr-corner sr-corner--tr"></div>
                        <div class="sr-corner sr-corner--bl"></div>
                        <div class="sr-corner sr-corner--br"></div>
                        <div class="sr-hero-info">
                            <div class="sr-hero-top-row">
                                <span class="sr-live-pip"></span>
                                <span class="sr-live-text">Director&rsquo;s Cut</span>
                                <span class="sr-hero-year">2025</span>
                            </div>
                            <h3 class="sr-hero-title">Subhasish Sahoo<br /><em>Showreel</em></h3>
                            <p class="sr-hero-desc">Commercial, YouTube, short-form &mdash; every style in one cut.</p>
                            <div class="sr-hero-actions">
                                <button class="sr-play-btn">
                                    <span class="sr-play-circle">
                                        <span class="sr-play-ripple"></span>
                                        <span class="sr-play-tri"></span>
                                    </span>
                                    <span>Play Reel</span>
                                </button>
                                <span class="sr-dur-pill">&#9654;&nbsp;2:45</span>
                            </div>
                        </div>
                        <div class="sr-format-tag">
                            <span class="sr-format-dot"></span>
                            <span>16:9 &nbsp;&middot;&nbsp; 4K</span>
                        </div>
                    </div>
                </div>

                <!-- ═══ MARQUEE TICKER ═══ -->
                <div class="sr-ticker" aria-hidden="true">
                    <div class="sr-ticker-track">
                        <span>Long Format</span><span class="sr-tick-sep">&#9679;</span>
                        <span>Brand Films</span><span class="sr-tick-sep">&#9679;</span>
                        <span>YouTube Series</span><span class="sr-tick-sep">&#9679;</span>
                        <span>Corporate</span><span class="sr-tick-sep">&#9679;</span>
                        <span>Reels &amp; Shorts</span><span class="sr-tick-sep">&#9679;</span>
                        <span>Motion Graphics</span><span class="sr-tick-sep">&#9679;</span>
                        <span>Color Grading</span><span class="sr-tick-sep">&#9679;</span>
                        <span>Long Format</span><span class="sr-tick-sep">&#9679;</span>
                        <span>Brand Films</span><span class="sr-tick-sep">&#9679;</span>
                        <span>YouTube Series</span><span class="sr-tick-sep">&#9679;</span>
                        <span>Corporate</span><span class="sr-tick-sep">&#9679;</span>
                        <span>Reels &amp; Shorts</span><span class="sr-tick-sep">&#9679;</span>
                        <span>Motion Graphics</span><span class="sr-tick-sep">&#9679;</span>
                        <span>Color Grading</span><span class="sr-tick-sep">&#9679;</span>
                    </div>
                </div>

                <!-- ═══ LONG FORMAT ═══ -->
                <div class="sr-row-hd">
                    <div class="sr-row-label">
                        <span class="sr-row-num">01</span>
                        <span class="sr-row-name">Long Format</span>
                    </div>
                    <div class="sr-row-rule"></div>
                </div>

                <div class="sr-long-row">

                    <div class="sr-long-card" data-open-modal="showreel">
                        <div class="sr-long-thumb">
                            <div class="sr-long-poster sr-lp-1"></div>
                            <div class="sr-long-overlay"></div>
                            <div class="sr-long-play"><span class="sr-play-tri"></span></div>
                            <span class="sr-badge sr-badge--yt">YouTube</span>
                            <span class="sr-long-dur">12:30</span>
                        </div>
                        <div class="sr-long-body">
                            <span class="sr-long-cat">Educational</span>
                            <h4>IoT Academy &mdash; Lecture Series</h4>
                            <p>Deep-dives with motion graphics and chapter markers.</p>
                        </div>
                    </div>

                    <div class="sr-long-card" data-open-modal="showreel">
                        <div class="sr-long-thumb">
                            <div class="sr-long-poster sr-lp-2"></div>
                            <div class="sr-long-overlay"></div>
                            <div class="sr-long-play"><span class="sr-play-tri"></span></div>
                            <span class="sr-badge sr-badge--brand">Brand Film</span>
                            <span class="sr-long-dur">4:15</span>
                        </div>
                        <div class="sr-long-body">
                            <span class="sr-long-cat">Brand</span>
                            <h4>UniConverge &mdash; Product Story</h4>
                            <p>Cinematic brand narrative cut for emotional impact.</p>
                        </div>
                    </div>

                    <div class="sr-long-card" data-open-modal="showreel">
                        <div class="sr-long-thumb">
                            <div class="sr-long-poster sr-lp-3"></div>
                            <div class="sr-long-overlay"></div>
                            <div class="sr-long-play"><span class="sr-play-tri"></span></div>
                            <span class="sr-badge sr-badge--corp">Corporate</span>
                            <span class="sr-long-dur">6:00</span>
                        </div>
                        <div class="sr-long-body">
                            <span class="sr-long-cat">Corporate</span>
                            <h4>Tech Mahindra &mdash; Internal Comms</h4>
                            <p>Clean corporate film with lower-thirds and colour grade.</p>
                        </div>
                    </div>

                </div>

                <!-- ═══ REELS ROW ═══ -->
                <div class="sr-row-hd">
                    <div class="sr-row-label">
                        <span class="sr-row-num">02</span>
                        <span class="sr-row-name">Reels &amp; Shorts</span>
                    </div>
                    <div class="sr-row-rule"></div>
                </div>

                <div class="sr-reels-row">

                    <div class="sr-reel-card" data-open-modal="showreel">
                        <div class="sr-phone">
                            <div class="sr-phone-shell">
                                <div class="sr-phone-notch"></div>
                                <div class="sr-phone-screen">
                                    <div class="sr-reel-poster sr-rp-1"></div>
                                    <div class="sr-reel-overlay"></div>
                                    <div class="sr-reel-play"><span class="sr-play-tri"></span></div>
                                    <div class="sr-reel-ui">
                                        <span class="sr-badge sr-badge--reel">Reel</span>
                                        <span class="sr-reel-dur">0:28</span>
                                    </div>
                                    <div class="sr-reel-side">
                                        <div class="sr-side-btn">&#10084;</div>
                                        <div class="sr-side-btn">&#128172;</div>
                                        <div class="sr-side-btn">&#10148;</div>
                                    </div>
                                </div>
                                <div class="sr-phone-bar"></div>
                            </div>
                            <div class="sr-phone-glow"></div>
                        </div>
                        <div class="sr-reel-info">
                            <h4>Brand Hook Reel</h4>
                            <p>Stop-scroll opener for product launch.</p>
                        </div>
                    </div>

                    <div class="sr-reel-card" data-open-modal="showreel">
                        <div class="sr-phone">
                            <div class="sr-phone-shell">
                                <div class="sr-phone-notch"></div>
                                <div class="sr-phone-screen">
                                    <div class="sr-reel-poster sr-rp-2"></div>
                                    <div class="sr-reel-overlay"></div>
                                    <div class="sr-reel-play"><span class="sr-play-tri"></span></div>
                                    <div class="sr-reel-ui">
                                        <span class="sr-badge sr-badge--shorts">Shorts</span>
                                        <span class="sr-reel-dur">0:58</span>
                                    </div>
                                    <div class="sr-reel-side">
                                        <div class="sr-side-btn">&#10084;</div>
                                        <div class="sr-side-btn">&#128172;</div>
                                        <div class="sr-side-btn">&#10148;</div>
                                    </div>
                                </div>
                                <div class="sr-phone-bar"></div>
                            </div>
                            <div class="sr-phone-glow"></div>
                        </div>
                        <div class="sr-reel-info">
                            <h4>YouTube Short &mdash; Ed-tech</h4>
                            <p>Fast-cut educational short with bold typography.</p>
                        </div>
                    </div>

                    <div class="sr-reel-card" data-open-modal="showreel">
                        <div class="sr-phone">
                            <div class="sr-phone-shell">
                                <div class="sr-phone-notch"></div>
                                <div class="sr-phone-screen">
                                    <div class="sr-reel-poster sr-rp-3"></div>
                                    <div class="sr-reel-overlay"></div>
                                    <div class="sr-reel-play"><span class="sr-play-tri"></span></div>
                                    <div class="sr-reel-ui">
                                        <span class="sr-badge sr-badge--reel">Reel</span>
                                        <span class="sr-reel-dur">0:30</span>
                                    </div>
                                    <div class="sr-reel-side">
                                        <div class="sr-side-btn">&#10084;</div>
                                        <div class="sr-side-btn">&#128172;</div>
                                        <div class="sr-side-btn">&#10148;</div>
                                    </div>
                                </div>
                                <div class="sr-phone-bar"></div>
                            </div>
                            <div class="sr-phone-glow"></div>
                        </div>
                        <div class="sr-reel-info">
                            <h4>Lifestyle Reel &mdash; Paraayan</h4>
                            <p>Mood-driven vertical cut with colour-graded aesthetic.</p>
                        </div>
                    </div>

                    <div class="sr-reel-card" data-open-modal="showreel">
                        <div class="sr-phone">
                            <div class="sr-phone-shell">
                                <div class="sr-phone-notch"></div>
                                <div class="sr-phone-screen">
                                    <div class="sr-reel-poster sr-rp-4"></div>
                                    <div class="sr-reel-overlay"></div>
                                    <div class="sr-reel-play"><span class="sr-play-tri"></span></div>
                                    <div class="sr-reel-ui">
                                        <span class="sr-badge sr-badge--shorts">Shorts</span>
                                        <span class="sr-reel-dur">0:45</span>
                                    </div>
                                    <div class="sr-reel-side">
                                        <div class="sr-side-btn">&#10084;</div>
                                        <div class="sr-side-btn">&#128172;</div>
                                        <div class="sr-side-btn">&#10148;</div>
                                    </div>
                                </div>
                                <div class="sr-phone-bar"></div>
                            </div>
                            <div class="sr-phone-glow"></div>
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
