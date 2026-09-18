import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import '../models/user_model.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/password_strength_bar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = false;
  bool _termsError = false;
  bool _isSubmitting = false;
  String _selectedGender = 'Male';

  final List<String> _genders = ['Male', 'Female', 'Other', 'Prefer not to say'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    setState(() {
      _agreedToTerms = false;
      _termsError = false;
      _selectedGender = 'Male';
    });
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!_agreedToTerms) {
      setState(() {
        _termsError = true;
      });
    } else {
      setState(() {
        _termsError = false;
      });
    }

    if (!isValid || !_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the highlighted errors before submitting.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Short simulated delay for smooth UX transition
    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    final user = UserModel(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      gender: _selectedGender,
      registeredAt: DateTime.now(),
    );

    setState(() {
      _isSubmitting = false;
    });

    // Navigate to Detail Screen using Named Route with arguments
    Navigator.pushNamed(
      context,
      AppRoutes.detail,
      arguments: user,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Create Account',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _resetForm,
            child: const Text(
              'Reset',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.border, height: 1.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: AppColors.primary,
                        size: 22,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Fill out the mandatory fields below. Your credentials will be validated against strict security rules.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primaryDark,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Full Name Field
                CustomTextField(
                  key: const Key('name_field'),
                  controller: _nameController,
                  labelText: 'Full Name *',
                  hintText: 'e.g. John Doe',
                  prefixIcon: Icons.person_outline_rounded,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Full name is required';
                    }
                    if (value.trim().length < 3) {
                      return 'Name must be at least 3 characters long';
                    }
                    if (!RegExp(r"^[a-zA-Z\s.'-]+$").hasMatch(value.trim())) {
                      return 'Name must only contain alphabetical characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Email Address Field
                CustomTextField(
                  key: const Key('email_field'),
                  controller: _emailController,
                  labelText: 'Email Address *',
                  hintText: 'e.g. name@example.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email address is required';
                    }
                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Enter a valid email address (e.g. user@domain.com)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Phone Number Field
                CustomTextField(
                  key: const Key('phone_field'),
                  controller: _phoneController,
                  labelText: 'Phone Number *',
                  hintText: 'e.g. 9876543210 (10 digits)',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Phone number is required';
                    }
                    final cleanPhone = value.replaceAll(RegExp(r'\D'), '');
                    if (cleanPhone.length != 10) {
                      return 'Enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Gender Selection Dropdown
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gender *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 1.2),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          key: const Key('gender_dropdown'),
                          value: _selectedGender,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.primary,
                          ),
                          items: _genders.map((gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(
                                gender,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedGender = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Password Field
                CustomTextField(
                  key: const Key('password_field'),
                  controller: _passwordController,
                  labelText: 'Password *',
                  hintText: 'Minimum 8 characters with upper, number & symbol',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: _obscurePassword,
                  onChanged: (_) => setState(() {}),
                  suffixIcon: IconButton(
                    key: const Key('toggle_password_visibility'),
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return 'Password must contain at least one uppercase letter';
                    }
                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return 'Password must contain at least one number';
                    }
                    if (!RegExp(r'[!@#\$&*~%^()_+=|<>?{}\[\]-]').hasMatch(value)) {
                      return 'Password must contain at least one special character';
                    }
                    return null;
                  },
                ),

                // Dynamic Password Strength Meter
                PasswordStrengthBar(password: _passwordController.text),
                const SizedBox(height: 18),

                // Confirm Password Field
                CustomTextField(
                  key: const Key('confirm_password_field'),
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password *',
                  hintText: 'Re-enter your password to confirm',
                  prefixIcon: Icons.lock_clock_outlined,
                  obscureText: _obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    key: const Key('toggle_confirm_visibility'),
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Terms and Conditions Checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      key: const Key('terms_checkbox'),
                      value: _agreedToTerms,
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _agreedToTerms = val ?? false;
                          if (_agreedToTerms) _termsError = false;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'I agree to the Terms of Service and Privacy Policy.',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                if (_termsError)
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
                    child: Text(
                      'You must accept the terms before submitting.',
                      style: TextStyle(
                        color: AppColors.error,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

                // Submit Button
                ElevatedButton(
                  key: const Key('submit_button'),
                  onPressed: _isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            color: Colors.white,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Complete Registration',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded, size: 18),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
