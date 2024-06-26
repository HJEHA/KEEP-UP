import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let workspace = Workspace(
  name: "WaistUp",
  projects: ["Projects/*"],
  generationOptions: .options(
    autogeneratedWorkspaceSchemes: .disabled
  )
)
