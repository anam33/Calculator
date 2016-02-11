//
//  ViewController.swift
//  Calculator
//
//  Created by Andrew Nam on 1/10/16.
//  Copyright © 2016 Andrew Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    var current_val = 0.0
    var opr = ""
    var prev_opr = ""
    var prev_val = 0.0
    var temp_val = 0.0
    var pressed = false
    var decimal = false
    var power = 10.0

    override func viewDidLoad() {
        super.viewDidLoad()
        clearButton.setTitle("AC", forState: .Normal)
        display.text = "0"
        opr = ""
        prev_opr = ""
        prev_val = 0
        current_val = 0
        temp_val = 0
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func uno() {
        let val = 1.0
        changeVal(val)
    }
    
    @IBAction func dos() {
        let val = 2.0
        changeVal(val)
    }
    
    @IBAction func tres() {
        let val = 3.0
        changeVal(val)
    }

    @IBAction func quatro() {
        let val = 4.0
        changeVal(val)
    }
    
    @IBAction func cinco() {
        let val = 5.0
        changeVal(val)
    }
    
    @IBAction func seis() {
        let val = 6.0
        changeVal(val)
    }
    
    @IBAction func seite() {
        let val = 7.0
        changeVal(val)
    }
    
    @IBAction func ocho() {
        let val = 8.0
        changeVal(val)
    }
    
    @IBAction func nueve(){
        let val = 9.0
        changeVal(val)
    }
    
    @IBAction func zero(){
        let val = 0.0
        changeVal(val)
    }
    
    @IBAction func sign(){
        if pressed {
            current_val *= -1
            show(current_val)
        }
        else if (opr == "="){
            prev_val *= -1
            show(prev_val)
        }
    }
    
    @IBAction func butAllClear(){
        if pressed || opr == "=" {
            clear()
            display.text="0"
            clearButton.setTitle("AC", forState: .Normal)
        }
        else {
            clear()
            display.text = "0"
            prev_val = 0
            opr = ""
        }
    }
    
    @IBAction func add(){
        if pressed {
            operate(current_val, o: opr)
        }
        opr = "+"
    }
    
    @IBAction func sub() {
        if pressed {
            operate(current_val, o: opr)
            }
        opr = "-"
    }
    
    @IBAction func mul() {
        if pressed {
            operate(current_val, o: opr)
        }
        opr = "*"
    }
    
    @IBAction func div() {
        if pressed {
            operate(current_val, o: opr)
        }
        opr = "/"
    }
    
    @IBAction func eq() {
        if pressed {
            if (opr == "="){
                prev_val = current_val
                operate(temp_val, o: prev_opr)
            }
            else {
                operate(current_val, o: opr)
            }
            opr = "="
        }
        else {
            operate(temp_val, o: prev_opr)
        }
    }
    
    @IBAction func dec() {
        decimal = true
        display.text = "\(lround(current_val))" + "."
    }
    
    func show(x: Double){
        if (x - Double(lround(x)) != 0) || decimal {
            display.text = "\(x)"
        }
        else {
            display.text = "\(lround(x))"
        }
    }
    
    func changeVal(val: Double){
        pressed = true
        clearButton.setTitle("C", forState: .Normal)
        if decimal {
            current_val = current_val + (val/power)
            power *= 10
            show(current_val)
        }
        else {
            current_val = current_val*10 + val
            show(current_val)
        }
    }
    
    func legalDiv() -> Bool {
        if (current_val == 0 && opr == "/") {
            display.text = "Cannot divide by 0"
            prev_val = 0
            opr = ""
            return false
        }
        return true
    }
    
    func operate(y: Double, o: String) {
        if (o == "/") {
            if(legalDiv()) {
                prev_val = prev_val / y
                clear()
                show(prev_val)
            }
        }
        else {
        if (o == "+"){
            prev_val = prev_val + y
        }
        else if (o == "-") {
            prev_val = prev_val - y
        }
        else if (o == "*") {
            prev_val = prev_val * y
        }
        else {
            prev_val = y
        }
        temp_val = y
        prev_opr = o
        pressed = false
        clear()
        show(prev_val)
        }
    }
    
    
    func clear() {
        current_val = 0
        decimal = false
        power = 10
    }
    
}

