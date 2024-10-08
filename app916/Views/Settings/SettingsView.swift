import SwiftUI
import StoreKit


struct SettingsView: View {
    
    @Environment(\.openURL) var openURL
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Text("Settings")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 10) {
                        setImage()
                        Text(viewModel.name == "" ? "Welcome!" : "Welcome, " + viewModel.name + "!")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        NavigationLink {
                            EditProfile(viewModel: ViewModelFactory.shared.makeEditProfileViewModel())
                        } label: {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .padding(5)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 12)
                }
                .padding(.horizontal, paddingH)
                .frame(maxHeight: .infinity, alignment: .top)
                
                VStack(spacing: 15) {
                    Button {
                        actionSheet()
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: "square.and.arrow.up.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.primaryGreen)
                                .frame(width: 24, height: 24)
                            Text("Share app")
                                .font(.subheadline.weight(.semibold))
                                .foregroundColor(.primaryGreen)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.white.opacity(0.2))
                        .clipShape(.rect(cornerRadius: 50))
                    }
                    Button {
                        SKStoreReviewController.requestReviewInCurrentScene()
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.primaryGreen)
                                .frame(width: 24, height: 24)
                            Text("Rate Us")
                                .font(.subheadline.weight(.semibold))
                                .foregroundColor(.primaryGreen)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.white.opacity(0.2))
                        .clipShape(.rect(cornerRadius: 50))
                    }
                    Button {
                        if let url = URL(string: "https://www.termsfeed.com/live/a1690025-0368-4d04-9f34-13963edaf770") {
                            openURL(url)
                        }
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: "doc.text.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.primaryGreen)
                                .frame(width: 24, height: 24)
                            Text("Usage Policy")
                                .font(.subheadline.weight(.semibold))
                                .foregroundColor(.primaryGreen)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.white.opacity(0.2))
                        .clipShape(.rect(cornerRadius: 50))
                    }

                }
                .padding(.horizontal, paddingH)
            }
        }
    }
    func actionSheet() {
        guard let urlShare = URL(string: "https://apps.apple.com/us/app/pixmetal-investment-tracker/id6736591099") else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
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
}

#Preview {
    SettingsView(viewModel: SettingsViewModel(dataController: DataController()))
}

extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}
