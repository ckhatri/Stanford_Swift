//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Khatri, Chirag on 6/10/16.
//  Copyright © 2016 Khatri, Chirag. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    //accumulator is the current total value/result
    private var accumulator = 0.0
    //description contains the digits and operations but not equal in a string
    private var description = ""
    //need this to decide between "..." or "+" at the end of the sequence.
    private var isPartialOperation = false
    
    //sets the accumulator to whatever value is passed in.
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    //dictionary to map symbols with their respective operations
    private var tableOperations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "x": Operation.BinaryOperation({$0 * $1}),
        "⌹": Operation.BinaryOperation({$0 / $1}),
        "+": Operation.BinaryOperation({$0 + $1}),
        "-": Operation.BinaryOperation({$0 - $1}),
        "=": Operation.Equals,
        "clr": Operation.Clear
    ]
    
    //enum used for each of the different types of operations
    //each one has a certain function
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Clear
    }
    
    func performOperation(symbol: String) {
        if let operation = tableOperations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
                updateDescription(symbol)
            case .UnaryOperation(let function):
                //if partial, then you do symbol(accumulator)
                if isPartialOperation {
                    updateDescription(symbol + "(" + String(accumulator) + ")")
                    isPartialOperation = false
                }
                //else you do the symbol(description)
                else {
                    setDescription(symbol + "(" + description + ")")
                }
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                // if empty, add.
                if (description.characters.count == 0) {
                    updateDescription(String(accumulator) + " " + symbol)
                }
                    //if partial, add
                else if isPartialOperation {
                    updateDescription(String(accumulator) + " " + symbol)
                }
                    //else just add symbol. So 9 + 7 = + 6 will do 9 + 7 + ...
                else {
                    updateDescription(symbol)
                }
                execPendingOperation()
                pending = PendingBinaryInfo(binaryFunctionInfo: function, firstOperand: accumulator)
                isPartialOperation = true
            case  .Equals:
                if isPartialOperation {
                    updateDescription(String(accumulator))
                }
                execPendingOperation()
                isPartialOperation = false
            //simply resets the calculator.
            case .Clear:
                accumulator = 0
                isPartialOperation = false
                description = ""
            }
        }

    }
    
    private var pending: PendingBinaryInfo?
    
    private func execPendingOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunctionInfo(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    private struct PendingBinaryInfo {
        var binaryFunctionInfo: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    private func updateDescription(val: String) {
        if description.characters.count != 0 {
            description += " "
        }
        description += val
    }
    
    private func setDescription(val: String) {
        description = val
    }
    
    //sequence displayed is slightly different than description, either has a "..." or "+" at the end of it.
    func getSequence() -> String {
        if (isPartialOperation) {
            return description + " ..."
        }
        else {
            return description + " ="
        }
    }
}