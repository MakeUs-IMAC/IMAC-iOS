//
//  TabViewUIRepresentable.swift
//  iMAC-Torip
//
//  Created by 유호준 on 2022/05/21.
//

import Foundation
import SwiftUI
struct TabBarViewUIRepresentable: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> some UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController

    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }

}
