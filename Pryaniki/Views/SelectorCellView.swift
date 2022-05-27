
import SwiftUI

struct SelectorCellView: View {
    @State var selection: Int
    let item: SampleData
    @State private var showingAlert: Bool = false
   
    init(item: SampleData) {
        self.item = item
        self.selection = item.data.selectedId ?? 1
    }
    
    
    var body: some View {
        Picker(selection: $selection, label: Text(item.name)) {
            ForEach(item.data.variants!, id: \.id) {
                Text($0.text)
            }
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(
                title: Text(item.name),
                message: Text("Variant ID: \(selection.description)"),
                dismissButton: .default(Text("Ok"))
            )
        })
        .onTapGesture {
            self.showingAlert = true
        }
    }
}
