//
//  SnsLogin.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/22.
//

import Foundation

//MARK: - SNS Login 관련
enum SnsLogin{
    case kakao
    case google
    case naver
    
    var url: String{
        switch self {
        case .kakao:
            return "http://jinbeom.shop/oauth2/authorization/kakao"
        case .google:
            return "http://jinbeom.shop/oauth2/authorization/google"
        case .naver:
            return "http://jinbeom.shop/oauth2/authorization/naver"
        }
    }
}
