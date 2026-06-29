#import "./style.typ": *

#let role-full-stack-eng = "Full Stack Engineer"
#let role-systems-eng = "Systems Engineer"
#let role-platform-eng = "Platform Engineer"

#let default-role = role-full-stack-eng

/* vale off */
#let is-role(role) = sys.inputs.at("role", default: default-role) == role
#let is-full-stack-eng() = is-role(role-full-stack-eng)
#let is-systems-eng() = is-role(role-systems-eng)
#let is-platform-eng() = is-role(role-platform-eng)
/* vale on */

#let section-insets = (x: 0.5em)

#let role-weights = (
  "Full Stack Engineer": (
    "Full Stack Engineer": 1.0,
    "Systems Engineer": 0.4,
    "Platform Engineer": 0.6,
  ),
  "Systems Engineer": (
    "Full Stack Engineer": 0.2,
    "Systems Engineer": 1.0,
    "Platform Engineer": 0.5,
  ),
  "Platform Engineer": (
    "Full Stack Engineer": 0.3,
    "Systems Engineer": 0.5,
    "Platform Engineer": 1.0,
  ),
)

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
  breakable: true,
  body,
) = context {
  block(breakable: breakable)[
    #if type(title) == content {
      title
    } else {
      heading(level: 2, title)
    }
    #block(
      inset: section-insets,
      body,
    )
  ]
}

#let skill(
  body,
) = text(
  weight: "bold",
  body,
)

#let location(city: none, state: none) = text[
  #if city != none [#city, ]
  #state
]

#let email-address(value) = {
  set text(
    font: "Alegreya Sans",
  )

  if type(value) != content {
    link("mailto:" + value)[#value]
  } else {
    value
  }
}

#let address(
  state: none,
  city: none,
) = {
  text[
    #if city != none {
      city
      if state != none [,]
    }
    #if state != none {
      state
    }
  ]
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
    font: heading-font,
  )

  if type(value) != content {
    text(value)
  } else {
    value
  }
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

#let resume-heading(
  spacing: 0.5em,
  stroke: black,
  name,
) = stack(
  spacing: 0.5em,
  heading(level: 1, name),
  line(length: 100%, stroke: stroke),
)

#let group-by(key, items) = {
  let groups = (:)
  for item in items {
    let value = str(item.at(key))
    if value in groups {
      groups.at(value).push(item)
    } else {
      groups.insert(value, (item,))
    }
  }
  groups
}

#let score-project(role, project) = {
  let w = role-weights.at(role, default: (:))
  let s = project.at("scores", default: (:))
  (
    w.at("Full Stack Engineer", default: 0) * s.at("Full Stack Engineer", default: 0)
      + w.at("Systems Engineer", default: 0) * s.at("Systems Engineer", default: 0)
      + w.at("Platform Engineer", default: 0) * s.at("Platform Engineer", default: 0)
  )
}

#let rank-projects(role, projects) = {
  let items = ()
  for p in projects {
    let score = score-project(role, p)
    items.push((project: p, score: score))
  }
  items.sorted(key: p => -p.score)
}

#let adjusted-score(base, count) = {
  base + (3 - base) * (1 - calc.exp(-count / 5))
}

#let sanitize-url(url) = url.replace("https", "").replace("http", "").replace("www.", "")
