

import SwiftUI

struct DefaultCellView: View {
    
    @StateObject var viewModel = ImageProvider()
    let item: SampleData    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        HStack {
            Text(item.data.text!)
            Spacer()
            if let url = URL(string: item.data.url ?? "") {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onAppear {
                        viewModel.loadImage(url: url)
                    }
            }
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(
                title: Text(item.name),
                message: Text(item.data.text!),
                dismissButton: .default(Text("Ok"))
            )
        })
        .onTapGesture {
            showingAlert = true
        }
        .padding()
    }
}

