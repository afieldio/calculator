//
//  ViewController.swift
//  calculator
//
//  Created by Adam Field on 06/09/2016.
//  Copyright (c) 2016 Adam Field. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    enum Operation:String {
        case Add = "+"
        case Subtract = "-"
        case Divide = "/"
        case Multiply = "*"
        case Empty = "Empty"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        print ("Number pressed was \(sender.tag)" )
        //Check if the user has already entered a decimal place
        //if they have and try to do it again just display the current number ie ignore the button click
        if runningNumber.contains("."){
            if sender.tag == -1{
                outputLbl.text = runningNumber
            }else{
                runningNumber += "\(sender.tag)"
                outputLbl.text = runningNumber
            }
        }else{
            if runningNumber == ""{
                if sender.tag == -1{
                    runningNumber += "0."
                    outputLbl.text = runningNumber
                }else{
                    runningNumber += "\(sender.tag)"
                    outputLbl.text = runningNumber
                }
            }else{
                if sender.tag == -1{
                    runningNumber += "."
                    outputLbl.text = runningNumber
                }else{
                    runningNumber += "\(sender.tag)"
                    outputLbl.text = runningNumber
                }
            }
        }
        
        
        /*if sender.tag == -1{
            runningNumber += "."
            outputLbl.text = runningNumber
        }else{
            runningNumber += "\(sender.tag)"
            outputLbl.text = runningNumber
        }*/
    }
    
    @IBAction func multiplyPressed(_ sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    
    @IBAction func dividePressed (_ sender: AnyObject){
        processOperation(operation: .Divide)
        
    }
    
    @IBAction func addPressed (_ sender: AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func subPressed (_ sender: AnyObject){
        processOperation(operation: .Subtract)
    }
    
    @IBAction func submitPressed(_ sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    
    @IBAction func clearPressed(_ sender: AnyObject) {
        runningNumber = ""
        rightValStr = ""
        leftValStr = ""
        outputLbl.text = "0"
        currentOperation = Operation.Empty
    }
    
    
    func processOperation(operation:Operation) {
        if currentOperation != Operation.Empty {
            //A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

}
