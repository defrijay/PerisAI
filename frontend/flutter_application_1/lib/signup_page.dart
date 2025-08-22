import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Simulasi proses signup
  Future<bool> _processSignup() async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulasi: sukses kalau email mengandung "@"
    return _emailController.text.contains("@");
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Konfirmasi", textAlign: TextAlign.center),
        content: const Text(
          "Apakah Anda Yakin Sudah Mengisi Data dengan Benar?",
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context); // tutup dialog
              bool success = await _processSignup();
              if (success) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SuccessPage()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const FailedPage()),
                );
              }
            },
            child: const Text("Ya, Sudah Benar!"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Kembali"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1020),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text("Sign up",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 4),
                const Text("Feel safe anywhere.",
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 20),

                // Username
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Username tidak boleh kosong" : null,
                ),
                const SizedBox(height: 12),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Email tidak boleh kosong" : null,
                ),
                const SizedBox(height: 12),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Password tidak boleh kosong" : null,
                ),
                const SizedBox(height: 12),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirmation Password",
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value != _passwordController.text
                          ? "Password tidak cocok"
                          : null,
                ),
                const SizedBox(height: 20),

                // Sign Up Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showConfirmationDialog();
                    }
                  },
                  child: const Text("Sign up to PerisAI"),
                ),

                const SizedBox(height: 10),
                const Center(
                    child: Text("Or sign up with",
                        style: TextStyle(color: Colors.white70))),
                const SizedBox(height: 10),

                // Google Sign Up Button
                ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text("Sign up with Google"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {
                    // TODO: Integrasi Google Sign-In
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Success Page
class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1020),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),
            const Text("Selamat Pembuatan Akun Berhasil!",
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Selanjutnya"),
            ),
          ],
        ),
      ),
    );
  }
}

// Failed Page
class FailedPage extends StatelessWidget {
  const FailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1020),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cancel, color: Colors.red, size: 100),
            const SizedBox(height: 20),
            const Text("Maaf Pembuatan Akun Gagal!",
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Kembali"),
            ),
          ],
        ),
      ),
    );
  }
}
