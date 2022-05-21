//
//  LoginWebView.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/21.
//

import Foundation
import SwiftUI
import WebKit


//MARK: - SNS Login을 위한 웹뷰
struct LoginWebView: UIViewRepresentable{
    @Environment(\.presentationMode) fileprivate var presentationMode
    
    private let urlToLoad: URL
    
    init?(urlToLoad: String){
        guard let url = URL(string: urlToLoad) else{
            return nil
        }
       
        self.urlToLoad = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        webView.navigationDelegate = context.coordinator as! WKNavigationDelegate
        webView.load(URLRequest(url: urlToLoad))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return LoginWebView.Coordinator(self)
    }
    
    final class Coordinator: NSObject{
        private let webView: LoginWebView
        init(_ webView: LoginWebView){
            self.webView = webView
        }
    }
}

//MARK: - WKNavigationDelegate
extension LoginWebView.Coordinator: WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url?.absoluteString{
            if url.contains("jwt"){//url에 query로 Jwt가 있다면
                decisionHandler(.cancel)//요청을 중지하고
        
                let queryStartIndex = url.index(after: url.firstIndex(of: "?")!)
                let queryString = url[queryStartIndex...]
                let queries = queryString.split(separator: "&")
                let jwtQuery = queries[0]
                
                let jwtStartIndex = jwtQuery.index(after: jwtQuery.firstIndex(of: "=")!)
                let jwt = jwtQuery[jwtStartIndex...]
                UserDefaults.standard.setValue(jwt, forKey: "token")//토큰을 저장
                self.webView.presentationMode.wrappedValue.dismiss()
            }
            else{
                decisionHandler(.allow)
            }
        }
        else{
            decisionHandler(.cancel)
            self.webView.presentationMode.wrappedValue.dismiss()
        }
    }
}
