//
//  LoginHostingVIewController.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/21.
//

import Foundation
import SwiftUI

//MARK: - LoginView를 호스팅 하기 위한 클래스
final class LoginViewController:UIViewController{
    @IBSegueAction func addSwiftUIVIew(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: LoginView())
    }
}
