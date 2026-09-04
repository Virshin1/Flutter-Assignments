# 📱 Flutter Profile Card Screen (Assignment 4)

A responsive, production-ready Flutter profile card interface engineered with foundational widgets (`Column`, `Row`, `Container`, `CircleAvatar`, `Text`, and `Icon`), custom theme architecture, sound null-safety practices, and Material 3 design principles.

---

## 🚀 Key Highlights & Architecture

- **Foundational Layout Architecture**:
  - Employs **`Column`** for structured vertical sequencing (Avatar → Identity → Badges → Bio → Statistics → Contact List → Actions).
  - Employs **`Row`** for balanced horizontal arrangements (AppBar actions, status badge chips, 3-metric statistics grid, and dual action buttons).
  - Responsive layout wrapped in `SingleChildScrollView` to eliminate rendering overflows across all device form factors.
- **Polished Card Design & Container Aesthetics**:
  - Elevated card container with `24px` rounded corners, subtle slate border (`1.5px`), and diffused drop shadow (`BoxShadow`).
  - Concentric dual-layer **`CircleAvatar`** system with contrast theme rings and primary profile icon.
  - Interactive status badges (`Developer` & `Verified`) and dual action buttons (`Message` & `Connect`).
- **Curated Theme System (`AppPalette`)**:
  - Dedicated palette decoupling UI colors into semantic constants (Rich Indigo, Ocean Teal, Warm Slate, Pure White).
  - Native integration with Material 3 via `ThemeData(colorScheme: ColorScheme.fromSeed(...))`.
- **Domain Modeling & Defensive Null Safety**:
  - Immutable **`UserProfile`** data entity decoupling profile metadata from layout code.
  - Demonstrates safe fallback handling using the null-coalescing operator (`bio ?? ...`).
- **Comprehensive Documentation & Quality Assurance**:
  - Includes a publication-ready **4-page Microsoft Word Document** (`DOCUMENTATION.docx`) and technical markdown report (`DOCUMENTATION.md`).
  - 100% pass rate in automated widget testing and 0 warnings or lints in static analysis.

---

## 📁 Project Structure

```text
profile/
├── README.md                 # Project overview, concept mapping & execution guide
├── DOCUMENTATION.md          # Comprehensive multi-page technical report
├── DOCUMENTATION.docx        # Formatted 4-page Microsoft Word technical report
├── assets/
│   ├── screenshot_top.png    # Verified execution screenshot (upper profile card view)
│   └── screenshot_bottom.png # Verified execution screenshot (contact list & action buttons)
├── lib/
│   └── main.dart             # Complete application (AppPalette, UserProfile & ProfileCardScreen)
├── test/
│   └── widget_test.dart      # Automated component test suite verifying all required widgets
└── pubspec.yaml              # Dependencies and Flutter SDK configuration
```

---

## 🛠️ Concepts & Widgets Demonstrated

| Widget / Concept | Curriculum Role | Implementation in Profile Card |
| :--- | :--- | :--- |
| **`Column`** | Vertical layout sequencing | Orders the avatar, name, subtitle, badges, bio box, stats panel, contact list, and buttons with `MainAxisSize.min`. |
| **`Row`** | Horizontal distribution | Organizes the AppBar actions, status badge chips, 3-metric stats grid, contact item pairings, and dual action buttons. |
| **`Container`** | Box styling & decoration | Builds the elevated card wrapper (`BorderRadius.circular(24)`, `BoxShadow`, `Border`), badge chips, and action buttons. |
| **`CircleAvatar`** | Concentric clipping & avatars | Layers two concentric avatars (radius 46 and 42) with contrast theme backgrounds to display the primary profile icon. |
| **`Text`** | Typographic scale | Displays name (22pt bold), role (14pt semibold), bio (12.5pt muted), statistics, contact values, and button labels. |
| **`Icon`** | Contextual Material iconography | Integrates `person`, `code`, `verified`, `star`, `badge_outlined`, `school_outlined`, `email_outlined`, `phone_outlined`, `location_on_outlined`, and `send_rounded`. |
| **`AppPalette`** | Centralized design tokens | Custom semantic color class providing global theme constants for Material 3 `ThemeData`. |
| **`UserProfile`** | Sound Null Safety | Immutable data model with nullable `String? bio` and null-coalescing fallback getter (`displayBio`). |

---

## 🎨 Theme Palette Constants (`AppPalette`)

| Constant | Hex Value | Color Preview | Semantic Role |
| :--- | :--- | :--- | :--- |
| `AppPalette.primary` | `#4F46E5` | 🟦 Rich Indigo | Brand primary, AppBar background, avatar, and active action button |
| `AppPalette.primaryLight` | `#EEF2FF` | 🩵 Soft Indigo Tint | Outer avatar ring, badge pill backgrounds, and contact icon frames |
| `AppPalette.secondary` | `#0D9488` | 🟩 Ocean Teal Accent | Secondary brand accent, verification checkmarks, and secondary pill text |
| `AppPalette.secondaryLight`| `#CCFBF1` | 🟢 Soft Teal Tint | Verification pill background creating high-contrast readability |
| `AppPalette.background` | `#F1F5F9` | ⬜ Slate-100 Canvas | Scaffold canvas color providing subtle contrast against the white card |
| `AppPalette.surface` | `#FFFFFF` | ⬜ Pure White Card | Card body surface reflecting clean elevation above the canvas |
| `AppPalette.cardBorder` | `#E2E8F0` | ◽ Slate-200 Border | Subtle border outlining cards, stats panel, and contact tiles |
| `AppPalette.textPrimary` | `#1E293B` | ⬛ Slate-800 Heading | High-contrast text for student name, primary labels, and contact values |
| `AppPalette.textSecondary` | `#64748B` | ▫️ Slate-500 Body | Muted body text for biography, section descriptors, and contact titles |
| `AppPalette.star` | `#F59E0B` | 🟨 Amber Star | Vibrant star icon color for user review rating display |

---

## 🖥️ Live Application Screenshots & Visual Proof

### Figure 1: Upper Profile Card & Navigation View
![Figure 1: Upper Profile Card View](assets/screenshot_top.png)
*Live execution showing custom Indigo AppBar, Concentric Avatar, Student Name, Badges, Bio Box, and Statistics Grid.*

---

### Figure 2: Scrolled View with Contact List & Interactive Actions
![Figure 2: Contact Details and Actions View](assets/screenshot_bottom.png)
*Scrolled view displaying complete contact tiles (Roll No, Department, Email, Phone, Location) and dual Action Buttons.*

---

## ▶️ Getting Started & Execution

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.13 or newer)
- [Dart SDK](https://dart.dev/get-dart) (version 3.0 or newer)
- Google Chrome, macOS desktop, or an Android/iOS emulator

### Running the Application

1. Open your terminal and navigate to the project directory:
   ```bash
   cd Assignments/profile
   ```

2. Run static analysis to verify code quality:
   ```bash
   flutter analyze
   ```

3. Execute the automated widget test suite:
   ```bash
   flutter test
   ```

4. Launch the application in Google Chrome:
   ```bash
   flutter run -d chrome
   ```
   *(Alternatively, run on macOS desktop via `flutter run -d macos`)*

---

## 🧪 Verification & Static Analysis Results

### 1. Static Analysis (`flutter analyze`)
```bash
$ flutter analyze
Analyzing profile...                                            
No issues found! (ran in 1.3s)
```

### 2. Automated Widget Testing (`flutter test`)
```bash
$ flutter test
00:00 +0: loading test/widget_test.dart
00:00 +0: Profile card renders required widgets and content
00:02 +1: All tests passed!
```

---

## 👤 Student Profile Information

- **Name:** R Virshin
- **Roll Number:** 150096724147
- **Department:** Computer Science & Artificial Intelligence
- **Course:** Cross-Platform Mobile Application Development (Flutter & Dart)
- **Assignment:** Assignment 4 - Profile Card Screen
