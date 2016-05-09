//
//  ViewController.swift
//  Calculator
//
//  Created by Pavel Anpleenko on 08/05/16.
//  Copyright © 2016 Pavel Anpleenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var displayResultLabel: UILabel!
  var stillTyping = false // label
  var dotIsPlaced = false
  var firstOperand: Double = 0
  var secondOperand: Double = 0
  var operatorSign: String = ""
  
  
  var currentInput: Double {
  
    get{
      return Double(displayResultLabel.text!)!
    }
    
    set {
      let value = "\(newValue)"
      // разделитеть по .
      let valueArray = value.componentsSeparatedByString(".")
      if valueArray[1] == "0" {
        displayResultLabel.text = "\(valueArray[0])"
      } else {
        displayResultLabel.text = "\(newValue)"
      }
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
    dotIsPlaced = false
  }
  
  
  func operateWithTwoOperands(operation: (Double, Double) -> Double) {
    currentInput = operation(firstOperand, secondOperand)
    stillTyping = false
  }
  
  @IBAction func equalitySignPressed(sender: UIButton) { //кнопка =
    
    if stillTyping {
      secondOperand = currentInput
    }
    
    dotIsPlaced = false
    
    // Делить на Ноль(если второй операн равен 0
    // и второй оператор равен / то показывать Ошибку
    // если же нет то продолжать вычесления
    if secondOperand == 0 && operatorSign == "÷" {
      displayResultLabel.text = "Ошибка"
    } else {
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
  
  @IBAction func clearButtonPressed(sender: UIButton) { //кнопка сброса чисел
    firstOperand = 0
    secondOperand = 0
    currentInput = 0
    displayResultLabel.text = "0"
    stillTyping = false
    dotIsPlaced = false
    operatorSign = ""
  }
  
  @IBAction func plusMinusButton(sender: UIButton) { //кнопка +/- чисел
    currentInput = -currentInput
  }
  
  @IBAction func persentageButtonPressed(sender: UIButton) { //кнопка % от числа
    if stillTyping {
      secondOperand = currentInput
    }
    operateWithTwoOperands{$0 * $1 / 100}
  }
  
  @IBAction func squareRootButtonPressed(sender: UIButton) { //корень от числа
    currentInput = sqrt(currentInput)
  }
  
  @IBAction func dotButtonPressed(sender: UIButton) { //кнопка .
    if stillTyping && !dotIsPlaced {
      displayResultLabel.text = displayResultLabel.text! + "."
      dotIsPlaced = true
    } else if !stillTyping && !dotIsPlaced {
      displayResultLabel.text = "0."
    }
  }
}

