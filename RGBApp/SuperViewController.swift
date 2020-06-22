//
//  MainViewController.swift
//  RGBApp
//
//  Created by Кирилл Заборский on 18.06.2020.
//  Copyright © 2020 Кирилл Заборский. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let colorVC = segue.destination as! ColorViewController
        colorVC.delegate = self
        colorVC.currentColor = view.backgroundColor
    }
}

// MARK: - ColorDelegate
extension MainViewController: ColorViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
