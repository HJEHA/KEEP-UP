import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
  .feature(
    factory: .init(
      dependencies: [
        .domain,
        .feature(implements: .Onboarding),
        .feature(implements: .Measurement),
        .feature(implements: .Record),
        .feature(implements: .Home)
      ]
    )
  )
]

let project: Project = .makeModule(
  name: "Feature",
  targets: targets,
  configurations: [.debug, .release]
)

