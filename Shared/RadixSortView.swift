//
//  RadixSortView.swift
//  Sorting Algorithms
//
//  Created by Joshua Levine on 1/8/22.
//

import SwiftUI

struct RadixSortView: View {
    static var KeyLength = 3
    
    @State var items: [String] = ["xyz", "abc", "tvd", "tqn", "xsg", "hwg", "opn", "onq", "nwz", "ahu"].shuffled()
    
    @State var sorted = false
    
    var body: some View {
        VStack {
            ForEach(items, id: \.self) { item in
                Capsule()
                    .fill(.gray)
                    .overlay(Text(item).bold())
            }
            if sorted {
                Button("Again") {
                    sorted = false
                    items = items.shuffled()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        radixSort()
                    }
                }
                .font(.system(size: 32).bold())
            }
        }
        .padding()
        .navigationTitle("Radix Sort")
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                radixSort()
            }
        }
    }
    
    func radixSort() {
        Task {
            let keyLength = Self.KeyLength
            for keyIndex in 0..<keyLength {
                var buckets: [String: [String]] = [:]
                for string in items {
                    let reverseIndex = keyLength - 1 - keyIndex
                    let key = reverseIndex < string.count ? String(string[reverseIndex]) : ""
                    if buckets[key] == nil {
                        buckets[key] = []
                    }
                    buckets[key]?.append(string)
                    try? await Task.defaultPause()
                }
                withAnimation(.standard) {
                    items = buckets.keys.sorted().flatMap { buckets[$0]! }
                }
                try? await Task.defaultPause()
            }
            withAnimation {
                sorted = true
            }
        }
    }
}

extension String {
    subscript(offset: Int) -> Character {
        return self[index(startIndex, offsetBy: offset)]
    }
}

struct RadixSortView_Previews: PreviewProvider {
    static var previews: some View {
        RadixSortView()
    }
}
