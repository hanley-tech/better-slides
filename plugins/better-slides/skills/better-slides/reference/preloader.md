# Asset preloader gate

For decks with heavy media (video backgrounds, large photos), add a loading gate so
the show never stutters mid-presentation: a black overlay that downloads every asset
into the browser's **HTTP disk cache** (not memory) with a progress bar, then reveals
a **Start** button. Two birds: the Start click is also the user gesture that unlocks
`video[autoplay]` playback on strict browsers.

Live example: `hanley.world/apple-10-things` (54 assets, ~55 MB).

## How it works
- A manifest array lists every asset path (build it by grepping the deck:
  `grep -o "assets/[^\"')]*" index.html | sort -u`).
- 6 concurrent workers `fetch(url, {cache:'force-cache'})` + `.blob()` each file —
  the response is discarded, so nothing stays in memory; the browser keeps it in
  its disk cache and the `<video>`/`<img>`/CSS loads hit cache instantly.
- Progress bar tracks `done/total`; failures are counted and logged, never block.
- When done, show the Start button (also Enter key). Dismiss fades the overlay,
  removes it, and calls `.play()` on all autoplay videos.

## Markup + script (drop in just before the main deck `<script>`)

```html
<div id="preload" style="position:fixed;inset:0;z-index:99;background:#000;color:#fff;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:28px;transition:opacity .5s ease">
  <div style="font-size:clamp(28px,5vmin,54px);font-weight:900;text-align:center;line-height:1.1">DECK TITLE</div>
  <div style="width:min(420px,70vw);height:4px;border-radius:99px;background:rgba(255,255,255,.14);overflow:hidden">
    <div id="preload-bar" style="width:0%;height:100%;border-radius:99px;background:var(--accent,#007AFF);transition:width .25s ease"></div>
  </div>
  <div id="preload-label" style="font-family:ui-monospace,Menlo,monospace;font-size:14px;opacity:.55">loading assets… 0%</div>
  <button id="preload-start" style="display:none;background:var(--accent,#007AFF);color:#fff;border:0;border-radius:999px;padding:14px 44px;font-size:18px;font-weight:700;cursor:pointer">Start ⏎</button>
</div>
<script>
(function(){
  const ASSETS=[ /* 'assets/…', one entry per file — regenerate when assets change */ ];
  const bar=document.getElementById('preload-bar'),label=document.getElementById('preload-label'),
        btn=document.getElementById('preload-start'),ov=document.getElementById('preload');
  let done=0,failed=0;
  function tick(){
    const pct=Math.round(done/ASSETS.length*100);
    bar.style.width=pct+'%';
    label.textContent=`loading assets… ${pct}%`+(failed?` (${failed} failed)`:'');
    if(done===ASSETS.length){
      // fetch() warms the HTTP cache but <video> still buffers via range requests on
      // demand — without this gate, Start clicks land on an unbuffered first video.
      label.textContent='preparing playback…';
      const tv=document.querySelector('video[autoplay]');
      const ready=()=>{if(btn.style.display==='block')return;
        label.textContent=failed?`ready (${failed} failed — see console)`:'all assets cached · ready';
        btn.style.display='block';btn.focus();};
      if(tv){try{tv.load();}catch(e){}
        if(tv.readyState>=4)ready();
        else{tv.addEventListener('canplaythrough',ready,{once:true});setTimeout(ready,5000);}}
      else ready();
    }
  }
  function dismiss(){ov.style.opacity='0';setTimeout(()=>ov.remove(),520);
    document.querySelectorAll('video[autoplay]').forEach(v=>v.play().catch(()=>{}));}
  btn.addEventListener('click',dismiss);
  addEventListener('keydown',e=>{if(e.key==='Enter'&&btn.style.display==='block'&&document.body.contains(ov))dismiss();});
  const queue=ASSETS.slice();
  async function worker(){while(queue.length){const url=queue.shift();
    try{const r=await fetch(url,{cache:'force-cache'});await r.blob();if(!r.ok){failed++;console.warn('preload failed',url,r.status);}}
    catch(e){failed++;console.warn('preload failed',url,e);}
    done++;tick();}}
  Promise.all(Array.from({length:6},worker));
})();
</script>
```

## Gotchas
- **Regenerate the manifest whenever assets change** — a missing entry just means that
  file loads lazily (no error), a stale entry shows a "failed" count.
- The overlay must set `color:#fff` explicitly — deck themes may default body text dark.
- Keep the overlay markup INLINE-styled and BEFORE the main deck script so it paints
  on first frame even while the engine boots.
- Works from `file://` too (fetch of relative paths is same-origin), but the cache
  benefit matters most over HTTP.
- Server must send 200s for every asset: after deploying, spot-check with
  `curl -o /dev/null -w "%{http_code}" <url>` — image tools often write mode-600 files
  which rsync preserves and Nginx then 403s. `chmod 644` before deploy.
