//
//  LoginView.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var profileViewModel: ProfileViewModel
    
    @State private var shouldShowNextView = false
    @State private var shouldShowKakaoLoginView = false
    @State private var shouldShowNaverLoginView = false
    @State private var shouldShowGoogleLoginView = false
    
    @State private var nextView: NextView = .profileForm
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
        .fullScreenCover(isPresented: $shouldShowNextView){
            switch nextView {
            case .tabBar:
                TabBarViewUIRepresentable()
            case .profileForm:
                ProfileFormView()
            }
        }.fullScreenCover(isPresented: $shouldShowKakaoLoginView){
            decideNextView()
        }content:{
            LoginWebView(.kakao)
        }
        .fullScreenCover(isPresented: $shouldShowNaverLoginView){
            decideNextView()
        }content:{
            LoginWebView(.naver)
        }
        .fullScreenCover(isPresented: $shouldShowGoogleLoginView){
            decideNextView()
        }content:{
            LoginWebView(.google)
        }
        .onAppear{
            decideNextView()
        }

        
    }
    
    private enum NextView{
        case tabBar
        case profileForm
    }
    
    private func decideNextView(){
        if let _ = UserDefaults.standard.string(forKey: "token"){
            profileViewModel.checkPresenceOfProfile{result, error in
                if error == nil{
                    if result{
                        self.nextView = .tabBar
                    }
                    else{
                        self.nextView = .profileForm
                    }
                    
                    self.shouldShowNextView = true
                }
                else{

                }
            }
            return
        }
        
        shouldShowNextView = false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
