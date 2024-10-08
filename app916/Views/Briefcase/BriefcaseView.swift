import SwiftUI

struct BriefcaseView: View {
    
    @ObservedObject var viewModel: BriefcaseViewModel
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @State var showBalanceAlert = false
    @State var showProfitAlert = false
    @State var showDeclineAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                
                Color.bgDark
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .padding(.top, 146 + safeAreaInsets.top)
                    .ignoresSafeArea()
                    .overlay(
                        content
                            .padding(.top, 104)
                    )
                
                VStack(spacing: 0) {
                    welcomeView
                        .padding(.horizontal, paddingH)
                    
                    Text("Briefcase")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, paddingH)
                }
                
                .frame(maxHeight: .infinity, alignment: .top)
                
                if showBalanceAlert {
                    CustomAlert(text: $viewModel.alertText, title: "Total balance", subtitle: "Your total balance") {
                        viewModel.balanceSave()
                        withAnimation {
                            showBalanceAlert = false
                        }
                    } close: {
                        viewModel.alertText = ""
                        withAnimation {
                            showBalanceAlert = false
                        }
                    }
                }
                if showDeclineAlert {
                    CustomAlert(text: $viewModel.alertText, title: "Decline", subtitle: "Your total decline") {
                        viewModel.declineSave()
                        withAnimation {
                            showDeclineAlert = false
                        }
                    } close: {
                        viewModel.alertText = ""
                        withAnimation {
                            showDeclineAlert = false
                        }
                    }
                }
                if showProfitAlert {
                    CustomAlert(text: $viewModel.alertText, title: "Profit", subtitle: "Your total profit") {
                        viewModel.profitSave()
                        withAnimation {
                            showProfitAlert = false
                        }
                    } close: {
                        viewModel.alertText = ""
                        withAnimation {
                            showProfitAlert = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BriefcaseView(viewModel: BriefcaseViewModel(dataController: DataController()))
}

extension BriefcaseView {
    private var welcomeView: some View {
        HStack(spacing: 10) {
            setImage()
            Text(viewModel.name == "" ? "Welcome!" : "Welcome, " + viewModel.name + "!")
                .font(.body.weight(.semibold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
                
    @ViewBuilder private func setImage() -> some View {
        if let imageData = viewModel.imageData,
           let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 38, height: 38)
                .clipShape(.circle)
        } else {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 38, height: 38)
                .clipShape(.circle)
        }
    }
    
    private var content: some View {
        VStack(spacing: 0) {
            totalBalance
            profitLossView.padding(.top, 12)
            HStack {
                Text("List of precious metals")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if !viewModel.metals.isEmpty {
                    NavigationLink{
                        AddMetalView(viewModel: ViewModelFactory.shared.makeAddMetalViewModel())
                    } label: {
                        Image(systemName: "plus.app.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.primaryGreen)
                        .frame(width: 31, height: 34)
                    }
                }
            }
            .padding(EdgeInsets(top: 20, leading: paddingH, bottom: 20, trailing: paddingH))
            metalsList.padding(.horizontal, paddingH)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var totalBalance: some View {
        VStack(spacing: 8) {
            Image(systemName: "creditcard")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white.opacity(0.4))
                .frame(width: 24, height: 24)
            Text(viewModel.totalBalance == "" ? "0 $" : "\(viewModel.totalBalance)")
                .font(.largeTitle.bold())
                .foregroundColor(.white)
            Text("Total balance")
                .font(.caption2)
                .foregroundColor(.white.opacity(0.4))
        }
        .frame(maxWidth: .infinity)
        .overlay(
            Button {
                withAnimation {
                    showBalanceAlert = true
                }
            } label: {
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .padding(6)
                    .frame(width: 24, height: 24)
            }
            ,alignment: .topTrailing
        )
        .background(Color.white.opacity(0.08))
        .clipShape(.rect(cornerRadius: 8))
        .padding(12)
        .background(Color.bgBlueLight)
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal, paddingH)
    }
    
    private var profitLossView: some View {
        HStack(spacing: 12) {
            VStack(spacing: 8) {
                Image(systemName: "chart.xyaxis.line")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white.opacity(0.4))
                    .frame(width: 25, height: 21)
                Text(viewModel.profit == "" ? "0 $" : "\(viewModel.profit)")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                Text("Profit")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.4))
            }
            .frame(maxWidth: .infinity)
            .overlay(
                Button {
                    withAnimation {
                        showProfitAlert = true
                    }
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .padding(6)
                        .frame(width: 24, height: 24)
                }
                ,alignment: .topTrailing
            )
            .padding(.vertical, 5)
            .background(Color.white.opacity(0.08))
            .clipShape(.rect(cornerRadius: 8))
            
            VStack(spacing: 8) {
                Image("chart.xyaxis.line")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white.opacity(0.4))
                    .frame(width: 25, height: 21)
                Text(viewModel.loss == "" ? "0 $" : "\(viewModel.loss)")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                Text("Decline")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.4))
            }
            .frame(maxWidth: .infinity)
            .overlay(
                Button {
                    withAnimation {
                        showDeclineAlert = true
                    }
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .padding(6)
                        .frame(width: 24, height: 24)
                }
                ,alignment: .topTrailing
            )
            .padding(.vertical, 5)
            .background(Color.white.opacity(0.08))
            .clipShape(.rect(cornerRadius: 8))
        }
        .padding(12)
        .background(Color.bgBlueLight)
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal, paddingH)
    }
    
    private var metalsList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 12) {
                if viewModel.metals.isEmpty {
                    VStack(spacing: 16) {
                        Text("Add precious metal")
                            .font(.title.bold())
                            .foregroundColor(.white)
                        NavigationLink {
                            AddMetalView(viewModel: ViewModelFactory.shared.makeAddMetalViewModel())
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "plus.app.fill")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.black)
                                Text("Add metal")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.black)
                            }
                            .padding(EdgeInsets(top: 14, leading: 20, bottom: 14, trailing: 20))
                            .background(Color.primaryGreen)
                            .clipShape(.rect(cornerRadius: 12))
                        }
                    }
                    .padding(EdgeInsets(top: 48, leading: 24, bottom: 48, trailing: 24))
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.06))
                    .clipShape(.rect(cornerRadius: 20))
                }
                MetalView(metal: viewModel.gold)
                if !viewModel.metals.isEmpty {
                    ForEach(viewModel.metals, id: \.self) { metal in
                        MetalView(metal: metal)
                    }
                }
            }
            .padding(.bottom, 12)
        }
    }
}
