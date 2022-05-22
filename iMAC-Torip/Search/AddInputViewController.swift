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
                //to do data 전달
                //let rootView =  self.presentingViewController?.presentingViewController as? DetailViewController
              
                  // rootView!.item.append((self.titleTextField.text!, self.addressTextField.text!))
                self.dismiss(animated: true)
                
            }).disposed(by: disposeBag)
    }
}

extension AddInputViewController {
    
}
