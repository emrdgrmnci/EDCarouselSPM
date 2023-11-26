//
//  CarouselView.swift
//
//
//  Created by Emre on 26.11.2023.
//

import SwiftUI
import UIKit
import EDCarouselSPM

/// A custom UICollectionViewFlowLayout to create a carousel effect
struct CarouselView: UIViewRepresentable {
    
    var data: [String] // Your data model
    
    /// Creates a `UICollectionView` instance for use in SwiftUI's `UIViewRepresentable` protocol.
    ///
    /// This method creates and configures a `UICollectionView` instance with a custom `CarouselFlowLayout`.
    /// It sets the collection view's delegate and data source to the `context.coordinator`.
    ///
    /// - Parameter context: A context structure that contains information about the current state of the system.
    ///
    /// - Returns: A configured `UICollectionView` instance.
    func makeUIView(context: Context) -> UICollectionView {
        let layout = CarouselFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200) // Change item size as per your requirement
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = context.coordinator
        collectionView.dataSource = context.coordinator
        return collectionView
    }
    
    /// Updates the state of the specified `UICollectionView`.
    ///
    /// SwiftUI calls this method when it wants your `UIViewRepresentable` type
    /// to synchronize its state with its underlying `UIView`. You can use this method
    /// to update any parameters that you need to change on the underlying `UICollectionView`.
    ///
    /// - Parameters:
    ///   - uiView: The `UICollectionView` that you want to update.
    ///   - context: A context structure that contains information about the current state of the system.
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        // Here you can update your UICollectionView
    }
    
    /// Creates a `Coordinator` instance to coordinate with the `UICollectionView`.
    /// - Returns: Current page
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
     
    /// The `Coordinator` class provides information about the number of items and configures cells for the `UICollectionView`.
    class Coordinator: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
        var parent: CarouselView
        
        /// Creates a new coordinator instance for the given `CarouselView`.
        init(_ carouselView: CarouselView) {
            self.parent = carouselView
        }
        
        /// Asks your data source object for the number of items in the specified section.
        ///
        /// This method is part of the `UICollectionViewDataSource` protocol that this class implements.
        /// It returns the number of items in the section of the collection view which is equal to the count of data in the parent `CarouselView`.
        ///
        /// - Parameters:
        ///   - collectionView: The collection view requesting this information.
        ///   - section: An index number identifying a section in `collectionView`. This index value is 0-based.
        ///
        /// - Returns: The number of items in `section`.
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return parent.data.count
        }
        
        /// Asks your data source object for the cell that corresponds to the specified item in the collection view.
        ///
        /// This method is part of the `UICollectionViewDataSource` protocol that this class implements.
        /// It dequeues a reusable cell from the pool and configures it with data corresponding to the current index path.
        ///
        /// - Parameters:
        ///   - collectionView: The collection view requesting this information.
        ///   - indexPath: The index path that specifies the location of the item.
        ///
        /// - Returns: A configured cell object. You must not return `nil` from this method.
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            // Configure your cell
            return cell
        }
    }
}

struct ContentView: View {
    var body: some View {
        CarouselView(data: ["Item 1", "Item 2", "Item 3"]) // Your data
            .onPageChanged { page in
                print("Current page: \(page)")
            }
    }
}
