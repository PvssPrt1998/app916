import SwiftUI

struct AnalyticsView: View {
    
    @ObservedObject var viewModel: AnalyticsViewModel
    
    @State var segmented = 0
    
    @State var mCurrentAlert = false
    @State var mLastAlert = false
    @State var wCurrentAlert = false
    @State var wLastAlert = false
    @State var dCurrentAlert = false
    @State var dLastAlert = false
    
    init(viewModel: AnalyticsViewModel) {
        self.viewModel = viewModel
        UISegmentedControl.appearance().selectedSegmentTintColor = .primaryGreen
        UISegmentedControl.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.06)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Text("Analytics")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker("", selection: $segmented) {
                    Text("Price dynamics")
                        .foregroundColor(.white)
                        .tag(0)
                    Text("Portfolio statistics")
                        .foregroundColor(.white)
                        .tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.top, 20)
                
                if segmented == 0 {
                    ScrollView(.vertical, showsIndicators: false) {
                        selection0
                            .padding(.vertical, 18)
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        selection1
                            .padding(.vertical, 18)
                    }
                }
            }
            .padding(.horizontal, paddingH)
            .frame(maxHeight: .infinity, alignment: .top)
            
            if mCurrentAlert {
                CustomAlert(text: $viewModel.alertText, title: "Current price this month", subtitle: "Enter the price for analytics") {
                    viewModel.mCurrentSave()
                    withAnimation {
                        mCurrentAlert = false
                    }
                } close: {
                    withAnimation {
                        mCurrentAlert = false
                    }
                    viewModel.alertText = ""
                }

            }
            if mLastAlert {
                CustomAlert(text: $viewModel.alertText, title: "Current price last month", subtitle: "Enter the price for analytics") {
                    viewModel.mLastSave()
                    withAnimation {
                        mLastAlert = false
                    }
                } close: {
                    withAnimation {
                        mLastAlert = false
                    }
                    viewModel.alertText = ""
                }

            }
            if wCurrentAlert {
                CustomAlert(text: $viewModel.alertText, title: "Current week's price", subtitle: "Enter the price for analytics") {
                    viewModel.wCurrentSave()
                    withAnimation {
                        wCurrentAlert = false
                    }
                } close: {
                    withAnimation {
                        wCurrentAlert = false
                    }
                    viewModel.alertText = ""
                }

            }
            if wLastAlert {
                CustomAlert(text: $viewModel.alertText, title: "Last week's price", subtitle: "Enter the price for analytics") {
                    viewModel.wLastSave()
                    withAnimation {
                        wLastAlert = false
                    }
                } close: {
                    withAnimation {
                        wLastAlert = false
                    }
                    viewModel.alertText = ""
                }

            }
            
            if dCurrentAlert {
                CustomAlert(text: $viewModel.alertText, title: "Price today", subtitle: "Enter the price for analytics") {
                    viewModel.dCurrentSave()
                    withAnimation {
                        dCurrentAlert = false
                    }
                } close: {
                    withAnimation {
                        dCurrentAlert = false
                    }
                    viewModel.alertText = ""
                }

            }
            if dLastAlert {
                CustomAlert(text: $viewModel.alertText, title: "Price yesterday", subtitle: "Enter the price for analytics") {
                    viewModel.dLastSave()
                    withAnimation {
                        dLastAlert = false
                    }
                } close: {
                    withAnimation {
                        dLastAlert = false
                    }
                    viewModel.alertText = ""
                }

            }
        }
    }
    
    private var selection1: some View {
        VStack(spacing: 12) {
            selection1element1
            selection1element2
            selection1element3
        }
    }
    
    private var selection0: some View {
        VStack(spacing: 12) {
            selection0element1
            selection0element2
            selection0element3
        }
    }
    
    private var selection0element1: some View {
        VStack(spacing: 20) {
            Text("Monthly price changes for each metal")
                .font(.title3.weight(.semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            ZStack {
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.white.opacity(0.06), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(height: 110)
                Circle()
                    .trim(from: 0, to: min(1,CGFloat(viewModel.mPercent)))
                    .stroke(viewModel.mPercent >= 1 ? Color.primaryGreen : Color.secondaryRed, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(height: 110)
                Text(String(format: "%.0f", viewModel.mPercent * 100) + "%")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding(.bottom, 9)
        }
        .padding(12)
        .background(Color.white.opacity(0.05))
        .clipShape(.rect(cornerRadius: 24))
    }
    private var selection0element2: some View {
        VStack(spacing: 20) {
            Text("Weekly price changes for each metal")
                .font(.title3.weight(.semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            ZStack {
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.white.opacity(0.06), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(height: 110)
                Circle()
                    .trim(from: 0, to: min(1,CGFloat(viewModel.wPercent)))
                    .stroke(viewModel.wPercent >= 1 ? Color.primaryGreen : Color.secondaryRed, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(height: 110)
                Text(String(format: "%.0f", viewModel.wPercent * 100) + "%")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding(.bottom, 9)
        }
        .padding(12)
        .background(Color.white.opacity(0.05))
        .clipShape(.rect(cornerRadius: 24))
    }
    private var selection0element3: some View {
        VStack(spacing: 20) {
            Text("Daily price changes for each metal")
                .font(.title3.weight(.semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            ZStack {
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.white.opacity(0.06), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(height: 110)
                Circle()
                    .trim(from: 0, to: min(1,CGFloat(viewModel.dPercent)))
                    .stroke(viewModel.dPercent >= 1 ? Color.primaryGreen : Color.secondaryRed, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(height: 110)
                Text(String(format: "%.0f", viewModel.dPercent * 100) + "%")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding(.bottom, 9)
        }
        .padding(12)
        .background(Color.white.opacity(0.05))
        .clipShape(.rect(cornerRadius: 24))
    }
    
    private var selection1element1: some View {
        
        VStack(spacing: 12) {
            VStack(spacing: 8) {
                Text("Monthly price changes for each metal")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 12) {
                    VStack(spacing: 8) {
                        Image(systemName: "chart.xyaxis.line")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white.opacity(0.4))
                            .frame(width: 25, height: 21)
                        Text(viewModel.mCurrent == 0 ? "0 $" : "$\(viewModel.mCurrent)")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        Text("Profit")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.4))
                    }
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Button {
                            withAnimation {
                                mCurrentAlert = true
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
                    .overlay(
                        overlay1
                        ,alignment: .topLeading
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
                        Text(viewModel.mLast == 0 ? "0 $" : "$\(viewModel.mLast)")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        Text("Decline")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.4))
                    }
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Button {
                            withAnimation {
                                mLastAlert = true
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
                .padding(EdgeInsets(top: 9, leading: 10, bottom: 9, trailing: 10))
                .background(Color.white.opacity(0.06))
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding(EdgeInsets(top: 15, leading: 9, bottom: 15, trailing: 9))
            .background(Color.white.opacity(0.06))
            .clipShape(.rect(cornerRadius: 20))
        }
    }
    private var selection1element2: some View {
        VStack(spacing: 12) {
            VStack(spacing: 8) {
                Text("Weekly price changes for each metal")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 12) {
                    VStack(spacing: 8) {
                        Image(systemName: "chart.xyaxis.line")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white.opacity(0.4))
                            .frame(width: 25, height: 21)
                        Text(viewModel.wCurrent == 0 ? "0 $" : "$\(viewModel.wCurrent)")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        Text("Profit")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.4))
                    }
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Button {
                            withAnimation {
                                wCurrentAlert = true
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
                    .overlay(
                        overlay2
                        ,alignment: .topLeading
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
                        Text(viewModel.wLast == 0 ? "0 $" : "$\(viewModel.wLast)")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        Text("Decline")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.4))
                    }
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Button {
                            withAnimation {
                                wLastAlert = true
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
                .padding(EdgeInsets(top: 9, leading: 10, bottom: 9, trailing: 10))
                .background(Color.white.opacity(0.06))
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding(EdgeInsets(top: 15, leading: 9, bottom: 15, trailing: 9))
            .background(Color.white.opacity(0.06))
            .clipShape(.rect(cornerRadius: 20))
        }
    }
    private var selection1element3: some View {
        VStack(spacing: 12) {
            VStack(spacing: 8) {
                Text("Daily price changes for each metal")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 12) {
                    VStack(spacing: 8) {
                        Image(systemName: "chart.xyaxis.line")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white.opacity(0.4))
                            .frame(width: 25, height: 21)
                        Text(viewModel.dCurrent == 0 ? "0 $" : "$\(viewModel.dCurrent)")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        Text("Profit")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.4))
                    }
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Button {
                            withAnimation {
                                dCurrentAlert = true
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
                    .overlay(
                        overlay3
                        ,alignment: .topLeading
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
                        Text(viewModel.dLast == 0 ? "0 $" : "$\(viewModel.dLast)")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        Text("Decline")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.4))
                    }
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Button {
                            withAnimation {
                                dLastAlert = true
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
                .padding(EdgeInsets(top: 9, leading: 10, bottom: 9, trailing: 10))
                .background(Color.white.opacity(0.06))
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding(EdgeInsets(top: 15, leading: 9, bottom: 15, trailing: 9))
            .background(Color.white.opacity(0.06))
            .clipShape(.rect(cornerRadius: 20))
        }
    }
    
    @ViewBuilder var overlay1: some View {
        if viewModel.mCurrent != 0 && viewModel.mLast != 0 {
            Text(viewModel.mCurrentPercentText)
                .font(.caption2)
                .foregroundColor(viewModel.mCurrent > viewModel.mLast ? Color.primaryGreen : Color.secondaryRed)
                .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                .background(Color.white.opacity(0.06))
                .clipShape(.rect(cornerRadius: 24))
                .padding(.horizontal, 4)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder var overlay2: some View {
        if viewModel.wCurrent != 0 && viewModel.wLast != 0 {
            Text(viewModel.wCurrentPercentText)
                .font(.caption2)
                .foregroundColor(viewModel.wCurrent > viewModel.wLast ? Color.primaryGreen : Color.secondaryRed)
                .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                .background(Color.white.opacity(0.06))
                .clipShape(.rect(cornerRadius: 24))
                .padding(.horizontal, 4)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder var overlay3: some View {
        if viewModel.dCurrent != 0 && viewModel.dLast != 0 {
            Text(viewModel.dCurrentPercentText)
                .font(.caption2)
                .foregroundColor(viewModel.dCurrent > viewModel.dLast ? Color.primaryGreen : Color.secondaryRed)
                .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                .background(Color.white.opacity(0.06))
                .clipShape(.rect(cornerRadius: 24))
                .padding(.horizontal, 4)
        } else {
            EmptyView()
        }
    }
}

#Preview {
    AnalyticsView(viewModel: AnalyticsViewModel(dataController: DataController()))
}
