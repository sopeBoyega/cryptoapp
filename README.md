# CryptoApp

A simple Flutter-based crypto portfolio tracker — UI-first implementation that can fetch market data from CoinGecko. This README contains quick setup instructions, demo/download links and notes for testing the Android APK.

---

## Release / Download

APK (Release)

- Direct APK download: https://drive.google.com/file/d/1rCxA7xEUQekdyTIZWyGR83BqsWNTQ8qo/view?usp=sharing


Demo video

- Demo video (replace with actual URL): https://drive.google.com/file/d/1BFwumfeDXyRmFe4RHaZWkjnxHq4MDEfz/view?usp=sharing

---

## Quick overview

This project is a small crypto wallet/portfolio tracker built with Flutter. Key features:

- Lists market data (CoinGecko)
- Coin details view with price chart
- Favorites management (in-memory provider)
- Offline caching using Hive (basic caching for coin list)

---

## Prerequisites

- Flutter SDK (stable channel recommended). See https://flutter.dev/docs/get-started/install
- Java JDK / Android SDK (for building APKs)
- A connected Android device or emulator to run the app
- (Optional) `adb` for installing APKs via terminal

On Windows, use PowerShell (this repo was developed on Windows).

---

## Setup (local development)

1. Open a terminal in the project folder (PowerShell recommended):

```powershell
cd C:\Users\User1\Desktop\cryptoapp
```

2. Get Flutter packages:

```powershell
flutter pub get
```

3. If you have a `.env` file with API keys, ensure it's at the project root. The project expects an `.env` file (see `pubspec.yaml` assets). Example `.env` (not included):

```
API_KEY=your_api_key_here
```

The CoinGecko API used in this project typically does not require a private API key for public endpoints — the `.env` key is optional and can be left empty.

4. Run the app on an Android device/emulator:

```powershell
flutter run -d <deviceId>
# Or to run on the default connected device:
flutter run
```

---

## Build a release APK

1. Create the release build:

```powershell
flutter build apk --release
```

2. The generated APK will be at:

```
build\app\outputs\flutter-apk\app-release.apk
```

3. Install the APK on a connected Android device using `adb`:

```powershell
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

If `adb` is not in your PATH, open Android Studio -> SDK Tools and ensure Platform Tools are installed, then restart your terminal.

---

## Running tests

This project contains a basic widget test (see `test/widget_test.dart`). Run tests with:

```powershell
flutter test
```

---

## Troubleshooting

- If `flutter pub get` fails: ensure your Flutter SDK is on the PATH, and you are using a compatible Dart/Flutter version.
- If provider package not found after editing pubspec: run `flutter pub get` again and restart your IDE.
- If network calls fail due to CORS or network: check device network settings and confirm CoinGecko is reachable.

---


---

## Credits & License

Mosope Adegboyega
2025.

---


