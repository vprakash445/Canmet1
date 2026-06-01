import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import '../utils/strings.dart';
import '../utils/providers.dart';
import 'main_shell.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl     = TextEditingController();
  final _ageCtrl      = TextEditingController();
  final _cancerCtrl   = TextEditingController();
  final _hospitalCtrl = TextEditingController();
  final _mobileCtrl   = TextEditingController();
  final _passCtrl     = TextEditingController();
  final _confirmCtrl  = TextEditingController();

  String _gender       = 'Male';
  bool   _obscurePass  = true;
  bool   _obscureConf  = true;
  bool   _loading      = false;
  String? _error;

  @override
  void dispose() {
    _nameCtrl.dispose(); _ageCtrl.dispose(); _cancerCtrl.dispose();
    _hospitalCtrl.dispose(); _mobileCtrl.dispose();
    _passCtrl.dispose(); _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final l = context.read<LanguageProvider>().lang;

    if (_nameCtrl.text.trim().isEmpty ||
        _ageCtrl.text.trim().isEmpty ||
        _cancerCtrl.text.trim().isEmpty ||
        _passCtrl.text.trim().isEmpty) {
      setState(() => _error = AppStrings.t('fields_required', l));
      return;
    }
    if (_passCtrl.text != _confirmCtrl.text) {
      setState(() => _error = AppStrings.t('password_mismatch', l));
      return;
    }

    setState(() { _loading = true; _error = null; });

    final result = await context.read<UserProvider>().register(
      name:       _nameCtrl.text.trim(),
      age:        _ageCtrl.text.trim(),
      gender:     _gender,
      cancerType: _cancerCtrl.text.trim(),
      hospitalId: _hospitalCtrl.text.trim(),
      mobile:     _mobileCtrl.text.trim(),
      password:   _passCtrl.text.trim(),
      language:   context.read<LanguageProvider>().lang,
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (result['success'] == true) {
      if (result['offline'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result['message'] ?? 'Registered offline'),
          backgroundColor: AppColors.warning,
          duration: const Duration(seconds: 3),
        ));
      }
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const MainShell()), (_) => false);
    } else {
      setState(() => _error = result['message'] ?? 'Registration failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final l    = lang.lang;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(AppStrings.t('register_title', l)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _FormField(label: AppStrings.t('full_name', l),
                child: TextField(
                  controller: _nameCtrl,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: AppStrings.t('full_name_hint', l),
                    prefixIcon: const Icon(Icons.person_outline,
                        color: AppColors.primary)),
                )),
              const SizedBox(height: 14),

              _FormField(label: AppStrings.t('age', l),
                child: TextField(
                  controller: _ageCtrl,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: AppStrings.t('age_hint', l),
                    prefixIcon: const Icon(Icons.cake_outlined,
                        color: AppColors.primary)),
                )),
              const SizedBox(height: 14),

              _FormField(label: AppStrings.t('gender', l),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.cardBorder)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _gender,
                      isExpanded: true,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      items: [
                        DropdownMenuItem(value: 'Male',
                            child: Text(AppStrings.t('male', l))),
                        DropdownMenuItem(value: 'Female',
                            child: Text(AppStrings.t('female', l))),
                        DropdownMenuItem(value: 'Other',
                            child: Text(AppStrings.t('other', l))),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => _gender = v);
                      },
                    ),
                  ),
                )),
              const SizedBox(height: 14),

              _FormField(label: AppStrings.t('cancer_type', l),
                child: TextField(
                  controller: _cancerCtrl,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: AppStrings.t('cancer_type_hint', l),
                    prefixIcon: const Icon(Icons.medical_information_outlined,
                        color: AppColors.primary)),
                )),
              const SizedBox(height: 14),

              _FormField(label: AppStrings.t('hospital_id', l),
                child: TextField(
                  controller: _hospitalCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: AppStrings.t('hospital_id_hint', l),
                    prefixIcon: const Icon(Icons.local_hospital_outlined,
                        color: AppColors.primary)),
                )),
              const SizedBox(height: 14),

              _FormField(label: AppStrings.t('mobile', l),
                child: TextField(
                  controller: _mobileCtrl,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: AppStrings.t('mobile_hint', l),
                    prefixIcon: const Icon(Icons.phone_outlined,
                        color: AppColors.primary)),
                )),
              const SizedBox(height: 14),

              _FormField(label: AppStrings.t('password', l),
                child: TextField(
                  controller: _passCtrl,
                  obscureText: _obscurePass,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: AppStrings.t('password_hint', l),
                    prefixIcon: const Icon(Icons.lock_outline,
                        color: AppColors.primary),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePass
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                          color: Colors.grey),
                      onPressed: () =>
                          setState(() => _obscurePass = !_obscurePass)),
                  ),
                )),
              const SizedBox(height: 14),

              _FormField(label: AppStrings.t('confirm_password', l),
                child: TextField(
                  controller: _confirmCtrl,
                  obscureText: _obscureConf,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _register(),
                  decoration: InputDecoration(
                    hintText: AppStrings.t('confirm_password_hint', l),
                    prefixIcon: const Icon(Icons.lock_outline,
                        color: AppColors.primary),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConf
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                          color: Colors.grey),
                      onPressed: () =>
                          setState(() => _obscureConf = !_obscureConf)),
                  ),
                )),

              if (_error != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppColors.danger.withOpacity(0.3))),
                  child: Row(children: [
                    const Icon(Icons.error_outline,
                        color: AppColors.danger, size: 16),
                    const SizedBox(width: 8),
                    Expanded(child: Text(_error!,
                        style: const TextStyle(
                            color: AppColors.danger, fontSize: 12))),
                  ]),
                ),
              ],

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _loading ? null : _register,
                child: _loading
                    ? const SizedBox(height: 22, width: 22,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2.5))
                    : Text(AppStrings.t('register_btn', l)),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.t('have_account', l),
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(AppStrings.t('login_link', l),
                        style: const TextStyle(color: AppColors.primary,
                            fontWeight: FontWeight.w600, fontSize: 13)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final Widget child;
  const _FormField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 13,
          fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      const SizedBox(height: 6),
      child,
    ],
  );
}
