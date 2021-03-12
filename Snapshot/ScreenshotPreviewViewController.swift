import UIKit

final class ScreenshotPreviewViewController: UIViewController {
    class func make(image: UIImage) -> ScreenshotPreviewViewController {
        let vc = UIStoryboard(name: String(describing: ScreenshotPreviewViewController.self), bundle: nil).instantiateInitialViewController() as! ScreenshotPreviewViewController
        vc.image = image
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = image
        self.titleLabel.text = "w: " + image.size.width.description + " h: " + image.size.height.description
    }
    private var image: UIImage!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
}
