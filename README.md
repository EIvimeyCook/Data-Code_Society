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
published articles for whether their data and code are **archived, accessible,
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
| Introduction | What the hackathon is and how articles are allocated |
| Timeline | Start (13 October 2026, 09:00 UTC) and close of data extraction (1 December 2026) |
| Code of conduct | A short summary, pointing to the SORTEE Code of Conduct |
| Contributions | Who can contribute, co-authorship requirements, and Dragon Kill Points (60 DKP for authorship) |
| Before you start | Ground rules for assessing |
| How the form flows | Which answers route to which sections |
| General FAQ | Timing, corrections, access problems, conflicts of interest, where to ask for help |
| Sections 1–6 | Help and FAQs for every form question |

## Data and code

The article lists behind the hackathon, and the R code that produced them, are in
`Data/` and `R/`. The article lists cover research articles published between
1 January and 30 September 2026 in the 89 society journals in the sample, pulled
from [OpenAlex](https://openalex.org) in October 2026.

```
Data/
├── Raw/                      journal policies, the OpenAlex pull and the randomised article list
└── article_sets/             the 40 article sets handed out to participants (1.csv to 40.csv)
R/
├── 01_journal_policy.R       summarises the journals' data and code policies
├── 02_open_alex_pull.R       pulls the articles from OpenAlex
├── 03_randomise_articles.R   shuffles the articles within each journal and gives them IDs
└── 04_article_assignment.R   draws the sample and splits it into article sets
```

**`Data/Raw/`**

| File | Rows | What it contains |
|---|---|---|
| `Concensus_policy.csv` | 89 journals | Each journal's data and code policy and whether it has a data editor, as agreed by the Advocacy Committee before the hackathon. |
| `publishers.csv` | 89 journals | Each journal's publisher, as recorded in OpenAlex. |
| `possible_comments.csv` | 76 items | Items whose titles look like comments, replies, introductions or obituaries. All but one were removed from the sampling frame. |
| `total_papers_oct_rerun.csv` | 10,721 articles | Every research article published in the sample journals over the period, after removing comments, replies and duplicate DOIs: the sampling frame. |
| `total_journals_oct_rerun.csv` | 89 journals | The number of articles each journal published per month, January to September 2026, with a total (matches `total_papers_oct_rerun.csv`). |
| `randomised_articles.csv` | 10,721 articles | `total_papers_oct_rerun.csv` with the articles shuffled into a random order within each journal, and given journal and article IDs. |

**`Data/article_sets/`**

Forty files, numbered 1 to 40, one per article set. Each participant is given a
set number, shown next to their name in the Expression of Interest sheet.

- **1,439 articles** from all 89 journals are assessed. Sets 1–39 hold 45 articles
  each and set 40 holds 35, so 1,790 articles are handed out in total.
- **351 articles (about 25%) appear in two sets**, so they are assessed twice to
  measure repeatability. No article appears in more than two sets.
- Within each set, the articles are in random order, and each set covers 44 or 45
  different journals (set 40: 35).

**Columns**

| Column | File(s) | Description |
|---|---|---|
| `row_id` | `possible_comments.csv`, `total_papers_oct_rerun.csv`, `randomised_articles.csv` | A unique ID for each article, assigned before comments were removed, so the numbers have gaps. It stays the same in every file, so articles can be matched across them. |
| `title` | all article lists | Article title |
| `doi` | all article lists | Article DOI, as a full `https://doi.org/` link |
| `journal` | all article lists | Journal name, as in OpenAlex |
| `publication_date` | all except the article sets | Publication date (`YYYY-MM-DD`) |
| `journal_id` | `randomised_articles.csv` | Journal number, 1–89. The ten journals with a data editor are 1–10. |
| `article_in_journal` | `randomised_articles.csv` | The article's position in its journal's random order |
| `article_id` | `randomised_articles.csv`, article sets | `journal_id` and `article_in_journal` joined by `_` (e.g. `12_7`). Unique. This is the ID participants enter in question 1.2 of the form. |

`Concensus_policy.csv` has one row per journal: `Journal`; `Data` and `Code`,
the journal's data and code policy (`Mandated`, `Encouraged`, `Neutral` or
`No Policy`), each with a `_Reason` column for notes; and `Data_editor`
(`Yes`/`No`), with notes in `DE_Reason`. `total_journals_oct_rerun.csv` has
`journal`, a column per month (`Jan`–`Sep`) and `total`. `publishers.csv` has
`display_name`, `issn_l`, `host_organization_name` (the publisher) and
`host_organization` (its OpenAlex ID).

**How the articles were pulled (`02_open_alex_pull.R`).** The script uses the
[openalexR](https://cran.r-project.org/package=openalexR) package and needs a
free OpenAlex API key. It:

1. matches each journal title to an OpenAlex source, automatically and then by
   hand for five journals where OpenAlex's first match was wrong, and saves each
   journal's publisher to `publishers.csv`;
2. downloads every work from those journals with `type = "article"`, published
   in 2026 up to 30 September, indexed in Crossref, not retracted, with at least
   one author and an assigned topic (filters intended to exclude editorials and
   other front matter);
3. gives every article a `row_id`, then flags titles that look like comments,
   replies, responses, introductions to special issues or obituaries, and saves
   them to `possible_comments.csv`. These were checked by hand: all are removed
   except one research article caught by the pattern ("Response to individual
   variation in protest calls by Brazilian free-tailed bats");
4. removes duplicate DOIs and saves the result as `total_papers_oct_rerun.csv`;
5. counts articles per journal per month and saves `total_journals_oct_rerun.csv`.

The script queries 90 journals; Primate Conservation published nothing in the
period, which leaves 89.

**How the articles were randomised (`03_randomise_articles.R`).** With
`set.seed(20261009)`, the articles in each journal are shuffled into a random
order and numbered. Journals are numbered so that the ten with a data editor
come first (1–10), and each article gets an `article_id` from its journal number and
its place in the order. The output is `randomised_articles.csv`.

**How the sample was drawn and split (`04_article_assignment.R`).** With
`set.seed(20261010)`, the script takes the first 15 articles in each journal's
random order, and the first 30 for the ten journals with a data editor: The
American Naturalist, Behavioral Ecology, Ecological Applications, Ecological
Monographs, Ecology, Ecology Letters, Ecosphere, Frontiers in Ecology and the
Environment, Journal of Evolutionary Biology, and Proceedings of the Royal
Society B. Journals with fewer articles contribute all they have: Ecological
Monographs 22, and seven other journals 6–14 each. Cycling through the journals
in turn, the articles are cut into 40 overlapping blocks of 45, each overlapping
the next by 9, then shuffled within each set and written to
`Data/article_sets/`.

**Journal policies (`01_journal_policy.R`).** Tabulates the data and code
policies in `Concensus_policy.csv`, by policy type and by whether the journal
has a data editor.

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
  `assets/css/sortee-faq.css`, `assets/js/faq.js` and the R scripts in `R/`,
  under the [MIT License](LICENSE).
- **Content**, meaning the guide text in `FAQ.md`, this README and the files in
  `Data/`, under [CC BY 4.0](LICENSE-data.md). The article metadata comes from
  OpenAlex, which releases its data under CC0.

The SORTEE logo mark in `assets/img/` belongs to SORTEE and is not covered by
either licence. The styling is inspired by the SORTEE website but not copied
from it.

## AI declaration

Claude (Anthropic) was used to draft the FAQ from the assessment form, to
summarise the Dragon Kill Points framework, and to write the page template,
CSS and JavaScript. All content was subsequently checked by the author.
