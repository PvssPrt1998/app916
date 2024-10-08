import SwiftUI

struct EditMetalView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: EditMetalViewModel
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 20) {
                MetalTextField(text: $viewModel.name, placeholder: "Name metal")
                MetalTextField(text: $viewModel.profit, placeholder: "Profit")
                    .onChange(of: viewModel.profit, perform: { newValue in
                        profitValidation(newValue)
                    })
                    .keyboardType(.numberPad)
                MetalTextField(text: $viewModel.decline, placeholder: "Decline")
                    .onChange(of: viewModel.decline, perform: { newValue in
                        declineValidation(newValue)
                    })
                    .keyboardType(.numberPad)
                Button {
                    viewModel.saveButtonPressed()
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                        .font(.callout.weight(.semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.primaryGreen)
                        .clipShape(.rect(cornerRadius: 50))
                }
                .disabled(viewModel.saveButtonDisabled)
                .opacity(viewModel.saveButtonDisabled ? 0.3 : 1)
            }
            .padding(EdgeInsets(top: 20, leading: paddingH, bottom: 0, trailing: paddingH))
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
    
    func profitValidation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }
        let newValuePostfixFilter = newValue.filter{ Set(" $").contains($0) }
        if newValuePostfixFilter != "" && !newValue.contains(" $") {
            filtered.removeLast()
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
                viewModel.profit = str + " $"
            } else {
                viewModel.profit = filtered + " $"
            }
        } else {
            viewModel.profit = ""
        }
    }
    
    func declineValidation(_ newValue: String) {
        var filtered = newValue.filter { Set("0123456789").contains($0) }
        let newValuePostfixFilter = newValue.filter{ Set(" $").contains($0) }
        if newValuePostfixFilter != "" && !newValue.contains(" $") {
            filtered.removeLast()
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
                viewModel.decline = str + " $"
            } else {
                viewModel.decline = filtered + " $"
            }
        } else {
            viewModel.decline = ""
        }
    }
}

#Preview {
    EditMetalView(viewModel: EditMetalViewModel(dataController: DataController(), metalName: "Silver"))
}

final class EditMetalViewModel: ObservableObject {
    
    let dataController: DataController
    let metalName: String
    
    var saveButtonDisabled: Bool {
        if name == "" || profit == "" || decline == "" || (metalName != "Gold" && name == "Gold")
            || dataController.metals.contains(where: { element in
                if element.name != metalName && name == element.name {
                    return true
                } else {
                    return false
                }
            }) 
        {
            return true
        } else { return false }
    }
    
    @Published var name: String = ""
    @Published var profit = ""
    @Published var decline = ""
    
    init(dataController: DataController, metalName: String) {
        self.dataController = dataController
        self.metalName = metalName
        let metal = dataController.metals.first(where: {$0.name == metalName})
        name = metal?.name ?? ""
        if let profit = metal?.profit {
            self.profit = "\(profit)"
        }
        if let decline = metal?.decline {
            self.decline = "\(decline)"
        }
    }
    
    func saveButtonPressed() {
        guard let profit = Int(self.profit.filter { Set("0123456789").contains($0) }), let decline = Int(self.decline.filter { Set("0123456789").contains($0) }) else { return }
        dataController.editMetal(metalName: metalName, metal: Metal(name: name, profit: profit, decline: decline))
    }
}
