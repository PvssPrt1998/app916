import SwiftUI

struct ProfitCalculatorView: View {
    
    @ObservedObject var viewModel: ProfitCalculatorViewModel
    
    @State var showCalculation1: Bool = false
    @State var showCalculation2: Bool = false
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Profit Calculator")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 8) {
                    Text("Title")
                        .font(.body.weight(.semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ProfitCalculatorTextField(text: $viewModel.title, placeholder: "Title")
                }
                HStack(spacing: 12) {
                    VStack(spacing: 8) {
                        Text("Metal weight")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ProfitCalculatorTextField(text: $viewModel.metalWeight, placeholder: "g")
                            .onChange(of: viewModel.metalWeight, perform: { newValue in
                                weightValidation(newValue)
                            })
                            .keyboardType(.numberPad)
                    }
                    VStack(spacing: 8) {
                        Text("Price per 1 g")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ProfitCalculatorTextField(text: $viewModel.pricePer1g, placeholder: "$")
                            .onChange(of: viewModel.pricePer1g, perform: { newValue in
                                pricePer1gValidation(newValue)
                            })
                            .keyboardType(.numberPad)
                    }
                }
                HStack(spacing: 12) {
                    VStack(spacing: 8) {
                        Text("Sale price")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ProfitCalculatorTextField(text: $viewModel.salePrice, placeholder: "Enter the price")
                            .onChange(of: viewModel.salePrice, perform: { newValue in
                                salePriceValidation(newValue)
                            })
                            .keyboardType(.numberPad)
                    }
                    VStack(spacing: 8) {
                        Text("Commission")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ProfitCalculatorTextField(text: $viewModel.commission, placeholder: "%")
                            .onChange(of: viewModel.commission, perform: { newValue in
                                commissionValidation(newValue)
                            })
                            .keyboardType(.numberPad)
                    }
                }
                HStack(spacing: 12) {
                    VStack(spacing: 8) {
                        Text("Additional costs")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ProfitCalculatorTextField(text: $viewModel.additionalCost, placeholder: "$")
                            .onChange(of: viewModel.additionalCost, perform: { newValue in
                                additionalCostValidation(newValue)
                            })
                            .keyboardType(.numberPad)
                    }
                    VStack(spacing: 8) {
                        Text("Income tax")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ProfitCalculatorTextField(text: $viewModel.incomeTax, placeholder: "$")
                            .onChange(of: viewModel.incomeTax, perform: { newValue in
                                incomeTaxValidation(newValue)
                            })
                            .keyboardType(.numberPad)
                    }
                }
                
                HStack(spacing: 12) {
                    Button {
                        viewModel.deleteButtonPressed()
                    } label: {
                        Text("Delete")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.primaryGreen)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .clipShape(.rect(cornerRadius: 50))
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(.primaryGreen, lineWidth: 1)
                            )
                    }
                    Button {
                        viewModel.calculateButtonPressed()
                        withAnimation {
                            showCalculation1 = true
                        }
                    } label: {
                        Text("Calculate")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.primaryGreen)
                            .clipShape(.rect(cornerRadius: 50))
                    }
                    .disabled(viewModel.saveButtonDisabled)
                    .opacity(viewModel.saveButtonDisabled ? 0.4 : 1)
                }
                
                if viewModel.calc != nil {
                    VStack(spacing: 20) {
                        Text("Saved calculations")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            VStack(spacing: 2) {
                                Text("Sale of gold")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                Text((viewModel.calc!.netProfit > 0 ? "+" : "") + "\(viewModel.calc!.netProfit) $")
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                withAnimation {
                                    showCalculation2 = true
                                }
                            } label: {
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 7, height: 12)
                                    .frame(width: 24, height: 24)
                            }
                        }
                        .padding(EdgeInsets(top: 9, leading: 15, bottom: 9, trailing: 15))
                        .background(Color.white.opacity(0.06))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                    .padding(.bottom, 25)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .padding(.horizontal, paddingH)
            .frame(maxHeight: .infinity, alignment: .top)
            
            if showCalculation1 {
                if let calc = viewModel.tmpCalculation {
                    Calc1View(calc: calc, isSale: false) {
                        viewModel.saveCalc()
                        withAnimation {
                            showCalculation1 = false
                        }
                    } deleteAction: {
                        viewModel.deleteTmpCalc()
                        withAnimation {
                            showCalculation1 = false
                        }
                    }
                }//
            }
            if showCalculation2 {
                if viewModel.calc != nil {
                    Calc1View(calc: viewModel.calc!, isSale: true) {
                        withAnimation {
                            showCalculation2 = false
                        }
                    } deleteAction: {
                        viewModel.deleteCalc()
                        withAnimation {
                            showCalculation2 = false
                        }
                    }
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
    }
    
    func weightValidation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }
        let newValuePostfixFilter = newValue.filter{ Set(" g").contains($0) }
        if newValuePostfixFilter != "" && !newValue.contains(" g") {
            filtered.removeLast()
        }
        while filtered != "" && filtered.first == "0" && filtered.count > 1 {
            filtered.removeFirst()
        }
        
        if filtered != "" {
            viewModel.metalWeight = filtered + " g"
        } else {
            viewModel.metalWeight = ""
        }
    }
    
    func pricePer1gValidation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }
        while filtered != "" && filtered.first == "0" && filtered.count > 1 {
            filtered.removeFirst()
        }
        if filtered != "" {
            viewModel.pricePer1g = "$" + filtered
        } else {
            viewModel.pricePer1g = ""
        }
    }
    
    func salePriceValidation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }
        while filtered != "" && filtered.first == "0" && filtered.count > 1 {
            filtered.removeFirst()
        }
        if filtered != "" {
            viewModel.salePrice = "$" + filtered
        } else {
            viewModel.salePrice = ""
        }
    }
    
    func commissionValidation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }
        let newValuePostfixFilter = newValue.filter{ Set(" %").contains($0) }
        if newValuePostfixFilter != "" && !newValue.contains(" %") {
            filtered.removeLast()
        }
        while filtered != "" && filtered.first == "0" && filtered.count > 1 {
            filtered.removeFirst()
        }
        
        if filtered != "" {
            viewModel.commission = filtered + " %"
        } else {
            viewModel.commission = ""
        }
    }
    
    func additionalCostValidation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }
        while filtered != "" && filtered.first == "0" && filtered.count > 1 {
            filtered.removeFirst()
        }
        if filtered != "" {
            viewModel.additionalCost = "$" + filtered
        } else {
            viewModel.additionalCost = ""
        }
    }
    
    func incomeTaxValidation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }
        let newValuePostfixFilter = newValue.filter{ Set(" %").contains($0) }
        if newValuePostfixFilter != "" && !newValue.contains(" %") {
            filtered.removeLast()
        }
        while filtered != "" && filtered.first == "0" && filtered.count > 1 {
            filtered.removeFirst()
        }
        
        if filtered != "" {
            viewModel.incomeTax = filtered + " %"
        } else {
            viewModel.incomeTax = ""
        }
    }
}

#Preview {
    ProfitCalculatorView(viewModel: ProfitCalculatorViewModel(dataController: DataController()))
}
