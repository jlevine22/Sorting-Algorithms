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
    
    @State var primaryHighlight: Int?
    @State var secondaryHighlight: Int?
    
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
                    if items[i] < items[j] {
                        withAnimation {
                            items.move(fromOffsets: .init(integer: i), toOffset: j)
                        }
                        try? await Task.sleep(seconds: 0.5)
                        break;
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

struct InsertionSortView_Previews: PreviewProvider {
    static var previews: some View {
        InsertionSortView()
    }
}
