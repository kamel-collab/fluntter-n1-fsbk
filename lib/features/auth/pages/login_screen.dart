// lib/features/auth/pages/login_screen.dart

import 'package:first/features/home/pages/home_screen.dart';
import 'package:flutter/material.dart';
import '../../auth/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Connexion",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // Email
                CustomTextField(
                  controller: _emailController,
                  label: "Email",
                  hintText: "exemple@mail.com",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email requis";
                    }
                    if (!value.contains('@')) {
                      return "Email invalide";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                CustomTextField(
                  controller: _passwordController,
                  label: "Mot de passe",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mot de passe requis";
                    }
                    if (value.length < 3) {
                      return "Au moins 3 caractères";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: _isLoading ? null : _tryLogin,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Se connecter"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tryLogin() {
    if (_formKey.currentState?.validate() == true) {
      setState(() => _isLoading = true);

      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() => _isLoading = false);

        // 🔁 Navigation vers Home via route nommée
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      });
    }
  }
}
