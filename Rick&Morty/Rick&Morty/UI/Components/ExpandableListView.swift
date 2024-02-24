import SwiftUI

// MARK: - ExpandableListView

struct ExpandableListView<Item, Content>: View where Item: Identifiable, Content: View {
    let items: [Item]
    let visible: Int
    let content: (Item) -> Content

    @State var isExpanded = false

    init(items: [Item], visible: Int = 3, @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.visible = visible
        self.content = content
    }

    var visibleItems: [Item] {
        guard canExpand else { return items }
        return Array(items[0..<visible])
    }

    var body: some View {
        List {
            ForEach(isExpanded ? items : visibleItems) { item in
                content(item)
            }

            if canExpand {
                Button(
                    action: {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    },
                    label: {
                        Text(buttonText)
                            .font(.headline)
                    }
                )
            }
        }
    }

    // MARK: Private

    private var buttonText: String {
        if isExpanded {
            return "Show less"
        }

        return "Show all"
    }

    private var canExpand: Bool {
        visible < items.count
    }
}

// MARK: Preview

#Preview {
    ExpandableListView(items: (0..<10).map { Sample(value: "\($0)") }) { item in
        Text(item.value)
    }
}

private struct Sample: Identifiable {
    let value: String

    var id: String { value }
}
