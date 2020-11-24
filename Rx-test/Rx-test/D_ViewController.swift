//
//  D_ViewController.swift
//  Rx-test
//
//  Created by Александр on 24.11.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit
import Bond

class D_ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var counter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       counter.reactive
            .tap
            .map{ String(Int(self.label.text!)! + 1) }
            .bind(to: label.reactive.text)
    }
}
