import SwiftUI

struct Tab: View {
    
    @State var selection: Int = 0
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(rgbColorCodeRed: 255, green: 255, blue: 255, alpha: 0.4)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgbColorCodeRed: 255, green: 255, blue: 255, alpha: 0.4)]

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(rgbColorCodeRed: 0, green: 255, blue: 17, alpha: 1)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgbColorCodeRed: 0, green: 255, blue: 17, alpha: 1)]
        appearance.backgroundColor = UIColor.bgDark
        appearance.shadowColor = .white.withAlphaComponent(0.15)
        appearance.shadowImage = UIImage(named: "tab-shadow")?.withRenderingMode(.alwaysTemplate)
        UITabBar.appearance().backgroundColor = .bgDark
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selection) {
            BriefcaseView(viewModel: ViewModelFactory.shared.makeBriefcaseViewModel())
                .tabItem { VStack {
                    tabViewImage("latch.2.case")
                    Text("Briefcase")
                } }
            ProfitCalculatorView(viewModel: ViewModelFactory.shared.makeProfitCalculatorViewModel())
                .tabItem { VStack {
                    tabViewImage("apps.ipad")
                    Text("Profit Calculator")
                } }
            AnalyticsView(viewModel: ViewModelFactory.shared.makeAnalyticsViewModel())
                .tabItem { VStack{
                    tabViewImage("chart.xyaxis.line")
                    Text("Analytics")
                }
                }
            SettingsView(viewModel: ViewModelFactory.shared.makeSettingsViewModel())
                .tabItem {
                    VStack {
                        tabViewImage("gearshape")
                        Text("Settings")
                    }
                }
        }
        .onAppear {
            AppDelegate.orientationLock = .portrait
        }
    }
    
    @ViewBuilder func tabViewImage(_ systemName: String) -> some View {
        if #available(iOS 15.0, *) {
            Image(systemName: systemName)
                .environment(\.symbolVariants, .none)
        } else {
            Image(systemName: systemName)
        }
    }
}

#Preview {
    Tab()
}

extension UIColor {
   convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {

     let redPart: CGFloat = CGFloat(red) / 255
     let greenPart: CGFloat = CGFloat(green) / 255
     let bluePart: CGFloat = CGFloat(blue) / 255

     self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
   }
}
