#import "colors.typ": *

#let accent-color = pu
#let accent-color2 = pu2

#let default-font = "Inter"
#let default-font-size = 10pt

#let get-heading-fill(level) = {
  if level <= 2 {
    accent-color
  } else if level <= 4 {
    accent-color2
  } else {
    tx
  }
}

#let heading-font = "Alegreya Sans"
#let heading-font-sizes = (
  "1": 22pt,
  "2": 13pt,
  "3": 11pt,
)

#let accent-line-thickness = (
  "1": 1.2pt,
)
#let accent-line-color = (
  "1": accent-color,
)
#let accent-line(
  level: 1,
  length: 100%,
) = {
  line(
    length: length,
    stroke: (
      thickness: accent-line-thickness.at(str(level), default: 1pt),
      paint: accent-line-color.at(str(level), default: accent-color2),
      cap: "round",
    ),
  )
}

#let resume-style(
  body,
) = {
  set page(
    paper: "us-letter",
    margin: (x: 0.75in, y: 0.75in),
    numbering: "1",
    fill: paper,
  )
  set text(
    font: default-font,
    size: default-font-size,
    spacing: 110%,
    fill: tx,
    fallback: false,
  )
  set par(
    justify: false,
    leading: 0.70em,
  )

  show heading: it => {
    show heading: smallcaps
    set text(
      font: heading-font,
      fill: get-heading-fill(it.level),
      size: heading-font-sizes.at(str(it.level), default: 10pt),
    )

    if it.level <= 1 {
      stack(
        spacing: 0.25em,
        it,
        accent-line(level: it.level),
      )
    } else if (it.level == 2) {
      it
    } else if it.level >= 3 {
      text(strong(it.body))
    } else {
      it
    }
  }

  show link: it => {
    set text(
      font: default-font,
      fill: cy,
      style: "italic",
      weight: 400,
    )

    it
  }

  body
}
