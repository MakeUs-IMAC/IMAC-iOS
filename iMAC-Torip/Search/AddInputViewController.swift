//
//  AddInputViewController.swift
//  iMAC-Torip
//
//  Created by JoSoJeong on 2022/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class AddInputViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    var addressData = ""
    let disposeBag = DisposeBag()
    var section = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    

    private func setupUI(){
        addressTextField.text = addressData
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func bindViewModel(){
        doneButton.rx.tap
            .subscribe(onNext: { _ in
                let controller = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 3] as! DetailViewController
            
//                controller.item.append((self.section, self.titleTextField.text!, self.addressTextField.text!))
                controller.sectionArray[self.section].append((self.titleTextField.text!, self.addressTextField.text!))
                //print(controller.item)
                self.navigationController?.popToViewController(controller, animated: true)
                
            }).disposed(by: disposeBag)
    }
}

extension AddInputViewController {
    
}
