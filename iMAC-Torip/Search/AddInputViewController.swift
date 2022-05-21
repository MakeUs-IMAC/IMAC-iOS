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
    
    private func bindViewModel(){
        doneButton.rx.tap
            .subscribe(onNext: { _ in
                //to do data 전달
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
}

extension AddInputViewController {
    
}
