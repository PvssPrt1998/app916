import SwiftUI

struct EditImageView: View {
    @Binding var imageData: Data?
    @State var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 197, height: 197)
                    .background(Color.white)
                    .clipShape(.circle)
                    .overlay(
                        Button {
                            showingImagePicker = true
                        } label: {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .padding(8)
                                .frame(width: 35, height: 35)
                                .background(Color.white.opacity(0.2))
                                .clipShape(.circle)
                        }
                        ,alignment: .bottomTrailing
                    )
            } else {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 84, height: 68)
                    .frame(width: 197, height: 197)
                    .background(Color.bgBlue)
                    .clipShape(.circle)
                    .overlay(
                        Button {
                            showingImagePicker = true
                        } label: {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .padding(8)
                                .frame(width: 35, height: 35)
                                .background(Color.white.opacity(0.2))
                                .clipShape(.circle)
                        }
                        ,alignment: .bottomTrailing
                    )
            }
        }
        .onChange(of: inputImage) { _ in
            loadImage()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
                .ignoresSafeArea()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        imageData = inputImage.pngData()
    }
}

