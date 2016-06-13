//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Khatri, Chirag on 6/10/16.
//  Copyright © 2016 Khatri, Chirag. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private var accumulator = 0.0
    private var description = ""
    private var isPartialOperation = false
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
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
                if isPartialOperation {
                    updateDescription(symbol + "(" + String(accumulator) + ")")
                    isPartialOperation = false
                }
                else {
                    setDescription(symbol + "(" + description + ")")
                }
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                if (description.characters.count == 0) {
                    updateDescription(String(accumulator) + " " + symbol)
                }
                else if isPartialOperation {
                    updateDescription(String(accumulator) + " " + symbol)
                }
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
            case .Clear:
                accumulator = 0
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
    
    func getSequence() -> String {
        if (isPartialOperation) {
            return description + " ..."
        }
        else {
            return description + " ="
        }
    }
}