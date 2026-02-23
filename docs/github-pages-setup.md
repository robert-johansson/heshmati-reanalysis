# GitHub Pages Setup Guide

**Purpose:** Host the xaringan presentation on GitHub Pages for easy sharing

**Final URL:** `https://robert-johansson.github.io/heshmati-reanalysis/presentation/`

---

## Overview

This guide will help you reorganize the repository to host your xaringan presentation on GitHub Pages, making it accessible via a public URL that anyone can view in their browser.

---

## Current vs. Target Structure

### Current Structure:
```
heshmati-reanalysis/
├── presentation.Rmd          # In root
├── presentation.html         # In root
├── custom.css               # In root
├── docs/
│   ├── testing.md
│   └── presentation-guide.md
└── ...
```

### Target Structure:
```
heshmati-reanalysis/
├── docs/                            # GitHub Pages serves from here
│   ├── index.html                   # NEW: Landing page
│   ├── presentation/                # NEW: Presentation folder
│   │   ├── presentation.Rmd         # MOVED from root
│   │   ├── index.html              # RENAMED from presentation.html
│   │   ├── custom.css              # MOVED from root
│   │   └── libs/                   # xaringan dependencies (auto-generated)
│   ├── testing.md                  # EXISTING
│   └── presentation-guide.md       # EXISTING
├── presentation-beamer.Rmd         # STAYS in root
└── ...
```

---

## Step 1: Create Directory Structure

```bash
# Navigate to repository
cd /path/to/heshmati-reanalysis

# Create presentation folder inside docs
mkdir -p docs/presentation
```

---

## Step 2: Move Presentation Files

```bash
# Move presentation files to docs/presentation/
mv presentation.Rmd docs/presentation/
mv custom.css docs/presentation/

# If presentation.html already exists, delete it (we'll regenerate)
rm -f presentation.html

# If libs/ folder exists in root, move it too
if [ -d "libs" ]; then
    mv libs docs/presentation/
fi
```

---

## Step 3: Update presentation.Rmd

Open `docs/presentation/presentation.Rmd` and modify the YAML header:

### Change This:
```yaml
output:
  xaringan::moon_reader:
    css: [default, default-fonts, custom.css]
    lib_dir: libs
```

### To This:
```yaml
output:
  xaringan::moon_reader:
    css: [default, default-fonts, custom.css]
    lib_dir: libs
    self_contained: false
    nature:
      highlightStyle: github
      highlightLines: true
      countIncrementalSlides: false
      ratio: '16:9'
      slideNumberFormat: '%current%'
knit: (function(inputFile, encoding) {
  rmarkdown::render(inputFile, encoding = encoding,
  output_file = 'index.html') })
```

**Key changes:**
- Added `knit:` function to output as `index.html` instead of `presentation.html`
- Kept `self_contained: false` (xaringan default, works best for GitHub Pages)

---

## Step 4: Render the Presentation

```r
# In R console
setwd("docs/presentation")
rmarkdown::render("presentation.Rmd")

# This will create:
# - docs/presentation/index.html
# - docs/presentation/libs/ (if not already there)
```

Or from command line:
```bash
cd docs/presentation
Rscript -e "rmarkdown::render('presentation.Rmd')"
```

---

## Step 5: Create Landing Page

Create `docs/index.html` with the following content:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ISTDP Reanalysis - Presentations & Documentation</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            line-height: 1.6;
            color: #333;
        }
        h1 { color: #A23B72; }
        h2 { color: #2E86AB; margin-top: 30px; }
        a { color: #A23B72; text-decoration: none; }
        a:hover { text-decoration: underline; }
        .button {
            display: inline-block;
            padding: 12px 24px;
            background: #A23B72;
            color: white;
            border-radius: 5px;
            margin: 10px 10px 10px 0;
            font-weight: bold;
        }
        .button:hover {
            background: #2E86AB;
            text-decoration: none;
        }
        .card {
            border: 1px solid #ddd;
            padding: 20px;
            margin: 20px 0;
            border-radius: 5px;
            background: #f9f9f9;
        }
    </style>
</head>
<body>
    <h1>Effectiveness and Mechanisms of ISTDP for Treatment-Resistant Depression</h1>
    <p><strong>A Reanalysis of a Randomized Controlled Trial</strong></p>
    <p>Robert Johansson | Stockholm University</p>

    <h2>📊 Presentation</h2>
    <div class="card">
        <h3>Research Talk (15-20 minutes)</h3>
        <p>Interactive HTML presentation covering methods, results, and implications.</p>
        <a href="presentation/" class="button">▶️ View Presentation</a>
        <a href="https://github.com/robert-johansson/heshmati-reanalysis/raw/main/presentation-beamer.pdf" class="button">📄 Download PDF</a>
    </div>

    <h2>📚 Documentation</h2>
    <ul>
        <li><a href="testing.html">Testing Framework</a> - 129 automated validation tests</li>
        <li><a href="presentation-guide.html">Presentation Guide</a> - How to use and customize</li>
        <li><a href="github-pages-setup.html">GitHub Pages Setup</a> - This guide</li>
    </ul>

    <h2>🔗 Resources</h2>
    <ul>
        <li><a href="https://github.com/robert-johansson/heshmati-reanalysis">GitHub Repository</a> - Full source code</li>
        <li><a href="https://doi.org/10.17605/OSF.IO/75PU8">OSF Data</a> - Public dataset</li>
        <li><a href="https://doi.org/10.1037/pst0000500">Original Paper</a> - Heshmati et al. (2023)</li>
    </ul>

    <h2>📝 Citation</h2>
    <pre>Johansson, R. (2025). Effects of Intensive Short-Term Dynamic Psychotherapy
on Depression: A Reanalysis of Heshmati et al.'s Data.
GitHub repository: https://github.com/robert-johansson/heshmati-reanalysis</pre>

    <footer style="margin-top: 50px; padding-top: 20px; border-top: 1px solid #ddd; color: #666; font-size: 0.9em;">
        <p>Last updated: 2025-10-11</p>
    </footer>
</body>
</html>
```

---

## Step 6: Update .gitignore (If Needed)

Make sure the `libs/` folder and generated HTML are tracked by git:

Check `.gitignore` and ensure these are **NOT** ignored:
```
# Make sure these lines are NOT in .gitignore:
# docs/presentation/libs/
# docs/presentation/index.html
# docs/index.html
```

If they are listed, remove them. GitHub Pages needs these files.

---

## Step 7: Commit and Push

```bash
# Add all new files
git add docs/presentation/
git add docs/index.html

# Remove old files from root (if you moved them)
git rm presentation.Rmd
git rm custom.css
# Only if these existed in root

# Commit
git commit -m "Set up GitHub Pages for xaringan presentation

- Move presentation files to docs/presentation/
- Create landing page (docs/index.html)
- Configure xaringan to output as index.html
- Ready for GitHub Pages deployment"

# Push to GitHub
git push origin main
```

---

## Step 8: Enable GitHub Pages on GitHub.com

1. **Go to your repository on GitHub:**
   https://github.com/robert-johansson/heshmati-reanalysis

2. **Click on "Settings"** (top right)

3. **Click on "Pages"** (left sidebar)

4. **Under "Source":**
   - Branch: Select `main` (or `master` if that's your default branch)
   - Folder: Select `/docs`
   - Click **Save**

5. **Wait 1-2 minutes** for GitHub to build and deploy

6. **Your site will be live at:**
   ```
   https://robert-johansson.github.io/heshmati-reanalysis/
   ```

7. **The presentation will be at:**
   ```
   https://robert-johansson.github.io/heshmati-reanalysis/presentation/
   ```

---

## Step 9: Verify It Works

### Test the Landing Page:
Open in browser:
```
https://robert-johansson.github.io/heshmati-reanalysis/
```

Should show the landing page with links.

### Test the Presentation:
Click "View Presentation" button, or go directly to:
```
https://robert-johansson.github.io/heshmati-reanalysis/presentation/
```

Should show your xaringan slides.

**Navigation:**
- Arrow keys: Next/previous slide
- Press `P`: Presenter notes
- Press `F`: Fullscreen
- Press `H`: Help (keyboard shortcuts)

---

## Step 10: Update README.md (Optional)

Add a badge and link to README.md:

```markdown
[![GitHub Pages](https://img.shields.io/badge/presentation-live-success)](https://robert-johansson.github.io/heshmati-reanalysis/presentation/)

## Presentations

- **HTML Slides (Web):** [View online](https://robert-johansson.github.io/heshmati-reanalysis/presentation/)
- **PDF Slides:** [Download](https://github.com/robert-johansson/heshmati-reanalysis/raw/main/presentation-beamer.pdf)
```

---

## Troubleshooting

### Problem: 404 Error - Page Not Found

**Possible causes:**
1. GitHub Pages not enabled correctly
   - Solution: Double-check Settings → Pages → Source is `/docs`

2. Files not pushed to GitHub
   - Solution: Run `git push` and wait 1-2 minutes

3. Using wrong URL
   - Solution: URL should be `https://USERNAME.github.io/REPO/` not `https://github.com/USERNAME/REPO/`

### Problem: Presentation loads but images missing

**Cause:** Image paths are wrong

**Solution:** Check image paths in presentation.Rmd. Use relative paths:
```r
# Good
![](../../figures/plot.png)

# Bad (absolute paths won't work on GitHub Pages)
![](/Users/robert/claude/heshmati/figures/plot.png)
```

### Problem: CSS not loading

**Cause:** custom.css not in correct location

**Solution:** Ensure `custom.css` is in `docs/presentation/` and referenced correctly in YAML:
```yaml
css: [default, default-fonts, custom.css]
```

### Problem: Slides work locally but not on GitHub Pages

**Cause:** File paths or case sensitivity

**Solution:**
- GitHub Pages is case-sensitive: `Index.html` ≠ `index.html`
- Use lowercase for all filenames
- Check all file paths are relative

---

## Testing Locally Before Pushing

### Option 1: Using R servr package
```r
setwd("docs")
servr::httd()
# Opens browser automatically at http://localhost:4321
```

### Option 2: Using Python
```bash
cd docs
python3 -m http.server 8000
# Open browser to: http://localhost:8000/
```

### Option 3: Using RStudio Viewer
```r
# Open docs/index.html in RStudio
# Click "Open in Browser"
```

---

## Updating the Presentation Later

When you make changes:

1. **Edit `docs/presentation/presentation.Rmd`**

2. **Re-render:**
   ```bash
   cd docs/presentation
   Rscript -e "rmarkdown::render('presentation.Rmd')"
   ```

3. **Commit and push:**
   ```bash
   git add docs/presentation/index.html
   git commit -m "Update presentation"
   git push origin main
   ```

4. **Wait 1-2 minutes** for GitHub Pages to rebuild

5. **Hard refresh browser:** Ctrl+Shift+R (or Cmd+Shift+R on Mac)

---

## File Checklist

After setup, you should have:

```
docs/
├── index.html                      ✓ Landing page
├── presentation/
│   ├── presentation.Rmd            ✓ Source file
│   ├── index.html                  ✓ Generated slides
│   ├── custom.css                  ✓ Styling
│   ├── libs/                       ✓ xaringan dependencies
│   │   ├── remark-css-0.0.1/
│   │   ├── remark-latest.min.js
│   │   └── ...
│   └── presentation_files/         ✓ Generated figures (if any)
│       └── figure-html/
├── testing.md                      ✓ Existing doc
├── presentation-guide.md           ✓ Existing doc
└── github-pages-setup.md           ✓ This guide
```

---

## Benefits of This Setup

✅ **Easy Sharing:** Just share one URL - no downloads needed
✅ **Professional:** Clean, memorable link
✅ **Always Updated:** Push changes, presentation updates automatically
✅ **Cross-Platform:** Works on any device with a browser
✅ **No Installation:** Viewers don't need R or any software
✅ **Version Control:** Full history of changes
✅ **Multiple Formats:** HTML (online) + PDF (download) both available

---

## URLs Summary

After setup, you'll have these public URLs:

| Resource | URL |
|----------|-----|
| **Landing Page** | https://robert-johansson.github.io/heshmati-reanalysis/ |
| **Presentation** | https://robert-johansson.github.io/heshmati-reanalysis/presentation/ |
| **Testing Guide** | https://robert-johansson.github.io/heshmati-reanalysis/testing.html |
| **Presentation Guide** | https://robert-johansson.github.io/heshmati-reanalysis/presentation-guide.html |
| **Setup Guide** | https://robert-johansson.github.io/heshmati-reanalysis/github-pages-setup.html |

---

## Notes

### Self-Contained Mode

**We use `self_contained: false` (default) because:**
- xaringan works better this way
- Smaller HTML files
- Faster loading
- Standard practice for GitHub Pages
- libs/ folder is committed to git, so everything works

**Alternative: `self_contained: true`**
- Embeds everything in HTML
- One large file (~2-3 MB)
- Works offline
- May have issues with some xaringan features
- Not recommended for GitHub Pages

### Markdown Files

GitHub Pages automatically converts `.md` to `.html`:
- `testing.md` → accessible as `testing.html`
- `presentation-guide.md` → accessible as `presentation-guide.html`
- Just link to `.html` in your landing page

---

## Additional Resources

- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [xaringan Documentation](https://slides.yihui.org/xaringan/)
- [Deploying xaringan Slides (R Views)](https://rviews.rstudio.com/2021/11/18/deploying-xaringan-slides-a-ten-step-github-pages-workflow/)

---

## Questions?

If you encounter issues:
1. Check the Troubleshooting section above
2. Verify all files are committed and pushed
3. Check GitHub Actions tab for build errors
4. Open an issue on the repository

---

**Last Updated:** 2025-10-11
**Estimated Setup Time:** 30-45 minutes
