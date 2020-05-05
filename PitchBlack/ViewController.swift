//
//  ViewController.swift
//  PitchBlack
//
//  Created by Lea Marolt Sonnenschein on 26/04/2020.
//  Copyright © 2020 elemes. All rights reserved.
//

import UIKit
import CoreHaptics

class PassThroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
}

class ViewController: UIViewController {
    
    let monthsData = ["January","February","March","April","May","June","July", "August","September","October","November","December"]
    let years = Array(1930...2010)
    
    @IBOutlet weak var birthdayPicker: UIPickerView!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var blackPassthroughView: PassThroughView!
    @IBOutlet weak var slider: UISlider!
    var i = 0
    // Track the screen dimensions:
    private lazy var windowWidth: CGFloat = {
        return UIScreen.main.bounds.size.width
    }()
    
    private lazy var windowHeight: CGFloat = {
        return UIScreen.main.bounds.size.height
    }()
    
    private lazy var supportsHaptics: Bool = {
        // Check if the device supports haptics.
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        return hapticCapability.supportsHaptics
    }()
    
    // Timer to handle transient haptic playback:
    private var transientTimer: DispatchSourceTimer?
    
    private var engine: CHHapticEngine!
    private var engineNeedsStart = true
    private var continuousPlayer: CHHapticAdvancedPatternPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prettify()
        // Do any additional setup after loading the view.
        
//        if let window = UIApplication.shared.windows.last {
//            //blackPassthroughView.removeFromSuperview()
//            //window.addSubview(blackPassthroughView)
//        }
//
//
//        let allUI: [UIView] = [aButton, aLabel, naButton, naLabel]
//
//        aButton.isAccessibilityElement = true
//        aLabel.isAccessibilityElement = true
//
//        for ui in allUI {
//            if !ui.isAccessibilityElement {
//                ui.backgroundColor = .black
//            }
//        }
//
//        addGestureRecognizers()
//        //createAndStartHapticsEngine()
//
    }
    
    private func setupPickers() {
        
    }
    
    private func prettify() {
        enterButton.layer.borderColor = UIColor.black.cgColor
        enterButton.layer.borderWidth = 2
    }
    
    @IBAction func didTapEnter(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          UIAccessibility.post(notification: .announcement, argument: "Sign Up enabled.")
        }
    }
    
    @IBAction func changeState(_ sender: UISwitch) {
        if sender.isOn {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
              UIAccessibility.post(notification: .announcement, argument: "Sign Up dimmed.")
            }
            
            //UIAccessibility.post(notification: .layoutChanged, argument: "Sign Up button dimmed.")
            //UIAccessibility.post(notification: .screenChanged, argument: "Sign Up button dimmed.")
            
//            UIAccessibility.post(notification: .screenChanged, argument: sender)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
              UIAccessibility.post(notification: .announcement, argument: "Sign Up button enabled.")
            }
            //UIAccessibility.post(notification: .layoutChanged, argument: "Sign Up button enabled.")
            //UIAccessibility.post(notification: .screenChanged, argument: "Sign Up button enabled.")
//            UIAccessibility.post(notification: .screenChanged, argument: sender)
        }
    }
    
    func addGestureRecognizers() {
        
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
//        longPress.minimumPressDuration = 0
//
//        view.addGestureRecognizer(longPress)
    }
    

    @IBAction func touchDown(_ sender: Any) {
        playHapticTransient(time: 0,
        intensity: 1.0,
        sharpness: 1.0)
    }
    
    @IBAction func touchUpInside(_ sender: Any) {
        playHapticTransient(time: 0,
        intensity: 1.0,
        sharpness: 1.0)
    }
    
    func createAndStartHapticsEngine() {
        do {
            engine = try CHHapticEngine()
        } catch {
            //fatalError("Couldn't initialize haptic engine.")
        }
        
        engine.playsHapticsOnly = true
        
        // Handle stopping and resetting etc...
        
        do {
            try engine.start()
        } catch {
            fatalError("Couldn't start haptic engine.")
        }
    }
    
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        
//        let location = recognizer.location(in: view)
//        print(location)
//
//        switch recognizer.state {
//        case .began:
//            if aButton.frame.contains(location) {
//                print("Inside the bounds")
//                playHapticTransient(time: 0,
//                                    intensity: 1.0,
//                                    sharpness: 1.0)
//            } else {
//                print("Outside bounds")
//            }
//        case .ended:
//            if aButton.frame.contains(location) {
//                print("Inside the bounds")
//                playHapticTransient(time: 0,
//                                    intensity: 1.0,
//                                    sharpness: 1.0)
//            } else {
//                print("Outside bounds")
//            }
//        case .changed, .cancelled, .failed, .possible: break
//        @unknown default: break
//        }
    }
    
    /// - Tag: PlayTransientPattern
    // Play a haptic transient pattern at the given time, intensity, and sharpness.
    private func playHapticTransient(time: TimeInterval,
                                     intensity: Float,
                                     sharpness: Float) {
        
        // Abort if the device doesn't support haptics.
        if !supportsHaptics {
            return
        }
        
        
        // Create an event (static) parameter to represent the haptic's intensity.
        let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity,
                                                        value: intensity)
        
        // Create an event (static) parameter to represent the haptic's sharpness.
        let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness,
                                                        value: sharpness)
        
        // Create an event to represent the transient haptic pattern.
        let event = CHHapticEvent(eventType: .hapticTransient,
                                  parameters: [intensityParameter, sharpnessParameter],
                                  relativeTime: 0)
        
        // Create a pattern from the haptic event.
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            
            // Create a player to play the haptic pattern.
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate) // Play now.
        } catch let error {
            print("Error creating a haptic transient pattern: \(error)")
        }
    }
    
    @IBAction func playButton(_ sender: Any) {
        i += 1
        print("Running \(i)")

        switch i {
        case 1:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)

        case 2:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)

        case 3:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)

        case 4:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()

        case 5:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()

        case 6:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()

        default:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            i = 0
        }
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
}

