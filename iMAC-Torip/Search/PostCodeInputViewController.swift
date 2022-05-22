//
//  PostCodeInputViewController.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/21.
//

import UIKit
import WebKit

class PostCodeInputViewController: UIViewController {
    
    lazy var postCodeView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    let indicator = UIActivityIndicatorView(style: .medium)
    var address = ""
    var addressData = ""
    var section = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://makeus-imac.github.io/IMAC-postCode/")
            else { return }
        let request = URLRequest(url: url)
        postCodeView.load(request)
        postCodeView.addSubview(indicator)
        postCodeView.configuration.userContentController.add(self, name: "callBackHandler")
        postCodeView.navigationDelegate = self
        view.addSubview(postCodeView)
        postCodeView.translatesAutoresizingMaskIntoConstraints = false
        postCodeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        postCodeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        postCodeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        postCodeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }


}

extension PostCodeInputViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            //유저가 주소 검색하고 선택시 데이터 받아오기
            if let data = message.body as? [String: Any] {
                addressData = data["roadAddress"] as? String ?? ""
                print("addressData \(addressData)")
            }
        let vc = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "AddInputViewController") as! AddInputViewController
        vc.addressData = addressData
        vc.section = section
        self.navigationController?.pushViewController(vc, animated: true)
//        let rootView = self.presentingViewController
//        self.dismiss(animated: true, completion: {
//            rootView?.present(vc, animated: true, completion: nil)
//
//        })
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
