import SwiftUI

struct ProfileTextField: View {
    
    @Binding var text: String
    
    let placeholder: String
    var trailingPadding: CGFloat = 0
    
    var body: some View {
        TextField("", text: $text)
            .font(.title.weight(.regular))
            .foregroundColor(.white)
            .autocorrectionDisabled(true)
            .accentColor(.white)
            .background(
                placeholderView()
            )
            .padding(EdgeInsets(top: 4, leading: 17, bottom: 4, trailing: 17))
            .background(
                Color.white.opacity(0.2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(.primaryGreen, lineWidth: 1)
            )
            .clipShape(.rect(cornerRadius: 50))
    }
    
    @ViewBuilder func placeholderView() -> some View {
        Text(text != "" ? "" : placeholder)
            .font(.title.weight(.regular))
            .foregroundColor(.white.opacity(0.6))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TextFieldCustom_Preview: PreviewProvider {
    
    @State static var text = ""
    
    static var previews: some View {
        ProfileTextField(text: $text, placeholder: "Name")
            .padding()
            .background(Color.bgBlue)
            .frame(height: 200)
    }
}
