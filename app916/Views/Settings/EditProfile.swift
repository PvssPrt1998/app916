import SwiftUI

struct EditProfile: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: EditProfileViewModel
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                EditImageView(imageData: $viewModel.imageData)
                    .padding(.top, 30)
                ProfileTextField(text: $viewModel.name, placeholder: "Name")
                    .padding(.top, 40)
                Button {
                    viewModel.saveButtonPressed()
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                        .font(.callout.weight(.semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .frame(height: 45)
                        .background(Color.primaryGreen)
                        .clipShape(.rect(cornerRadius: 50))
                }
                .padding(.top, 63)
            }
            .padding(.horizontal, paddingH)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Edit")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditProfile_Preview: PreviewProvider {
    
    @State static var show = true
    
    static var previews: some View {
        EditProfile(viewModel: EditProfileViewModel(dataController: DataController()))
    }
}

final class EditProfileViewModel: ObservableObject {
    
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
