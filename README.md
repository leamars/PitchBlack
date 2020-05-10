# SETUP VOICE OVER

## 1. Clone the repo

## 2. Build & run the Xcode project

## 3. Put the PitchBlack app on your homescreen 
![homescreen img](Img/homescreen.png)

## 4. Enable Accessibliity Shortcut for VoiceOver

* Go to Settings > Accessibility > Accessibility Shortcut
* Select VoiceOver
![accessibility shortcut img](Img/accessibilityShortcut.png)

## 5. Set the speed

* Go to Settings > Accessibility > Voice Over
* Change the speed to somewhere between 50% and 70%, otherwise you won't be able to understand it

![speed img](Img/speed.png)

## 6. Go to your Home Screen and try it out!
* Go back to your home screen
* Tripple press the Home or Side button to turn VoiceOver on or off

![vo shortcut img](Img/voShortcut.png)

# HOW TO USE THIS APP 

This app shows two approaches of how to use audio to communicate what's on a touchscreen when a person can't see it.

* Open the app in VoiceOver mode
* Explore the interface elements for about 5 minutes
* Do you understand what the app does?
* Do you understand what you can do with it?

## 1. Auditory Overviews

An auditory overview is a technique of describing a user interface through audio alone. The aim of an auditory overview is to situate the user, covering the key affordances and actions of a particular screen. Normally a user has to create this overview on their own by exploring and discovering interface controls one-by-one. An auditory overview thus minimizes the time and cognitive effort the user has to make to understand the interface.

To enable the auditory overview experience for PitchBlack:

* Open the PitchBlack project in Xcode
* Go to `ViewController.swift > viewDidLoad()`
* Uncomment the lind under **Step 1**:
* Run the app and see how it feels like now 

## 2. Communicating State Changes

Forms are a particularly difficult UI experience to create and communicate effectively, even when your users have vision at their disposal. When you can't see, it's even harder. Let's imagine a common scenario. A button at the end of a form is disabled until the right parts of a form are filled in. Normally, a button changes visually when it goes from disabled to enabled. How can we communicate that auditorially? I provide one simple example, but I challenge you to think of the edge case where this type of a solution would be a poor choice. What else we could do?

To enable the utton state change for experience PitchBlack:

* Open the PitchBlack project in Xcode
* Go to `ViewController.swift > enableButtonIfPossible()`
* Uncomment the lind under **Step 2**:
* Run the app and see how it feels like now 

# RESOURCES FOR CREATING ACCESSIBLE APPS

* [AppleVis](https://www.applevis.com/) general purpose site that posts app reviews, teaches blind users how to use Apple software where you can talk to real users
* [Laura Savino’s](https://twitter.com/savinola) [Interactive Accessibility Talk](https://vimeo.com/151277877) at Layers 2015
* [John Fox's](https://twitter.com/djembe?lang=en) [Doing Well by Doing Good](https://youtu.be/XfVkNXgT1jE) Mobius 2019 
* [Build Accessible iOS Apps](https://www.podfeet.com/blog/tutorials-5/build-accessible-ios-apps/); Podfeet Podcast hosting Donald Burr 2017
* [Paul Hudson’s](https://twitter.com/twostraws) [Checklist on making apps more accessible](https://www.hackingwithswift.com/articles/91/checklist-how-to-make-your-ios-app-more-accessible) 2018
* [Mobile Accessibility Talk] (https://www.youtube.com/watch?v=yn-6Ee7bwRQ&feature=emb_logo) by Chris McMeeking
* [Stanford Lecture on Accessibility](https://www.youtube.com/watch?v=NOzXRBom7bw) by Skylar Peterson
* [Apple's UI Accessiblity Documentation](https://developer.apple.com/documentation/uikit/accessibility/uiaccessibility)

This is the accompanying app for AppBuilder 2020, talk UI Mode: Pitch Black.
