//
//  B_ViewController.swift
//  Rx-test
//
//  Created by Александр on 24.11.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit
import Bond

class B_ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.reactive.text
            .ignoreNil()
            .debounce(interval: 0.5)
            .filter{$0 != ""}
            .map{"Отправка запроса для <\($0)>"}
            .observeNext{ text in print(text) }
    }
}
