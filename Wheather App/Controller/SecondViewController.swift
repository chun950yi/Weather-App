//
//  SecondViewController.swift
//  Wheather App
//
//  Created by 竣亦 on 2022/1/19.
//

import UIKit

protocol delegateProtocol {
    
    func newCityName (city: String)
}

class SecondViewController: UIViewController {
    
    var delegate: delegateProtocol?
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBAction func getCityDetail(_ sender: UIButton) {
        
        if cityTextField.text != "" {
            delegate?.newCityName(city: cityTextField.text!)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func backViewController(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

}
