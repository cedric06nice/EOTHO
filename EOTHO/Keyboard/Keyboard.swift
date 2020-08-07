//
//  Keyboard.swift
//  EOTHO
//
//  Created by Cedric on 04/08/2020.
//  Copyright © 2020 cedric06nice. All rights reserved.
//

import UIKit

protocol KeyboardDelegate {
    func returnValue(number: String)
    func hideKeyoard()
}

enum Operation:String {
    case Add = "+"
    case Subtract = "-"
    case NULL = "Null"
}

class Keyboard: UIView {
    
    var delegate: KeyboardDelegate?
        
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation:Operation = .NULL
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let view = Bundle.main.loadNibNamed("Keyboard", owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        self.delegate?.returnValue(number: result)
    }
    
    @IBAction func numbers(sender: UIButton) {
        
        if runningNumber.count < 10 {
            runningNumber += "\(sender.tag - 1)"
            self.delegate?.returnValue(number: runningNumber)
        }
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        
        if runningNumber == "" && result != "" {
            if sender.tag == 20 {
                operation(operation: .Add)
            }
            else if sender.tag == 30 {
                operation(operation: .Subtract)
            }
        }
        if runningNumber != "" && sender.tag != 11 && sender.tag != 50 && sender.tag != 99 {
            
            if sender.tag == 20 {
                operation(operation: .Add)
            }
            else if sender.tag == 30 {
                operation(operation: .Subtract)
            }
        }
        else if sender.tag == 11 {
            if !runningNumber.contains(".") {
                runningNumber += "."
                self.delegate?.returnValue(number: runningNumber)
            }
        }
        else if sender.tag == 50 {
            operation(operation: currentOperation)
            self.delegate?.hideKeyoard()
        }
        else if sender.tag == 99 {
            runningNumber = ""
            leftValue = ""
            rightValue = ""
            result = ""
            currentOperation = .NULL
            self.delegate?.returnValue(number: "")
        }
    }
    
    func operation(operation:Operation) {
        
        if currentOperation != .NULL {
            if runningNumber != "" {
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == .Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }
                else if currentOperation == .Subtract {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                }
                leftValue = result
                if Double(result)!.truncatingRemainder(dividingBy: 1) == 0 {
                    result = "\(Int(Double(result)!))"
                }
                self.delegate?.returnValue(number: result)
            }
            currentOperation = operation
        }
        else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}
