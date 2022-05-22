//
//  LoginWebView.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/21.
//

import Foundation
import SwiftUI
import WebKit
struct LoginWebView: UIViewRepresentable{
    @Environment(\.presentationMode) fileprivate var presentationMode
    private let urlToLoad: URL
    
    init(_ snsLogin: SnsLogin){
        self.urlToLoad = snsLogin.url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: urlToLoad))
        webView.navigationDelegate = context.coordinator
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject{
        private let webView: LoginWebView
        init(_ webView: LoginWebView){
            self.webView = webView
        }
        fileprivate func dismiss(){
            webView.presentationMode.wrappedValue.dismiss()
        }
    }
}
extension LoginWebView.Coordinator: WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let _ = UserDefaults.standard.string(forKey: "token"){
            decisionHandler(.cancel)
            dismiss()
            return
        }
        
        guard let url = navigationAction.request.url?.absoluteString else{
            decisionHandler(.cancel)
            dismiss()
            return
        }
        
        if url.contains("jwt"){
            decisionHandler(.cancel)
            let queryStartIndex = url.index(after: url.firstIndex(of: "?")!)
            let queryString = url[queryStartIndex...]
            let queries = queryString.split(separator: "&")
           
            let jwtQuery = queries[0]
            let idQuery = queries[1]
            let jwt = jwtQuery[url.index(after: jwtQuery.firstIndex(of: "=")!)...]
            let id = idQuery[url.index(after: idQuery.firstIndex(of: "=")!)...]
            UserDefaults.standard.setValue(jwt, forKey: "token")
            UserDefaults.standard.setValue(id, forKey: "id")
            
            dismiss()
            return
        }
        
        decisionHandler(.allow)
    }
}
