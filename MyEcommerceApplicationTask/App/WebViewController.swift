//
//  WebViewController.swift
//  MyEcommerceApplicationTask
//
//  Created by Akshay Nena on 24/07/25.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var animate: UIActivityIndicatorView!
    @IBOutlet weak var webview: WKWebView!
    
    
    var objPageType: PageType = .AboutUs
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        webview.navigationDelegate = self

        var urlString = ""

                if objPageType == .AboutUs {
        
                    urlString =
                        "https://www.aboutamazon.com/about-us"
                    self.title = "About Us"
                }
                else if objPageType == .PrivacyPolicy {
        
                    urlString =
                        "https://www.amazon.com/gp/help/customer/display.html?nodeId=G5P4WEC4RW345KS3"
                    self.title = "Privacy Policy"
                }
                else if objPageType == .TermsAndConditions {
                    urlString =
                        "https://www.amazon.com/gp/help/customer/display.html?nodeId=GX7NJQ4ZB8MHFRNJ"
                    self.title = "Terms and Conditions"
                }
                
                if let url = URL(string: urlString) {
                           let request = URLRequest(url: url)
                    webview.load(request)
                       }
    }
    }
    


extension WebViewController:WKNavigationDelegate {
    

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
