//
//  LoginHostingVIewController.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/21.
//

import Foundation
import SwiftUI
class LoginViewController:UIViewController{
    @IBSegueAction func addSwiftUiView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: LoginView().environmentObject(ProfileViewModel()))
    }
    
}
