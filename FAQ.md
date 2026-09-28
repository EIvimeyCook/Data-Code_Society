# 🐉 SORTEE 2026 Hackathon — Data & Code in Ecology and Evolution Society Journals: FAQ and Guide

> **Quick links:** [Introduction](#introduction) · [Before you start](#before-you-start) · [Form flow](#how-the-form-flows) · [Section 1](#section-1--metadata) · [Section 2](#section-2--is-there-a-data-repository) · [Section 3](#section-3--data-repository) · [Section 4](#section-4--is-there-a-code-repository) · [Section 5](#section-5--code-repository) · [Section 6](#section-6--comments) · [General FAQ](#general-faq) · [Contributions (Dragon Kill Points)](#contributions-dragon-kill-points)

---

## Introduction

<!--
TODO (organisers): Extend the introduction. Still to add:
- Which journals/societies are included and why
- What the assessments will be used for (e.g. a paper / report)
- Date, time and location/format at the SORTEE 2026 conference
- Who to contact during the event (names, Slack/Discord channel)
- How manuscripts are allocated to participants
- Code of conduct link
-->

This hackathon, led by the **SORTEE Advocacy Committee**, looks at **data and code availability and quality in journals published by ecology and evolution societies**. Many of these journals now require authors to share the data and code behind their papers, but how well that works in practice varies.

Working through a shared set of recently published papers, participants record whether each paper's data and code are **archived, accessible, licensed and documented**, using a Google Form. This guide explains every question on that form and how to handle the edge cases.

---

## Before you start

- **Have the manuscript open** (PDF or journal web page) *and* keep a second tab free for the repository.
- **Assess what is there, not what should be there.** You are recording what a reader can find and use today — don't try to fix, re-run, or contact authors about anything.
- **Don't download huge files.** If a dataset is very large, you can answer "downloadable?" based on whether the download link starts working; you don't need to wait for it to finish.
- **When in doubt, pick the most defensible answer and explain it in the comments box** for that section (3.13, 5.12 or 6.1). Comments are extremely useful to us when we clean the data.
- Questions marked **\*** are mandatory.

---

## How the form flows

```
Section 1 (Metadata)
   └─ 1.4 Should there be data and/or code?
        ├─ No  ──────────────────────────────────────────► Section 6 (Comments) → End
        └─ Yes ─► Section 2: Is there a data repository? (2.1)
                    ├─ Yes ─► Section 3 (Data repository) ─┐
                    └─ Any "No" option ────────────────────┤
                                                           ▼
                             Section 4: Is there a code repository? (4.1)
                                ├─ Yes ─► Section 5 (Code repository) ─┐
                                └─ Any "No" option ────────────────────┤
                                                                       ▼
                                                  Section 6 (Comments) → End
```

Note that **data and code are assessed separately**, even when they live in the same repository. If one Zenodo record contains both, you will visit it in Section 3 *and* again in Section 5 — that is intended.

---

## Section 1 — Metadata

### 1.1 Name \*
**What to do:** Enter your name.

**FAQ**
- *Why do you need my name?* So we can credit you (see [Contributions](#contributions-dragon-kill-points)).

- *I'm assessing multiple papers — do I enter it every time?* Yes, one form submission per manuscript.

### 1.2 What is the ID of the manuscript? \*
**What to do:** Enter the manuscript ID exactly as it appears in your allocation sheet.

**FAQ**
- *Where do I find the ID?* In the allocation spreadsheet you were given. Please copy–paste rather than retype — typos here make it very hard to match records.

### 1.3 DOI of the manuscript \*
**What to do:** Enter the article DOI.

**FAQ**
- *What format?* Either `10.xxxx/xxxxx` or the full `https://doi.org/10.xxxx/xxxxx` is fine — please be consistent across your submissions.
- *Where do I find it?* Usually on the first page of the PDF or at the top of the journal web page.

### 1.4 Should there be data and/or code associated with the paper? \*
**What to do:** Answer **Yes** if the paper analyses data (empirical work) or presents theory/simulations that rely on code. Answer **No** for reviews, opinion pieces, perspectives, editorials, etc.

**FAQ**
- *It's a meta-analysis.* **Yes** — meta-analyses analyse extracted data.
- *It's a purely mathematical/analytical theory paper with no simulations.* Usually **No**, unless the paper mentions code (e.g. numerical solutions). If it does, answer **Yes**.
- *It's a review that includes a small quantitative analysis or a systematic literature search.* **Yes** — there is data behind it.
- *I'm unsure.* Answer **Yes**; it's easier for us to remove a false positive than to recover a skipped assessment. Explain in 6.1.

➡️ **Yes** → Section 2. **No** → Section 6.

---

## Section 2 — Is there a Data repository?

### 2.1 Is there a working reference to archived data in the MS? \*
**What to do:** Search the manuscript for "data" and read the **Data Availability / Open Research statement**, the **Methods**, and the **Supplementary Material** list. Try every link given.

| Option | Choose when… |
|---|---|
| **Yes** | At least one link/accession works and leads to data, *or* the data are in the supplementary files. |
| **No, link(s) that doesn't work** | Data are referenced but the link is broken, leads to a 404, a login wall, or a generic landing page with no way to find the dataset. |
| **No, sensitive data so not shared** | The authors explicitly state data are withheld for ethical, legal, or conservation reasons (e.g. endangered species locations, human participants). |
| **No, no reference** | No mention of archived data, *or* only "available from the authors on (reasonable) request". |

**FAQ**
- *"Data available on request" — which option?* **No, no reference.** Data on request are not archived. Mention it in 6.1.
- *The DOI works but resolves to a private/embargoed record.* **Yes** here — the reference works. You'll record the access problem at 3.8.
- *Only some of the data are archived.* **Yes**, and explain what's missing in 3.13.
- *A link works in some browsers but not others / only works on the university network.* Choose **No, link(s) that doesn't work** and describe what happened in 6.1.
- *The data come entirely from an existing public database (e.g. GBIF, a previously published dataset) and the paper cites it.* **Yes** if a working link/accession to the specific data used is given; otherwise **No, no reference**. Note it in the comments.

➡️ **Yes** → Section 3. **Any "No"** → Section 4.

---

## Section 3 — Data Repository

### 3.1 Is the data stored across multiple repositories? \*
**What to do:** Answer **Yes** if data are split across more than one location (e.g. Dryad + GenBank, or Zenodo + Supplementary Material).

**FAQ**
- *Is a GitHub repo that is also archived on Zenodo "multiple repositories"?* **No** — that's one resource in two places. Treat the **Zenodo** version as the repository (it has the permanent ID).
- *Raw sequence reads on NCBI plus processed data on Dryad?* **Yes.**

### 3.2 If there are multiple repos, select one as the primary and justify
**What to do:** Only answer if 3.1 = Yes. Pick **one** repository to assess for the rest of the section, using this priority order:

1. The repo where **data and code are stored together**.
2. The repo that holds the data the **analysis directly uses** (i.e. processed data).
3. The repo holding **most** of the data.

Briefly say which rule you used, e.g. *"Zenodo chosen: data and code together; raw reads on NCBI."*

### 3.3 What is the repository? \*
**What to do:** Select the repository you are assessing.

**FAQ**
- *The DOI starts with `10.5061/dryad`* → Dryad. *`10.5281/zenodo`* → Zenodo. *`10.17605/OSF.IO` or osf.io* → OSF. *`10.6084/m9.figshare`* → Figshare.
- *Data are in the journal's Supporting Information* → **Supplementary Material**.
- *A university data store (e.g. "Edinburgh DataShare", "Pure")* → **Institutional repository**.
- *Pangaea, Mendeley Data, Borealis, etc.* → **Other**, and name it in 3.13.

### 3.4 Paste URL of the repository \*
**What to do:** Copy the URL from your browser's address bar **after** following the link — i.e. the actual landing page, not the DOI string from the paper.

### 3.5 Is there a Permanent ID? \*
**What to do:** Answer **Yes** if the dataset has a persistent identifier such as a **DOI**, an **accession number** (e.g. GenBank, SRA), or a **Handle**.

**FAQ**
- *GitHub?* **No.** A GitHub URL is not a permanent identifier — repos can be renamed, edited or deleted. (If the GitHub repo has been archived to Zenodo, you should be assessing the Zenodo record — see 3.1.)
- *OSF project?* OSF projects can be registered or given a DOI. Answer **Yes** only if a DOI is shown on the project page.
- *Supplementary material?*  Answer **No** unless the supplementary file has its own DOI (some publishers, e.g. those using Figshare-hosted supplements, assign one). The article's DOI does not count.

### 3.6 If yes, what is the Permanent ID?
**What to do:** Paste the DOI/accession, e.g. `10.5061/dryad.xxxxxxx`.

### 3.7 Is there a license? \*
**What to do:** Look for a LICENSE file, or a licence stated on the repository landing page.

**FAQ**
- *Dryad.* Dryad publishes all data under CC0, even if no licence file is included — answer **Yes**.
- *Zenodo / Figshare / OSF.* The licence is usually shown on the landing page sidebar (e.g. "Creative Commons Attribution 4.0 International"). If one is shown → **Yes**.
- *Common data licences:* CC0, CC-BY-4.0. *Common code licences:* MIT, Apache-2.0, GNU GPL. A code licence applied to a data repository still counts as **Yes**.
- *"All rights reserved" / a copyright notice only.* **No** — this isn't an open licence. Note it in 3.13.
- *Supplementary material.* Answer **Yes** only if a licence is stated for the supplement (sometimes the article's CC-BY licence explicitly covers supplementary files — if so, say so in 3.13).

### 3.8 Are data archived and downloadable? \*
**What to do:** Can you see data files **and** start downloading them?

Answer **No** if the repo is **private**, **embargoed**, requires a **login or request** to access, or the files are **empty or corrupt**.

**FAQ**
- *The download is enormous.* If the download starts, answer **Yes** — no need to finish it.
- *Files are compressed (.zip, .tar.gz).* Download and unzip if reasonably sized so you can answer 3.9–3.12. If it's too large, answer based on the file listing and note this in 3.13.

### 3.9 What format are the data in? \*
**What to do:** Tick **all** formats present, based on file extensions.

| Option | Examples |
|---|---|
| Tabular data | `.csv`, `.tsv` |
| Spreadsheet | `.xlsx`, `.xls`, `.ods` |
| Text | `.txt` |
| Statistical software file | `.rds`, `.RData`/`.rda`, `.sav`, `.dta`, `.mat` |
| Image | `.png`, `.jpg`, `.tiff` |
| Video | `.mp4`, `.mov`, `.avi` |
| Document | `.doc`, `.docx`, `.pdf`, `.odt` |
| Format not identifiable | No extension, or an extension you can't identify |
| Other | Anything else — list extensions separated by `;` (e.g. `.fasta; .nex; .shp`) |

**FAQ**
- *Data are only in a `.zip`.* Record the formats **inside** the archive where you can.
- *Data tables are only in a PDF supplement.* Tick **Document**.

### 3.10 Is there info on the project? \*
**What to do:** Answer **Yes** if the repository contains or displays project-level information — e.g. the associated article, authors/contact details, funders. This is usually in a **README** or the landing-page description.

**FAQ**
- *The landing page just repeats the paper's abstract.* **Yes** — that is project information. A title alone is **No**.

### 3.11 Is each data file described? \*
**What to do:** Answer **Yes** if *every* data file has a description (what it contains/what it's for), either in a README or in file-level metadata.

**FAQ**
- *Most files described, one or two aren't.* **No** — the question asks about *each* file. Explain in 3.13.
- *There's only one data file and the landing page describes it.* **Yes.**

### 3.12 Are the variables in the data files explicitly explained? \*
**What to do:** Is there a **data dictionary** or equivalent that says what each column/variable means (ideally with units and codes for categories)?

**FAQ**
- *Column names are self-explanatory (e.g. `body_mass_g`).* That's good practice, but not an explanation — answer **No** unless explanations are given. Mention it in 3.13.
- *Only some variables are explained.* **No**, and note it in 3.13.
- *Variables are described in the paper's methods, not the repo.* **No** — we're assessing whether the archive stands alone. Note it in 3.13.

### 3.13 Comments about data
Anything unusual: partial archiving, ambiguous answers, which rule you applied, access problems, etc.

➡️ Continue to Section 4.

---

## Section 4 — Is there a Code repository?

### 4.1 Is there a working reference to archived code in the MS? \*
**What to do:** Search the manuscript for "code", "script", "software", and "GitHub", and read the Data/Code Availability or Open Research statement and the Supplementary list.

| Option | Choose when… |
|---|---|
| **Yes** | A link works and leads to code, *or* code is in the supplementary files. |
| **No, link(s) that doesn't work** | Code is referenced but the link is broken/inaccessible. |
| **No, no reference** | No mention of archived code, or "available on request". |

**FAQ**
- *The data repository from Section 3 also contains code, but the paper never mentions code.* **Yes** — code is archived and reachable from a working reference in the MS. Say so in 5.12.
- *The paper only cites the R packages used (e.g. "analyses used lme4").* That is **not** archived analysis code → **No, no reference**.
- *The paper says "code on GitHub" with no link.* **No, no reference**, and comment in 6.1 if you found it by searching.

➡️ **Yes** → Section 5. **Any "No"** → Section 6.

---

## Section 5 — Code Repository

> If code is spread across multiple repositories, assess the one prioritised under the rules in **3.2** (above) and explain in 5.12.

### 5.1 What is the repository? \*
See **3.3** (above). Answer for the **code**, even if it's the same repo as the data.

### 5.2 Paste URL of the repository \*
Copy the landing-page URL from the browser address bar.

### 5.3 Is there a Permanent ID? \*
See **3.5** (above). A bare GitHub/GitLab repo is **No**; a Zenodo snapshot of it (with DOI) is **Yes**.

**FAQ**
- *The GitHub README has a Zenodo DOI badge.* If you are assessing the GitHub repo because that is what the paper links to, answer **Yes** only if the DOI actually resolves to an archived snapshot. Note the situation in 5.12.

### 5.4 If yes, what is the Permanent ID?
Paste the DOI.

### 5.5 Is there a license? \*
See **3.7** (above). On GitHub, look for a `LICENSE` file or the licence shown in the "About" sidebar. **A public GitHub repo without a licence is *not* open-licensed** — answer **No**.

### 5.6 Are code files archived and downloadable? \*
Can you see code files and download them (or download the whole repo, e.g. GitHub's *Code → Download ZIP*)? Private, empty, or login-only → **No**.

### 5.7 What format is the code in? \*
Tick all that apply.

| Option | Examples |
|---|---|
| Text | `.txt` containing code |
| Code / script | `.R`, `.py`, `.m`, `.sh`, `.jl`, `.stan`, `.Rmd`, `.qmd`, `.ipynb` |
| Document | Code pasted into `.doc`, `.docx`, `.pdf` |
| Other | Anything else — name it in 5.12 |

**FAQ**
- *R Markdown, Quarto or Jupyter notebooks?* Tick **Code / script** — these are executable.

### 5.8 Is there info on the project? \*
See **3.10** (above).

### 5.9 Are the code files well described? \*
**What to do:** Could you work out **what each script does** and **in what order to run them** *without* reading the paper?

**FAQ**
- *Scripts are numbered (`01_clean.R`, `02_models.R`) but there's no README.* A judgement call — if the order and purpose are genuinely obvious, **Yes**; otherwise **No**. Explain in 5.12.
- *There's a single, well-commented script.* **Yes.**
- *The README says "run the code" and nothing else.* **No.**

### 5.10 Is there information on the version of the computing software used? \*
**What to do:** Is the version of the language/software stated (e.g. *R v4.3.3*, *Python 3.11*, *MATLAB R2023b*)?

**FAQ**
- *Where should I look?* README, top of scripts, `sessionInfo()` output, `renv.lock`, `environment.yml`, a Dockerfile, or the repository page.
- *Only stated in the paper's methods.* **No** — note it in 5.12.

### 5.11 Is there some information on version numbers of software packages? \*
**What to do:** Are versions given for **at least some** packages/libraries (e.g. *lme4 v1.1-35*)?

**FAQ**
- *Which files count?* A README list, `sessionInfo()` output, `renv.lock`, `requirements.txt` (with versions), `environment.yml`, `DESCRIPTION`, or versions in script comments.
- *`requirements.txt` lists packages without versions.* **No.**
- *Only some packages have versions.* **Yes** (the question asks for "some"), and note it in 5.12.

### 5.12 Comments about code
Anything unusual: hard-coded file paths, missing scripts, code in a different repo from data, ambiguous answers.

➡️ Continue to Section 6.

---

## Section 6 — Comments

### 6.1 General comments
Anything that doesn't fit elsewhere: data "on request", links that work in one browser but not another, disagreements between the paper and the repository, time taken, or suggestions for improving the form.

---

## General FAQ

**How long should one assessment take?**
We're thinking this should take a maximum(!) of 10 mins per paper.

_To be confirmed._

**Should I run the code or check the data reproduce the results?**
No. This form assesses **availability and documentation**, not computational reproducibility.

**Should I contact the authors if something is missing?**
No. Record what you find.

**I made a mistake in a submission. What do I do?**
Contact the organisers either by email or during the 

_To be confirmed._

**Two answers both seem right.**
Choose the more conservative answer and explain in the comments box.

**Where do I ask questions during the event?**
The zoom chat or the dedicated slack channel. 

_To be confirmed._

---

## Contributions (Dragon Kill Points)

We track contributions using **Dragon Kill Points (DKP)** (Martinig et al. 2026), a transparent, points-based system adapted from multiplayer gaming. It is built on five **GREAT** principles:

- **Granularity** — record contributions at a detailed task level so nothing is under-counted;
- **Responsibility** — authorship criteria are agreed at the outset;
- **Equity** — the same rules apply to everyone, regardless of career stage;
- **Autonomy** — contributors can query or change their position as the project progresses;
- **Transparency** — the contribution record is shared with the whole team throughout.

For this hackathon we track **one contribution only: the number of papers you extract** (i.e. completed form submissions). Each completed form counts as one paper.

**Authorship rule:** extract **30 papers** and you earn authorship on the resulting paper. Authorship will be alphabetical. 

### Contribution table

| Name | Confirmed involvement | Papers extracted (count) | Authorship earned (≥ 30 papers) | Author order (\* = equal) |
|---|---|---|---|---|
| Participant 1 | participating | | | |
| Participant 2 | participating | | | |
| Participant 3 | not participating | NA | No | NA |

### Reference

Martinig, A. R., Burk, S. L. P., Drobniak, S. M., Perry, I., Morrison, K., Petersohn, M., Pottier, P., Nakagawa, S., Pollo, P., Ricolfi, L., Williams, C., Mizuno, A., Chhen, A., Tam, J., Yang, Y., de Jong, J., Ceccacci, A., Cuadros, S., & Lagisz, M. (2026). Dragon Kill Points: applying a transparent working template to relieve authorship stress. *BMC Biology*, 24, 48. https://doi.org/10.1186/s12915-026-02521-x
