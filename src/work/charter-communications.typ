#import "./work.typ": work
#import "../util.typ": skill
#metadata("Logstash") <skills>
#metadata("Kibana") <skills>
#metadata("Data Engineering") <skills>
#metadata("Java") <skills>
#metadata("EKS") <skills>
#metadata("Kubernetes") <skills>
#metadata("Helm") <skills>
#metadata("Vue") <skills>
#metadata("ETL") <skills>
#metadata("Jaeger") <skills>
#metadata("Gitflow") <skills>
#metadata("SAFe") <skills>
#metadata("Agile") <skills>
#metadata("Kafka")<skills>
#work(
  location: "Denver, CO",
  company: "Charter Communications",
  start-date: datetime(
    day: 10,
    month: 2,
    year: 2021,
  ),
  end-date: datetime(
    day: 10,
    month: 2,
    year: 2022,
  ),
  "Software Engineer II",
)[
  - Collaborated with DevOps, Developers and @QA:a to refine deployment manifests improving release workflow,
    integrate #skill[Jaeger] into their #skill[Spring Boot] service to improve observability,
    and optimize #skill[Elasticsearch] cluster topology for improved query performance and cost-effectiveness.
  - Architected reusable high-throughput @ETL pipelines utilizing #skill[Logstash], #skill[Kafka] and #skill[Java]
    reducing re-indexing windows from days to hours.
]
