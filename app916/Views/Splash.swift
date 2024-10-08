import SwiftUI

struct Splash: View {
    
    @Binding var show: Bool
    let dataController: DataController
    
    var body: some View {
        ZStack {
            Image("SplashBackground")
                .resizable()
                .ignoresSafeArea()
            Image("LoadingLogo")
                .scaledToFit()
        }
        .onAppear {
            dataController.load()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                show = false
            }
        }
    }
}

struct Splash_Preview: PreviewProvider {
    
    @State static var show = true
    
    static var previews: some View {
        Splash(show: $show, dataController: DataController())
    }
    
}
