//
//  MergeSort.swift
//  Sorting Algorithms
//
//  Created by Joshua Levine on 11/30/21.
//

import SwiftUI

struct MergeSort: View {
    @State var items: [Int] = Array(1...10).shuffled()

    @State var isSorting: Bool = false
    @State var isSorted: Bool = false
    
    var body: some View {
        ItemView(items: $items, isSorting: $isSorting, isSorted: $isSorted) {
            sort()
        }
        .navigationTitle("Merge Sort")
    }
    
    func sort() {
        guard items.count > 1 else { return }
        Task {
            await mergeSort(range: 0..<items.count)
            
            withAnimation {
                isSorted = true
                isSorting = false
            }
        }
    }
    
    func merge(_ left: Range<Int>, with right: Range<Int>) async {
        guard var i = left.first else { return }
        guard var j = right.first else { return }
        
        var leftEnd = i + left.count
        let rightEnd = j + right.count
        
        guard var start = left.first else { return }
        
        while i < leftEnd, j < rightEnd {
            if items[i] < items[j] {
                i += 1
            } else {
                if j != start {
                    withAnimation {
                        items.move(fromOffsets: .init(integer: j), toOffset: start)
                    }
                    try? await Task.sleep(seconds: 0.5)
                }
                leftEnd += 1
                i += 1
                j += 1
            }
            start += 1
        }
        
        while i < leftEnd {
            if i != start {
                withAnimation {
                    items.move(fromOffsets: .init(integer: i), toOffset: start)
                }
                try? await Task.sleep(seconds: 0.5)
            }
            i += 1
            start += 1
        }
        while j < rightEnd {
            if j != start {
                withAnimation {
                    items.move(fromOffsets: .init(integer: j), toOffset: start)
                }
                try? await Task.sleep(seconds: 0.5)
            }
            j += 1
            start += 1
        }
    }
    
    func mergeSort(range: Range<Int>) async {
        guard range.count > 1 else { return }
        
        let splitPoint = range.first! + (range.count / 2)
        
        let left: Range<Int> = range.first!..<splitPoint
        let right: Range<Int> = splitPoint..<range.last!+1
        await mergeSort(range: left)
        await mergeSort(range: right)
        
        await merge(left, with: right)
    }
}

struct MergeSort_Previews: PreviewProvider {
    static var previews: some View {
        MergeSort()
    }
}
