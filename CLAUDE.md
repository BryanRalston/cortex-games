# Casual Game Portal

A collection of browser-based casual games monetized with Google AdSense. Each game is a standalone page optimized for SEO, cross-linked within a shared portal.

## Goal
Build passive ad revenue through organic search traffic. Target: 1,000+ daily visitors within 3 months.

## Tech Stack
- Pure HTML/CSS/JavaScript — no frameworks, no build step
- Static site — deployable on Vercel/Netlify/GitHub Pages (free)
- Mobile-first responsive design
- Google AdSense for monetization

## Project Structure
```
game-portal/
├── index.html              # Portal landing page with game grid
├── shared/
│   ├── style.css           # Shared base styles + ad layout
│   ├── analytics.js        # Google Analytics setup
│   └── ads.js              # AdSense integration
├── games/
│   ├── sudoku/
│   │   └── index.html      # Self-contained game page
│   ├── minesweeper/
│   │   └── index.html
│   ├── 2048/
│   │   └── index.html
│   └── [game-name]/
│       └── index.html
└── assets/
    ├── favicon.ico
    └── og-images/          # Social sharing images per game
```

## Game Requirements (Every Game Must Have)
- Self-contained in a single HTML file (inline CSS + JS)
- Mobile-responsive (playable on phone, tablet, desktop)
- Touch + mouse + keyboard input support
- No external dependencies (no CDN imports)
- Fast load time (< 100KB total per game page)
- Local storage for saving progress/high scores
- Clean, modern UI — not retro/ugly
- SEO meta tags (title, description, og:image)
- AdSense ad slots (top banner, sidebar on desktop, between-content on mobile)
- Cross-links to other games in the portal
- Accessible (proper contrast, keyboard navigable, aria labels)

## Design Language
- Clean, minimal, modern
- White/light background with subtle color accents per game
- Large touch targets (min 44px)
- Smooth animations (CSS transitions, not JS when possible)
- System font stack (no web font loading)
- Dark mode support via prefers-color-scheme

## SEO Strategy
- Each game page targets its primary keyword: "play [game] online free"
- Proper heading hierarchy (h1 = game name, h2 = how to play)
- Schema.org Game markup
- Canonical URLs
- Sitemap.xml
- Fast Core Web Vitals (static HTML = easy wins)

## Ad Placement Rules
- Max 3 ad units per page (Google policy)
- Never interrupt gameplay — ads go above, below, or beside the game
- No interstitials or popups
- Responsive ad units that adapt to screen size

## Performance Targets
- Lighthouse score: 95+ across all categories
- First Contentful Paint: < 0.5s
- Total page weight: < 100KB per game
- Works offline after first load (service worker optional, nice-to-have)

## Game Roadmap (Build Order)
1. Sudoku — highest search volume, proven gameplay
2. Minesweeper — nostalgic, simple logic
3. 2048 — viral mechanic, quick to build
4. Word game (daily) — repeat engagement
5. Nonogram — niche but passionate audience
6. Memory match — simple, good for mobile
7. Solitaire — massive keyword traffic

## Domain
TBD — budget ~$10. Candidates: [to be decided]

## Common Gotchas
- AdSense approval requires: privacy policy page, about page, 15-20 pages of content, and real traffic. Plan to submit after 3+ games are live.
- Google indexes static sites fast but ranking takes weeks. Patience required.
- Mobile game controls are tricky — always test touch interactions thoroughly.
- Ad blockers will hide ads for ~30% of visitors. That's normal, don't fight it.
- Canvas-based games are NOT indexable by Google — use HTML/DOM for game UI when possible.
