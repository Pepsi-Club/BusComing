import ProjectDescription
import DependencyPlugin
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "App",
    moduleType: .app,
    entitlementsPath: .relativeToManifest("App.entitlements"),
    hasResource: true,
    appExtensionTarget: [
//        Project.appExtensionTarget(
//            name: "Widget",
//            plist: .extendingDefault(
//                with: .widgetInfoPlist
//            ),
//            resources: [
//                "Resources/Model.xcdatamodeld",
//                "Resources/total_stationList.json",
//                "Widget/Resources/**",
//            ],
//            entitlements: .file(
//                path: .relativeToRoot(
//                    "Projects/App/Widget.entitlements"
//                )
//            ),
//            dependencies: [
//                .mainFeature,
//                .data,
//            ]
//        )
    ],
    packages: [
        .remote(
            url: "https://github.com/firebase/firebase-ios-sdk",
            requirement: .upToNextMajor(from: "10.22.0")
        )
    ],
    dependencies: [
        .mainFeature,
        .data,
        .package(product: "FirebaseMessaging"),
    ]
)
