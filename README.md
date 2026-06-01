# CANMET — Cancer Metabolic Management App
### Flutter Android App · Hindi + English · 7 Modules

---

## What's in this app

A complete patient-facing Android app for cancer patients to manage metabolic syndrome during treatment. Fully bilingual (Hindi + English), based on the CANMET intervention protocol.

---

## Project file structure

```
canmet_app/
├── lib/
│   ├── main.dart                        ← App entry point
│   ├── utils/
│   │   ├── app_colors.dart              ← Colour constants
│   │   ├── app_theme.dart               ← MaterialTheme
│   │   ├── strings.dart                 ← All EN + HI UI strings
│   │   ├── module_data.dart             ← All 7 modules with full bilingual content
│   │   └── providers.dart              ← LanguageProvider, UserProvider, TaskProvider
│   └── screens/
│       ├── login_screen.dart            ← Login
│       ├── register_screen.dart         ← Registration
│       ├── main_shell.dart              ← Bottom nav shell
│       ├── home_screen.dart             ← Dashboard + module grid
│       ├── module_detail_screen.dart    ← Module content + task checklist
│       ├── track_screen.dart            ← Daily health log
│       └── profile_screen.dart          ← Profile + settings
├── android/                             ← Android native config
├── pubspec.yaml                         ← Dependencies
└── README.md
```

---

## How to run

### Step 1 — Install Flutter
Download and install Flutter SDK from https://flutter.dev/docs/get-started/install

Make sure `flutter doctor` passes with no errors for Android.

### Step 2 — Open the project

```bash
cd canmet_app
```

### Step 3 — Install dependencies

```bash
flutter pub get
```

### Step 4 — Run on a device or emulator

Connect an Android device (enable USB debugging) or start an Android emulator, then:

```bash
flutter run
```

### Step 5 — Build a release APK

```bash
flutter build apk --release
```

The APK will be at:
```
build/app/outputs/flutter-apk/app-release.apk
```

You can copy this APK to any Android phone and install it directly.

---

## Features

### Login & Register
- Login with Patient ID + password
- Registration collects: name, age, gender, cancer type, hospital ID, mobile number, password
- Patient ID is auto-generated on registration (format: CNM-XXXXX)
- Session persists — user stays logged in on next app open
- Language selection on the login screen

### Home Dashboard
- Time-based greeting (morning / afternoon / evening) in selected language
- Treatment day counter and day streak
- Adherence, modules progress stats
- All 7 modules in a 2-column grid with progress bar per module
- Today's motivational message

### 7 Full Modules (all content in Hindi + English)

| Module | Content |
|--------|---------|
| EduMET | What is metabolic syndrome, why it matters during cancer, how to identify it, modifiable risk factors |
| NutriMET | Millet swap challenge, 3:1 plate model, hidden sugar detective, healthy fats & protein targets |
| PhysiMET | Activity snacking every hour, chair sits & wall push-ups, brisk walking guide, post-meal walk |
| SafeMET | Blood sugar safe zone during chemo, daily foot care protocol, warning signs to act immediately |
| TrackMET | What to monitor and how often, waist vs weight concept, understanding your numbers |
| MindMET | Morning sunlight 15 min, 4-4-6 calm breathing technique, sleep hygiene dark protocol |
| MediMET | Taking on time every day, never skip never double rule, managing side effects, medicine storage |

Each module has:
- Key motivational quote
- 3–4 expandable education sections (tap to expand/collapse)
- Daily reminder card
- Interactive task checklist — tap to check off tasks
- Task completion progress counter

### TrackMET Daily Log
- Blood glucose (fasting + post-meal)
- Blood pressure (systolic + diastolic)
- Weight (kg) and waist circumference (cm)
- Stress score (0–10) and sleep hours
- Data auto-loads from today's previous entry
- Saved locally by date using shared_preferences
- Warning signs reminder card

### Profile
- Patient info display
- Language switcher (EN / हिंदी) — switches entire app instantly
- Reminders (placeholder for future)
- Ask-a-Nurse helpline dialog
- Emergency contacts dialog
- Logout with confirmation dialog

---

## Language switching

Language can be changed from 3 places:
1. Login screen — EN / हिंदी buttons
2. Home screen — toggle button top-right
3. Profile → Settings → Language

All UI text, module content, tasks, and messages switch instantly.

---

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| provider | ^6.1.1 | State management |
| shared_preferences | ^2.2.2 | Local data persistence |

---

## Adding to Android Studio

1. Open Android Studio
2. File → Open → select the `canmet_app` folder
3. Wait for Gradle sync
4. Select your device/emulator and click Run

---

## Future additions (ready to build on top)

- Firebase Firestore for cloud sync of patient logs
- Push notifications for medication reminders using firebase_messaging
- Health trend charts using fl_chart
- OTP login via Firebase Auth
- Video demonstrations for exercises
- Doctor/nurse admin dashboard
- Offline-first sync with connectivity_plus
