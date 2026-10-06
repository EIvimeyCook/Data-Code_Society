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

    // 9. Back-to-top button
    var top = document.querySelector(".to-top");
    if (top) {
      var onScroll = function () { top.classList.toggle("show", window.scrollY > 600); };
      window.addEventListener("scroll", onScroll, { passive: true });
      onScroll();
    }
  });
})();
