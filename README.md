# Mohit Khandelwal - Portfolio

A responsive personal portfolio website built with Flutter Web. This portfolio showcases my skills, projects, and professional experience.

## Features

- Fully responsive design that works on mobile, tablet, and desktop
- Dark theme with modern styling and animations
- Interactive UI elements with smooth transitions
- Cross-browser compatibility
- Optimized performance
- Firebase integration for data storage
- PDF viewer for resume/documents

## Tech Stack

- Flutter Web for building the UI
- Responsive_Framework for handling different screen sizes
- Flutter_Animate for smooth animations
- URL_Launcher for handling external links
- Flutter_SVG for vector graphics
- Firebase/Firestore for backend services
- Google Fonts for typography
- Cached Network Image for efficient image loading
- Flutter Staggered Animations for enhanced UI animations

## Sections

- Home - Introduction and social links
- About - Personal information and skills
- Projects - Showcase of recent work
- Experience - Professional background
- Contact - Ways to get in touch

## Setup and Deployment

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Set up Firebase:
   - Create a Firebase project in the Firebase Console
   - Enable Firestore database
   - Configure Firebase in your app (web/index.html)
4. Run `flutter run -d chrome` to test locally
5. For production build:
   - Run `flutter build web --release --web-renderer canvaskit`
   - Deploy to Firebase Hosting with `firebase deploy`

## Firebase Configuration

This project uses Firebase for backend services. The Firebase configuration includes:
- Firestore Rules (firestore.rules)
- Firebase Hosting configuration (firebase.json)
- Firebase project settings (.firebaserc)

## Dependencies

Key dependencies include:
- Flutter SDK: ^3.5.0
- Google Fonts: ^6.1.0
- Flutter Animate: ^4.5.0
- URL Launcher: ^6.2.5
- Responsive Framework: ^1.4.0
- Firebase Core: ^2.24.2
- Cloud Firestore: ^4.17.5
- Flutter PDF View: ^1.4.0+1

## License

This project is open source and available under the [MIT License](LICENSE).

## Contact

For any inquiries, please reach out to [mkhandelwal.mk@gmail.com](mailto:mkhandelwal.mk@gmail.com).
