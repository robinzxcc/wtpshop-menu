# WTPSHOP menu host (no card)

Hosts `wtpmenu.lua` on **GitHub Pages** — free, no Cloudflare R2, no credit card.

After publish, inject:

```lua
MachoIsolatedInject(MachoGetRequest("https://raw.githubusercontent.com/robinzxcc/wtpshop-menu/main/wtpshop/wtpmenu.lua"))
```

Or use `wtpshop-loader.lua` in Downloads (URL updated by `PUBLISH.ps1`).

**Privacy:** repo is public; use an obscure repo name / folder in `publish-config.ps1` if you want a harder-to-guess URL.

Run: `.\PUBLISH.ps1`
