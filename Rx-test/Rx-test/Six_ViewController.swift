//
//  Six_ViewController.swift
//  Rx-test
//
//  Created by Александр on 24.11.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit


class Six_ViewController: UIViewController {

    @IBOutlet weak var Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Примеры утечек памяти
        // Они не очищаются так как замыкание
        
        Button.reactive.tap.observeNext{
            self.something()
        }
    }
    
    func something() {
        print("Something")
    }

}
