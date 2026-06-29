#import "../util.typ": *

#let project-title(
  url: none,
  start-date: none,
  end-date: none,
  separator: [ -- ],
  skills: none,
  name,
) = context {
  set text(
    font: heading-font,
  )

  show list: it => {
    set list(marker: none)
    it
      .children
      .map(child => {
        child.body
      })
      .join(sym.space + separator + sym.space)
  }

  let data = ()
  if name != none {
    data += (
      heading(level: 3, name),
    )
  }
  if url != none {
    data += (
      link(url),
    )
  }
  if skills != none {
    data += (
      metadata(
        fill: tx2,
        skills.join(", "),
      ),
    )
  }

  grid(
    columns: (1fr, auto),
    list(..data),
    dates(
      start-date: start-date,
      end-date: end-date,
    ),
  )
}

#let project(
  url: none,
  name: none,
  start-date: none,
  end-date: none,
  above: 1em,
  below: 1em,
  spacing: 1em,
  skills: none,
  scores: none,
  description,
) = block(
  above: above,
  below: below,
  breakable: false,
  stack(
    spacing: spacing,
    project-title(
      url: url,
      start-date: start-date,
      end-date: end-date,
      skills: skills,
      name,
    ),
    description,
  ),
)

#let default-projects-section-title = "Projects"

#let projects-section(
  title: default-projects-section-title,
  body,
) = section(
  title: title,
  body,
)

#let projects-list(
  role: none,
  title: default-projects-section-title,
  default-score: 1,
  max-items: 5,
  projects,
) = {
  let ranked = rank-projects(role, projects)
  let get-project-description(name) = include "/src/projects/" + lower(name) + ".typ"
  projects-section(
    title: title,
  )[
    #for p in ranked.slice(0, calc.min(ranked.len(), max-items)) {
      project(..p.project, get-project-description(p.project.name))
    }
  ]
}
