import Foundation

final class AnalyticsViewModel: ObservableObject {
    
    let dataController: DataController
    
    @Published var alertText = ""
    
    @Published var mCurrent = 0
    @Published var mLast = 0
    @Published var wCurrent = 0
    @Published var wLast = 0
    @Published var dCurrent = 0
    @Published var dLast = 0
    
    var mPercent: Double {
        if mLast == 0 && mCurrent == 0 {
            return 0
        }
        if mLast == 0 {
            return 100
        }
        var value = Double(mCurrent) / Double(mLast)
        if value < 1 { value = 1 - value }
        return value
    }
    var wPercent: Double {
        if wLast == 0 && wCurrent == 0 {
            return 0
        }
        if wLast == 0 {
            return 100
        }
        var value = Double(wCurrent) / Double(wLast)
        if value < 1 { value = 1 - value }
        return value
    }
    var dPercent: Double {
        if dLast == 0 && dCurrent == 0 {
            return 0
        }
        if dLast == 0 {
            return 100
        }
        var value = Double(dCurrent) / Double(dLast)
        if value < 1 { value = 1 - value }
        return value
    }
    
    var mCurrentPercentText: String {
        var str = ""
        if mCurrent > mLast {
            str += "+"
        } else if mCurrent < mLast {
            str += "-"
        }
        var value = mPercent
        if value > 1 {
            value = value - 1
        } else if value < 1 {
            value = 1 - value
        }
        str += String(format: "%.0f", value * 100) + "%"
        return str
    }
    var wCurrentPercentText: String {
        var str = ""
        if wCurrent > wLast {
            str += "+"
        } else if wCurrent < wLast {
            str += "-"
        }
        var value = wPercent
        if value > 1 {
            value = value - 1
        } else if value < 1 {
            value = 1 - value
        }
        str += String(format: "%.0f", value * 100) + "%"
        return str
    }
    var dCurrentPercentText: String {
        var str = ""
        if dCurrent > dLast {
            str += "+"
        } else if dCurrent < dLast {
            str += "-"
        }
        var value = dPercent
        if value > 1 {
            value = value - 1
        } else if value < 1 {
            value = 1 - value
        }
        str += String(format: "%.0f", value * 100) + "%"
        return str
    }
    
    init(dataController: DataController) {
        self.dataController = dataController
        
        mCurrent = dataController.mCurrent
        mLast = dataController.mLast
        wCurrent = dataController.wCurrent
        wLast = dataController.wLast
        dCurrent = dataController.dCurrent
        dLast = dataController.dLast
    }
    
    func mCurrentSave() {
        guard let value = Int(alertText.filter { Set("0123456789").contains($0) }) else { return }
        mCurrent = value
        dataController.saveMcurrent(value)
        alertText = ""
    }
    
    func mLastSave() {
        guard let value = Int(alertText.filter { Set("0123456789").contains($0) }) else { return }
        mLast = value
        dataController.saveMlast(value)
        alertText = ""
    }
    func wCurrentSave() {
        guard let value = Int(alertText.filter { Set("0123456789").contains($0) }) else { return }
        wCurrent = value
        dataController.saveWcurrent(value)
        alertText = ""
    }
    
    func wLastSave() {
        guard let value = Int(alertText.filter { Set("0123456789").contains($0) }) else { return }
        wLast = value
        dataController.saveWlast(value)
        alertText = ""
    }
    func dCurrentSave() {
        guard let value = Int(alertText.filter { Set("0123456789").contains($0) }) else { return }
        dCurrent = value
        dataController.saveDcurrent(value)
        alertText = ""
    }
    
    func dLastSave() {
        guard let value = Int(alertText.filter { Set("0123456789").contains($0) }) else { return }
        dLast = value
        dataController.saveDlast(value)
        alertText = ""
    }
}
