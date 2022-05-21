//
//  LoginView.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/21.
//

import SwiftUI

struct LoginView: View {
    @State private var shouldShowTabView = false
    @State private var shouldShowKakaoLoginView = false
    @State private var shouldShowGoogleLoginView = false
    @State private var shouldShowNaverLoginView = false
    
    var body: some View {
        VStack{
            Spacer()
            Image("logo").resizable().aspectRatio(contentMode: .fit)
            Spacer()
            HStack{
                //MARK: - SNS Login Button
                Circle()
                    .foregroundColor(Color(red: 250, green: 225, blue: 0, opacity: 1))
                    .frame(width:100, height: 100).overlay(Image("kakaoLogo").resizable().frame(width:70,height:70))
                    .onTapGesture {
                        shouldShowKakaoLoginView = true
                    }
                Spacer()
                Circle().frame(width:100, height: 100)
                    .overlay(Image("naverLogo").resizable())
                    .onTapGesture {
                        shouldShowNaverLoginView = true
                    }
                Spacer()
                Circle().frame(width:100, height: 100)
                    .foregroundColor(.white)
                    .overlay(Image("googleLogo")
                                .resizable()
                                .frame(width:50,height: 50))
                    .onTapGesture {
                        shouldShowGoogleLoginView = true
                    }
            }.padding(.horizontal, 30)
            Spacer()
        }.frame(maxWidth:.infinity, maxHeight: .infinity).background(Color.appColor.ignoresSafeArea())
            .fullScreenCover(isPresented: $shouldShowTabView){
                TabBarViewUIRepresentable()
            }
            //MARK: - SNS Login View
            .fullScreenCover(isPresented: $shouldShowKakaoLoginView){//kakao
                if checkPresenceOfToken(){
                    shouldShowTabView = true
                }
            }content: {
                LoginWebView(urlToLoad: SnsLogin.kakao.url)
            }.fullScreenCover(isPresented: $shouldShowGoogleLoginView){//google
                if checkPresenceOfToken(){
                    shouldShowTabView = true
                }
            }content: {
                LoginWebView(urlToLoad: SnsLogin.google.url)
            }.fullScreenCover(isPresented: $shouldShowNaverLoginView){//naver
                if checkPresenceOfToken(){
                    shouldShowTabView = true
                }
            }content: {
                LoginWebView(urlToLoad: SnsLogin.naver.url)
            }
            .onAppear{
                if checkPresenceOfToken(){
                    shouldShowTabView = true
                }
            }
    }
    
    //MARK: - 토큰 존재 유무 확인
    private func checkPresenceOfToken() -> Bool{
        if let _ = UserDefaults.standard.string(forKey: "token"){
            return true
        }
        
        return false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
