import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_colors.dart';
import '../core/app_strings.dart';
import '../widgets/google_logo.dart';
import '../widgets/onboarding_controls.dart';
import 'home_screen.dart';
import 'reset_password_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  void _handleGoogleSignIn(AppStrings strings) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(strings.googleSignInNotConfigured),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleForgotPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
    );
  }

  void _handleSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SignUpScreen()),
    );
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
                        AppAssets.logo,
                        height: 130,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      strings.loginToYourAccount,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.darkText : AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
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
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _handleLogin(),
                      style: TextStyle(
                        color: isDark ? AppColors.darkText : AppColors.lightText,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDark ? Colors.transparent : Colors.white,
                        hintText: strings.enterYourPassword,
                        hintStyle: TextStyle(color: hintColor, fontSize: 16),
                        prefixIcon: Icon(Icons.lock_outline, color: iconColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: iconColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
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
                        if (value == null || value.isEmpty) {
                          return strings.passwordRequired;
                        }
                        if (value.length < 6) {
                          return strings.passwordTooShort;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: _handleForgotPassword,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          strings.forgotPassword,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppPrimaryButton(
                      label: strings.login,
                      onPressed: _handleLogin,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          strings.dontHaveAccount,
                          style: TextStyle(
                            color: isDark
                                ? AppColors.darkText
                                : AppColors.lightText,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: _handleSignUp,
                          child: Text(
                            strings.signUp,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),



                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.primary,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            strings.or,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.primary,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () => _handleGoogleSignIn(strings),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        backgroundColor:
                            isDark ? Colors.transparent : Colors.white,
                        side: const BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const GoogleLogo(size: 24),
                          const SizedBox(width: 12),
                          Text(
                            strings.loginWithGoogle,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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

