import Foundation

final class CoreDataManager {
    private let modelName = "DataModel"
    
    lazy var coreDataStack = CDSk(modelName: modelName)
    
    func saveOrEditMCurrent(_ value: Int) {
        do {
            let ids = try coreDataStack.managedContext.fetch(MCurrent.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].value = Int32(value)
            } else {
                let mCurrent = MCurrent(context: coreDataStack.managedContext)
                mCurrent.value = Int32(value)
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func saveOrEditMLast(_ value: Int) {
        do {
            let ids = try coreDataStack.managedContext.fetch(MLast.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].value = Int32(value)
            } else {
                let mCurrent = MLast(context: coreDataStack.managedContext)
                mCurrent.value = Int32(value)
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func saveOrEditWCurrent(_ value: Int) {
        do {
            let ids = try coreDataStack.managedContext.fetch(WCurrent.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].value = Int32(value)
            } else {
                let mCurrent = WCurrent(context: coreDataStack.managedContext)
                mCurrent.value = Int32(value)
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func saveOrEditWLast(_ value: Int) {
        do {
            let ids = try coreDataStack.managedContext.fetch(WLast.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].value = Int32(value)
            } else {
                let mCurrent = WLast(context: coreDataStack.managedContext)
                mCurrent.value = Int32(value)
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func saveOrEditDCurrent(_ value: Int) {
        do {
            let ids = try coreDataStack.managedContext.fetch(DCurrent.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].value = Int32(value)
            } else {
                let mCurrent = DCurrent(context: coreDataStack.managedContext)
                mCurrent.value = Int32(value)
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func saveOrEditDLast(_ value: Int) {
        do {
            let ids = try coreDataStack.managedContext.fetch(DLast.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].value = Int32(value)
            } else {
                let mCurrent = DLast(context: coreDataStack.managedContext)
                mCurrent.value = Int32(value)
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchMCurrent() throws -> Int? {
        guard let totalNumber = try coreDataStack.managedContext.fetch(MCurrent.fetchRequest()).first else { return nil }
        return Int(totalNumber.value)
    }
    func fetchMLast() throws -> Int? {
        guard let totalNumber = try coreDataStack.managedContext.fetch(MLast.fetchRequest()).first else { return nil }
        return Int(totalNumber.value)
    }
    func fetchWCurrent() throws -> Int? {
        guard let totalNumber = try coreDataStack.managedContext.fetch(WCurrent.fetchRequest()).first else { return nil }
        return Int(totalNumber.value)
    }
    func fetchWLast() throws -> Int? {
        guard let totalNumber = try coreDataStack.managedContext.fetch(WLast.fetchRequest()).first else { return nil }
        return Int(totalNumber.value)
    }
    func fetchDCurrent() throws -> Int? {
        guard let totalNumber = try coreDataStack.managedContext.fetch(DCurrent.fetchRequest()).first else { return nil }
        return Int(totalNumber.value)
    }
    func fetchDLast() throws -> Int? {
        guard let totalNumber = try coreDataStack.managedContext.fetch(DLast.fetchRequest()).first else { return nil }
        return Int(totalNumber.value)
    }
    
    func saveOrEditImage(_ imageData: Data?, name: String) {
        do {
            let ids = try coreDataStack.managedContext.fetch(ProfileCoreData.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].image = imageData
                ids[0].name = name
            } else {
                let profile = ProfileCoreData(context: coreDataStack.managedContext)
                profile.name = name
                profile.image = imageData
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchProfile() throws -> (Data?, String)? {
        guard let totalNumber = try coreDataStack.managedContext.fetch(ProfileCoreData.fetchRequest()).first else { return nil }
        return (totalNumber.image, totalNumber.name)
    }
    
    func saveOrEditTotalBalance(_ value: String) {
        do {
            let ids = try coreDataStack.managedContext.fetch(TotalBalance.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].balance = value
            } else {
                let mCurrent = TotalBalance(context: coreDataStack.managedContext)
                mCurrent.balance = value
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func saveOrEditProfit(_ value: String) {
        do {
            let ids = try coreDataStack.managedContext.fetch(Profit.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].profit = value
            } else {
                let mCurrent = Profit(context: coreDataStack.managedContext)
                mCurrent.profit = value
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    func saveOrEditDecline(_ value: String) {
        do {
            let ids = try coreDataStack.managedContext.fetch(Decline.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].decline = value
            } else {
                let mCurrent = Decline(context: coreDataStack.managedContext)
                mCurrent.decline = value
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchDecline() throws -> String? {
        guard let totalNumber = try coreDataStack.managedContext.fetch(Decline.fetchRequest()).first else { return nil }
        return totalNumber.decline
    }
    func fetchProfit() throws -> String? {
        guard let totalNumber = try coreDataStack.managedContext.fetch(Profit.fetchRequest()).first else { return nil }
        return totalNumber.profit
    }
    func fetchTotalBalance() throws -> String? {
        guard let totalNumber = try coreDataStack.managedContext.fetch(TotalBalance.fetchRequest()).first else { return nil }
        return totalNumber.balance
    }
    
    func saveMetal(_ metal: Metal) {
        let metalCoreData = MetalCoreData(context: coreDataStack.managedContext)
        metalCoreData.title = metal.name
        metalCoreData.decline = Int32(metal.decline)
        metalCoreData.profit = Int32(metal.profit)
        coreDataStack.saveContext()
    }
    
    func fetchMetals() throws -> Array<Metal> {
        var array: Array<Metal> = []
        let metalsCoreData = try coreDataStack.managedContext.fetch(MetalCoreData.fetchRequest())
        metalsCoreData.forEach { metalCoreData in
            array.append(Metal(name: metalCoreData.title, profit: Int(metalCoreData.profit), decline: Int(metalCoreData.decline)))
        }
        return array
    }
    func editMetal(_ metal: Metal) {
        do {
            let ids = try coreDataStack.managedContext.fetch(MetalCoreData.fetchRequest())
            let index = ids.firstIndex(where: {$0.title == metal.name})
            if let index = index {
                ids[index].decline = Int32(metal.decline)
                ids[index].profit = Int32(metal.profit)
                ids[index].title = metal.name
                coreDataStack.saveContext()
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func saveOrEditGold(_ gold: Metal) {
        do {
            let ids = try coreDataStack.managedContext.fetch(Gold.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].decline = Int32(gold.decline)
                ids[0].profit = Int32(gold.profit)
                ids[0].name = gold.name
            } else {
                let mCurrent = Gold(context: coreDataStack.managedContext)
                mCurrent.decline = Int32(gold.decline)
                mCurrent.profit = Int32(gold.profit)
                mCurrent.name = gold.name
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchGold() throws -> Metal? {
        guard let totalNumber = try coreDataStack.managedContext.fetch(Gold.fetchRequest()).first else { return nil }
        return Metal(name: totalNumber.name, profit: Int(totalNumber.profit), decline: Int(totalNumber.decline))
    }
    
    func saveOrEditCalculation(_ calculation: Calculation) {
        do {
            let ids = try coreDataStack.managedContext.fetch(CalculationCoreData.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].title = calculation.title
                ids[0].marketValue = Int32(calculation.marketValue)
                ids[0].profit = Int32(calculation.profit)
                ids[0].commission = calculation.commission
                ids[0].tax = calculation.tax
                ids[0].netProfit = calculation.netProfit
            } else {
                let mCurrent = CalculationCoreData(context: coreDataStack.managedContext)
                mCurrent.title = calculation.title
                mCurrent.marketValue = Int32(calculation.marketValue)
                mCurrent.profit = Int32(calculation.profit)
                mCurrent.commission = calculation.commission
                mCurrent.tax = calculation.tax
                mCurrent.netProfit = calculation.netProfit
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchCalculation() throws -> Calculation? {
        guard let t = try coreDataStack.managedContext.fetch(CalculationCoreData.fetchRequest()).first else { return nil }
        return Calculation(title: t.title,
                           marketValue: Int(t.marketValue),
                           profit: Int(t.profit),
                           commission: t.commission, tax: t.tax, netProfit: t.netProfit)
    }
    
    func deleteCalculation() throws {
        guard let goalsCoreData = try coreDataStack.managedContext.fetch(CalculationCoreData.fetchRequest()).first else { return }
        coreDataStack.managedContext.delete(goalsCoreData)
        coreDataStack.saveContext()
    }
}
