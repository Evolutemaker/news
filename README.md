# News Feed App

News Feed app allows users to scroll through news posts, like them, and save the liked posts locally on the device. The app was developed using Clean Architecture, Dependency Injection, and BLoC as for State Management technique, along with unit and widget tests.

## Features
- Display a list of news posts fetched from Daily News API.
- Like a post.
- Persist liked posts locally using SharedPreferences.
- Pull-to-refresh to fetch new data.

## Folder Structure
```
lib
└── src
  ├── data
  │ ├── datasources
  │ ├── models
  │ └── repositories
  ├── domain
  │ ├── entities
  │ ├── repositories
  │ └── usecases
  ├── presentation
  │ ├── bloc
  │ ├── navigation
  │ ├── screens
  │ └── widgets
  └── utils
```

## Setup

### Prerequisites
- Flutter SDK (>=3.3.3 <4.0.0)
- A device or emulator to run the app

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Evolutemaker/news.git
   cd news
2. **Install dependencies:**

   ```dart
   flutter pub get
   ```

3. **Generate the necessary code:**

   ```dart
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

### Running the App
1. **Run the app:**
   ```dart
   flutter run
   ```
### Running Tests
1. **Run unit and widget tests:**
   ```dart
   flutter test
   ```

## Contributors
- [Evolutemaker](https://github.com/Evolutemaker)