import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileApp());
}

// ======================================================
// PALETTE CONSTANTS (Custom Theme Colors)
// ======================================================
class AppPalette {
  static const Color primary = Color(0xFF4F46E5); // Rich Indigo Accent
  static const Color primaryLight = Color(0xFFEEF2FF); // Soft Indigo Tint
  static const Color secondary = Color(0xFF0D9488); // Ocean Teal Accent
  static const Color secondaryLight = Color(0xFFCCFBF1); // Soft Teal Tint
  static const Color background = Color(0xFFF1F5F9); // Warm Slate Background
  static const Color surface = Color(0xFFFFFFFF); // Pure White Card Surface
  static const Color cardBorder = Color(0xFFE2E8F0); // Subtle Slate-200 Border
  static const Color textPrimary = Color(0xFF1E293B); // Slate-800 Heading Text
  static const Color textSecondary = Color(0xFF64748B); // Slate-500 Body Text
  static const Color star = Color(0xFFF59E0B); // Amber Rating Star
}

// ======================================================
// USER PROFILE MODEL (Data Entity & Null Safety)
// ======================================================
class UserProfile {
  final String name;
  final String role;
  final String rollNumber;
  final String department;
  final String email;
  final String phone;
  final String location;
  final String? bio;
  final int projectsCount;
  final int repoCount;
  final double rating;

  const UserProfile({
    required this.name,
    required this.role,
    required this.rollNumber,
    required this.department,
    required this.email,
    required this.phone,
    required this.location,
    this.bio,
    this.projectsCount = 0,
    this.repoCount = 0,
    this.rating = 5.0,
  });

  /// Null-coalescing fallback for biography string
  String get displayBio =>
      bio ??
      'Passionate student developer building modern, interactive cross-platform applications with Flutter & Dart.';
}

// ======================================================
// APPLICATION SETUP (Theme & Material 3 Configuration)
// ======================================================
class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppPalette.primary,
          primary: AppPalette.primary,
          secondary: AppPalette.secondary,
          surface: AppPalette.surface,
        ),
        scaffoldBackgroundColor: AppPalette.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppPalette.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const ProfileCardScreen(),
    );
  }
}

// ======================================================
// PROFILE CARD SCREEN (Main View)
// ======================================================
class ProfileCardScreen extends StatelessWidget {
  const ProfileCardScreen({super.key});

  // Mock student profile data
  static const UserProfile profile = UserProfile(
    name: 'R Virshin',
    role: 'Flutter & Mobile App Developer',
    rollNumber: '150096724147',
    department: 'Computer Science & AI',
    email: 'virshinkumar@gmail.com',
    phone: '+91 98765 43210',
    location: 'Bangalore, India',
    bio:
        'Passionate student developer building modern, interactive, and responsive cross-platform applications with Flutter & Dart.',
    projectsCount: 12,
    repoCount: 35,
    rating: 4.9,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // ==========================================
      // APP BAR
      // ==========================================
      appBar: AppBar(
        title: const Text(
          'Profile Card',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.share_outlined, color: Colors.white),
          ),
        ],
      ),

      // ==========================================
      // BODY
      // ==========================================
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ============================================================
              // MAIN PROFILE CARD (Container with subtle shadow & border)
              // ============================================================
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 420),
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: AppPalette.surface,
                  borderRadius: BorderRadius.circular(24.0),
                  border: Border.all(color: AppPalette.cardBorder, width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000), // Soft diffused shadow
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // --------------------------------------------------------
                    // 1. AVATAR SECTION (CircleAvatar + Container frame)
                    // --------------------------------------------------------
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppPalette.primary,
                          width: 3.0,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 46,
                        backgroundColor: AppPalette.primaryLight,
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: AppPalette.primary,
                          child: Icon(
                            Icons.person,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --------------------------------------------------------
                    // 2. NAME & ROLE (Text)
                    // --------------------------------------------------------
                    Text(
                      profile.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.textPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      profile.role,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppPalette.primary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // --------------------------------------------------------
                    // 3. BADGES ROW (Row + Container pills + Icon + Text)
                    // --------------------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppPalette.primaryLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.code,
                                size: 14,
                                color: AppPalette.primary,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Developer',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppPalette.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppPalette.secondaryLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified,
                                size: 14,
                                color: AppPalette.secondary,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Verified',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppPalette.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // --------------------------------------------------------
                    // 4. BIO SECTION (Container + Text)
                    // --------------------------------------------------------
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppPalette.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        profile.displayBio,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppPalette.textSecondary,
                          height: 1.45,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --------------------------------------------------------
                    // 5. STATISTICS SECTION (Container + Row + Column)
                    // --------------------------------------------------------
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppPalette.cardBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${profile.projectsCount}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppPalette.primary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Projects',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: AppPalette.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 28,
                            width: 1,
                            color: AppPalette.cardBorder,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${profile.repoCount}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppPalette.primary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Repos',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: AppPalette.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 28,
                            width: 1,
                            color: AppPalette.cardBorder,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${profile.rating}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppPalette.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  const Icon(
                                    Icons.star,
                                    size: 15,
                                    color: AppPalette.star,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Rating',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: AppPalette.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --------------------------------------------------------
                    // 6. CONTACT DETAILS LIST (Column + Row + Icon + Text)
                    // --------------------------------------------------------
                    Column(
                      children: [
                        _ContactInfoRow(
                          icon: Icons.badge_outlined,
                          label: 'Roll Number',
                          value: profile.rollNumber,
                        ),
                        const SizedBox(height: 10),
                        _ContactInfoRow(
                          icon: Icons.school_outlined,
                          label: 'Department',
                          value: profile.department,
                        ),
                        const SizedBox(height: 10),
                        _ContactInfoRow(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: profile.email,
                        ),
                        const SizedBox(height: 10),
                        _ContactInfoRow(
                          icon: Icons.phone_outlined,
                          label: 'Phone',
                          value: profile.phone,
                        ),
                        const SizedBox(height: 10),
                        _ContactInfoRow(
                          icon: Icons.location_on_outlined,
                          label: 'Location',
                          value: profile.location,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // --------------------------------------------------------
                    // 7. ACTION BUTTONS (Row + Container + Icon + Text)
                    // --------------------------------------------------------
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.send_rounded,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Message',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: theme.colorScheme.primary,
                                width: 1.5,
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_add_alt_1_outlined,
                                  size: 18,
                                  color: AppPalette.primary,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Connect',
                                  style: TextStyle(
                                    color: AppPalette.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
// REUSABLE SUB-COMPONENTS
// ======================================================

/// Reusable contact details row constructed using Container, Row, Icon, and Text
class _ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppPalette.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppPalette.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppPalette.primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 18,
              color: AppPalette.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: AppPalette.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppPalette.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
