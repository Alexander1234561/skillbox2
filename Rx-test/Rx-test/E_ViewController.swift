//
//  E_ViewController.swift
//  Rx-test
//
//  Created by Александр on 24.11.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit
import Bond

class E_ViewController: UIViewController {
    
    @IBOutlet weak var rocketLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rocketLabel.text = ""
        
       firstButton.reactive.tap
            .with(latestFrom: secondButton.reactive.tap)
            .map{ _ in "Ракета запущена" }
            .bind(to: rocketLabel.reactive.text)
        
        secondButton.reactive.tap
            .with(latestFrom: firstButton.reactive.tap)
            .map{ _ in "Ракета запущена" }
            .bind(to: rocketLabel.reactive.text)
    }

}
