import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Feature.name+ModulePath.Feature.MyPage.rawValue,
  targets: [
    .feature(
      interface: .MyPage,
      factory: .init(
        dependencies: [
          .domain
        ]
      )
    ),
    .feature(
      implements: .MyPage,
      factory: .init(
        dependencies: [
          .feature(interface: .MyPage)
        ]
      )
    ),
    .feature(
      testing: .MyPage,
      factory: .init(
        dependencies: [
          .feature(interface: .MyPage)
        ]
      )
    ),
    .feature(
      tests: .MyPage,
      factory: .init(
        dependencies: [
          .feature(testing: .MyPage)
        ]
      )
    ),
    .feature(
      example: .MyPage,
      factory: .init(
        infoPlist: .extendingDefault(
          with: [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UILaunchStoryboardName": "LaunchScreen",
            "UIApplicationSceneManifest": [
              "UIApplicationSupportsMultipleScenes": false,
              "UISceneConfigurations": []
            ]
          ]
        ),
        dependencies: [
          .feature(interface: .MyPage)
        ],
        configurations: [.debug, .release]
      )
    )
  ],
  configurations: [.debug, .release]
)