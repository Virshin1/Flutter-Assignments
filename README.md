# Assignment 7: 3-Screen Flutter App with Named Routes & Form Validation

A multi-screen Flutter application demonstrating **Named Routes navigation**, **comprehensive Form validation**, and **strongly-typed parameter passing** across screens.

---

## 📱 App Architecture & Screens

The application is structured into 3 dedicated screens connected via Flutter's Named Routes:

1. **Home Screen (`/`)**:
   - Modern landing page featuring a welcome hero card, overview badges, and architectural highlights.
   - Quick visual representation of the application flow (`Home` ➔ `Form` ➔ `Detail`).
   - "Start Registration" CTA navigating to the registration form using `Navigator.pushNamed(context, AppRoutes.register)`.

2. **Registration Form Screen (`/register`)**:
   - `Form` managed via `GlobalKey<FormState>()`.
   - **Validation Rules**:
     - **Full Name**: Required, minimum 3 characters, alphabetical characters & spaces only.
     - **Email Address**: Required, RFC-compliant email regex (`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`).
     - **Phone Number**: Required, exactly 10 digits.
     - **Password**: Required, minimum 8 characters, must include uppercase, number, and special character. Includes interactive real-time **Password Strength Meter**.
     - **Confirm Password**: Required, must match the entered password.
     - **Gender**: Dropdown selector (`Male`, `Female`, `Other`, `Prefer not to say`).
     - **Terms of Service**: Mandatory checkbox agreement with submission validation.
   - On successful validation, constructs a `UserModel` and navigates using `Navigator.pushNamed(context, AppRoutes.detail, arguments: user)`.

3. **Detail Screen (`/details`)**:
   - Extracts the `UserModel` via `ModalRoute.of(context)!.settings.arguments`.
   - Displays a verified badge, user initials avatar, full profile details, and formatted registration timestamp.
   - Interactive actions: copy email address to clipboard, "Edit Details" (returns to form via `Navigator.pop`), and "Back to Home" (returns to root route).
   - Graceful fallback UI with return CTA if accessed without route arguments.

---

## 📂 Project Structure

```text
lib/
├── constants/
│   ├── app_colors.dart         # Material 3 color system & gradients
│   └── app_routes.dart         # Named route strings & onGenerateRoute factory
├── models/
│   └── user_model.dart         # UserModel with initials and formatted date
├── screens/
│   ├── home_screen.dart        # Screen 1: Landing & route overview
│   ├── registration_screen.dart# Screen 2: Validated registration form
│   └── detail_screen.dart      # Screen 3: User profile display & actions
├── widgets/
│   ├── custom_text_field.dart  # Form field wrapper with error styling
│   └── password_strength_bar.dart # Live password meter with checklist pills
└── main.dart                   # Application entry point & theme configuration
```

---

## 🚀 Running the Project

### Prerequisites
- Flutter SDK 3.47+ (Dart 3.13+)

### Execute the App
```bash
# From the Assignments directory
cd /Users/virshin/VScode/Cross-App/Assignments

# Run on Chrome
flutter run -d chrome

# Run on macOS desktop
flutter run -d macos
```

### Run Automated Tests & Static Analysis
```bash
# Run code analysis
flutter analyze

# Run unit and widget tests
flutter test
```
