
import UIKit
import WebKit

class TermsAndConditionViewController: UIViewController {

    @IBOutlet weak var webViewTermsAndCondition: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "Terms & Conditioin"
        
        let url = "https://www.amazon.in/gp/help/customer/display.html?nodeId=GLSBYFE9MGKKQXXM"
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webViewTermsAndCondition.load(request)
        }
        
        
    }

}
