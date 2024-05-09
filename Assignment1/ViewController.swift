//
//  ViewController.swift
//  Assignment1
//
//  Created by Andrew Jenkins on 9/19/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectType: UISegmentedControl!
    @IBOutlet weak var inputA: UITextField!
    @IBOutlet weak var inputB: UITextField!
    @IBOutlet weak var inputC: UITextField!
    @IBOutlet weak var inputD: UITextField!
    
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var labelC: UILabel!
    @IBOutlet weak var roots: UILabel!
    @IBOutlet weak var derivative: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func showFunction(_ sender: Any){
        if selectType.selectedSegmentIndex == 0 {
            inputA.isHidden = true
            inputB.isHidden = true
            labelA.isHidden = true
            labelB.isHidden = true
            inputC.frame.origin = CGPoint(x:140, y:261)
            inputD.frame.origin = CGPoint(x:210, y:261)
            labelC.frame.origin = CGPoint(x:180, y:267)
            
        }else if selectType.selectedSegmentIndex == 1 {
            inputA.isHidden = true
            inputB.isHidden = false
            labelA.isHidden = true
            labelB.isHidden = false
            inputB.frame.origin = CGPoint(x:110, y:261)
            inputC.frame.origin = CGPoint(x:180, y:261)
            inputD.frame.origin = CGPoint(x:250, y:261)
            labelB.frame.origin = CGPoint(x:147, y:267)
            labelC.frame.origin = CGPoint(x:218, y:267)
        }else{
            inputA.isHidden = false
            inputB.isHidden = false
            labelA.isHidden = false
            labelB.isHidden = false
            inputA.frame.origin = CGPoint(x:75, y:261)
            inputB.frame.origin = CGPoint(x:145, y:261)
            inputC.frame.origin = CGPoint(x:215, y:261)
            inputD.frame.origin = CGPoint(x:285, y:261)
            labelA.frame.origin = CGPoint(x:112, y:267)
            labelB.frame.origin = CGPoint(x:182, y:267)
            labelC.frame.origin = CGPoint(x:253, y:267)
        }
    }
    @IBAction func showButton(_ sender: Any){
        let a = Double(inputA.text ?? "")
        let b = Double(inputB.text ?? "")
        let c = Double(inputC.text ?? "")
        let d = Double(inputD.text ?? "")
        if selectType.selectedSegmentIndex == 0 {
            if(c != nil && d != nil){
                button.isHidden = false
            }else{
                button.isHidden = true
            }
                
            
            
        }else if selectType.selectedSegmentIndex == 1 {
            if(b != nil && c != nil && d != nil){
                button.isHidden = false
            }else{
                button.isHidden = true
            }
        }else{
            if(a != nil && b != nil && c != nil && d != nil){
                button.isHidden = false
            }else{
                button.isHidden = true
            }
        }
    }
    
    @IBAction func calculate(_ sender: Any) {
        var rootNums: [Double] = []
        if selectType.selectedSegmentIndex == 0 {
            
            let m = Double(inputC.text!)!
            let b = Double(inputD.text!)!
            if(m != 0.0){
                rootNums.append( -b/m )
                roots.text = String(rootNums.reduce("") { $0 + ", " + String(format: "%.2f", $1) }.dropFirst(2))
                derivative.text = String(m)
                roots.isHidden = false
                derivative.isHidden = false
            }else{
                roots.text = "This function has no roots 🤷 "
                derivative.text = String(m)
                roots.isHidden = false
                derivative.isHidden = false
            }
            
        }else if selectType.selectedSegmentIndex == 1 {
            let a = Double(inputB.text!)!
            let b = Double(inputC.text!)!
            let c = Double(inputD.text!)!
            let discriminant = Double(b * b - (4 * a * c))
            
            if(discriminant > 0.0){
                let discsqrt = discriminant.squareRoot()
                for sign in ["plus", "minus"]{
                    if(sign == "plus"){
                        let firstRoot = ((b * -1.0) + discsqrt) / (2.0 * a)
                        rootNums.append(firstRoot)
                    }else{
                        let secondRoot = ((b * -1.0) - discsqrt) / (2.0 * a)
                        rootNums.append(secondRoot)
                    }
                    roots.text = String(rootNums.reduce("") { $0 + ", " + String(format: "%.2f", $1) }.dropFirst(2))
                    roots.isHidden = false;
                }
            }else if(discriminant == 0.0){
                let firstRoot = ((b * -1.0)) / (2.0 * a)
                rootNums.append(firstRoot)
                roots.text = String(rootNums.reduce("") { $0 + ", " + String(format: "%.2f", $1) }.dropFirst(2))
                roots.isHidden = false;
            }else{
                roots.text = "This function has no roots 🤷 "
                roots.isHidden = false;
            }
            var deriText = ""
            if(a != 0.0){
                deriText += String(a * 2) + "x"
                if(b != 0.0){
                    deriText += " + " + String(b)
                }
            }else if(b != 0.0){
                deriText = String(b)
            }else{
                deriText = "0"
            }
            derivative.text = deriText.replacingOccurrences(of: "+ -", with: "- ")
            derivative.isHidden = false
            
        }else{
            let a = Double(inputA.text!)!
            let b = Double(inputB.text!)!
            let c = Double(inputC.text!)!
            roots.text = "idk man, the math is too hard 🤷 "
            roots.isHidden = false;
            var deriText = ""
            if(a != 0.0){
                deriText += String(a * 3) + "x^2"
                if(b != 0.0){
                    deriText += " + " + String(b * 2) + "x"
                    if(c != 0.0){
                        deriText += " + " + String(c)
                    }
                }else if(c != 0.0){
                    deriText += " + " + String(c)
                }
            }else if(b != 0.0){
                deriText += String(b * 2) + "x"
                if(c != 0.0){
                    deriText += " + " + String(c)
                }
            }else if(c != 0){
                deriText = String(c)
            }else{
                deriText = "0"
            }
            derivative.text = exponentize(str: deriText).replacingOccurrences(of: "+ -", with: "- ")
            derivative.isHidden = false
        }
        
    }
    
    func exponentize(str: String) -> String {

        let supers = [
            "1": "\u{00B9}",
            "2": "\u{00B2}",
            "3": "\u{00B3}"]

        var newStr = ""
        var isExp = false
        for (char) in str {
            if char == "^" {
                isExp = true
            } else {
                if isExp {
                    let key = String(char)
                    if supers.keys.contains(key) {
                        newStr.append(Character(supers[key]!))
                    } else {
                        isExp = false
                        newStr.append(char)
                    }
                } else {
                    newStr.append(char)
                }
            }
        }
        return newStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        labelA.text = exponentize(str: labelA.text!)
        labelB.text = exponentize(str: labelB.text!)
        labelC.text = exponentize(str: labelC.text!)
    }


}

