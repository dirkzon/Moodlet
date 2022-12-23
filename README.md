# Data-driven (Stress) Coaching For People With Autism

This repository holds the code for the Coaching app. Before cloning it, contact [Garde-Perik,Evelien E.M. van de](e.vandegarde@fontys.nl) for more information. Moodl (Coaching app for people with Autism) is an app that measures the arousal of a person using the MoodMetric ring to this moment. The goal of the app is to give people with Autism spectrum disorder a better insight into their arousal, which can be negative and positive.

## Required Packages And Hardware

The app is built using [Flutter](https://flutter.dev/) and the Bluetooth connection is handeled by [FlutterBlue](https://pub.dev/packages/flutter_blue), therefore they are required before running the app.

Hardware requirements include a USB-A to Micro USB to charge the ring and the [Moodmetric ring](https://moodmetric.com/services/moodmetric-smart-ring/), a phone (running min. Android ) and a cable to connect the phone to the computer.


## Setup
- First clone this repositry:
`git clone https://github.com/dirkzon/Moodl.git`

- Install [Flutter](https://docs.flutter.dev/get-started/install) by following the guideline on their website.

- Intall the dependencies (includes FlutterBlue).
`flutter pub get`

- Turn on USB-debugging in the developer settings on your phone 

- Run the app
`flutter run lib/main.dart`

- There you go... It works, hopefully.
