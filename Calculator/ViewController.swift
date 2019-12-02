//
//  ViewController.swift
//  Calculator
//
//  Created by Pavel Arkhipov on 01.12.2019.
//  Copyright © 2019 uptop. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {
    
    //todo("вынести в enum или подобие sealed class или в map?")
    private static let CLEAR = 10
    private static let DIVIDE = 11
    private static let MULTIPLY = 12
    private static let MINUS = 13
    private static let PLUS = 14
    private static let EQUAL = 15
    
    private var previousNum: Double? = 0
    private var isMath = false
    private var isCommandFinished = false
    private var operation: Int = 0
    private var numberOnTheScreen: Double? = 0
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        if isMath == true {
            label.text = String(sender.tag)
            isMath.toggle()
        } else {
            if isCommandFinished == true {
                label.text = String(sender.tag)
                isCommandFinished = false
            } else {
                label.text = label.text! + String(sender.tag)
            }
        }
        
        numberOnTheScreen = Double(label.text!)!
    }
    
    @IBAction func actions(_ sender: UIButton) {
        switch sender.tag {
            case ViewController.DIVIDE:
                checkAndSetPreviousNumber(sender: sender)
                setMathAndOperation(isMath: true, tag: sender.tag)
                label.text = "/"
            case ViewController.MULTIPLY:
                checkAndSetPreviousNumber(sender: sender)
                setMathAndOperation(isMath: true, tag: sender.tag)
                label.text = "*"
            case ViewController.MINUS:
                checkAndSetPreviousNumber(sender: sender)
                setMathAndOperation(isMath: true, tag: sender.tag)
                label.text = "-"
            case ViewController.PLUS:
                checkAndSetPreviousNumber(sender: sender)
                setMathAndOperation(isMath: true, tag: sender.tag)
                label.text = "+"
            case ViewController.EQUAL:
                if(isIncorrectNumber()) { return }
                isCommandFinished = true
                label.text = String(performCalculating(operation: operation))
            default:
                break;
        }
    }
    
    private func  isIncorrectNumber() -> Bool {
        if(label.text == "*"
        || label.text == "/"
        || label.text == "-"
            || label.text == "+") { return true }
        
        return false
    }
    
    private func setMathAndOperation(isMath: Bool, tag: Int) {
        self.isMath = isMath
        operation = tag
    }
    
    private func checkAndSetPreviousNumber(sender: UIButton) {
        if(!label.text!.isEmpty
            && label.text != "*"
            && label.text != "/"
            && label.text != "-"
            && label.text != "+") {
            previousNum = Double(label.text!)!
        }
    }
    
    
    @IBAction func clear(_ sender: UIButton) {
        clearLabel()
    }
    
    private func performCalculating(operation: Int) -> Double {
        var result: Double = 0
        switch operation {
            case ViewController.DIVIDE:
                result = previousNum! / numberOnTheScreen!
            case ViewController.MULTIPLY:
                 result = previousNum! * numberOnTheScreen!
            case ViewController.MINUS:
                 result = previousNum! - numberOnTheScreen!
            case ViewController.PLUS:
                 result = previousNum! + numberOnTheScreen!
        default:
            result = numberOnTheScreen!
        }
        
        return result
    
    }
    
    private func clearLabel() {
        label.text = ""
        previousNum = 0
        operation = 0
        numberOnTheScreen = 0
        previousNum = 0
        isMath = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

