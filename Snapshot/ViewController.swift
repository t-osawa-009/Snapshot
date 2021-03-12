import UIKit

final class ViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        array = (0...Int.random(in: 50...100)).map({ _ in UIColor.randomColor })
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        
        let image = UIImage(view: cell)
        let vc = ScreenshotPreviewViewController.make(image: image)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = array[indexPath.item]
        return cell
    }
    
    private var array: [UIColor] = []
}

extension UIColor {
    static var randomColor: UIColor {
        let r = CGFloat.random(in: 0 ... 255) / 255.0
        let g = CGFloat.random(in: 0 ... 255) / 255.0
        let b = CGFloat.random(in: 0 ... 255) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

extension UIImage {
    
    convenience init(view: UIView) {
        let image = UIGraphicsImageRenderer(bounds: view.bounds).image { context in
            view.layer.render(in: context.cgContext)
        }
        
        guard let cgImage = image.cgImage else {
            self.init()
            return
        }
        
        self.init(cgImage: cgImage)
    }
    
    convenience init(scrollView: UIScrollView) {
        let savedFrame = scrollView.frame
        let savedContentOffset = scrollView.contentOffset
        let savedHorizontalScroll = scrollView.showsHorizontalScrollIndicator
        let savedVerticalScroll = scrollView.showsVerticalScrollIndicator
        
        defer {
            scrollView.frame = savedFrame
            scrollView.contentOffset = savedContentOffset
            scrollView.showsHorizontalScrollIndicator = savedHorizontalScroll
            scrollView.showsVerticalScrollIndicator = savedVerticalScroll
        }
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentOffset = .zero
        scrollView.frame = CGRect(origin: .zero, size: scrollView.contentSize)
        
        self.init(view: scrollView)
    }
}
