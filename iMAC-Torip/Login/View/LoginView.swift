//
//  LoginView.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/21.
//

import SwiftUI

struct LoginView: View {
    @State private var shouldShowTabBarView = false
    @State private var shouldShowKakaoLoginView = false
    @State private var shouldShowNaverLoginView = false
    @State private var shouldShowGoogleLoginView = false
    
    var body: some View {
        VStack{
            Spacer()
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            HStack{
                Spacer()
                Circle()
                    .foregroundColor(Color(#colorLiteral(red: 0.9983025193, green: 0.9065476656, blue: 0, alpha: 1)))
                    .frame(width: 100, height: 100)
                    .overlay(Image("kakaoLogo")
                                .resizable()
                                .frame(width:70, height: 70))
                    .onTapGesture {
                        shouldShowKakaoLoginView = true
                    }
                Spacer()
                Circle().frame(width: 100, height: 100)
                    .overlay(Image("naverLogo")
                                .resizable())
                    .onTapGesture {
                        shouldShowNaverLoginView = true
                    }
                Spacer()
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)
                    .overlay(Image("googleLogo").resizable()
                                .frame(width: 50, height: 50)
                    )
                    .onTapGesture {
                        shouldShowGoogleLoginView = true
                    }

                Spacer()
            }
            Spacer()
        }
        .frame(maxHeight:.infinity)
        .background(Color.appColor.ignoresSafeArea())
        .fullScreenCover(isPresented: $shouldShowTabBarView){
            TabBarViewUIRepresentable()
        }.fullScreenCover(isPresented: $shouldShowKakaoLoginView){
            checkShouldShowTabBar()
        }content:{
            LoginWebView(.kakao)
        }
        .fullScreenCover(isPresented: $shouldShowNaverLoginView){
            checkShouldShowTabBar()
        }content:{
            LoginWebView(.naver)
        }
        .fullScreenCover(isPresented: $shouldShowGoogleLoginView){
            checkShouldShowTabBar()
        }content:{
            LoginWebView(.google)
        }
        .onAppear{
            checkShouldShowTabBar()
        }

        
    }
    
    
    private func checkShouldShowTabBar(){
        if let _ = UserDefaults.standard.string(forKey: "token"){
            shouldShowTabBarView = true
            return
        }
        
        shouldShowTabBarView = false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
