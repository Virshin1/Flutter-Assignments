class UserProfile {
  final int id;
  final String name;
  final String email;
  final String? bio;
  final String? phoneNumber;
  final double? rating;
  final List<String>? skills;
  final Map<String, dynamic>? preferences;

  // Demonstrates late final field with initialization
  late final String displayCard = _generateDisplayCard();

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.bio,
    this.phoneNumber,
    this.rating,
    this.skills,
    this.preferences,
  });

  /// Factory constructor parsing mock JSON/Map data with null safety operators
  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      id: data['id'] is int ? data['id'] as int : int.parse(data['id'].toString()),
      name: (data['name'] as String?) ?? 'Anonymous User',
      email: (data['email'] as String?) ?? 'no-email@domain.com',
      bio: data['bio'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      rating: (data['rating'] as num?)?.toDouble(),
      skills: (data['skills'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList(),
      preferences: data['preferences'] as Map<String, dynamic>?,
    );
  }

  String _generateDisplayCard() {
    return 'ID: #$id | $name ($email)';
  }

  void displayDetails() {
    print('----------------------------------------------------');
    print('  Card Header   : $displayCard');
    print('  User ID       : $id');
    print('  Full Name     : $name');
    print('  Email Address : $email');

    // Using ?? null-coalescing fallback
    print('  Biography     : ${bio ?? "[No biography provided]"}');
    print('  Phone Number  : ${phoneNumber ?? "[No contact number available]"}');

    // Safe navigation and formatting
    String ratingText = rating != null ? rating!.toStringAsFixed(1) : 'Unrated';
    print('  User Rating   : $ratingText ⭐');

    // Null safe collection access
    int skillCount = skills?.length ?? 0;
    String skillsList = skills != null && skills!.isNotEmpty
        ? skills!.join(', ')
        : '[No skills listed]';
    print('  Skills ($skillCount)   : $skillsList');

    // Safe navigation on nested Map
    String theme = preferences?['theme']?.toString() ?? 'Default (System Light)';
    bool notifications = (preferences?['notificationsEnabled'] as bool?) ?? false;
    print('  Preferences   : Theme -> $theme | Notifications -> $notifications');
    print('----------------------------------------------------');
  }
}
