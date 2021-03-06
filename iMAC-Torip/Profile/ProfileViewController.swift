//
//  ProfileViewController.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/21.
//

import SwiftUI

class ProfileViewController: UIViewController {
    private let viewModel = ProfileViewModel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel.checkPresenceOfProfile()
    }
    
    @IBSegueAction func addSwiftUiView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ProfileListMenuView().environmentObject(viewModel))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
