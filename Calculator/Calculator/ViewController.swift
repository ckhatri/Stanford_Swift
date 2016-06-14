//
//  ViewController.swift
//  Calculator
//
//  Created by Khatri, Chirag on 6/10/16.
//  Copyright © 2016 Khatri, Chirag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //displayed value in calculator
    @IBOutlet private weak var display: UILabel!
    
    //sequence leading to the current result
    @IBOutlet weak var sequence: UILabel!
    
    //are they done writing a number?
    var userIsInTheMiddleOfTyping = false
    
    /* Everytime a user touches a digit, get that digit from the sender
        and update the display  */
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let currentTextInDisplay = display.text!
            display.text = currentTextInDisplay + digit
        }
        else {
            display.text = digit
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
    
    //get the value to perform the operation on, and the symbol.
    //update the displayed value and sequence
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {

            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
        sequence.text = brain.getSequence()
    }
}

