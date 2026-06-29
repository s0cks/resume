#import "../util.typ": *

#let work-heading(
  company: none,
  location: none,
  start-date: none,
  end-date: none,
  title-level: 3,
  title,
) = context {
  set text(
    font: heading-font,
  )

  let last-header = query(selector(heading).before(here())).last()
  let level = last-header.level + 1
  let title-size = heading-font-sizes.at(str(title-level), default: default-font-size)

  stack(
    spacing: 0.5em,
    grid(
      columns: (1fr, auto),
      text(
        size: title-size,
        fill: get-heading-fill(3),
        strong(title),
      ),
      dates(
        start-date: start-date,
        end-date: end-date,
      ),
    ),
    grid(
      columns: (1fr, auto),
      metadata(
        size: text.size + 1pt,
        style: "italic",
        weight: 500,
        company,
      ),
      metadata(
        style: "italic",
        fill: tx3,
        location,
      ),
    ),
  )
}

#let work(
  location: none,
  company: none,
  start-date: none,
  end-date: none,
  title,
  body,
) = block(
  breakable: false,
  above: 1.5em,
  below: 1.5em,
)[
  #work-heading(
    company: company,
    location: location,
    start-date: start-date,
    end-date: end-date,
    title,
  )
  #body
]

#let work-list(
  role: none,
  title: "Experience",
  body,
) = section(
  title: title,
  body,
)
