import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Emodi",
    organizationName: "diana",
    packages: [
        .firebase
    ],
    targets: [
        .target(
            name: "Emodi",
            destinations: .iOS,
            product: .app,
            bundleId: "\(Environment.appIdentifier).emodi",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIImageName": "LaunchImage"
                    ],
                    "CFBundleDisplayName": "Emodi",
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .firebaseCore,
                .project(target: "Coordinator", path: "../Coordinator")
            ]
        ),
        .target(
            name: "EmodiTest",
            destinations: Environment.destinations,
            product: .unitTests,
            bundleId: "\(Environment.appIdentifier).emodiTest",
            infoPlist: .default,
            sources: [],
            resources: [],
            dependencies: [.target(name: "Emodi")]
        ),
    ]
)
