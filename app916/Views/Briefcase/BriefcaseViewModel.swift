import Foundation
import Combine

final class BriefcaseViewModel: ObservableObject {
    
    let dataController: DataController
    
    @Published var alertText: String = ""
    
    @Published var totalBalance: String
    @Published var profit: String
    @Published var loss: String
    @Published var metals: Array<Metal> = []
    @Published var gold: Metal
    
    var imageData: Data? {
        dataController.imageData
    }
    
    var name: String {
        dataController.name
    }
    
    private var metalsCancellable: AnyCancellable?
    private var nameCancellable: AnyCancellable?
    private var imageDataCancellable: AnyCancellable?
    private var goldCancellable: AnyCancellable?
    
    init(dataController: DataController) {
        self.dataController = dataController
        gold = dataController.gold
        totalBalance = dataController.totalBalance
        profit = dataController.profit
        loss = dataController.loss
        
        goldCancellable = dataController.$gold.sink { [weak self] value in
            self?.gold = value
        }
        metalsCancellable = dataController.$metals.sink { [weak self] value in
            self?.metals = value
        }
        nameCancellable = dataController.$name.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        imageDataCancellable = dataController.$imageData.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func profitSave() {
        profit = alertText
        dataController.saveProfit(profit)
        alertText = ""
    }
    
    func declineSave() {
        loss = alertText
        dataController.saveLoss(loss)
        alertText = ""
    }
    
    func balanceSave() {
        totalBalance = alertText
        dataController.saveTotalBalance(totalBalance)
        alertText = ""
    }
}
