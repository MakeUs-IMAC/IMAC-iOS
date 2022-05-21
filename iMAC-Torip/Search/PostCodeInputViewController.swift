//
//  PostCodeInputViewController.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/21.
//

import UIKit
import WebKit

class PostCodeInputViewController: UIViewController {
    @IBOutlet weak var postCodeView: WKWebView!
    let indicator = UIActivityIndicatorView(style: .medium)
    var address = ""
    var addressData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://makeus-imac.github.io/IMAC-postCode/"),
            let webView = postCodeView
            else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        webView.addSubview(indicator)
        webView.configuration.userContentController.add(self, name: "callBackHandler")
        webView.navigationDelegate = self
    }


}

extension PostCodeInputViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            //유저가 주소 검색하고 선택시 데이터 받아오기
            if let data = message.body as? [String: Any] {
                addressData = data["roadAddress"] as? String ?? ""
                print("addressData \(addressData)")
            }
        }
}


extension PostCodeInputViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}
