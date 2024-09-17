# FinVest App: Sample Flutter Credit Card Manager APP

## Installation and Setup

### 1. Clone the Repository

Open your terminal or command prompt and run:

```bash
git clone https://github.com/shaunak-jagtap/finvest.git
```

### 2. Navigate to the Project Directory

Move into the cloned repository's directory:

```bash
cd finvest_app
```

### 3. Get Dependencies

Fetch all the project dependencies:

```bash
flutter pub get
```

### 4. Run the Application

Launch the app on an available emulator or connected device:

```bash
flutter run
```

- If you have multiple devices connected, you can specify one using:

  ```bash
  flutter run -d <device_id>
  ```

- To run on a specific platform (e.g., Chrome for web):

  ```bash
  flutter run -d chrome
  ```

## Additional Information

### Screenshots

You can find screenshots of the application in the `screenshots` folder of the repository.

### Dependencies

Ensure that the following dependencies are included in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  fl_chart: ^0.45.1
  intl: ^0.17.0
```

### Troubleshooting

- If you encounter issues with missing packages, try running `flutter pub cache repair`.
- Ensure your Flutter SDK is up to date with `flutter upgrade`.
