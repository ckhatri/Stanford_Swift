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
                addToDescription(symbol, writing: false)
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
                addToDescription(symbol, writing: false)
            case .BinaryOperation(let function):
                execPendingOperation()
                pending = PendingBinaryInfo(binaryFunctionInfo: function, firstOperand: accumulator)
                addToDescription(symbol, writing: false)
            case  .Equals:
                execPendingOperation()
                resetDescription()
            case .Clear:
                accumulator = 0
                resetDescription()
            }
        }

    }
    
    private var pending: PendingBinaryInfo?
    
    private func execPendingOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunctionInfo(pending!.firstOperand, accumulator)
            pending = nil
            isPartialOperation = false
        }
        else {
            isPartialOperation = true
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
    
    func addToDescription(let part: String, let writing: Bool) {
        if (description.characters.count != 0 && !writing) {
            description += " "
        }
        description += part
        print(description)
    }
    
    private func resetDescription() {
        description = ""
    }
    
    
}