import SwiftUI

struct CustomAlert: View {
    
    @Binding var text: String
    let title: String
    let subtitle: String
    
    let save: () -> Void
    let close: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Text(title)
                    .font(.body.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.top, 19)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.top, 2)
                AlertTextField(text: $text, placeholder: title)
                    .onChange(of: text, perform: { newValue in
                        validation(newValue)
                    })
                    .padding(EdgeInsets(top: 14, leading: 16, bottom: 0, trailing: 16))
                Rectangle()
                    .fill(.white.opacity(0.4))
                    .frame(height: 0.33)
                    .padding(.top, 15)
                Button {
                    save()
                } label: {
                    Text("Save")
                        .font(.body.weight(.semibold))
                        .foregroundColor(.primaryGreen)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                }
                Rectangle()
                    .fill(.white.opacity(0.4))
                    .frame(height: 0.33)
                Button {
                    close()
                } label: {
                    Text("Close")
                        .font(.body.weight(.semibold))
                        .foregroundColor(.white.opacity(0.4))
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                }
            }
            .frame(width: 270)
            .background(Color.bgDark)
            .clipShape(.rect(cornerRadius: 14))
        }
    }
    
    func validation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789-,").contains($0) }
        let newValuePostfixFilter = newValue.filter{ Set(" $").contains($0) }
        if newValuePostfixFilter != "" && !newValue.contains(" $") {
            filtered.removeLast()
        }
        if filtered.first == "," {
            filtered.removeFirst()
        }
        if filtered.last == "-" {
            if filtered.count > 1 {
                filtered.removeLast()
            }
        }
        if filtered.last == "," {
            var count = 0
            filtered.forEach { c in
                if c == "," {
                    count += 1
                }
            }
            if count >= 2 {
                filtered.removeLast()
            }
        }
        if filtered.last == "-" {
            var count = 0
            filtered.forEach { c in
                if c == "-" {
                    count += 1
                }
            }
            if count >= 2 {
                filtered.removeLast()
            }
        }
        
        
        while filtered != "" && filtered.first == "0" && filtered.count > 1 {
            filtered.removeFirst()
        }
        
        if filtered != "" {
            if let int = Int(filtered) {
                let ns = NSNumber(value: int)
                let formatter = NumberFormatter()
                formatter.groupingSeparator = " "
                formatter.groupingSize = 3
                formatter.numberStyle = .decimal
                let str = String((formatter.string(from: ns) ?? filtered))
                text = str + " $"
            } else {
                text = filtered + " $"
            }
        } else {
            text = ""
        }
    }
}

struct CustomAlert_Preview: PreviewProvider {
    
    @State static var text: String = ""
    
    static var previews: some View {
        CustomAlert(text: $text, title: "Title", subtitle: "Subtitle") {
            
        } close: {
            
        }
        .padding()
        .background(Color.bgBlue)
    }
    
}
