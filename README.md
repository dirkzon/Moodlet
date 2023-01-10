<div align="center">

[![license](https://img.shields.io/badge/license-MIT-green)](LICENSE)
</div>

# Data-driven (Stress) Coaching For People With Autism

This repository holds the code for the Coaching app. Before cloning it, contact [Garde-Perik,Evelien E.M. van de](mailto:e.vandegarde@fontys.nl) for more information. Moodl (Coaching app for people with Autism) is an app that measures the arousal of a person using the MoodMetric ring to this moment. The goal of the app is to give people with Autism spectrum disorder a better insight into their arousal, which can be negative and positive. 

During this project we collaberated with multiple groups within the A.S.S. project managed by Garde-Perik,Evelien E.M. van de. The Figma designs we used can be found [here](https://www.figma.com/proto/JiXk734r2YPBCTL1gH2DWt/S6-Designs?node-id=108%3A2953&scaling=scale-down&page-id=111%3A1154&starting-point-node-id=108%3A2953).

## Contents 
- Required Packages And Hardware
- Features
- Setup
- Licence

## Required Packages And Hardware
The project is built with <a href="https://flutter.dev/"><img src="https://storage.googleapis.com/cms-storage-bucket/ec64036b4eacc9f3fd73.svg" alt="Flutter" width="75"/> </a> 

Prominent packages / libraries that are used in the project are:
* [FlutterBlue](https://pub.dev/packages/flutter_blue), for handeling the bluetooth connection with the Moodmetric ring.
* [Hive](https://pub.dev/packages/hive), a lightweight NoSQL database for storing data locally on the user's phone
* [Flutter local notifications](https://pub.dev/packages/flutter_local_notifications), for sending notifications to the device

Hardware requirements include a USB-A to Micro USB to charge the ring and the [Moodmetric ring](https://moodmetric.com/services/moodmetric-smart-ring/), a phone (running min. Android 4.4) and a cable to connect the phone to the computer.

## Features
<details>
<summary>
<strong> Connecting app to Moodmetric ring </strong>
</summary>
The user is able to connect the ring to the app via Bluetooth. The app is able to store previously linked devices and automatically connect to these on startup.

{picture of Bluetooth settings page}
</details>

<details>
<summary>
<strong> Periodically downloading data from Moodmetric ring</strong>
</summary>
The Moodmetric data is downloaded from the ring with a set time interval. By default this happens every 15 minutes, but the interval can be modified in the code.
</details>

<details>
<summary>
<strong> Adding moments to arousal data</strong>
</summary>
From both the home and the journal screen, the user can create a 'moment' which consists of a name, a location, a start and an end time. The user is advised to keep track of their daily activities by frequently adding moments. In a moment the user can also fill in the Self Assessment Manikin (SAM) to describe their feelings and there is also another free text field for further notes.

{pictures of the form}

When a moment is saved, the app also checks the average, peak and low Moodmetric level in the timeframe specified in the moment. These values are displayed on the details page of the specific moment. On this page the moment can also be edited or deleted.

{picture of the details page}
</details>

<details>
<summary>
<strong> Visualising arousal data</strong>
</summary>
On the home screen of the app, the arousal data collected from the Moodmetric ring of the current day is displayed in a graph. In the journal screen you can also look back at the same graph for other days, but also weeks and months.

{pictures of home and journal pages}
</details>


<details>
<summary>
<strong> Scheduling notifications for daily reflections</strong>
</summary>
We would like to give the user the option to relect on their day. To do this the app can send a notification to the user on a specific time. This notification will direct the user to a page which will give them thier arousal data and moments on that specific day

{picture of notification}

Of course the user will be able to set the reflection time to thier liking or turn off the notification completely.
{picture of notification settings page}
</details>


<details>
<summary>
<strong> Personalization</strong>
</summary>
The app also provides the user with a handful of customization options. The user can switch the app to dark mode for a better personal experience, but we also recommend the user to tell us their name and birthday so that Moodl can call them by their name and congratulate them on their birthday.
{picture of profile page}
</details>



## Setup
- First clone this repository:
`git clone https://github.com/dirkzon/Moodl.git`

- Install [Flutter](https://docs.flutter.dev/get-started/install) by following the guideline on their website.

- Intall the dependencies (includes the necessary packages).
`flutter pub get`

- Turn on USB-debugging in the developer settings on your phone 

- Connect your phone to your development device using USB

- Run the app
`flutter run lib/main.dart`

## License

This software is licensed under [MIT](LICENSE)