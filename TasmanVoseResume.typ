#import "@preview/abbr:0.3.1"
#import "style.typ": accent-color, default-font, default-font-size
#import "colors.typ": paper, tx, tx2
#import "util.typ": *

#abbr.load("data/abbrs.csv")
#show: abbr.show-rule

#import "components/summary.typ": summary
#import "components/skills.typ": skills-matrix
#import "components/education.typ": education-list
#import "components/awards.typ": award-list
#import "components/certifications.typ": cert-list
#import "components/work.typ": work-list
#import "components/projects.typ": projects-list
#import "components/contact.typ": contact-info

#let target-role = get-target-role()
#set document(
  title: "Tasman Vose Resume",
  author: "Tasman Vose",
  keywords: (
    "Resume",
    target-role,
  ),
)

#show: resume-style

= Tasman Vose

#contact-info(..yaml("data/contact.yaml"))

#summary(
  include "data/summaries/" + target-role + ".typ",
)

#skills-matrix(
  role: target-role,
  yaml("data/skills.yaml"),
)

#let projects = yaml("data/projects.yaml")
#let max-num-projects = 4
#let max-num-certifications = 5
#if is-full-stack-eng() {
  work-list(
    role: target-role,
  )[
    #include "data/work/keyhole-software.typ"
    #include "data/work/charter-communications.typ"
    #include "data/work/great-west-financial.typ"
  ]

  projects-list(
    role: target-role,
    max-items: max-num-projects,
    projects,
  )
} else {
  projects-list(
    role: target-role,
    max-items: max-num-projects,
    projects,
  )

  work-list(
    role: target-role,
  )[
    #include "data/work/keyhole-software.typ"
    #include "data/work/charter-communications.typ"
    #include "data/work/great-west-financial.typ"
  ]
}

#cert-list(
  role: target-role,
  max-items: max-num-certifications,
  yaml("data/certifications.yaml"),
)

#award-list(
  role: target-role,
  yaml("data/awards.yaml"),
)

#education-list(
  role: target-role,
  yaml("data/education.yaml"),
)

#section(
  title: "Open Source & Community Contributions",
)[
  - Assisted CoderDojo in teaching #skill[Javascript] to kids.
  - Contributed technical articles to the Keyhole Software blog.
]
