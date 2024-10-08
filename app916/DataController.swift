import Foundation

final class DataController: ObservableObject {
    
    let coreDataManager = CoreDataManager()
    
    @Published var imageData: Data?
    @Published var name: String = ""
    var totalBalance: String = ""
    var profit: String = ""
    var loss: String = ""
    
    var mCurrent = 0
    var mLast = 0
    var wCurrent = 0
    var wLast = 0
    var dCurrent = 0
    var dLast = 0
    
    @Published var metals: Array<Metal> = []
    @Published var gold: Metal = Metal(name: "Gold", profit: 0, decline: 0)
    
    var calculation: Calculation?
    
    func load() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            
            if let mCurrent = try? coreDataManager.fetchMCurrent() {
                self.mCurrent = mCurrent
            }
            if let mLast = try? coreDataManager.fetchMLast() {
                self.mLast = mLast
            }
            if let wCurrent = try? coreDataManager.fetchWCurrent() {
                self.wCurrent = wCurrent
            }
            if let wLast = try? coreDataManager.fetchWLast() {
                self.wLast = wLast
            }
            if let dCurrent = try? coreDataManager.fetchDCurrent() {
                self.dCurrent = dCurrent
            }
            if let dLast = try? coreDataManager.fetchDLast() {
                self.dLast = dLast
            }
            
            if let profile = try? coreDataManager.fetchProfile() {
                self.name = profile.1
                self.imageData = profile.0
            }
            if let decline = try? coreDataManager.fetchDecline() {
                self.loss = decline
            }
            if let profit = try? coreDataManager.fetchProfit() {
                self.profit = profit
            }
            if let totalBalance = try? coreDataManager.fetchTotalBalance() {
                self.totalBalance = totalBalance
            }
            if let metals = try? coreDataManager.fetchMetals() {
                self.metals = metals
            }
            if let gold = try? coreDataManager.fetchGold() {
                self.gold = gold
            }
            if let calculation = try? coreDataManager.fetchCalculation() {
                self.calculation = calculation
            }
        }
    }
    
    func savePofile(imageData: Data?, name: String) {
        self.imageData = imageData
        self.name = name
        coreDataManager.saveOrEditImage(imageData, name: name)
    }
    
    func saveTotalBalance(_ balance: String) {
        self.totalBalance = balance
        coreDataManager.saveOrEditTotalBalance(balance)
    }
    
    func saveProfit(_ profit: String) {
        self.profit = profit
        coreDataManager.saveOrEditProfit(profit)
    }
    
    func saveLoss(_ loss: String) {
        self.loss = loss
        coreDataManager.saveOrEditDecline(loss)
    }
    
    func save(metal: Metal) {
        metals.append(metal)
        coreDataManager.saveMetal(metal)
    }
    
    func editMetal(metalName: String, metal: Metal) {
        if metalName == "Gold" {
            gold = Metal(name: "Gold", profit: metal.profit, decline: metal.decline)
            coreDataManager.saveOrEditGold(gold)
        } else {
            guard let index = metals.firstIndex(where: {$0.name == metalName}) else { return }
            metals[index] = metal
            coreDataManager.editMetal(metal)
        }
    }
    
    func saveCalculation(_ calculation: Calculation) {
        self.calculation = calculation
        coreDataManager.saveOrEditCalculation(calculation)
    }
    
    func saveMcurrent(_ value: Int) {
        mCurrent = value
        coreDataManager.saveOrEditMCurrent(value)
    }
    func saveMlast(_ value: Int) {
        mLast = value
        coreDataManager.saveOrEditMLast(value)
    }
    func saveWcurrent(_ value: Int) {
        wCurrent = value
        coreDataManager.saveOrEditWCurrent(value)
    }
    func saveWlast(_ value: Int) {
        wLast = value
        coreDataManager.saveOrEditWLast(value)
    }
    func saveDcurrent(_ value: Int) {
        dCurrent = value
        coreDataManager.saveOrEditDCurrent(value)
    }
    func saveDlast(_ value: Int) {
        dLast = value
        coreDataManager.saveOrEditDLast(value)
    }
    func removeCalc() {
        try? coreDataManager.deleteCalculation()
    }
}

struct Metal: Hashable {
    var name: String
    var profit: Int
    var decline: Int
}

struct Calculation {
    let title: String
    let marketValue: Int
    let profit: Int
    let commission: Double
    let tax: Double
    let netProfit: Double
}
