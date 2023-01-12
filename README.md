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
  <table>
  <tr>
    <td height="412" width="200"><img align="right" src="https://user-images.githubusercontent.com/61184232/212034079-4dcf560c-3c30-442d-8ea4-0a226491ae3b.jpg"></td>
    <td align="center">The user is able to connect the ring to the app via Bluetooth. The app is able to store previously linked devices and automatically connect to these on startup.</td>
  </tr>
</table>
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
  <table>
  <tr>
    <td height="412" width="200"><img align="right" src="https://user-images.githubusercontent.com/61184232/212047490-69acd552-8f71-4600-b0a9-f3bb5cc1ae95.jpg"></td>
    <td height="412" width="200"><img align="right" src="https://user-images.githubusercontent.com/61184232/212047568-12b05003-59a0-4b17-a0cd-783710171cd0.jpg"></td>
    <td height="412" width="200"><img align="right" src="https://user-images.githubusercontent.com/61184232/212047620-777e9298-2c4a-45a5-a1d2-096786edb5b4.jpg"></td>
    <td align="center">From both the home and the journal screen, the user can create a 'moment' which consists of a name, a location, a start and an end time. The user is advised to keep track of their daily activities by frequently adding moments. In a moment the user can also fill in the Self Assessment Manikin (SAM) to describe their feelings and there is also another free text field for further notes.</td>
  </tr>
    <tr>
      <td height="412" width="200"><img align="right" src="https://user-images.githubusercontent.com/61184232/212047763-db2d629d-3866-4d6c-bca5-9589de242720.jpg"></td>
    <td colspan="3" align="center">When a moment is saved, the app also checks the average, peak and low Moodmetric level in the timeframe specified in the moment. These values are displayed on the     details page of the specific moment. On this page the moment can also be edited or deleted.</td>
  </tr>
</table>
</details>

<details>
<summary>
<strong> Visualising arousal data</strong>
</summary>
  <table>
  <tr>
    <td height="412" width="200"><img align="right" src="https://user-images.githubusercontent.com/61184232/212047899-e7c99d02-15e9-4f1c-8f8d-16307544c6fd.jpeg"></td>
    <td height="412" width="200"><img align="right" src="https://user-images.githubusercontent.com/61184232/212047953-d43af11b-9789-4072-ac72-f62ea4068664.jpeg"></td>
    <td height="412" width="200"><img align="right" src="https://user-images.githubusercontent.com/61184232/212048024-95ae6495-e886-4124-a1af-99117b90e912.jpeg"></td>
    <td align="center">On the home screen of the app, the arousal data collected from the Moodmetric ring of the current day is displayed in a graph. In the journal screen you can also       look back at the same graph for other days, but also weeks and months.</td>
  </tr>
</table>
</details>


<details>
<summary>
<strong> Scheduling notifications for daily reflections</strong>
</summary>
  <table>
  <tr>
    <td height="180" width="200"><img align="right" src="https://user-images.githubusercontent.com/61184232/212048425-8aac8c35-ff55-4e81-854d-d8db1f1ba18e.jpg"></td>
    <td align="center">We would like to give the user the option to relect on their day. To do this the app can send a notification to the user on a specific time. This notification will direct the user to a page which will give them thier arousal data and moments on that specific day</td>
    </tr>
    <tr>
      <td height="412" width="200"><img align="right" src="https://user-images.githubusercontent.com/61184232/212048807-74c69874-7c2e-4a43-996d-7c29e4029162.jpg"></td>
<td align="center">
Of course the user will be able to set the reflection time to thier liking or turn off the notification completely.</td>
  </tr>
  </table>
</details>

<details>
<summary>
<strong> Personalization</strong>
</summary>
  <table>
  <tr>
    <td height="412" width="200"><img align="right" src="https://user-images.githubusercontent.com/61184232/212048875-5be454a0-ea2d-4557-bf25-7c686ab5c6a2.jpg"></td>
    <td align="center">
  The app also provides the user with a handful of customization options. The user can switch the app to dark mode for a better personal experience, but we also         recommend the user to tell us their name and birthday so that Moodl can call them by their name and congratulate them on their birthday.</td>
  </tr>
</table>
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
