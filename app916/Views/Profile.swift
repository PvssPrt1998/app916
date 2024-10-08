import SwiftUI

struct Profile: View {
    
    @Binding var show: Bool
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            
            Text("Fill out the profile")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .padding(.top, 66)
                .frame(maxHeight: .infinity, alignment: .top)
            
            VStack(spacing: 32) {
                ImageView(imageData: $viewModel.imageData)
                ProfileTextField(text: $viewModel.name, placeholder: "Name")
            }
            .padding(.horizontal, paddingH)
            
            Button {
                viewModel.saveButtonPressed()
                show = false
            } label: {
                Text("Save")
                    .font(.callout.weight(.semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(height: 45)
                    .background(Color.primaryGreen)
                    .clipShape(.rect(cornerRadius: 50))
            }
            .padding(EdgeInsets(top: 0, leading: paddingH, bottom: 66, trailing: paddingH))
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.keyboard)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
    }
}

struct Profile_Preview: PreviewProvider {
    
    @State static var show = true
    
    static var previews: some View {
        Profile(show: $show, viewModel: ProfileViewModel(dataController: DataController()))
    }
    
}

final class ProfileViewModel: ObservableObject {
    
    let dataController: DataController
    
    @Published var name: String = ""
    @Published var imageData: Data?
    
    init(dataController: DataController) {
        self.dataController = dataController
        
        imageData = dataController.imageData
    }
    
    func saveButtonPressed() {
        dataController.savePofile(imageData: imageData, name: name)
    }
}
