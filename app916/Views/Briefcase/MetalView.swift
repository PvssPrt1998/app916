import SwiftUI

struct MetalView: View {
    
    let metal: Metal
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(metal.name)
                        .font(.footnote)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Text(value)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                NavigationLink {
                    EditMetalView(viewModel: ViewModelFactory.shared.makeEditMetalViewModel(metalName: metal.name))
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .padding(5)
                        .frame(width: 24, height: 24)
                }
            }
                .padding(.horizontal, 15)
            HStack(spacing: 12) {
                VStack(spacing: 8) {
                    Text("Profit")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.4))
                    Text(profitStr)
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                }
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.08))
                .clipShape(.rect(cornerRadius: 8))
                
                VStack(spacing: 8) {
                    Text("Decline")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.4))
                    Text(declineStr)
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                }
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.08))
                .clipShape(.rect(cornerRadius: 8))
            }
        }
        .padding(EdgeInsets(top: 9, leading: 16, bottom: 9, trailing: 16))
        .background(Color.white.opacity(0.06))
        .clipShape(.rect(cornerRadius: 20))
    }
    
    private var profitStr: String {
        var str = ""
        var str1 = ""
        if metal.profit > 0 {
            let ns = NSNumber(value: metal.profit)
            let formatter = NumberFormatter()
            formatter.groupingSeparator = " "
            formatter.groupingSize = 3
            formatter.numberStyle = .decimal
            str1 = String(formatter.string(from: ns) ?? "")
            str += "+"
        }
        
        if str1 != "" {
            return str + str1 + " $"
        } else {
            return str + "\(metal.profit) $"
        }
    }
    private var declineStr: String {
        var str = ""
        var str1 = ""
        if metal.decline > 0 {
            let ns = NSNumber(value: metal.decline)
            let formatter = NumberFormatter()
            formatter.groupingSeparator = " "
            formatter.groupingSize = 3
            formatter.numberStyle = .decimal
            str1 = String(formatter.string(from: ns) ?? "")
            str += "-"
        }
        if str1 != "" {
            return str + str1 + " $"
        } else {
            return str + "\(metal.decline) $"
        }
    }
    private var value: String {
        var str = ""
        var str1 = ""
        let val = metal.profit - metal.decline
        if val > 0 {
            str += "+"
        }
        let ns = NSNumber(value: val)
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        formatter.numberStyle = .decimal
        str1 = String(formatter.string(from: ns) ?? "")
        if str1 != "" {
            return str + str1 + " $"
        } else {
            return str + "\(val) $"
        }
    }
}

#Preview {
    MetalView(metal: Metal(name: "Gold", profit: 200000, decline: 100))
        .padding()
        .background(Color.bgDark)
}
