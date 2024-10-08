import Foundation

final class ProfitCalculatorViewModel: ObservableObject {
    
    let dataController: DataController
    
    @Published var title: String = ""
    @Published var metalWeight: String = ""
    @Published var pricePer1g: String = ""
    @Published var salePrice: String = ""
    @Published var commission: String = ""
    @Published var additionalCost: String = ""
    @Published var incomeTax: String = ""
    
    var tmpCalculation: Calculation?
    @Published var calc: Calculation?
    
    var saveButtonDisabled: Bool {
        if title == "" || metalWeight == "" || pricePer1g == "" || salePrice == "" || commission == "" || additionalCost == "" || incomeTax == "" {
            return true
        } else {
            return false
        }
    }
    
    init(dataController: DataController) {
        self.dataController = dataController
        self.calc = dataController.calculation
    }
    
    func deleteButtonPressed() {
        title = ""
        metalWeight = ""
        pricePer1g = ""
        salePrice = ""
        commission = ""
        additionalCost = ""
        incomeTax = ""
    }
    
    func calculateButtonPressed() {
        guard let metalWeight = Int(metalWeight.filter { Set("0123456789").contains($0) }),
              let pricePer1g = Int(pricePer1g.filter { Set("0123456789").contains($0) }),
              let salePrice = Int(salePrice.filter { Set("0123456789").contains($0) }),
              let commission = Int(commission.filter { Set("0123456789").contains($0) }),
              let additionalCost = Int(additionalCost.filter { Set("0123456789").contains($0) }),
              let incomeTax = Int(incomeTax.filter { Set("0123456789").contains($0) }) else { return }
        let marketValue = metalWeight * pricePer1g
        let profit = metalWeight * salePrice - marketValue
        let comm = Double(marketValue) * (Double(commission) / 100)
        let tax = Double(profit) * (Double(incomeTax) / 100)
        let net = Double(profit) - Double(additionalCost) - tax - comm
        let calculation = Calculation(title: title,
                                      marketValue: marketValue,
                                      profit: profit,
                                      commission: comm,
                                      tax: tax,
                                      netProfit: net)
        dataController.saveCalculation(calculation)
        self.tmpCalculation = calculation
    }
    
    func saveCalc() {
        calc = tmpCalculation
        if let calc = calc {
            dataController.saveCalculation(calc)
        }
    }
    
    func deleteTmpCalc() {
        tmpCalculation = nil
    }
    
    func deleteCalc() {
        calc = nil
        dataController.removeCalc()
    }
}
