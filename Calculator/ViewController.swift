//
//  ViewController.swift
//  Calculator
//
//  Created by Hieu Bui on 5/18/20.
//  Copyright © 2020 fit.tdc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    var isBeginning = true;
    @IBOutlet weak var display: UILabel!
    
    @IBAction func btnPressProcessing(_ sender: UIButton) {
        let digit = sender.currentTitle!    // Get button khi bam. Day la bien optional: bien se co gia tri hoac khong.
        let currentValue = display.text!    // Lay chuoi hien thi tren display
        if isBeginning {
            if digit != "0" {
                display.text = digit
                isBeginning =	 false
            }
        } else {
            display.text = currentValue + digit
        }
    }
    
    var displayDoubleValue: Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    let calculatorBrain = CalculatorBrain()
    @IBAction func mathFunctions(_ sender: UIButton) {
        
        if !isBeginning {
            calculatorBrain.setOperand(operand: displayDoubleValue)
            isBeginning = true
        }
        
        if let mathSymbol = sender.currentTitle {
            calculatorBrain.performMathFunction(mathSymbol: mathSymbol)
        }
        if let result = calculatorBrain.result {
            displayDoubleValue = result
        }
    }
}
