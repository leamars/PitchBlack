//
//  ViewController.swift
//  PitchBlack
//
//  Created by Lea Marolt Sonnenschein on 26/04/2020.
//  Copyright © 2020 elemes. All rights reserved.
//

import UIKit

class PassThroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
}

class ViewController: UIViewController {
    
    let monthsData = ["January","February","March","April","May","June","July", "August","September","October","November","December"]
    let years = Array(1930...2010)
    
    @IBOutlet weak var cheeseLoverSwitch: UISwitch!
    @IBOutlet weak var cheeseLoverLabel: UILabel!
    @IBOutlet weak var idealPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var birthdayPicker: UIPickerView!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var enterButton: UIButton!
    
    private var hasPrice: Bool {
        priceSlider.value > 0
    }
    
    private var isCheeseLover: Bool {
        cheeseLoverSwitch.isOn
    }
    
    private var isOver18: Bool = false
    private var hasInteractedWithPicker: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterButton.isEnabled = false
        setupUI()
        setupCustomAccessibility()
        
        // Step 1: Uncomment line below to hear an auditory overview when you first open the app.
        // addAuditoryOverview()
    }
    
    private func addAuditoryOverview() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          UIAccessibility.post(notification: .announcement,
                               argument: "Pitch Black finds you your perfect cheese. Answer 3 questions to find your match.")
        }
    }
    
    private func setupCustomAccessibility() {
        priceSlider.accessibilityValue = "\(Int(priceSlider.value)) €"
    }
    
    private func setupUI() {
        let color = enterButton.isEnabled ? UIColor.blue : UIColor.gray.withAlphaComponent(0.5)
        enterButton.layer.borderColor = color.cgColor
        enterButton.layer.borderWidth = 2
        enterButton.setTitleColor(color, for: .normal)
        enterButton.setTitleColor(color, for: .disabled)
    }
    
    private func enableButtonIfPossible() {
        let allTrue = hasPrice && isCheeseLover && isOver18 && hasInteractedWithPicker
        
        let stateChanged = enterButton.isEnabled != allTrue
        enterButton.isEnabled = allTrue
        
        updateUI()
        
        // Step 2: Uncomment this line to communicate button state change through Voice Over
        // communicateButtonState(stateChanged: stateChanged, shouldEnable: allTrue)
    }
    
    private func communicateButtonState(stateChanged: Bool, shouldEnable: Bool) {
        if stateChanged {
            if !shouldEnable {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                  UIAccessibility.post(notification: .announcement, argument: "Find Your Cheese Match button dimmed.")
                }
                
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                  UIAccessibility.post(notification: .announcement, argument: "Find Your Cheese Match button enabled.")
                }
            }
        }
    }
    
    private func updateUI() {
        idealPriceLabel.textColor = hasPrice ? .black : .red
        birthdayLabel.textColor = isOver18 && hasInteractedWithPicker ? .black : .red
        cheeseLoverLabel.textColor = isCheeseLover ? .black : .red
        setupUI()
    }
    
    @IBAction func priceSliderDidChange(_ sender: UISlider) {
        let value = "\(Int(sender.value))"
        
        priceSlider.accessibilityValue = "\(value) €"
        priceLabel.text = "\(value) (€)"
        enableButtonIfPossible()
    }
    
    @IBAction func changeState(_ sender: UISwitch) {
        enableButtonIfPossible()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 31
        case 1:
            return monthsData.count
        case 2:
            return years.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        
        switch component {
        case 0:
            label.text = "\(row + 1)"
        case 1:
            label.text = "\(monthsData[row])"
        case 2:
            label.text = "\(years[row])"
        default: break
        }
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        hasInteractedWithPicker = true
        switch component {
        case 0, 1, 2:
            isOver18 = years[row] < 2001
        default: break
        }
        enableButtonIfPossible()
    }
}

