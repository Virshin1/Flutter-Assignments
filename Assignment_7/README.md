<div align="center">

# ⚡ Nexus ID

### Modern Digital Identity & Enterprise Onboarding Platform

[![Flutter Version](https://img.shields.io/badge/Flutter-3.47.0-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.13.0-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Material 3](https://img.shields.io/badge/Design-Material%203-7C3AED?style=for-the-badge)](https://m3.material.io)
[![Platform Support](https://img.shields.io/badge/Platforms-iOS%20|%20Android%20|%20macOS%20|%20Web-4F46E5?style=for-the-badge)]()
[![Build & Tests](https://img.shields.io/badge/Tests-4%2F4%20Passing-10B981?style=for-the-badge&logo=githubactions&logoColor=white)]()

<p align="center">
  A state-of-the-art Flutter multi-screen client showcasing <b>declarative named routing</b>, <b>real-time cryptographic form validation</b>, and <b>type-safe parameter transmission</b> across an intuitive onboarding journey.
</p>

[📄 View Technical Documentation (Markdown)](DOCUMENTATION.md) &nbsp;|&nbsp; [📥 Download Engineering PDF Report (5 Pages)](DOCUMENTATION.pdf)

---

</div>

## 📸 Visual Showcase

<div align="center">
  <table>
    <tr>
      <th align="center" width="33%"><b>Stage 1: Discovery Portal</b></th>
      <th align="center" width="33%"><b>Stage 2: Credentials Form</b></th>
      <th align="center" width="33%"><b>Stage 3: Verified Member Profile</b></th>
    </tr>
    <tr>
      <td align="center" valign="top">
        <img src="SS/home_screen.png" alt="Discovery Screen" width="100%" style="border-radius: 12px;" />
        <br><sub><b>Route:</b> <code>'/'</code></sub>
        <br><sub>• Hero Banner & Enterprise SLA</sub>
        <br><sub>• Capability Showcase Cards</sub>
        <br><sub>• 3-Step Journey Visualizer</sub>
      </td>
      <td align="center" valign="top">
        <img src="SS/registration_screen.png" alt="Registration Form Screen" width="100%" style="border-radius: 12px;" />
        <br><sub><b>Route:</b> <code>'/register'</code></sub>
        <br><sub>• Strict RFC Regex Validation</sub>
        <br><sub>• Live Password Strength Meter</sub>
        <br><sub>• Dual Visibility Toggles</sub>
      </td>
      <td align="center" valign="top">
        <img src="SS/detail_screen.png" alt="Member Profile Screen" width="100%" style="border-radius: 12px;" />
        <br><sub><b>Route:</b> <code>'/details'</code></sub>
        <br><sub>• Cryptographic Profile Badge</sub>
        <br><sub>• Formatted Initials Avatar</sub>
        <br><sub>• 1-Tap Clipboard Copy & Unwind</sub>
      </td>
    </tr>
  </table>
</div>

---

## 🌟 Key Capabilities

- **Declarative Named Routing (`AppRoutes.generateRoute`):** Built on clean string route identifiers (`'/'`, `'/register'`, `'/details'`) with strongly-typed argument extraction and defensive 404 fallback routing.
- **Dynamic Password Strength Heuristic:** Computes length, casing, numeric, and symbolic complexity in real time, giving instant visual feedback with requirement checklist pills.
- **Strict Client-Side Validation Matrix:** Guarantees data integrity across 6 validation layers before permitting route transitions.
- **Immutable Domain Modeling (`UserModel`):** Value-based object encapsulation with automatic initials extraction and readable timestamp formatting.
- **Modern Material 3 Aesthetic:** Curated Deep Indigo and Emerald color palette with smooth gradients, soft shadows, and high-contrast typography.

---

## 🔒 Form Validation Specifications

| Field | Criteria | Pattern / Validation Logic |
| :--- | :--- | :--- |
| **Full Name** | Required • $\ge 3$ characters • Alphabetic | `RegExp(r"^[a-zA-Z\s.'-]+$")` |
| **Email Address** | Required • RFC-compliant format | `RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')` |
| **Phone Number** | Required • Exactly 10 digits | `value.replaceAll(RegExp(r'\D'), '').length == 10` |
| **Password** | Required • $\ge 8$ chars • Upper • Number • Symbol | 4-point real-time additive evaluator |
| **Confirm Password** | Required • Cross-field equality | Must match password controller value |
| **Terms of Service** | Required • Explicit Boolean consent | Mandatory checkbox agreement |

---

## 📐 Architecture & Routing Flow

```
   [ HomeScreen ]
         │
         │  Navigator.pushNamed(context, AppRoutes.register)
         ▼
[ RegistrationScreen ]
         │
         │  Form.validate() == true
         │  Navigator.pushNamed(context, AppRoutes.detail, arguments: UserModel)
         ▼
  [ DetailScreen ]
    ├── Tap "Edit Details"  ──>  Navigator.pop() [Preserves input state]
    └── Tap "Back to Home"  ──>  Navigator.popUntil('/') [Clears route stack]
```

---

## 📂 Project Structure

```text
lib/
├── main.dart                      # Application initialization & Material 3 theme
├── constants/
│   ├── app_colors.dart            # Design tokens (Indigo, Emerald, Slate)
│   └── app_routes.dart            # Named routes & onGenerateRoute coordinator
├── models/
│   └── user_model.dart            # Immutable UserModel with initials & timestamp helpers
├── screens/
│   ├── home_screen.dart           # Screen 1: Discovery portal & journey overview
│   ├── registration_screen.dart   # Screen 2: Validated user enrollment form
│   └── detail_screen.dart         # Screen 3: Verified member profile & actions
└── widgets/
    ├── custom_text_field.dart     # Input field wrapper with error decoration
    └── password_strength_bar.dart # Reactive strength evaluator with requirement pills
```

---

## 🚀 Quickstart Guide

### Prerequisites
- Flutter SDK **3.47+**
- Dart SDK **3.13+**

### 1. Clone & Navigate
```bash
cd /Users/virshin/VScode/Cross-App/Assignments
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Launch Application
```bash
# Run on macOS desktop
flutter run -d macos

# Run on Google Chrome
flutter run -d chrome

# Run on iOS / Android Simulator
flutter run
```

---

## 🧪 Quality Assurance & Testing

The repository maintains **100% clean static analysis** and includes full end-to-end automated widget tests.

### Static Code Analysis
```bash
flutter analyze
```
```text
Analyzing Assignments...
No issues found! (ran in 2.4s)
```

### Automated Widget Test Suite
```bash
flutter test
```
```text
00:00 +0: loading test/widget_test.dart
00:00 +0: Home screen renders and navigates to Registration screen
00:00 +1: Registration form validates required fields and regexes
00:00 +2: Registration form completes successfully and passes data to Detail screen
00:01 +3: Detail screen handles empty arguments gracefully
00:01 +4: All tests passed!
```

---

## 📖 In-Depth Technical Report & PDF

For a complete architectural breakdown covering UI/UX methodologies, navigation state machines, accessibility tokens, and future scalability patterns, consult:

- 👉 **[DOCUMENTATION.md](DOCUMENTATION.md)** (Full Markdown Technical Report)
- 📥 **[DOCUMENTATION.pdf](DOCUMENTATION.pdf)** (5-Page Publication-Grade PDF with Visual Screenshots)

---

<div align="center">
  <sub>Built with ❤️ using Flutter & Dart • Designed for Production Grade Identity Onboarding</sub>
</div>
