#import "../util.typ": *

#let cert(
  date: none,
  name,
) = context {
  let last-header = query(selector(heading).before(here())).last()
  let level = last-header.level + 1
  block(
    grid(
      columns: (1fr, auto),
      text(
        font: heading-font,
        size: text.size + 1.5pt,
        fill: get-heading-fill(level),
        strong(name),
      ),
      if date != none { metadata(date) } else [],
    ),
  )
}


#let cert-list(
  title: "Certifications",
  role: none,
  spacing: 0.5em,
  max-items: 5,
  certs,
) = {
  let score(it) = it.weights.at(role, default: 0)
  section(
    title: title,
    stack(
      spacing: spacing,
      ..certs
        .filter(it => score(it) > 0)
        .sorted(key: it => score(it))
        .rev()
        .slice(0, max-items)
        .map(item => {
          cert(
            date: item.at("date", default: none),
            item.at("name", default: none),
          )
        }),
    ),
  )
}
