import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            CharacterListView(viewModel: DefaultCharacterListViewModel())
        }
    }
}

#Preview {
    ContentView()
}
