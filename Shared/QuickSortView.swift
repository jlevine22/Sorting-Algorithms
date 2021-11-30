//
//  QuickSortView.swift
//  Sorting Algorithms
//
//  Created by Joshua Levine on 11/30/21.
//

import SwiftUI

struct QuickSortView: View {
    @State var items: [Int] = Array(1...10).shuffled()

    @State var isSorting: Bool = false
    @State var isSorted: Bool = false
    
    @State var primaryHighlight: Int?
    @State var secondaryHighlight: Int?
    
    var body: some View {
        ItemView(items: $items, isSorting: $isSorting, isSorted: $isSorted, primaryHighlight: primaryHighlight, secondaryHighlight: secondaryHighlight) {
            sort()
        }
        .navigationTitle("Quick Sort")
    }
    
    func sort() {
        Task {
            await quickSort(left: 0, right: items.count - 1)
            withAnimation {
                isSorted = true
                isSorting = false
            }
        }
    }
    
    func partition(start: Int, end: Int) async -> Int {
        let pivot = items[start]
        var swapIndex = start
        for i in start+1...end {
            if items[i] < pivot {
                swapIndex += 1
                if i != swapIndex {
                    withAnimation {
                        items.swapAt(i, swapIndex)
                    }
                    try? await Task.sleep(seconds: 0.5)
                }
            }
        }
        withAnimation {
            items.swapAt(swapIndex, start)
        }
        try? await Task.sleep(seconds: 0.5)
        return swapIndex
    }
    
    func quickSort(left: Int, right: Int) async {
        if left < right {
            let pivotIndex = await partition(start: left, end: right)
            
            await quickSort(left: left, right: pivotIndex - 1)
            await quickSort(left: pivotIndex + 1, right: right)
        }
    }
}

struct QuickSortView_Previews: PreviewProvider {
    static var previews: some View {
        QuickSortView()
    }
}
