import Foundation

final class ViewModelFactory {
    static let shared = ViewModelFactory()
    
    private init() {}
    
    let dataController: DataController = DataController()
    
    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(dataController: dataController)
    }
    func makeEditProfileViewModel() -> EditProfileViewModel {
        EditProfileViewModel(dataController: dataController)
    }
    
    func makeBriefcaseViewModel() -> BriefcaseViewModel {
        BriefcaseViewModel(dataController: dataController)
    }
    
    func makeProfitCalculatorViewModel() -> ProfitCalculatorViewModel {
        ProfitCalculatorViewModel(dataController: dataController)
    }
    
    func makeAddMetalViewModel() -> AddMetalViewModel {
        AddMetalViewModel(dataController: dataController)
    }
    
    func makeEditMetalViewModel(metalName: String) -> EditMetalViewModel {
        EditMetalViewModel(dataController: dataController, metalName: metalName)
    }
    
    func makeAnalyticsViewModel() -> AnalyticsViewModel {
        AnalyticsViewModel(dataController: dataController)
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(dataController: dataController)
    }
}
