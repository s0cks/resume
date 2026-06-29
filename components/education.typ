#import "../util.typ": dates, metadata, section

#let education(
  degree: none,
  institution: none,
  location: none,
  start-date: none,
  end-date: none,
  body,
) = context {
  block(
    above: 1em,
    below: 1em,
    breakable: false,
  )[
    #stack(
      spacing: 0.5em,
      grid(
        columns: (1fr, auto),
        heading(level: 3, institution), dates(start-date: start-date, end-date: end-date),
      ),
      metadata(size: text.size - 1.5pt, degree),
    )
    #body
  ]
}

// ╭───────────╮
// │ Education │
// ╰───────────╯
#let education-list(
  role: none,
  title: "Education",
  body,
) = section(
  title: title,
)[
  #if type(body) == content {
    body
  } else [
    #for (k, child) in body {
      let desc = child.at("description", default: none)
      education(
        degree: k,
        institution: child.at("institution", default: none),
        location: child.at("location", default: none),
        start-date: child.at("start", default: none),
        end-date: child.at("end", default: none),
        if desc != none { desc } else [],
      )
    }
  ]
]
