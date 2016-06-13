//
//  ViewController.swift
//  Calculator
//
//  Created by Khatri, Chirag on 6/10/16.
//  Copyright © 2016 Khatri, Chirag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let currentTextInDisplay = display.text!
            display.text = currentTextInDisplay + digit
            brain.addToDescription(digit, writing: userIsInTheMiddleOfTyping)
        }
        else {
            display.text = digit
            brain.addToDescription(digit, writing: userIsInTheMiddleOfTyping)
        }
        userIsInTheMiddleOfTyping = true
        
    }
    
    // computer property
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
}

