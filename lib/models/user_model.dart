class UserModel {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final DateTime registeredAt;

  const UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.registeredAt,
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts[0].isEmpty) return 'U';
    if (parts.length == 1) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  String get formattedDate {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final month = months[registeredAt.month - 1];
    final day = registeredAt.day;
    final year = registeredAt.year;
    
    final hour24 = registeredAt.hour;
    final period = hour24 >= 12 ? 'PM' : 'AM';
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = registeredAt.minute.toString().padLeft(2, '0');

    return '$month $day, $year • $hour12:$minute $period';
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? gender,
    DateTime? registeredAt,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      registeredAt: registeredAt ?? this.registeredAt,
    );
  }
}
