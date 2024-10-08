import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    
    let dataController: DataController
    
    @Published var name: String
    @Published var imageData: Data?
    
    private var nameCancellable: AnyCancellable?
    private var imageDataCancellable: AnyCancellable?
    
    init(dataController: DataController) {
        self.dataController = dataController
        name = dataController.name
        self.imageData = dataController.imageData
        
        nameCancellable = dataController.$name.sink { [weak self] value in
            self?.name = value
        }
        imageDataCancellable = dataController.$imageData.sink { [weak self] value in
            self?.imageData = value
        }
    }
}
