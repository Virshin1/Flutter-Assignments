import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PasswordStrengthBar extends StatelessWidget {
  final String password;

  const PasswordStrengthBar({
    super.key,
    required this.password,
  });

  int get score {
    if (password.isEmpty) return 0;
    int points = 0;
    if (password.length >= 8) points++;
    if (RegExp(r'[A-Z]').hasMatch(password)) points++;
    if (RegExp(r'[0-9]').hasMatch(password)) points++;
    if (RegExp(r'[!@#\$&*~%^()_+=|<>?{}\[\]-]').hasMatch(password)) points++;
    return points;
  }

  Color get strengthColor {
    switch (score) {
      case 1:
        return AppColors.error;
      case 2:
        return AppColors.warning;
      case 3:
        return Colors.blue;
      case 4:
        return AppColors.success;
      default:
        return AppColors.border;
    }
  }

  String get strengthLabel {
    switch (score) {
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Strong';
      default:
        return 'Enter a password';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    final hasMinLength = password.length >= 8;
    final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecial = RegExp(r'[!@#\$&*~%^()_+=|<>?{}\[\]-]').hasMatch(password);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Password strength:',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              strengthLabel,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: strengthColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: List.generate(4, (index) {
            final isFilled = index < score;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: index < 3 ? 4 : 0),
                height: 4,
                decoration: BoxDecoration(
                  color: isFilled ? strengthColor : AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            _RequirementPill(label: '8+ chars', isMet: hasMinLength),
            _RequirementPill(label: 'Uppercase', isMet: hasUpper),
            _RequirementPill(label: 'Number', isMet: hasNumber),
            _RequirementPill(label: 'Special char', isMet: hasSpecial),
          ],
        ),
      ],
    );
  }
}

class _RequirementPill extends StatelessWidget {
  final String label;
  final bool isMet;

  const _RequirementPill({
    required this.label,
    required this.isMet,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isMet ? AppColors.secondaryLight : AppColors.background,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isMet ? AppColors.secondary.withValues(alpha: 0.4) : AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMet ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
            size: 11,
            color: isMet ? AppColors.secondary : AppColors.textMuted,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isMet ? FontWeight.w600 : FontWeight.normal,
              color: isMet ? AppColors.secondary : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
