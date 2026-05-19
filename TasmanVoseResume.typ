#import "./util.typ": (
  award-list, cert-list, contact-info, education, education-list, email, github-user-link, linkedin-user-link, location,
  project, project-list, section, skills-matrix, summary, work-list,
)
#import "./style.typ": *

#set document(
  title: "Tasman Vose",
  author: "Tasman Vose",
  keywords: (
    "Resume",
  ),
)

#set page(
  paper: "us-letter",
  margin: (x: 0.75in, y: 0.75in),
  numbering: "1",
  fill: paper,
)
#set text(
  font: default-font,
  size: 10pt,
  spacing: 120%,
  fill: tx,
  fallback: false,
)
#set par(
  justify: true,
  leading: 0.65em,
)

#show heading: it => {
  show heading: smallcaps
  set text(
    font: heading-font,
    fill: get-heading-fill(it.level),
    size: get-heading-font-size(it.level),
  )

  if it.level <= 2 {
    stack(
      spacing: 0.25em,
      it,
      accent-line(),
    )
  } else {
    it
  }
}

#let contact = json("contact.json")

#show link: it => {
  set text(
    fill: pu2,
    weight: 400,
  )
  it
}

= Tasman Vose

#contact-info(
  phone: contact.phone,
  email: contact.email,
  location: location(
    state: "NY",
    city: "Albany",
  ),
  links: (
    linkedin-user-link("tazzvose"),
    github-user-link("s0cks"),
  ),
)

#summary(title: [== Summary])[
  Platform and systems engineer with experience building cloud-native infrastructure, robust data pipelines,
  observability platforms, and low-level systems programming. \
  Background in cloud migrations, Kubernetes operations and distributed systems engineering
  with a focus on scalability and reliability.
]

#skills-matrix(
  title: [== Skills],
  yaml("skills.yml"),
)

#project-list(
  title: [== Projects],
)[
  #include "projects/home-lab.typ"
  #include "projects/token.typ"
  #include "projects/gel.typ"
  #include "projects/prette.typ"
  #include "projects/generator-cc.typ"
  #include "projects/resume.typ"
]

#work-list(
  title: [== Experience],
)[
  #include "work/keyhole-software.typ"
  #include "work/charter-communications.typ"
  #include "work/great-west-financial.typ"
]

#cert-list(
  title: [== Certifications],
  yaml("certifications.yml"),
)

#award-list(
  title: [== Awards],
  yaml("awards.yml"),
)

#education-list(
  title: [== Education],
  yaml("./education.yml"),
)

#section(
  title: "Open Source & Community Contributions",
  inset: (x: 0.5em),
)[
  - Assisted CoderDojo in teaching Javascript to kids.
  - Contributed technical articles to the Keyhole Software blog.
]

