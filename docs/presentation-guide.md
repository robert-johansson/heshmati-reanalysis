# Presentation Guide

**Last Updated:** 2025-10-11
**Presentations Available:** Xaringan (HTML) + Beamer (PDF)

---

## Overview

This repository includes **two presentation formats** for presenting the ISTDP reanalysis findings:

1. **`presentation.Rmd`** → `presentation.html` (**Xaringan** - Modern, web-based)
2. **`presentation-beamer.Rmd`** → `presentation-beamer.pdf` (**Beamer** - Traditional academic, PDF)

Both tell the same narrative story but optimized for different presentation contexts.

---

## Quick Start

### Render the Presentations

**Option 1: Xaringan (Modern, HTML)**
```r
rmarkdown::render("presentation.Rmd")
# Creates: presentation.html
```

**Option 2: Beamer (Traditional, PDF)**
```r
rmarkdown::render("presentation-beamer.Rmd")
# Creates: presentation-beamer.pdf
```

**Option 3: Both at Once**
```bash
Rscript -e "rmarkdown::render('presentation.Rmd')"
Rscript -e "rmarkdown::render('presentation-beamer.Rmd')"
```

---

## Choosing Between Formats

### Use **Xaringan** when:

✅ Presenting at modern conferences or online
✅ Want beautiful, modern aesthetics
✅ Need smooth transitions and animations
✅ Presenting from a computer (HTML in browser)
✅ Want two-column layouts and flexible formatting
✅ Presenting to tech-savvy audiences

### Use **Beamer** when:

✅ Traditional academic conference (psychology, psychiatry)
✅ Need PDF handouts
✅ Presenting from conference computer (unknown software)
✅ Want classic academic style
✅ Reviewers/supervisors prefer traditional format
✅ Need to print slides

---

## Presentation Structure

Both presentations follow the same **narrative arc**:

### Act 1: The Problem & Questions (Slides 1-6)
1. Title slide
2. The problem: Treatment-resistant depression
3. ISTDP as a solution
4. The original study
5. Research questions

### Act 2: Methods (Slides 7-9)
6. Methods overview
7. Statistical approach

### Act 3: Results (Slides 10-22)
8-11. RQ1: Depression trajectories & effect sizes
12-14. RQ2: Process measure changes
15. RQ3: Mediation results
16. RQ4: Temporal precedence

### Act 4: Discussion & Conclusions (Slides 23-28)
17. Key findings summary
18. Clinical implications
19. Theoretical implications
20. Strengths & limitations
21. Main conclusions
22. Future research

### Closing (Slides 29-31)
23. Open science
24. Thank you / Questions

**Total: ~25 slides for 15-20 minute talk**

---

## Xaringan Presentation

### Features

**Visual:**
- Modern, clean design
- Smooth slide transitions
- Two-column layouts (`.pull-left` / `.pull-right`)
- Incremental reveals (`--`)
- Custom colors (#A23B72 purple, #2E86AB blue)

**Technical:**
- HTML5 presentation (runs in web browser)
- Based on remark.js
- Includes presenter notes
- Self-contained option available

### How to Present

1. **Open in Browser:**
   ```bash
   open presentation.html
   # Or double-click the file
   ```

2. **Navigate Slides:**
   - **Next slide:** Arrow keys (→ or ↓) or Space
   - **Previous slide:** ← or ↑
   - **First slide:** Home
   - **Last slide:** End

3. **Presenter Mode:**
   - Press **`P`** to toggle presenter notes
   - Shows current slide + next slide + notes
   - Timer included

4. **Other Shortcuts:**
   - **`F`** - Fullscreen mode
   - **`C`** - Clone slideshow (for dual monitors)
   - **`B`** - Blackout (blank screen)
   - **`H`** - Help (show all shortcuts)

### Customization

**Colors:**
Edit `custom.css`:
```css
.inverse {
  background-color: #2E86AB;  /* Change section header color */
}
```

**Fonts:**
Add to `custom.css`:
```css
.remark-slide-content {
  font-size: 28px;  /* Increase base font size */
}
```

**Add Your Logo:**
Add to YAML header in `presentation.Rmd`:
```yaml
---
output:
  xaringan::moon_reader:
    seal: false  # Disable default title slide
---

Then create custom title slide with logo
```

### Exporting to PDF

**Option 1: Print from Browser**
1. Open `presentation.html` in Chrome
2. Press Ctrl/Cmd + P
3. Destination: Save as PDF
4. More settings → Background graphics: ✓

**Option 2: Using pagedown package**
```r
install.packages("pagedown")
pagedown::chrome_print("presentation.html")
# Creates: presentation.pdf
```

---

## Beamer Presentation

### Features

**Visual:**
- Traditional academic style (Metropolis theme)
- Professional PDF output
- Custom colors (purple/blue)
- 25 pages, optimized for printing

**Technical:**
- LaTeX-based PDF
- Works on any computer (PDF reader)
- Easy to print/distribute
- Consistent formatting

### How to Present

1. **Open in PDF Reader:**
   ```bash
   open presentation-beamer.pdf
   # Or use Adobe Reader, Preview, etc.
   ```

2. **Presentation Mode:**
   - Most PDF readers have "Presentation" or "Fullscreen" mode
   - **Adobe Reader:** View → Full Screen Mode
   - **macOS Preview:** View → Enter Full Screen
   - **Windows PDF:** F5 for presentation mode

3. **Navigate:**
   - Arrow keys or Space to advance
   - Click to advance

### Customization

**Theme:**
Change in YAML header:
```yaml
output:
  beamer_presentation:
    theme: "Madrid"  # Or: Berlin, Copenhagen, etc.
    colortheme: "whale"
```

**Colors:**
Edit `beamer-header.tex`:
```tex
\definecolor{istdp_purple}{RGB}{162, 59, 114}  % Change RGB values
```

**Font Size:**
Add to YAML:
```yaml
output:
  beamer_presentation:
    fontsize: 12pt  # Or 10pt, 11pt
```

---

## Narrative Tips

### Story Arc

The presentations follow a clear narrative:

1. **Hook** (Slides 1-2): "Treatment-resistant depression is a major problem"
2. **Hope** (Slide 3): "ISTDP might help"
3. **Setup** (Slides 4-5): "Original study found big effects, but how?"
4. **Questions** (Slide 6): "Here's what we investigated"
5. **Methods** (Slides 7-9): "Here's how we did it"
6. **Results** (Slides 10-22): "Here's what we found" (4 acts)
7. **Payoff** (Slides 23-26): "Here's what it means"
8. **Cliffhanger** (Slide 27): "But mysteries remain..."
9. **Call to Action** (Slide 28): "Future research needed"

### Key Messages

Emphasize these **3 main points**:

1. ✅ **ISTDP works** (very large, durable effects)
2. ✅ **Process changes occur** (as predicted by theory)
3. ❓ **But mechanism unclear** (doesn't work HOW we thought)

### Timing Suggestions

For a **15-minute talk:**

| Section | Slides | Time | Notes |
|---------|--------|------|-------|
| Intro | 1-6 | 3 min | Set up problem, questions |
| Methods | 7-9 | 2 min | Brief, don't dwell |
| Results | 10-22 | 7 min | Core content, go slow |
| Discussion | 23-28 | 3 min | Implications, conclusions |
| **Total** | **~25** | **15 min** | +5 min for questions |

For a **20-minute talk:**
- Spend more time on Results (add 3 min)
- Add future research details (add 2 min)

For a **10-minute talk:**
- Skip RQ4 (temporal precedence)
- Combine implications slides
- Focus on RQ1-RQ3 only

### Presenter Notes

**Xaringan includes presenter notes.** Press `P` during presentation to see them.

Example notes included for:
- What to emphasize on each slide
- Transition phrases
- Potential questions

### Handling Questions

**Common Expected Questions:**

**Q1: "Why didn't repression mediate?"**
- A: Could be measurement timing, conceptual overlap, or true concurrent change
- Acknowledge limitation, emphasize need for better measures

**Q2: "Sample size seems small for mediation?"**
- A: N=40 with complete data has 80% power for medium effects
- Acknowledge limitation, note bootstrap methods are robust

**Q3: "Can results generalize beyond Iran?"**
- A: Important question; need replication in other cultural contexts
- Note: Depression mechanisms may be universal, but caution warranted

**Q4: "Why only 3 time points?"**
- A: Secondary analysis limitation; original study design
- Future work: Session-by-session or daily measures

---

## Technical Requirements

### Xaringan

**Required R Packages:**
```r
install.packages(c(
  "xaringan",
  "haven",
  "dplyr",
  "tidyr",
  "ggplot2",
  "lme4",
  "lmerTest",
  "emmeans",
  "effsize",
  "knitr",
  "patchwork",
  "mediation"
))
```

**Browser:**
- Chrome (recommended)
- Firefox
- Safari
- Edge

**No internet needed** (self-contained HTML)

### Beamer

**Required:**
- R packages (same as above)
- LaTeX distribution:
  - macOS: MacTeX
  - Windows: MiKTeX
  - Linux: TeX Live

**Optional but recommended:**
- TinyTeX: `tinytex::install_tinytex()`

---

## Updating the Presentations

### Add New Slides

**Xaringan:**
```markdown
---

# New Slide Title

Slide content here

- Bullet 1
- Bullet 2

---
```

**Beamer:**
```markdown
## New Slide Title

Slide content here

- Bullet 1
- Bullet 2
```

### Add Figures

Both formats support the same R chunk syntax:

```r
{r figure-name, fig.width=10, fig.height=6}
# Your plotting code here
ggplot(data, aes(...)) + ...
```

### Two-Column Layouts

**Xaringan:**
```markdown
.pull-left[
Left content
]

.pull-right[
Right content
]
```

**Beamer:**
```markdown
:::::: {.columns}
::: {.column width="50%"}
Left content
:::

::: {.column width="50%"}
Right content
:::
::::::
```

---

## Troubleshooting

### Xaringan Issues

**Problem:** Slides don't render
- **Solution:** Check R console for errors; ensure all packages installed

**Problem:** Figures missing
- **Solution:** Re-run code chunks; check file paths

**Problem:** CSS not loading
- **Solution:** Ensure `custom.css` in same directory

### Beamer Issues

**Problem:** LaTeX error about missing packages
- **Solution:** Install via `tinytex::tlmgr_install("package-name")`

**Problem:** Unicode character errors
- **Solution:** Replace special characters (✓ → +, ✗ → -)
- Or use XeLaTeX: `output: beamer_presentation: latex_engine: xelatex`

**Problem:** Table too wide
- **Solution:** Reduce font size or split into multiple slides

---

## Best Practices

### Content

- **One main point per slide**
- **Minimal text** (audience reads slides faster than you talk)
- **High-contrast colors** (ensure readability)
- **Large fonts** (minimum 18pt)
- **Simple figures** (avoid cluttered plots)

### Delivery

- **Practice timing** (aim for under-time, not over)
- **Know your backup** (what to skip if running long)
- **Test equipment** (bring adapters, test before talk)
- **Have PDF backup** (even if using Xaringan)

### Accessibility

- **High contrast** (check colors)
- **Alt text for figures** (describe visually)
- **Avoid color-only distinctions** (use shapes too)
- **Large text** (readable from back of room)

---

## Example Customizations

### Change Entire Color Scheme

**Edit `custom.css`:**
```css
:root {
  --primary-color: #1E88E5;    /* New blue */
  --secondary-color: #FFC107;   /* New gold */
}

.inverse {
  background-color: var(--primary-color);
}

.title-slide {
  background-color: var(--secondary-color);
}
```

### Add Institution Logo

**Xaringan - Add to title slide:**
```markdown
---
class: title-slide

# Your Title

<img src="images/logo.png" style="position:absolute; top:20px; right:20px; width:100px;">

---
```

### Create Handouts

**From Xaringan:**
```r
pagedown::chrome_print("presentation.html", output = "handouts.pdf")
```

**From Beamer:**
```r
# Add to YAML:
output:
  beamer_presentation:
    includes:
      in_header: handout-mode.tex
```

---

## Resources

### Xaringan

- Official docs: https://slides.yihui.org/xaringan/
- Gallery: https://xaringan.gallery/
- remark.js wiki: https://github.com/gnab/remark/wiki

### Beamer

- Beamer manual: https://ctan.org/pkg/beamer
- Themes gallery: https://hartwork.org/beamer-theme-matrix/
- Metropolis theme: https://github.com/matze/mtheme

### R Markdown

- R Markdown guide: https://rmarkdown.rstudio.com/
- Presentations chapter: https://bookdown.org/yihui/rmarkdown/presentations.html

---

## License

These presentations are part of the ISTDP reanalysis project and are licensed under the MIT License. You are free to use, modify, and adapt them for your own research presentations with attribution.

---

## Contact

**Questions about the presentations?**
- Robert Johansson: robert.johansson@psychology.su.se
- Open an issue on GitHub
- Check the README.md for more information

---

**Happy presenting!** 🎤

Remember: The best presentation is the one that tells a clear, compelling story. Use these slides as a starting point and adapt them to your audience and context.
