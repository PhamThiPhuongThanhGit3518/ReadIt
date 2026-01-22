import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_it/widgets/custom_role_card.dart';
import 'package:read_it/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  String name = "";
  String phone = "";
  String password = "";
  String role = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
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
                    label: 'Phone Number',
                    hint: 'Enter your phone number',
                    isPassword: false,
                    controller: phoneController
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
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        )
                      ),
                      child: Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
                      )
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
