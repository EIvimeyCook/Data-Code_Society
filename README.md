<h1 align="center">SORTEE 2026 Hackathon: Data &amp; Code in Society Journals</h1>

<p align="center">
  <em>A question-by-question guide to the assessment form for the SORTEE 2026
  hackathon on data and code availability in ecology and evolution society
  journals.</em>
</p>

<p align="center">
  <a href="LICENSE"><img alt="Code: MIT" src="https://img.shields.io/badge/code-MIT-blue.svg"></a>
  <a href="LICENSE-data.md"><img alt="Content: CC BY 4.0" src="https://img.shields.io/badge/content-CC%20BY%204.0-lightgrey.svg"></a>
  <img alt="Built with GitHub Pages" src="https://img.shields.io/badge/built%20with-GitHub%20Pages-1f6feb.svg">
</p>

---

## Description

The SORTEE 2026 conference hackathon, led by the **SORTEE Advocacy
Committee**, examines **data and code availability and quality in journals
published by ecology and evolution societies**. Participants assess recently
published papers for whether their data and code are **archived, accessible,
licensed and documented**, using a shared Google Form. This repository hosts
the FAQ that sits alongside that form.

For every question on the form, the guide says **what to do**, and answers the
edge cases that come up in practice: data "available on request", GitHub
repositories without a DOI, partial archiving, Dryad's default CC0 licence,
packages listed without versions, and so on. It also sets out how contributions
are credited, using **Dragon Kill Points** (Martinig et al. 2026).

Read it at: <https://eivimeycook.github.io/Data-Code_Society/>

The guide covers:

| Section | What it covers |
|---|---|
| Introduction | What the hackathon is and how papers are allocated |
| Timeline | Start (13 October 2026, 09:00 UTC) and close of data extraction (1 December 2026) |
| Contributions | Who can contribute, co-authorship requirements, and Dragon Kill Points (60 DKP for authorship) |
| Before you start | Ground rules for assessing |
| How the form flows | Which answers route to which sections |
| General FAQ | Timing, corrections, access problems, conflicts of interest, where to ask for help |
| Sections 1–6 | Help and FAQs for every form question |

## Data files

The `hackathon_papers/` folder holds the paper lists behind the hackathon and
the R code that produced them. The paper lists cover journal articles published
between 1 January and 30 September 2026 in the 89 society journals in the
sample, pulled from [OpenAlex](https://openalex.org) in October 2026.

| File | Rows | What it contains |
|---|---|---|
| `total_papers_oct_rerun.csv` | 10,798 papers | Every article published in the sample journals over that period: the sampling frame the hackathon papers were drawn from. |
| `hackathon_papers.csv` | 1,442 papers | The papers to be assessed at the hackathon, a random subset of `total_papers_oct_rerun.csv`. Each participant's file of allocated papers is drawn from this. |
| `2026_journals_oct_rerun.csv` | 89 journals | The number of articles each journal published per month, January to September 2026, with a total. |
| `publishers.csv` | 89 journals | Each journal's publisher, as recorded in OpenAlex. |
| `OpenAlexPull.R` | — | R script that pulls the articles from OpenAlex and writes the three files above it. |
| `split_papers.R` | — | R script that draws the hackathon sample from the full list. |

**Columns in `total_papers_oct_rerun.csv` and `hackathon_papers.csv`**

| Column | Description |
|---|---|
| `title` | Article title |
| `doi` | Article DOI, as a full `https://doi.org/` link |
| `journal` | Journal name, as in OpenAlex |
| `publication_date` | Publication date (`YYYY-MM-DD`) |
| `sample_no` | `hackathon_papers.csv` only: the order in which the paper was drawn **within its journal** (1–15, or 1–30 for data-editor journals). Not unique across journals. |
| `manuscript_id` | `hackathon_papers.csv` only: a unique number for each paper (1–1,442), entered at question 1.2 of the form. Added after sampling, so it is not produced by `split_papers.R`. |

**Columns in `2026_journals_oct_rerun.csv`**

| Column | Description |
|---|---|
| *(unnamed, first)* | Row number (1–89) |
| `journal` | Journal name, matching the `journal` column in the other files |
| `Jan` – `Sep` | Number of articles the journal published in that month of 2026 |
| `total` | Total articles January–September 2026 (the sum of the monthly columns) |

**Columns in `publishers.csv`**

| Column | Description |
|---|---|
| `display_name` | Journal name in OpenAlex |
| `issn_l` | Linking ISSN |
| `host_organization_name` | Publisher (e.g. Wiley, Springer Science+Business Media, Oxford University Press) |
| `host_organization` | Publisher's OpenAlex ID |

**How the papers were pulled (`OpenAlexPull.R`).** The script uses the
[openalexR](https://cran.r-project.org/package=openalexR) package and needs a
free OpenAlex API key. It:

1. matches each journal title to an OpenAlex source, automatically and then by
   hand for five journals whose automatic match was wrong, and saves each
   journal's publisher to `publishers.csv`;
2. downloads every work from those journals with `type = "article"`, published
   in 2026 up to 30 September, indexed in Crossref, with at least one author
   and an assigned topic (filters intended to exclude editorials and other front matter);
3. removes duplicate DOIs and saves the result as `total_papers_oct_rerun.csv`;
4. counts articles per journal per month and saves `2026_journals_oct_rerun.csv`.

The script queries 90 journals; Primate Conservation published nothing in the
period, which leaves 89.

**How the hackathon sample was drawn (`split_papers.R`).** A stratified random
sample, made reproducible with `set.seed(1)`:

- **Ten journals with a data editor** contribute up to 30 papers each: The
  American Naturalist, Behavioral Ecology, Ecological Applications, Ecological
  Monographs, Ecology, Ecology Letters, Ecosphere, Frontiers in Ecology and the
  Environment, Journal of Evolutionary Biology, and Proceedings of the Royal
  Society B. Ecological Monographs published only 24 articles, so all 24 are
  included.
- **All other journals** contribute up to 15 papers each. Seven published fewer
  than 15, so all of their papers are included (7–14 each).

## Organisers

The hackathon is run by the **SORTEE Advocacy Committee**:

| Name | Role | Affiliation |
|---|---|---|
| Ed R. Ivimey-Cook | Co-chair | University of East Anglia, UK |
| Joel Pick | Co-chair | University of Edinburgh, UK |
| Ben Auxier | Member | Wageningen University and Research, Netherlands |
| Kevin R. Bairos-Novak | Member | Australian Institute of Marine Science, Australia |
| Leyla Cabugos | Member | California Polytechnic State University, USA |
| Dena J. Clink | Member | Cornell University, USA |
| Sarah Hasnain | Member | Laboratoire d'Océanographie de Villefranche, Sorbonne University, France |
| Christian John | Member | University of California, USA |
| Kate L. Laskowski | Member | University of California Davis, USA |
| César Marín | Member | Universidad Santo Tomás, Chile |
| Shinichi Nakagawa | Member | University of Alberta, Canada & COSSEE |
| Julia Sharapi | Member | Stanford University, USA |

## Contributing

Corrections and clarifications are welcome, particularly new edge cases that
come up during the hackathon.

- **Something unclear or wrong?** Open an
  [issue](https://github.com/EIvimeyCook/Data-Code_Society/issues).
- **Suggesting an edit?** Edit `FAQ.md` and open a pull request. Keep answers
  short, give the answer first (**Yes** / **No**), then the reason, and say which
  comments box to use when the answer is a judgement call.

## Citation

If you use the Dragon Kill Points approach described here, please cite:

> Martinig, A. R., et al. (2026). Dragon Kill Points: applying a transparent
> working template to relieve authorship stress. *BMC Biology* 24: 48.
> <https://doi.org/10.1186/s12915-026-02521-x>

To cite this guide itself, GitHub's *Cite this repository* button reads
`CITATION.cff`, or:

> Ivimey-Cook, E. R., Pick, J. L., Auxier, B., Bairos-Novak, K. R., Cabugos, L.,
> Clink, D. J., Hasnain, S., John, C., Laskowski, K. L., Marín, C., Nakagawa, S.,
> & Sharapi, J. (2026). *SORTEE 2026 Hackathon: Data & Code in Society
> Journals — Assessment FAQ.* <https://github.com/EIvimeyCook/Data-Code_Society>

## Contact

Edward R. Ivimey-Cook — e.ivimeycook@gmail.com
[![ORCID](https://img.shields.io/badge/ORCID-0000--0003--4910--0443-A6CE39.svg)](https://orcid.org/0000-0003-4910-0443)

## Licence

- **Code**, meaning `_config.yml`, `_layouts/default.html`,
  `assets/css/sortee-faq.css`, `assets/js/faq.js` and the R scripts in
  `hackathon_papers/`, under the [MIT License](LICENSE).
- **Content**, meaning the guide text in `FAQ.md` and this README, under
  [CC BY 4.0](LICENSE-data.md).

The SORTEE logo mark in `assets/img/` belongs to SORTEE and is not covered by
either licence. The styling is inspired by the SORTEE website but not copied
from it.

## AI declaration

Claude (Anthropic) was used to draft the FAQ from the assessment form, to
summarise the Dragon Kill Points framework, and to write the page template,
CSS and JavaScript. All content was subsequently checked by the author.
