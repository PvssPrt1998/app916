import SwiftUI

struct Calc1View: View {
    
    let calc: Calculation
    let isSale: Bool
    let action: () -> Void
    let deleteAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            VStack(spacing: 24) {
                Text("Profit from the sale")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                VStack(spacing: 0) {
                    Text(isSale ? "Sale of \(calc.title)" : calc.title)
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                    Rectangle()
                        .fill(.c0191255)
                        .frame(height: 1)
                    HStack {
                        Text("Market value")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(calc.marketValue) $")
                            .font(.callout.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    Rectangle()
                        .fill(.c0191255)
                        .frame(height: 1)
                    HStack {
                        Text("Profit from the sale")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(calc.profit) $")
                            .font(.callout.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    Rectangle()
                        .fill(.c0191255)
                        .frame(height: 1)
                    HStack {
                        Text("Commission")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(String(format: "%.0f", calc.commission) + " $")
                            .font(.callout.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    Rectangle()
                        .fill(.c0191255)
                        .frame(height: 1)
                    HStack {
                        Text("Income tax")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(String(format: "%.0f", calc.tax) + " $")
                            .font(.callout.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    Rectangle()
                        .fill(.c0191255)
                        .frame(height: 1)
                    HStack {
                        Text("Net profit")
                            .font(.title.weight(.bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(String(format: "%.0f", calc.netProfit) + " $")
                            .font(.title.weight(.bold))
                            .foregroundColor(.white)
                    }
                    Rectangle()
                        .fill(.c0191255)
                        .frame(height: 1)
                }
                
                HStack(spacing: 12) {
                    Button {
                        deleteAction()
                    } label: {
                        Text("Delete")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.primaryGreen)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .clipShape(.rect(cornerRadius: 50))
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.primaryGreen, lineWidth: 1)
                            )
                    }
                    Button {
                        action()
                    } label: {
                        Text("Save")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.primaryGreen)
                            .clipShape(.rect(cornerRadius: 50))
                    }
                }
            }
            .padding(24)
            .background(Color.bgDark)
            .clipShape(.rect(cornerRadius: 16))
            .frame(maxWidth: 340)
        }
    }
}

#Preview {
    Calc1View(calc: Calculation(title: "Gold",  marketValue: 6000, profit: 500, commission: 120, tax: 50, netProfit: 320), isSale: true) {
        
    } deleteAction: {
        
    }
}
