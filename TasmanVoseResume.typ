#import "@preview/abbr:0.3.1"
#import "src/style.typ": accent-color, default-font, default-font-size
#import "src/colors.typ": paper, tx, tx2
#import "src/util.typ": *

#abbr.load("src/abbrs.csv")
#show: abbr.show-rule

#import "src/summary.typ": summary
#import "src/skills.typ": skills-matrix
#import "src/education.typ": education-list
#import "src/awards.typ": award-list
#import "src/certifications.typ": cert-list
#import "src/work/work.typ": work-list
#import "src/projects/projects.typ": projects-list
#import "src/contact.typ": contact-info

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

#contact-info(..yaml("src/contact.yaml"))

#summary(
  include "src/summaries/" + target-role + ".typ",
)

#skills-matrix(
  role: target-role,
  yaml("src/skills.yaml"),
)

#let projects = yaml("src/projects/projects.yaml")
#let max-num-projects = 4
#let max-num-certifications = 5
#if is-full-stack-eng() {
  work-list(
    role: target-role,
  )[
    #include "src/work/keyhole-software.typ"
    #include "src/work/charter-communications.typ"
    #include "src/work/great-west-financial.typ"
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
    #include "src/work/keyhole-software.typ"
    #include "src/work/charter-communications.typ"
    #include "src/work/great-west-financial.typ"
  ]
}

#cert-list(
  role: target-role,
  max-items: max-num-certifications,
  yaml("src/certifications.yaml"),
)

#award-list(
  role: target-role,
  yaml("src/awards.yaml"),
)

#education-list(
  role: target-role,
  yaml("src/education.yaml"),
)

#section(
  title: "Open Source & Community Contributions",
)[
  - Assisted CoderDojo in teaching #skill[Javascript] to kids.
  - Contributed technical articles to the Keyhole Software blog.
]
