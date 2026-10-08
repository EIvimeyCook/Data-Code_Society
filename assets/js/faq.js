/* Progressive enhancement for the hackathon FAQ.
   The page is fully readable without this script; it only adds
   question cards, number badges, the side contents and small touches. */
(function () {
  "use strict";

  function ready(fn) {
    if (document.readyState !== "loading") fn();
    else document.addEventListener("DOMContentLoaded", fn);
  }

  ready(function () {
    var main = document.querySelector(".content");
    if (!main) return;

    // 1. Question headings: "3.7 Is there a license? *" -> badge + text + "required" pill
    main.querySelectorAll("h3").forEach(function (h) {
      var html = h.innerHTML.trim();
      var m = html.match(/^(\d+\.\d+)\s+/);
      if (!m) return;
      var rest = html.slice(m[0].length);
      var required = /\s*\*\s*$/.test(rest);
      rest = rest.replace(/\s*\*\s*$/, "");
      h.innerHTML =
        '<span class="qnum">' + m[1] + "</span>" +
        '<span class="qtext">' + rest +
        (required ? ' <span class="req">Required</span>' : "") +
        "</span>";
      h.classList.add("q");
    });

    // 2. Wrap each question and its answer in a card
    main.querySelectorAll("h3.q").forEach(function (h) {
      var card = document.createElement("section");
      card.className = "card";
      h.parentNode.insertBefore(card, h);
      var node = h;
      while (node) {
        var next = node.nextElementSibling;
        card.appendChild(node);
        if (!next || /^(H2|H3|HR)$/.test(next.tagName)) break;
        node = next;
      }
    });

    // 3. "FAQ" labels and routing lines
    main.querySelectorAll("p").forEach(function (p) {
      var text = p.textContent.trim();
      if (text === "FAQ") p.classList.add("faq-label");
      if (/^➡️/.test(text)) {
        p.innerHTML = p.innerHTML.replace(/^\s*➡️\s*/, "");
        p.classList.add("route");
      }
    });

    // 4. "To be confirmed" placeholders
    main.querySelectorAll("em").forEach(function (em) {
      if (/^To be confirmed/i.test(em.textContent.trim())) em.classList.add("pending");
    });

    // 5. Tables: rounded scroll wrapper
    main.querySelectorAll("table").forEach(function (t) {
      var wrap = document.createElement("div");
      wrap.className = "table-wrap";
      t.parentNode.insertBefore(wrap, t);
      wrap.appendChild(t);
    });

    // 6. Side contents built from the section headings
    var toc = document.getElementById("toc");
    var sections = Array.prototype.slice.call(main.querySelectorAll("h2[id]"));
    if (toc && sections.length) {
      sections.forEach(function (h) {
        var a = document.createElement("a");
        a.href = "#" + h.id;
        a.textContent = h.textContent.replace(/\s+—\s+/, ": ");
        toc.appendChild(a);
      });
      document.body.classList.add("has-toc");

      var links = toc.querySelectorAll("a");
      if ("IntersectionObserver" in window) {
        var obs = new IntersectionObserver(function (entries) {
          entries.forEach(function (e) {
            if (!e.isIntersecting) return;
            links.forEach(function (l) {
              l.classList.toggle("active", l.getAttribute("href") === "#" + e.target.id);
            });
          });
        }, { rootMargin: "0px 0px -70% 0px" });
        sections.forEach(function (s) { obs.observe(s); });
      }
    }

    // 7. Mermaid diagrams (```mermaid blocks): render with Mermaid from jsDelivr.
    //    GitHub renders the same blocks natively, so FAQ.md stays readable there.
    var blocks = [];
    main.querySelectorAll("code.language-mermaid, pre.mermaid code, .language-mermaid code").forEach(function (code) {
      var outer = code.closest(".language-mermaid") || code.closest("pre");
      if (!outer || blocks.some(function (b) { return b.outer === outer; })) return;
      // classDef colours are for GitHub's own view; on the site the CSS colours
      // the nodes (so they follow light/dark), so drop the classDef lines here.
      var text = code.textContent.split("\n").filter(function (line) {
        return !/^\s*classDef\s/.test(line);
      }).join("\n");
      blocks.push({ outer: outer, text: text });
    });
    if (blocks.length) {
      blocks.forEach(function (b) {
        var wrap = document.createElement("figure");
        wrap.className = "flow";
        var div = document.createElement("div");
        div.className = "mermaid";
        div.textContent = b.text;
        wrap.appendChild(div);
        b.outer.parentNode.replaceChild(wrap, b.outer);
      });
      var s = document.createElement("script");
      s.src = window.MERMAID_SRC || "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js";
      s.onload = function () {
        window.mermaid.initialize({
          startOnLoad: false,
          securityLevel: "strict",
          theme: "base",
          flowchart: { curve: "basis", padding: 8, nodeSpacing: 22, rankSpacing: 26, htmlLabels: true },
          themeVariables: {
            fontFamily: '"Roboto", Helvetica, Arial, sans-serif',
            fontSize: "12px",
            lineColor: "#5d6561",
            edgeLabelBackground: "transparent",
            textColor: "#2f3432"
          }
        });
        window.mermaid.run({ querySelector: ".flow .mermaid" });
      };
      document.head.appendChild(s);
    }

    // 8. Light/dark toggle: remembers the choice; otherwise follows the system
    var toggle = document.querySelector(".theme-toggle");
    if (toggle) {
      var root = document.documentElement;
      var isDark = function () {
        var t = root.getAttribute("data-theme");
        if (t) return t === "dark";
        return window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches;
      };
      var label = function () { toggle.setAttribute("aria-pressed", isDark() ? "true" : "false"); };
      label();
      toggle.addEventListener("click", function () {
        var next = isDark() ? "light" : "dark";
        root.setAttribute("data-theme", next);
        try { localStorage.setItem("faq-theme", next); } catch (e) {}
        label();
      });
    }

    // 9. "Today" marker on the timeline. Edit these dates if the schedule changes.
    var TIMELINE = {
      start: Date.UTC(2026, 9, 13, 9, 0),      // 13 Oct 2026, 09:00 UTC (months are 0-based)
      hackEnd: Date.UTC(2026, 9, 13, 10, 25),  // 13 Oct 2026, 10:25 UTC
      close: Date.UTC(2026, 11, 2, 0, 0)       // end of 1 Dec 2026 (00:00 UTC on 2 Dec)
    };
    var tl = document.querySelector("#timeline + ol");
    if (tl && tl.children.length >= 3) {
      var items = tl.children;
      var marker = document.createElement("div");
      marker.className = "tl-now";
      marker.setAttribute("aria-hidden", "true");
      marker.innerHTML = '<span class="tl-now-label"></span><span class="tl-now-arrow"></span>';
      tl.appendChild(marker);
      var label = marker.querySelector(".tl-now-label");
      var DAY = 86400000;

      var place = function () {
        var now = Date.now();
        var dotY = function (li) { return li.offsetTop + 25; };   // centre of each item's dot
        var y, text, current = -1;
        if (now < TIMELINE.start) {
          var ms = TIMELINE.start - now, d = Math.ceil(ms / DAY);
          y = dotY(items[0]) - 30;
          text = ms < DAY ? "Starts in " + Math.ceil(ms / 3600000) + "h" : d + " days to go";
        } else if (now < TIMELINE.hackEnd) {
          y = dotY(items[0]); text = "Happening now"; current = 0;
        } else if (now < TIMELINE.close) {
          var f = (now - TIMELINE.hackEnd) / (TIMELINE.close - TIMELINE.hackEnd);
          y = dotY(items[0]) + f * (dotY(items[2]) - dotY(items[0]));
          var left = Math.ceil((TIMELINE.close - now) / DAY);
          text = left + (left === 1 ? " day left" : " days left"); current = 1;
        } else {
          y = dotY(items[2]); text = "Closed"; current = 2;
        }
        marker.style.top = Math.max(-6, y) + "px";
        label.textContent = text;
        for (var i = 0; i < items.length; i++) items[i].classList.toggle("current", i === current);
      };
      place();
      window.addEventListener("resize", place);
      setInterval(place, 60000);
    }

    // 10. Back-to-top button
    var top = document.querySelector(".to-top");
    if (top) {
      var onScroll = function () { top.classList.toggle("show", window.scrollY > 600); };
      window.addEventListener("scroll", onScroll, { passive: true });
      onScroll();
    }
  });
})();
