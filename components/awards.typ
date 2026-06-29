#import "../util.typ": *

#let award(
  date: none,
  institution: none,
  description: none,
  event: none,
  name,
) = context {
  let source = if event != none {
    event
    if institution != none [
      (#institution)
    ]
  } else {
    if institution != none {
      institution
    }
  }

  block(
    above: 0.5em,
    below: 0.5em,
    breakable: false,
  )[
    #stack(
      spacing: 0.5em,
      grid(
        columns: (1fr, auto),
        heading(level: 3, name), if date != none { dates(start-date: date) } else [ ],
      ),
      if source != none {
        metadata(
          size: text.size - 1.5pt,
          style: "italic",
          source,
        )
      },
    )
    #if description != none {
      description
    }
  ]
}

#let award-list(
  title: "Awards",
  role: none,
  awards,
) = section(
  title: title,
)[
  #for (k, child) in awards {
    award(
      date: child.at("date", default: none),
      event: child.at("event", default: none),
      institution: child.at("institution", default: none),
      description: child.at("description", default: none),
      k,
    )
  }
]
