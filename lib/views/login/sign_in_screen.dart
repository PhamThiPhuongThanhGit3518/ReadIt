import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/widgets/custom_continue_card.dart';

import '../../viewmodels/auth/auth_viewmodel.dart';
import '../../widgets/custom_text_field.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  String email = "";
  String password = "";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Welcome back',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your details to access your library',
                      style: Theme.of(context).textTheme.displaySmall
                    )
                  ],
                ),
                const SizedBox(height: 48),
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/ic_book.svg',
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  isPassword: false,
                  controller: emailController,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  isPassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: ref.watch(authViewModelProvider).isLoading
                        ? null
                        : () async {
                      try {
                        await ref.read(authViewModelProvider.notifier).login(
                          emailController.text.trim(),
                          passwordController.text,
                        );
                        if (context.mounted) {
                          context.go('/home');
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                e.toString().contains('401') || e.toString().contains('Unauthorized')
                                    ? 'Email hoặc mật khẩu không đúng!'
                                    : 'Đăng nhập thất bại: $e',
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      }
                    },
                    child: ref.watch(authViewModelProvider).isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      'Log In',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? '
                    ),
                    GestureDetector(
                      onTap: () async {
                        context.go('/sign_up');
                      },
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                      )
                    )
                  ],
                ),
                const SizedBox(height: 32),
                Row (
                  children: [
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                        thickness: 1,
                      ),
                    ),
                    Text(
                      ' Or continue with ',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                    ),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: CustomContinueCard(
                        iconPath: 'assets/icons/ic_google.svg',
                        title: '  Google'
                      )
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomContinueCard(
                        iconPath: 'assets/icons/ic_apple.svg',
                        title: '  Apple',
                        color: Color(0xFFFFFFFF),
                      )
                    )
                  ]
                )
              ]
            ),
          ),
        )
      ),
    );
  }
}
