//
//  ViewController.swift
//  RGBApp
//
//  Created by Кирилл Заборский on 22.05.2020.
//  Copyright © 2020 Кирилл Заборский. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    @IBOutlet var redLabelValue: UILabel!
    @IBOutlet var greenLabelValue: UILabel!
    @IBOutlet var blueLabelValue: UILabel!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 10
        redLabelValue.text = String(format: "%.2f", redSlider.value)
        greenLabelValue.text = String(format: "%.2f", greenSlider.value)
        blueLabelValue.text = String(format: "%.2f", blueSlider.value)
        updateColor()
        
    }

    @IBAction func redSliderAction() {
        updateColor()
        redLabelValue.text = String(format: "%.2f", redSlider.value)
    }
    
    @IBAction func greenSliderAction() {
        updateColor()
        greenLabelValue.text = String(format: "%.2f", greenSlider.value)
    }
    
    @IBAction func blueSliderAction() {
        updateColor()
        blueLabelValue.text = String(format: "%.2f", blueSlider.value)
    }
    
    
    func updateColor() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        
        let color = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
        
        mainView.backgroundColor = color
        
    }
    
}

