import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = SampleViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.itemViewModels, id: \.self) { item in
                switch item.name {
                case "selector":
                    SelectorCellView(item: item)
                 default:
                    DefaultCellView(item: item)
                }
            
            }
            
            .alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil)) {
                Alert(
                    title: Text("Error!"),
                    message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""),
                    dismissButton: .default(Text("Ok"), action: {
                        viewModel.error = nil
                    })
                )
            }
            .navigationTitle("Пряники")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
