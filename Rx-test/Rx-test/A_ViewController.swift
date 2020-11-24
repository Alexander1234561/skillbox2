//
//  A_ViewController.swift
//  Rx-test
//
//  Created by Александр on 10.11.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit
import Bond

class A_ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var signalButton: UIButton!
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        self.alertLabel.text = ""
        
        self.signalButton.isHidden = true
        
        loginTextField.reactive.text
            .ignoreNil()
            .with(latestFrom: passwordTextField.reactive.text)
            .map{ [weak self] in
                    if !$0.0.contains("@") { self?.signalButton.isHidden = true; return "Некорректная почта" }
                    else if ($0.1!.count < 6) {self?.signalButton.isHidden = true; return "Слишком короткий пароль" }
                    else { self?.signalButton.isHidden = false; return "" }
                }
            .bind(to: alertLabel.reactive.text)
        
        passwordTextField.reactive.text
            .ignoreNil()
            .with(latestFrom: loginTextField.reactive.text)
            .map{ [weak self] in
                    if !$0.1!.contains("@") { self?.signalButton.isHidden = true; return "Некорректная почта" }
                    else if ($0.0.count < 6) {self?.signalButton.isHidden = true; return "Слишком короткий пароль" }
                    else { self?.signalButton.isHidden = false; return "" }
                }
            .bind(to: alertLabel.reactive.text)
        
    }
    @IBAction func signalAction(_ sender: UIButton) {
        print("Одобрено")
    }
}
