//
//  SelectionSortView.swift
//  Sorting Algorithms
//
//  Created by Joshua Levine on 11/30/21.
//

import SwiftUI

struct SelectionSortView: View {
    @State var items: [Int] = Array(1...10).shuffled()

    @State var isSorting: Bool = false
    @State var isSorted: Bool = false
    
    var body: some View {
        ItemView(items: $items, isSorting: $isSorting, isSorted: $isSorted) {
            sort()
        }
        .navigationTitle("Selection Sort")
    }
    
    func sort() {
        guard items.count > 1 else { return }
        Task {
            for i in 0..<items.count {
                var minIndex = i
                for j in i..<items.count {
                    if items[j] < items[minIndex] {
                        minIndex = j
                    }
                    try? await Task.defaultPause()
                }
                if minIndex != i {
                    withAnimation(.standard) {
                        items.swapAt(i, minIndex)
                    }
                }
                try? await Task.defaultPause()
            }
            withAnimation {
                isSorted = true
                isSorting = false
            }
        }
    }
}

struct SelectionSortView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionSortView()
    }
}
