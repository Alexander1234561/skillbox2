//
//  C_ViewController.swift
//  Rx-test
//
//  Created by Александр on 24.11.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit
import Bond

func fullNameGenerator() -> String {
    let names = ["Alex", "David", "Joe", "Vadim", "Paul", "Sergei", "Rafael", "Mihail", "Anton", "Vasilii", "Rostislav", "Jurgen", "Dominic", "Stan", "Cosmos", "Avraam", "Jeorge", "Steven", "Kristopher", "Ernest", "Damir", "Ilias", "Nikita", "Leonid", "Teodor", "Ivan", "Kim"]
    let surnames = ["Sergeev", "Tiem", "Nadal", "Djocovic", "Zverev", "Medvedev", "Zidane", "Goffen", "Ilin", "Wawrinka", "Cilic", "Karlovic", "Filinov", "Filatov", "Anderson", "Filatov", "Belii", "Rusevelt", "Messi", "Nobel", "Mcavoe", "Burunov", "Dol"]
    return "\(names[Int.random(in: 0...names.count - 1)]) \(surnames[Int.random(in: 0...surnames.count - 1)])"
}

func tenFullNames() -> [String] {
    var fullNames: [String] = []
    for _ in 0...19 { fullNames.append(fullNameGenerator()) }
    return fullNames
}

class C_ViewController: UIViewController {

    @IBOutlet weak var humanTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var filterTF: UITextField!
    var fullNames =  MutableObservableArray( tenFullNames() )
    var mass: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myBind()
        
        self.mass = self.fullNames.value.collection
        
        filterTF.reactive.text
            .debounce(interval: 2)
            .observeNext{ [weak self] text in
                if (text != "") {
                    var filterMass: [String] = []
                    filterMass = (self?.mass.filter{$0 == text})!
                    self?.fullNames.removeAll()
                    self?.fullNames.insert(contentsOf: filterMass, at: 0)
                }
                else{
                    self?.fullNames.removeAll()
                    self?.fullNames.insert(contentsOf: (self?.mass)!, at: 0)
                }
            }
    }
    
    func myBind() {
        self.fullNames.bind(to: humanTableView) { (dataSource, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Human") as! C_HumanTableViewCell
            cell.nameLabel.text = self.fullNames[indexPath.row]
            return cell
        }
    }
    @IBAction func addAction(_ sender: Any) {
        self.fullNames.insert(fullNameGenerator(), at: 0)
        self.mass.insert(fullNameGenerator(), at: 0)
    }
    @IBAction func deleteAction(_ sender: Any) {
        if fullNames.count != 0 {
            self.fullNames.removeLast()
            self.mass.removeLast()
        }
    }
    
}
