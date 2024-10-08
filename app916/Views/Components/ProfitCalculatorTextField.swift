import SwiftUI

struct ProfitCalculatorTextField: View {
    
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
            .padding(16)
            .frame(height: 45)
            .background(
                Color.white.opacity(0.08)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.secondaryGreen, lineWidth: 1)
            )
            .clipShape(.rect(cornerRadius: 12))
    }
    
    @ViewBuilder func placeholderView() -> some View {
        Text(text != "" ? "" : placeholder)
            .font(.body.weight(.regular))
            .foregroundColor(.white.opacity(0.4))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProfitCalculatorTextField_Preview: PreviewProvider {
    
    @State static var text = ""
    
    static var previews: some View {
        ProfitCalculatorTextField(text: $text, placeholder: "Name")
            .padding()
            .background(Color.bgBlue)
            .frame(height: 200)
    }
}
