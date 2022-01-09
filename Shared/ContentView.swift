//
//  ContentView.swift
//  Shared
//
//  Created by Joshua Levine on 11/29/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    AlgorithmLink(title: "Bubble Sort", destination: BubbleSortView())
                    AlgorithmLink(title: "Insertion Sort", destination: InsertionSortView())
                    AlgorithmLink(title: "Selection Sort", destination: SelectionSortView())
                    AlgorithmLink(title: "Quick Sort", destination: QuickSortView())
                    AlgorithmLink(title: "Merge Sort", destination: MergeSort())
                    AlgorithmLink(title: "Radix Sort", destination: RadixSortView())
                }
                .padding()
            }
            .navigationTitle("Sorting Algorithms")
        }
    }
}

struct AlgorithmLink<Content: View>: View {
    var title: String
    var destination: Content
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(title).font(.title)
                Spacer()
            }
            .padding()
            .background(.regularMaterial)
            .cornerRadius(8)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
