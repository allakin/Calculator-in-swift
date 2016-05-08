//
//  ViewController.swift
//  Calculator
//
//  Created by Павел Анплеенко on 08/05/16.
//  Copyright © 2016 Павел Анплеенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var displayResultLabel: UILabel!
  var stillTyping = false
  var firstOperand: Double = 0
  var secondOperand: Double = 0
  var operatorSign: String = ""
  
  var currentInput: Double {
  
    get{
      return Double(displayResultLabel.text!)!
    }
    
    set {
      displayResultLabel.text = "\(newValue)"
      stillTyping = false
    }
  }
  
  
  
  
  @IBAction func numberPressed(sender: UIButton) {
    
    let number = sender.currentTitle!
    
    if stillTyping {
      if displayResultLabel.text?.characters.count < 15 {
        displayResultLabel.text = displayResultLabel.text! + number
      }
    } else {
      displayResultLabel.text = number
      stillTyping = true
    }
  }
  
  @IBAction func twoOperandsSignPressed(sender: UIButton) {
    operatorSign = sender.currentTitle!
    firstOperand = currentInput
    stillTyping = false
  }
  
  func operateWithTwoOperands(operation: (Double, Double) -> Double) {
    currentInput = operation(firstOperand, secondOperand)
    stillTyping = false
  }
  
  @IBAction func equalitySignPressed(sender: UIButton) {
    
    if stillTyping {
      secondOperand = currentInput
    }
    
    switch operatorSign {
    case "+":
      operateWithTwoOperands{$0 + $1}
    case "-":
      operateWithTwoOperands{$0 - $1}
    case "×":
      operateWithTwoOperands{$0 * $1}
    case "÷":
      operateWithTwoOperands{$0 / $1}
    default: break
      
    }
    
  }
}

