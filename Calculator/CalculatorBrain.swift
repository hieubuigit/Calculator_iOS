//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Hieu Bui on 5/25/20.
//  Copyright © 2020 fit.tdc. All rights reserved.
//

import Foundation

func sign(operand:Double) -> Double {
    return -operand
}

func add(a: Double, b: Double) -> Double {
    return (a + b)
}

func sub(a: Double, b: Double) -> Double {
    return (a - b)
}

func mul(a: Double, b: Double) -> Double {
    return (a * b)
}

func div(a: Double, b: Double) -> Double {
    return (a / b)
}

class CalculatorBrain {
    //MARK: Properties
    var accumulator: Double?    // Mot bien Optional luu tru du lieu
    
    //MARK: Functions
    enum Operation {
        case constant(Double)
        case unbinaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equal
    }
    
    // Create a dictionary Variable
    let operations : [String : Operation] = [
        "∏" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unbinaryOperation(sqrt),
        "cos" : Operation.unbinaryOperation(cos),
        "±" : Operation.unbinaryOperation(sign),
        "+" : Operation.binaryOperation(add),
        "−" : Operation.binaryOperation(sub),
        "×" : Operation.binaryOperation(mul),
        "÷" : Operation.binaryOperation(div),
        "=" : Operation.equal
    ]
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private var calculatorPending: CalculatePending?
    
    //MARK: Data structor for saving the properties of Calculator
    private struct CalculatePending {
        var firstOperand: Double
        var function: (Double, Double) -> Double
        
        func performCalculations(secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    func performMathFunction(mathSymbol: String) {
        if let operand = operations[mathSymbol] {
            switch operand {
            case .constant(let value):
                accumulator = value
            case .unbinaryOperation(let function):
                accumulator = function(accumulator!)
            case .binaryOperation(let function):
                if let firstOperand = accumulator {
                    calculatorPending = CalculatePending(firstOperand: firstOperand, function: function)
                    accumulator = nil
                }
            case .equal:
                if calculatorPending != nil && accumulator != nil {
                    accumulator = calculatorPending?.performCalculations(secondOperand: accumulator!)
                    calculatorPending = nil
                }
            }
        }
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
