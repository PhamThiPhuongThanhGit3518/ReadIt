import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/widgets/custom_role_card.dart';
import 'package:read_it/widgets/custom_text_field.dart';
import '../../services/viewmodels/auth_viewmodel.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends ConsumerState<SignUpScreen> {
  String name = "";
  String email = "";
  String password = "";
  String role = "";
  bool _isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.displayLarge ,
                      ),
                      const SizedBox(height: 8,),
                      Text(
                        'Start your journey as a reader or creator',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 28,),
                CustomTextField(
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    isPassword: false,
                    controller: nameController
                ),
                const SizedBox(height: 24,),
                CustomTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    isPassword: false,
                    controller: emailController
                ),
                const SizedBox(height: 24,),
                CustomTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    isPassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 24,),
                Text(
                  'I want to be a:',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 18,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => role = 'Reader'),
                      child: CustomRoleCard(
                        iconPath: 'assets/icons/ic_read_book.svg',
                        title: 'Reader',
                        subtitle: 'Read, manage library and discover stories',
                        isSelected: role == 'Reader'
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => role = 'Creator'),
                      child: CustomRoleCard(
                        iconPath: 'assets/icons/ic_write_book.svg',
                        title: 'Author',
                        subtitle: 'Write, publish PDFs and manage your audience',
                        isSelected: role == 'Creator'
                      )
                    )
                  ],
                ),
                const SizedBox(height: 24,),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                        if (nameController.text.trim().isEmpty ||
                            emailController.text.trim().isEmpty ||
                            passwordController.text.isEmpty ||
                            role.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Vui lòng điền đầy đủ thông tin và chọn vai trò!'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }

                        setState(() => _isLoading = true);

                        try {
                          print(
                            'name: ${nameController.text.trim()}, email: ${emailController.text.trim()}, password: ${passwordController.text}, role: $role',
                          );
                          await ref.read(authViewModelProvider.notifier).register(
                            nameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text,
                            role == 'Reader' ? 'viewer' : 'author',
                          );
                          ref.invalidate(authViewModelProvider);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Đăng ký thành công! Đang chuyển hướng...'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            context.go('/home');
                          }
                        } catch (e) {
                          String errorMessage = 'Đăng ký thất bại. Vui lòng thử lại.';
                          if (e.toString().contains('409') || e.toString().contains('already exists')) {
                            errorMessage = 'Email này đã được sử dụng!';
                          } else if (e.toString().contains('400') || e.toString().contains('validation')) {
                            errorMessage = 'Thông tin không hợp lệ (email hoặc password không đúng định dạng).';
                          } else if (e.toString().contains('network')) {
                            errorMessage = 'Không có kết nối mạng. Kiểm tra lại kết nối!';
                          }

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                                backgroundColor: Colors.redAccent,
                                duration: const Duration(seconds: 4),
                              ),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() => _isLoading = false);
                          }
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                          : Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface)
                    ),
                    GestureDetector(
                      onTap: () => context.go('/sign_in'),
                      child: Text(
                        'Log In',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                      )
                    )
                  ]
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
