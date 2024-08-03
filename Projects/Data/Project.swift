import ProjectDescription
import DependencyPlugin
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "Data",
    moduleType: .dynamicFramework,
    packages: [
        .remote(
            url: "https://github.com/google/GoogleUtilities.git",
            requirement: .exact("7.13.1")
        ),
        .remote(
            url: "https://github.com/firebase/firebase-ios-sdk",
            requirement: .exact("10.23.1")
        ),
    ],
    dependencies: [
        .networkService,
        .coreDataService,
        .package(product: "FirebaseAnalytics"),
    ],
    coreDataModel: [
        .init(
            "../App/Resources/Model.xcdatamodeld",
            currentVersion: "Model_v2"
        )
    ]
)
