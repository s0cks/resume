#import "./util.typ": *

#let contact-info(
  name: none,
  location: none,
  phone: none,
  email: none,
  links: none,
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
  set text(
    font: heading-font,
  )

  let contact-info = ()
  if location != none {
    contact-info.push(
      if type(location) == content {
        location
      } else {
        address(..location)
      },
    )
  }

  if phone != none {
    contact-info.push(phone-number(phone))
  }

  if email != none {
    contact-info.push(email-address(email))
  }

  block(
    inset: section-insets,
    breakable: false,
    stack(
      spacing: 0.5em,
      list(..contact-info),
      if links != none {
        if type(links) == content {
          links
        } else {
          list(..links.map(it => link(it)))
        }
      },
    ),
  )
}
