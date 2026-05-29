#import "../../util.typ": github-repo-link, project

#project(
  start-date: "2024",
  role: "Developer",
  url: github-repo-link("s0cks", "gel"),
  name: "gel",
  languages: (
    "C++",
  ),
)[
  A purely functional programming language inspired by *Clojure*, with *LLVM* based just-in-time (*JIT*) compilation
  and parallel garbage collection (*GC*) based on Cheney's Algorithm and the Parallel Scavenge algorithm
  found in Dart and V8.
]
