#import "./style.typ": *

#let metadata(
  fill: tx2,
  size: none,
  weight: 400,
  style: "normal",
  value,
) = context {
  text(
    fill: fill,
    style: style,
    weight: weight,
    size: if size != none { size } else { text.size },
    value,
  )
}

#let section(
  title: none,
  inset: (x: 0.5em),
  body,
) = context {
  block[
    #if type(title) == content {
      title
    } else {
      let last-header = query(selector(heading).before(here())).last()
      let last-header-level = last-header.level
      heading(level: last-header-level, title)
    }
    #block(
      inset: inset,
      body,
    )
  ]
}

#let location(city: none, state: none) = text[
  #if city != none [#city, ]
  #state
]

#let email(value) = {
  set text(
    font: "Alegreya Sans",
  )
  link("mailto:" + value)[#value]
}

#let github-link(
  base-url: "github.com",
  protocol: "https",
  path: none,
) = {
  set text(
    font: "Alegreya Sans",
    weight: 300,
  )
  let full-url = base-url
  if path != none {
    full-url += "/" + path
  }
  link(repr(full-url), full-url)
}

#let github-user-link(
  base-url: "github.com",
  protocol: "https",
  user,
) = {
  github-link(base-url: base-url, protocol: protocol, path: user)
}

#let github-repo-link(
  base-url: "github.com",
  protocol: "https",
  owner,
  repo,
) = {
  github-link(base-url: base-url, protocol: protocol, path: owner + "/" + repo)
}

#let linkedin-link(
  base-url: "linkedin.com",
  protocol: "https",
  path: none,
) = {
  set text(
    font: "Alegreya Sans",
    weight: 300,
  )
  let full-url = base-url
  if path != none {
    full-url += "/" + path
  }
  link(repr(full-url), full-url)
}

#let linkedin-user-link(
  base-url: "linkedin.com",
  protocol: "https",
  user,
) = {
  linkedin-link(base-url: base-url, protocol: protocol, path: ("in/" + user))
}

#let phone-number(value) = {
  set text(
    font: "Alegreya Sans",
  )
  text(value)
}

#let dates(
  end-date: none,
  start-date: none,
  use-present: false,
) = context {
  let separator = [---]

  let start = start-date
  let end = if end-date != none {
    end-date
  } else if use-present [
    Present
  ] else {
    none
  }

  let date-format = "[year]"
  let format-date(d) = if type(d) == dictionary {
    assert("year" in d)
    format-date(datetime(
      year: d.at("year"),
      month: d.at("month", default: 1),
      day: d.at("day", default: 1),
    ))
  } else if type(d) == datetime {
    d.display(date-format)
  } else {
    d
  }

  metadata(
    size: text.size + 1.5pt,
  )[
    #set text(
      font: heading-font,
    )
    #format-date(start)
    #if end != none [
      #separator
      #format-date(end)
    ]
  ]
}

// ╭─────────╮
// │ Summary │
// ╰─────────╯
#let summary(
  title: "Summary",
  inset: (x: 0.75em),
  body,
) = section(
  title: title,
  inset: inset,
  body,
)

// ╭────────╮
// │ Skills │
// ╰────────╯
#let skills-block(
  category: none,
  category-weight: 600,
  category-level: 3,
  above: 0.5em,
  below: 0.5em,
  body,
) = context {
  show list: it => {
    set list(marker: none)

    set text(
      font: default-font,
      style: "italic",
      size: text.size - 1.5pt,
      weight: category-weight - 200,
    )

    for item in it.children {
      item.body
      sym.comma
      sym.space
    }
  }

  block(
    above: above,
    below: below,
  )[
    #if category != none {
      text(
        font: heading-font,
        weight: category-weight,
        size: get-heading-font-size(category-level),
        fill: get-heading-fill(category-level),
        smallcaps(category + sym.colon),
      )
    }
    #body
  ]
}

#let skills-list(
  category: none,
  above: 0.5em,
  below: 0.5em,
  items,
) = context {
  skills-block(
    category: category,
    above: above,
    below: below,
    list(..items),
  )
}

#let skills-matrix(
  title: "Skills",
  inset: (x: 0.75em),
  skills,
) = section(
  title: title,
  inset: inset,
)[
  #for (k, child) in skills {
    skills-list(category: k, child)
  }
]

// ╭──────╮
// │ Work │
// ╰──────╯
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
  let title-size = get-heading-font-size(level)

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
  inset: (x: 0.75em),
  title: "Experience",
  body,
) = section(
  title: title,
  inset: inset,
  body,
)

// ╭──────────╮
// │ Projects │
// ╰──────────╯
#let project-title(
  role: none,
  url: none,
  start-date: none,
  end-date: none,
  separator: [ -- ],
  languages: none,
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

  let last-header = query(selector(heading).before(here())).last()
  let level = last-header.level + 1
  let size = get-heading-font-size(level)
  let data = ()
  if role != none {
    data += (
      {
        set text(
          fill: get-heading-fill(level),
          size: size,
        )
        strong(role)
      },
    )
  }
  data += (
    metadata(
      fill: tx2,
      name,
    ),
  )
  if url != none {
    data += (
      metadata(url),
    )
  }
  if languages != none {
    data += (
      metadata(
        fill: tx3,
        languages.join(", "),
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
  role: none,
  url: none,
  name: none,
  start-date: none,
  end-date: none,
  above: 1em,
  below: 1em,
  spacing: 1em,
  languages: none,
  body,
) = block(
  above: above,
  below: below,
  breakable: false,
  stack(
    spacing: spacing,
    project-title(
      role: role,
      url: url,
      start-date: start-date,
      end-date: end-date,
      languages: languages,
      name,
    ),
    body,
  ),
)

#let project-list(
  title: "Projects",
  inset: (x: 0.75em),
  body,
) = section(
  title: title,
  inset: inset,
  body,
)

// ╭───────────╮
// │ Education │
// ╰───────────╯
#let education(
  degree: none,
  institution: none,
  location: none,
  start-date: none,
  end-date: none,
  body,
) = context {
  let last-header = query(selector(heading).before(here())).last()
  let level = last-header.level + 1
  let title-size = get-heading-font-size(level)

  set text(
    font: heading-font,
  )

  block(
    above: 1em,
    below: 1em,
    breakable: false,
  )[
    #stack(
      spacing: 0.5em,
      grid(
        columns: (1fr, auto),
        text(
          fill: get-heading-fill(level),
          size: title-size,
          strong(institution),
        ),
        dates(start-date: start-date, end-date: end-date),
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
  inset: (x: 0.75em),
  title: "Education",
  body,
) = section(
  title: title,
  inset: inset,
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

// ╭────────────────╮
// │ Certifications │
// ╰────────────────╯
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
  inset: (x: 0.75em),
  spacing: 0.5em,
  certs,
) = section(
  title: title,
  inset: inset,
  stack(
    spacing: spacing,
    ..certs
      .keys()
      .sorted()
      .map(k => {
        let child = certs.at(k)
        cert(
          date: child.at("date", default: none),
          k,
        )
      }),
  ),
)

// ╭────────╮
// │ Awards │
// ╰────────╯
#let award(
  date: none,
  institution: none,
  description: none,
  event: none,
  name,
) = context {
  let last-header = query(selector(heading).before(here())).last()
  let level = last-header.level + 1
  let title-size = get-heading-font-size(level)

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
        text(
          size: title-size,
          fill: get-heading-fill(3),
          strong(name),
        ),
        if date != none { dates(start-date: date) } else [ ],
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
  inset: (x: 0.75em),
  title: "Awards",
  awards,
) = section(
  title: title,
  inset: inset,
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

// ╭─────────╮
// │ Contact │
// ╰─────────╯

#let contact-info(
  location: none,
  phone: none,
  email: none,
  links: none,
  above: 0.5em,
  below: 1em,
  inset: (x: 0.5em, bottom: 1em),
  spacing: 1em,
) = {
  show list: it => {
    set list(marker: none)
    it
      .children
      .map(child => {
        child.body
      })
      .join([ --- ])
  }
  let info = list(location, phone, email)
  set text(
    font: heading-font,
  )
  block(
    above: above,
    below: below,
    inset: inset,
    if links != none {
      stack(
        spacing: spacing,
        info,
        list(..links),
      )
    } else {
      info
    },
  )
}

#let resume-heading(
  spacing: 0.5em,
  stroke: black,
  name,
) = stack(
  spacing: 0.5em,
  heading(level: 1, name),
  line(length: 100%, stroke: stroke),
)
