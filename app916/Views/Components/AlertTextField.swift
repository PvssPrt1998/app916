import SwiftUI

struct AlertTextField: View {
    
    @Binding var text: String
    
    let placeholder: String
    var trailingPadding: CGFloat = 0
    
    var body: some View {
        TextField("", text: $text)
            .font(.body.weight(.regular))
            .foregroundColor(.white)
            .autocorrectionDisabled(true)
            .accentColor(.white)
            .background(
                placeholderView()
            )
            .padding(EdgeInsets(top: 4, leading: 17, bottom: 4, trailing: 17))
            .background(
                Color.white.opacity(0.08)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.white.opacity(0.08), lineWidth: 0.5)
            )
            .clipShape(.rect(cornerRadius: 5))
    }
    
    @ViewBuilder func placeholderView() -> some View {
        Text(text != "" ? "" : placeholder)
            .font(.body.weight(.regular))
            .foregroundColor(.white.opacity(0.08))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct AlertTextField_Preview: PreviewProvider {
    
    @State static var text = ""
    
    static var previews: some View {
        AlertTextField(text: $text, placeholder: "Name")
            .padding()
            .background(Color.bgBlue)
            .frame(height: 200)
    }
}
