#import "@preview/abbr:0.3.1"
#import "../../components/work.typ": work
#import "../../util.typ": skill

#metadata("MySQL")<skills>
#metadata("Stored Procedures")<skills>
#metadata("AngularJS") <skills>
#metadata("Angular") <skills>
#metadata("Spring Boot") <skills>
#metadata("Progressive Web Apps") <skill>
#metadata("Android") <skill>
#metadata("Honeywell") <skill>
#work(
  location: "Denver, CO",
  company: "Keyhole Software",
  start-date: datetime(
    day: 10,
    month: 2,
    year: 2022,
  ),
  end-date: datetime(
    day: 31,
    month: 7,
    year: 2025,
  ),
  "Full Stack Engineer",
)[
  - Led modernization of legacy applications into mobile first architectures powered by Honeywell (#skill[Android]) devices running #skill[Angular] @SPA:pla with #skill[Ionic] and #skill[Spring Boot] Microservices,
    orchestrated by #skill[Kubernetes] serving Mainframe data, delivering 3 sprints ahead of schedule.
  - Guided development on a legacy systems powered by #skill[AngularJS], #skill[Spring Boot] and #skill[MySQL]
    improving maintainability and feature velocity by crafting actionable stories, championing @TDD:a, and mentoring team members.
]
