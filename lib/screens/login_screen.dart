import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import '../utils/strings.dart';
import '../utils/providers.dart';
import 'main_shell.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idCtrl   = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure  = true;
  bool _loading  = false;
  String? _error;

  @override
  void dispose() {
    _idCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final l = context.read<LanguageProvider>().lang;
    final id   = _idCtrl.text.trim();
    final pass = _passCtrl.text.trim();

    if (id.isEmpty || pass.isEmpty) {
      setState(() => _error = AppStrings.t('fields_required', l));
      return;
    }

    setState(() { _loading = true; _error = null; });

    final result = await context.read<UserProvider>().login(id, pass);

    if (!mounted) return;
    setState(() => _loading = false);

    if (result['success'] == true) {
      // Show offline warning if needed
      if (result['offline'] == true && result['message'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: AppColors.warning,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const MainShell()));
    } else {
      setState(() => _error = result['message'] ?? 'Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final l    = lang.lang;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 36),

              // ── Logo ──────────────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 82, height: 82,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [BoxShadow(
                          color: AppColors.primary.withOpacity(0.28),
                          blurRadius: 18, offset: const Offset(0, 7))],
                      ),
                      child: const Icon(Icons.health_and_safety_outlined,
                          color: Colors.white, size: 42),
                    ),
                    const SizedBox(height: 14),
                    Text(AppStrings.t('app_name', l),
                      style: const TextStyle(fontSize: 30,
                        fontWeight: FontWeight.w800, color: AppColors.primary,
                        letterSpacing: 1.2)),
                    const SizedBox(height: 4),
                    Text(AppStrings.t('app_tagline', l),
                      style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // ── Language toggle ───────────────────────────────────
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _LangOption(label: 'English', active: l == 'en',
                          onTap: () => lang.setLanguage('en')),
                      _LangOption(label: 'हिंदी', active: l == 'hi',
                          onTap: () => lang.setLanguage('hi')),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // ── Fields ────────────────────────────────────────────
              _FieldLabel(AppStrings.t('patient_id', l)),
              const SizedBox(height: 6),
              TextField(
                controller: _idCtrl,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: AppStrings.t('patient_id_hint', l),
                  prefixIcon: const Icon(Icons.badge_outlined,
                      color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 14),

              _FieldLabel(AppStrings.t('password', l)),
              const SizedBox(height: 6),
              TextField(
                controller: _passCtrl,
                obscureText: _obscure,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _login(),
                decoration: InputDecoration(
                  hintText: AppStrings.t('password_hint', l),
                  prefixIcon: const Icon(Icons.lock_outline,
                      color: AppColors.primary),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                        color: Colors.grey),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),

              if (_error != null) ...[
                const SizedBox(height: 10),
                _ErrorBox(_error!),
              ],

              const SizedBox(height: 22),

              ElevatedButton(
                onPressed: _loading ? null : _login,
                child: _loading
                    ? const SizedBox(height: 22, width: 22,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2.5))
                    : Text(AppStrings.t('login_btn', l)),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.t('no_account', l),
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterScreen())),
                    child: Text(AppStrings.t('register_link', l),
                        style: const TextStyle(color: AppColors.primary,
                            fontWeight: FontWeight.w600, fontSize: 13)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Online indicator
              Consumer<UserProvider>(
                builder: (_, user, __) => Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(
                        user.isOnline
                            ? Icons.wifi : Icons.wifi_off,
                        size: 14,
                        color: user.isOnline
                            ? AppColors.primary : AppColors.warning),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          user.isOnline
                              ? (l == 'hi'
                                  ? 'ऑनलाइन — डेटा सर्वर पर सेव होगा'
                                  : 'Online — data will sync to server')
                              : (l == 'hi'
                                  ? 'ऑफलाइन — डेटा locally सेव होगा'
                                  : 'Offline — data saved locally only'),
                          style: const TextStyle(
                              fontSize: 11, color: AppColors.primaryDark),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _LangOption extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _LangOption({required this.label,
      required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(label,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
            color: active ? Colors.white : Colors.grey[500])),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
        color: AppColors.textPrimary));
}

class _ErrorBox extends StatelessWidget {
  final String message;
  const _ErrorBox(this.message);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.danger.withOpacity(0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.danger.withOpacity(0.3))),
    child: Row(children: [
      const Icon(Icons.error_outline, color: AppColors.danger, size: 16),
      const SizedBox(width: 8),
      Expanded(child: Text(message,
          style: const TextStyle(color: AppColors.danger, fontSize: 12))),
    ]),
  );
}
