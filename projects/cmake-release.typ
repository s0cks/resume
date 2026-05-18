#import "../util.typ": github-repo-link, project

#project(
  start-date: datetime(
    year: 2022,
    month: 1,
    day: 1,
  ),
  url: github-repo-link("s0cks", "cmake-release"),
  role: "Developer",
  name: "cmake-release",
  languages: (
    "JavaScript",
  ),
)[
  A *semantic-release* plugin written in *Typescript* for managing and enforcing strict semantic versioning consistency in *CMake* projects.
]
