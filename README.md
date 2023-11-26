# EDCarouselSPM

**`EDCarousel`** is a [`Custom collection view Layout`](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout) library for overlapping style carousel collection view flow layout.

## Features
* Animate cell scale while scrolling
* Easy to integrate and use
* Easy Customizeable
* Page control 

## Installation

The [Swift Package Manager](https://www.swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

```swift
dependencies: [
    .package(url: "https://github.com/emrdgrmnci/EDCarouselSPM.git", .upToNextMajor(from: "0.0.2"))
]
```

To install using Cocoapods, clone this repo and go to Example directory then run the following command:

```swift
pod install
```

## Example - UIKit

https://github.com/emrdgrmnci/Example-UIKit

![Visual](https://github.com/emrdgrmnci/EDCarousel/blob/main/visual.gif "")

## Usage
#### via Interface Builder

Set the UICollectionView layout class to CarouselFlowLayout as given below.

![Alt text](https://github.com/emrdgrmnci/EDCarousel/blob/main/usage.png "step-1")

#### Detect current indexPath or page while scrolling

* After scrolling end with left or right then you can use the scrollViewWillEndDragging delegate method. This method called when scroll view grinds to a halt.
```
func scrollViewWillEndDragging(
        _: UIScrollView,
        withVelocity _: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let targetOffset = targetContentOffset.pointee.x
        let width = (collectionView.frame.size.width - padding) / 1.21
        let rounded = Double((images.count / 2)) * abs(targetOffset / width)
        let scale = round(rounded)
        pageControl.currentPage = Int(scale)
        updateButtonStates(with: pageControl.currentPage)
        updateUI(with: pageControl.currentPage)
    }
```

* Updates the button and page control states.
```
//
@IBAction
    func didTapOnPreviousButton(_: Any) {
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControl.currentPage = prevIndex
        collectionView?.isPagingEnabled = false
        collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
        updateButtonStates(with: pageControl.currentPage)
        updateUI(with: pageControl.currentPage)
    }

    @IBAction
    func didTapOnNextButton(_: Any) {
        let nextIndex = min(pageControl.currentPage + 1, images.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.isPagingEnabled = false
        collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
        updateButtonStates(with: pageControl.currentPage)
        updateUI(with: pageControl.currentPage)
    }

    private func updateUI(with currentPage: Int) {
        pageControl.currentPage = currentPage
        pageControl.indicatorImage(forPage: pageControl.currentPage)
        previousButton.isHidden = currentPage == 0
        nextButton.isHidden = currentPage == images.count - 1
        if currentPage == images.count - 1 {
            nextButton.isHidden = false
            nextButton.setImage(UIImage(), for: .normal)
        } else {
            nextButton.setImage(UIImage("image"), for: .normal)
        }
    }

    private func updateButtonStates(with currentPage: Int) {
        pageControl.currentPage = currentPage
        previousButton.isEnabled = currentPage > 0
        nextButton.isEnabled = currentPage < images.count
    }

```

#### Scroll to specifc index
`scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)` method use to scroll specific index. 

```
collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
```

## Example - SwiftUI

## Usage
#### via SwiftUI

* A custom UICollectionViewFlowLayout to create a carousel effect

```swift
struct CarouselView: UIViewRepresentable {    
 var data: [String] // Your data model
...

```

* This method creates and configures a `UICollectionView` instance with a custom `CarouselFlowLayout`.
* It sets the collection view's delegate and data source to the `context.coordinator`.

```swift
func makeUIView(context: Context) -> UICollectionView {
        let layout = CarouselFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200) // Change item size as per your requirement
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = context.coordinator
        collectionView.dataSource = context.coordinator
        return collectionView
}
```

* SwiftUI calls this method when it wants your `UIViewRepresentable` type
* to synchronize its state with its underlying `UIView`. You can use this method
* to update any parameters that you need to change on the underlying `UICollectionView`.

```swift
func updateUIView(_ uiView: UICollectionView, context: Context) {
        // Here you can update your UICollectionView
}
```

* Creates a `Coordinator` instance to coordinate with the `UICollectionView`.

```swift
func makeCoordinator() -> Coordinator {
        Coordinator(self)
}
```

* The `Coordinator` class provides information about the number of items and configures cells for the `UICollectionView`.

```swift
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
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return parent.data.count
        }
        
        /// Asks your data source object for the cell that corresponds to the specified item in the collection view.
        /// This method is part of the `UICollectionViewDataSource` protocol that this class implements.
        /// It dequeues a reusable cell from the pool and configures it with data corresponding to the current index path.
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            // Configure your cell
            return cell
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
```

## Contributing

Feel free to open an issue if you have questions about how to use `EDCarousel`, discovered a bug, or want to improve the implementation or interface.

## Credits

`EDCarousel` is primarily the work of [Emre Degirmenci](https://github.com/emrdgrmnci).
