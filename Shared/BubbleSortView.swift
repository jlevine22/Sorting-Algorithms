//
//  BubbleSortVIEW.swift
//  Sorting Algorithms
//
//  Created by Joshua Levine on 11/30/21.
//

import SwiftUI

struct BubbleSortView: View {
    @State var items: [Int] = Array(1...10).shuffled()

    @State var isSorting: Bool = false
    @State var isSorted: Bool = false

    var body: some View {
        ItemView(items: $items, isSorting: $isSorting, isSorted: $isSorted) {
            bubbleSort()
        }
        .navigationTitle("Bubble Sort")
    }
    
    func bubbleSort() {
        Task {
            for i in 0..<items.count {
                for j in 0..<items.count - i - 1 {
                    if items[j+1] < items[j] {
                        withAnimation {
                            items.swapAt(j, j+1)
                        }
                        try? await Task.sleep(seconds: 0.5)
                    }
                }
            }
            withAnimation {
                isSorted = true
                isSorting = false
            }
        }
    }
}

struct BubbleSortView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleSortView()
    }
}
