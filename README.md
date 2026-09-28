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

## Contents

| File | What it is |
|---|---|
| `FAQ.md` | The guide itself. Renders as the site's home page, and is also readable directly on GitHub |
| `_config.yml` | GitHub Pages (Jekyll) settings |
| `_layouts/default.html` | Page template: top bar, content area, footer |
| `assets/css/sortee-faq.css` | Styling, loosely based on the SORTEE website (Roboto, SORTEE green) |

The guide covers:

| Section | What it covers |
|---|---|
| Introduction | What the hackathon is and how papers are allocated |
| Before you start | Ground rules for assessing |
| How the form flows | Which answers route to which sections |
| Sections 1–6 | Help and FAQs for every form question |
| General FAQ | Timing, corrections, where to ask for help |
| Contributions | Dragon Kill Points: 30 papers extracted earns authorship |

## Organisers

The hackathon is run by the **SORTEE Advocacy Committee**:

| Name | Role | Affiliation |
|---|---|---|
| Ed Ivimey-Cook | Co-chair | University of East Anglia, UK |
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

- **Code**, meaning `_config.yml`, `_layouts/default.html` and
  `assets/css/sortee-faq.css`, under the [MIT License](LICENSE).
- **Content**, meaning the guide text in `FAQ.md` and this README, under
  [CC BY 4.0](LICENSE-data.md).

The styling is inspired by the SORTEE website but is not affiliated with or
copied from it; the name SORTEE belongs to the society.

## AI declaration

Claude (Anthropic) was used to draft the FAQ from the assessment form, to
summarise the Dragon Kill Points framework, and to write the page template and
CSS. All content was subsequently checked by the author.
