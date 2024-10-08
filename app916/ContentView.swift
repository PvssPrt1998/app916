import SwiftUI

struct ContentView: View {
    
    @AppStorage("showProfile") var showProfile = true
    @State var showSplash = true
    
    var body: some View {
        if showSplash {
            Splash(show: $showSplash, dataController: ViewModelFactory.shared.dataController)
        } else {
            if showProfile {
                Profile(show: $showProfile, viewModel: ViewModelFactory.shared.makeProfileViewModel())
            } else {
                Tab()
            }
        }
    }
}

#Preview {
    ContentView()
}
