//
//  SnsLogin.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/22.
//

import Foundation
enum SnsLogin{
    case kakao
    case naver
    case google
    
    var url: URL{
        switch self {
        case .kakao:
            return URL(string: "http://jinbeom.shop/oauth2/authorization/kakao")!
        case .naver:
            return URL(string: "http://jinbeom.shop/oauth2/authorization/naver")!
        case .google:
            return URL(string: "http://jinbeom.shop/oauth2/authorization/google")!
        }
    }
}
