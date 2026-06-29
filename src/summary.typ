#import "./util.typ": *

#let default-summary-title = "Summary"

#let summary(
  title: default-summary-title,
  body,
) = section(
  title: title,
  body,
)

#let summary-card(
  title: default-summary-title,
  role: none,
  summaries,
) = summary(
  title: title,
  if role != none {
    summaries.at(role, default: [])
  } else {
    []
  },
)
