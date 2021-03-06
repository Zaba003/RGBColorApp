    //
    //  ViewController.swift
    //  RGBApp
    //
    //  Created by Кирилл Заборский on 22.05.2020.
    //  Copyright © 2020 Кирилл Заборский. All rights reserved.
    //
    
    import UIKit
    
    protocol ColorViewControllerDelegate {
        func setColor(_ color: UIColor)
    }
    
    class ColorViewController: UIViewController {
        
        @IBOutlet var mainView: UIView!
        
        @IBOutlet weak var redLabel: UILabel!
        @IBOutlet weak var greenLabel: UILabel!
        @IBOutlet weak var blueLabel: UILabel!
        
        
        @IBOutlet weak var redSlider: UISlider!
        @IBOutlet weak var greenSlider: UISlider!
        @IBOutlet weak var blueSlider: UISlider!
        
        @IBOutlet weak var redTextField: UITextField!
        @IBOutlet weak var greenTextField: UITextField!
        @IBOutlet weak var blueTextField: UITextField!
        
        
        // MARK: - Public Properties
        var delegate: ColorViewControllerDelegate!
        var currentColor: UIColor!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            mainView.layer.cornerRadius = 15
            
            redSlider.tintColor = .red
            greenSlider.tintColor = .green
            blueSlider.tintColor = .blue
            
            mainView.backgroundColor = currentColor
            
            setValue(for: redSlider, greenSlider, blueSlider)
            setValue(for: redLabel, greenLabel, blueLabel)
            setValue(for: redTextField, greenTextField, blueTextField)
            addDoneButtonTo(redTextField, greenTextField, blueTextField)
            
        }
        
        // MARK: - IB Actions
        @IBAction func rgbSlider(_ sender: UISlider) {
            
            switch sender.tag {
            case 0:
                redLabel.text = string(from: sender)
                redTextField.text = string(from: sender)
            case 1:
                greenLabel.text = string(from: sender)
                greenTextField.text = string(from: sender)
            case 2:
                blueLabel.text = string(from: sender)
                blueTextField.text = string(from: sender)
            default:
                break
            }
            
            setColor()
        }
        
        @IBAction func doneButtonPressed() {
            delegate?.setColor(mainView.backgroundColor ?? .white)
            dismiss(animated: true)
        }
    }
    
    // MARK: - Private Methods
    extension ColorViewController {
        
        private func setColor() {
            mainView.backgroundColor = UIColor(
                red: CGFloat(redSlider.value),
                green: CGFloat(greenSlider.value),
                blue: CGFloat(blueSlider.value),
                alpha: 1
            )
        }
        
        private func setValue(for labels: UILabel...) {
            labels.forEach { label in
                switch label.tag {
                case 0: redLabel.text = string(from: redSlider)
                case 1: greenLabel.text = string(from: greenSlider)
                case 2: blueLabel.text = string(from: blueSlider)
                default: break
                }
            }
        }
        
        private func setValue(for textFields: UITextField...) {
            textFields.forEach { textField in
                switch textField.tag {
                case 0: redTextField.text = string(from: redSlider)
                case 1: greenTextField.text = string(from: greenSlider)
                case 2: blueTextField.text = string(from: blueSlider)
                default: break
                }
            }
        }
        
        private func setValue(for sliders: UISlider...) {
            let ciColor = CIColor(color: currentColor)
            
            sliders.forEach { slider in
                switch slider.tag {
                case 0: redSlider.value = Float(ciColor.red)
                case 1: greenSlider.value = Float(ciColor.green)
                case 2: blueSlider.value = Float(ciColor.blue)
                default: break
                }
            }
        }
        
        // Значения RGB
        private func string(from slider: UISlider) -> String {
            return String(format: "%.2f", slider.value)
        }
        
        private func addDoneButtonTo(_ textFields: UITextField...) {
            
            textFields.forEach { textField in
                let keyboardToolbar = UIToolbar()
                textField.inputAccessoryView = keyboardToolbar
                keyboardToolbar.sizeToFit()
                
                let doneButton = UIBarButtonItem(title:"Done",
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(didTapDone))
                
                let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                    target: nil,
                                                    action: nil)
                
                keyboardToolbar.items = [flexBarButton, doneButton]
            }
        }
        
        @objc private func didTapDone() {
            view.endEditing(true)
        }
        
        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        
    }
    
    // MARK: - UITextFieldDelegate
    extension ColorViewController: UITextFieldDelegate {
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            view.endEditing(true)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            guard let text = textField.text else { return }
            
            if let currentValue = Float(text) {
                switch textField.tag {
                case 0:
                    redSlider.setValue(currentValue, animated: true)
                    setValue(for: redLabel)
                case 1:
                    greenSlider.setValue(currentValue, animated: true)
                    setValue(for: greenLabel)
                case 2:
                    blueSlider.setValue(currentValue, animated: true)
                    setValue(for: blueLabel)
                default: break
                }
                
                setColor()
            } else {
                showAlert(title: "Wrong format!", message: "Please enter correct value")
            }
        }
    }
    
