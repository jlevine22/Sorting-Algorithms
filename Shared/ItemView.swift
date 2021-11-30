//
//  ItemView.swift
//  Sorting Algorithms
//
//  Created by Joshua Levine on 11/30/21.
//

import SwiftUI

struct ItemView: View {
    @Binding var items: [Int]
    @Binding var isSorting: Bool
    @Binding var isSorted: Bool
    var primaryHighlight: Int?
    var secondaryHighlight: Int?
    var startSort: () -> Void
    
    func fill(_ item: Int) -> Color {
        if let primaryHighlight = primaryHighlight, items[primaryHighlight] == item {
            return .red
        }
        if let secondaryHighlight = secondaryHighlight, items[secondaryHighlight] == item {
            return .blue
        }
        return .gray
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(items, id: \.self) { item in
                    GeometryReader { reader in
                        let height = reader.size.height * (CGFloat(item) / CGFloat(items.count))
                        Capsule()
                            .fill(fill(item))
                            .frame(height: height)
                            .offset(x: 0, y: (reader.size.height - height)/2)
                    }
                }
            }
            if isSorted {
                Button("Again") {
                    sort()
                }
                .font(.system(size: 32).bold())
            }
        }
        .padding()
        .onAppear {
            sort()
        }
    }
    
    func sort() {
        guard isSorting == false else { return }
        isSorting = true
        if isSorted {
            withAnimation {
                items.shuffle()
                isSorted = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                startSort()
            }
        } else {
            startSort()
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(
            items: .constant([3, 2, 9, 4]),
            isSorting: .constant(false),
            isSorted: .constant(false),
            startSort: {}
        )
    }
}
