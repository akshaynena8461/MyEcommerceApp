
import UIKit
import WebKit

class AboutViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var animate: UIActivityIndicatorView!
    
    var objPageType: PageType = .AboutUs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        var urlString = ""
        
        switch objPageType {
        case .AboutUs:
            urlString = "https://corporate.flipkart.net/about-us"
            self.title = "About Us"
            
        case .PrivacyPolicy:
            urlString = "https://www.flipkart.com/pages/privacypolicy"
            self.title = "Privacy Policy"
            
        case .TermsAndConditions:
            urlString = "https://www.flipkart.com/pages/terms"
            self.title = "Terms and Conditions"
            
        default:
            break
        }
     
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        animate.startAnimating()
        animate.isHidden = false
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        animate.stopAnimating()
        animate.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        animate.stopAnimating()
        animate.isHidden = true
        print("Failed to load: \(error.localizedDescription)")
    }
}


