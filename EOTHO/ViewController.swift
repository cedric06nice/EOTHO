//
//  ViewController.swift
//  EOTHO
//
//  Created by Cedric on 03/08/2020.
//  Copyright © 2020 cedric06nice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var coversTextField: UITextField!
    @IBOutlet weak var coversErrorLabel: UILabel!
    @IBOutlet weak var foodTextField: UITextField!
    @IBOutlet weak var foodErrorLabel: UILabel!
    @IBOutlet weak var discountTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var eothoLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myColor = UIColor.systemGreen
        coversTextField.layer.borderColor = myColor.cgColor
        foodTextField.layer.borderColor = myColor.cgColor
        discountTextField.layer.borderColor = myColor.cgColor

        coversTextField.layer.borderWidth = 2.0
        foodTextField.layer.borderWidth = 2.0
        discountTextField.layer.borderWidth = 2.0

        self.dismissKey()
        let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self
        foodTextField.inputView = keyboardView
    }

    @IBAction func calculateButtonClicked(_ sender: Any) {
        calculate()
    }
    
    func calculate() {
        if (coversTextField.text == "") {
            coversErrorLabel.text = "The number of covers must be completed."
        }
        else {
            coversErrorLabel.text = ""
        }
        
        if (foodTextField.text == "") {
            foodErrorLabel.text = "The amount of consumed food and soft driks is empty."
        }
        else {
            foodErrorLabel.text = ""
        }
        guard let nbCovers = coversTextField.text?.doubleValue else { return }
        guard let foodAmount = foodTextField.text?.doubleValue else { return }
        guard let discount = discountTextField.text?.doubleValue else { return }
        let discountedAmount = foodAmount-(foodAmount*(discount/100))
        let asph = discountedAmount/nbCovers
        
        var eotho = 0.0
        
        if (asph >= 20) {
            eotho = nbCovers*10
        }
        else {
            eotho = nbCovers*(asph/2)
        }
        
        let amoutToPay = discountedAmount-eotho
        
        if (nbCovers != 0 && foodAmount != 0) {
            eothoLabel.text = "EAT OUT TO HELP OUT SAVINGS"
            resultLabel.text = "£"+String(format: "%.2f", eotho)
            resultTextView.text = "Eat Out To Help Out Scheme:\n50% discount on food or non-alcoholic drinks to eat or drink in (up to a maximum of £10 discount per diner)"
            /*
            Amount after discount = £"+String(format: "%.2f",discountedAmount)+".\nAverage per cover = £"+String(format: "%.2f",asph)+".\nAmount to pay = £"+String(format: "%.2f",amoutToPay)+".
            */
        }
        else {
            eothoLabel.text = ""
            resultLabel.text = ""
            resultTextView.text = ""
        }
    }
}

extension ViewController : KeyboardDelegate {

    func hideKeyoard() {
        self.view.endEditing(true)
        calculate()
    }

    func returnValue(number: String) {
        foodTextField.text = number
    }
}

extension String {
    var doubleValue: Double {
        return Double(self) ?? 0
    }
    var intValue: Int {
        return Int(self) ?? 0
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.00, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIViewController {
    func dismissKey()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
