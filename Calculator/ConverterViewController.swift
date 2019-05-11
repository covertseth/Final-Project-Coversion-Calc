//
//  ConverterViewController.swift
//  Calculator
//
//  Created by Seth Covert on 5/8/19.
//  Copyright © 2019 Seth Covert. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    var iText:String = ""
    var oText:String = ""
    var theConverter:Converter = Converter(label: "Fahrenheit to Celcius", input: "°F", output: "°C")
    
    let converters:[Converter] =
        [
            Converter(label: "Fahrenheit to Celcius", input: "°F", output: "°C"),
            Converter(label: "Celcius to Fahrenheit", input: "°C", output: "°F"),
            Converter(label: "Miles to Kilometers", input: "mi", output: "km"),
            Converter(label: "Kilometers to Miles", input: "km", output: "mi")
    ]
    
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    @IBAction func plusMinus(_ sender: Any) {
        changeSign()
    }
    
    @IBAction func ClearButton(_ sender: Any) {
        clear()
    }
    
    @IBAction func buttonPress(_ sender: UIButton)
    {
        NumPressed(num: sender.titleLabel!.text!)
    }
    @IBAction func ActionType(_ sender: Any) {
        let popupAlert = UIAlertController(title: nil, message: "Choose Converter", preferredStyle: UIAlertController.Style.actionSheet)
        
        for converter in converters{
            popupAlert.addAction(UIAlertAction(title: converter.label, style: UIAlertAction.Style.default, handler: {
                (alertAction) -> Void in
                self.theConverter = converter
                self.inputDisplay.text = self.iText + converter.input
                if let input = Double(self.iText){
                    self.oText = String(format: "%.2f", self.calculateConversion(input: input))
                }
                self.outputDisplay.text = self.oText + converter.output
            }
                )
            )
        }
        self.present(popupAlert, animated: true, completion: nil)
    }
    func calculateConversion(input:Double) -> Double {
        var output: Double = 0.0
        
        switch theConverter.label{
        case "Fahrenheit to Celcius":
            output = (input - 32) * (5/9)
        case "Celcius to Fahrenheit":
            output = input * (9/5) + 32
        case "Miles to Kilometers":
            output = input / 0.62137
        case "Kilometers to Miles":
            output = input * 0.62137
        default:
            break
        }
        return output
    }
    func NumPressed(num:String){
        iText.append(num)
        self.inputDisplay.text = iText + theConverter.input
        if let input = Double(iText){
            oText = String(format: "%.2f", calculateConversion(input: input))
        }
        self.outputDisplay.text = oText + theConverter.output
    }
    
    func changeSign() {
        if(!self.iText.isEmpty){
            if(self.iText.first != "-"){
                self.iText = "-" + self.iText
            }else{
                self.iText.remove(at: self.iText.index(of: "-")!)
            }
            self.oText = String(format: "%.2f", calculateConversion(input: Double(self.iText)!))
            self.inputDisplay.text = iText + theConverter.input
            self.outputDisplay.text = oText + theConverter.output
        }
    }
    
    func decimal() {
        if(!self.iText.contains(".") && self.iText.last != "."){
            self.iText.append(".")
            self.inputDisplay.text = iText + theConverter.input
            self.outputDisplay.text = oText + theConverter.output
        }
    }
    
    func clear(){
        self.iText = ""
        self.oText = ""
        self.inputDisplay.text = iText + theConverter.input
        self.outputDisplay.text = oText + theConverter.output
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aConverter = converters[0]
        theConverter = aConverter
        inputDisplay.text = aConverter.input
        outputDisplay.text = aConverter.output
    }
}
