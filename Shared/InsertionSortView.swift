//
//  InsertionSortView.swift
//  Sorting Algorithms
//
//  Created by Joshua Levine on 11/30/21.
//

import SwiftUI

struct InsertionSortView: View {
    @State var items: [Int] = Array(1...10).shuffled()

    @State var isSorting: Bool = false
    @State var isSorted: Bool = false
    
    var body: some View {
        ItemView(items: $items, isSorting: $isSorting, isSorted: $isSorted) {
            sort()
        }
        .navigationTitle("Insertion Sort")
    }
    
    func sort() {
        guard items.count > 1 else { return }
        Task {
            for i in 0..<items.count {
                for j in 0...i {
                    if items[i - j] < items[i] {
                        withAnimation(.standard) {
                            items.move(fromOffsets: .init(integer: i), toOffset: i - j + 1)
                        }
                        try? await Task.defaultPause()
                        break
                    } else if j == i {
                        withAnimation(.standard) {
                            items.move(fromOffsets: .init(integer: i), toOffset: 0)
                        }
                    }
                    try? await Task.defaultPause()
                }
                try? await Task.defaultPause()
            }
            withAnimation(.standard) {
                isSorted = true
                isSorting = false
            }
        }
    }
}

struct InsertionSortView_Previews: PreviewProvider {
    static var previews: some View {
        InsertionSortView()
    }
}
