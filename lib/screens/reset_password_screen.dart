import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_colors.dart';
import '../core/app_strings.dart';
import '../widgets/onboarding_controls.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      final strings = AppStrings.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(strings.resetPasswordEmailSent),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: isDark ? AppColors.primary : AppColors.grey.withValues(alpha: 0.4),
        width: isDark ? 1.2 : 1.0,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 1.8,
      ),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Colors.redAccent,
        width: 1.2,
      ),
    );

    final hintColor = isDark
        ? AppColors.darkText.withValues(alpha: 0.6)
        : AppColors.grey;
    final iconColor = isDark ? AppColors.primary : AppColors.grey;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          strings.forgetPasswordTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkText : AppColors.lightText,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    Center(
                      child: Image.asset(
                        AppAssets.forgetPassword,
                        height: 260,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _handleResetPassword(),
                      style: TextStyle(
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark ? Colors.transparent : Colors.white,
                        hintText: strings.enterYourEmail,
                        hintStyle: TextStyle(color: hintColor, fontSize: 16),
                        prefixIcon: Icon(Icons.email_outlined, color: iconColor),
                        border: inputBorder,
                        enabledBorder: inputBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: errorBorder,
                        focusedErrorBorder: errorBorder,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return strings.emailRequired;
                        }
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegex.hasMatch(value.trim())) {
                          return strings.invalidEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    AppPrimaryButton(
                      label: strings.resetPassword,
                      onPressed: _handleResetPassword,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
