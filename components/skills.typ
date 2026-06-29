#import "../util.typ": *

#let skills-block(
  category: none,
  above: 0.5em,
  below: 0.5em,
  body,
) = context {
  show list: it => {
    set list(marker: none)

    set text(
      font: default-font,
      fill: tx,
      style: "italic",
    )

    it
      .children
      .map(child => {
        child.body
      })
      .join(sym.comma + sym.space)
  }

  block(
    above: above,
    below: below,
  )[
    #if category != none {
      heading(level: 3, smallcaps(category + sym.colon))
    }
    #body
  ]
}

#let default-max-items = 5

#let skills-list(
  category: none,
  above: 0.5em,
  below: 0.5em,
  max-items: default-max-items,
  items,
) = skills-block(
  category: category,
  above: above,
  below: below,
  list(..items),
)

#let role-scorer(
  default-score: 0,
  role,
) = skill => skill.scores.at(role, default: default-score)

#let rank(
  max-items: none,
  scorer,
  items,
) = {
  let scored = items
    .map(s => {
      (
        score: scorer(s),
        skill: s,
      )
    })
    .sorted(key: it => it.score)
    .rev()
  if max-items != none and type(max-items) == int {
    scored = scored.slice(0, calc.min(scored.len(), max-items))
  }
  scored.map(s => s.skill)
}

#let skills-matrix(
  title: "Skills",
  role: none,
  default-score: 0,
  max-items: 15,
  skills,
) = {
  let scorer = role-scorer(
    default-score: default-score,
    role,
  )
  let ranked = rank(
    max-items: max-items,
    scorer,
    skills,
  )

  let groups = (:)
  for item in ranked {
    let value = str(item.at("category", default: "Misc"))
    if value in groups {
      groups.at(value).push(item)
    } else {
      groups.insert(value, (item,))
    }
  }

  section(
    title: title,
  )[
    #for category in groups.keys().sorted() {
      skills-list(
        category: category,
        max-items: max-items,
        groups.at(category, default: ()).map(it => it.name),
      )
    }
  ]
}
