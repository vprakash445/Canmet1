import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import '../utils/strings.dart';
import '../utils/providers.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final user = context.watch<UserProvider>();
    final l = lang.lang;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(AppStrings.t('my_profile', l)),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Avatar / Name Header ────────────────────────────────────
            _ProfileHeader(user: user),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Personal Info ─────────────────────────────────────
                  _SectionLabel(AppStrings.t('personal_info', l)),
                  _Card(children: [
                    if (user.age.isNotEmpty)
                      _InfoRow(
                          icon: Icons.cake_outlined,
                          label: AppStrings.t('age', l),
                          value: user.age),
                    if (user.gender.isNotEmpty)
                      _InfoRow(
                          icon: Icons.wc_outlined,
                          label: AppStrings.t('gender', l),
                          value: _genderLabel(user.gender, l)),
                    if (user.cancerType.isNotEmpty)
                      _InfoRow(
                          icon: Icons.medical_information_outlined,
                          label: AppStrings.t('cancer_type', l),
                          value: user.cancerType),
                    if (user.hospitalId.isNotEmpty)
                      _InfoRow(
                          icon: Icons.local_hospital_outlined,
                          label: AppStrings.t('hospital_id', l),
                          value: user.hospitalId),
                    if (user.mobile.isNotEmpty)
                      _InfoRow(
                          icon: Icons.phone_outlined,
                          label: AppStrings.t('mobile', l),
                          value: user.mobile,
                          isLast: true),
                  ]),

                  const SizedBox(height: 16),

                  // ── Settings ──────────────────────────────────────────
                  _SectionLabel(AppStrings.t('settings', l)),
                  _Card(children: [
                    // Language row with inline toggle
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.language_outlined,
                              color: AppColors.primary, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              AppStrings.t('language', l),
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textPrimary),
                            ),
                          ),
                          _LangToggle(lang: lang),
                        ],
                      ),
                    ),
                    const Divider(
                        height: 1,
                        indent: 46,
                        color: AppColors.cardBorder),
                    _ActionRow(
                      icon: Icons.notifications_outlined,
                      label: AppStrings.t('reminders', l),
                      onTap: () => _toast(
                          context, AppStrings.t('coming_soon', l)),
                      isLast: true,
                    ),
                  ]),

                  const SizedBox(height: 16),

                  // ── Support ───────────────────────────────────────────
                  _SectionLabel(AppStrings.t('support', l)),
                  _Card(children: [
                    _ActionRow(
                      icon: Icons.support_agent_outlined,
                      label: AppStrings.t('ask_nurse', l),
                      onTap: () => _showNurseDialog(context, l),
                    ),
                    const Divider(
                        height: 1,
                        indent: 46,
                        color: AppColors.cardBorder),
                    _ActionRow(
                      icon: Icons.emergency_outlined,
                      label: AppStrings.t('emergency', l),
                      iconColor: AppColors.danger,
                      labelColor: AppColors.danger,
                      onTap: () => _showEmergencyDialog(context, l),
                      isLast: true,
                    ),
                  ]),

                  const SizedBox(height: 20),

                  // ── Logout ────────────────────────────────────────────
                  OutlinedButton.icon(
                    onPressed: () => _confirmLogout(context, l),
                    icon: const Icon(Icons.logout, color: AppColors.danger),
                    label: Text(
                      AppStrings.t('logout', l),
                      style: const TextStyle(color: AppColors.danger),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: const BorderSide(color: AppColors.danger),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  String _genderLabel(String gender, String l) {
    switch (gender) {
      case 'Male':
        return AppStrings.t('male', l);
      case 'Female':
        return AppStrings.t('female', l);
      default:
        return AppStrings.t('other', l);
    }
  }

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showNurseDialog(BuildContext context, String l) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppStrings.t('ask_nurse', l)),
        content: Text(AppStrings.t('nurse_info', l)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.t('close', l)),
          ),
        ],
      ),
    );
  }

  void _showEmergencyDialog(BuildContext context, String l) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(children: [
          const Icon(Icons.emergency, color: AppColors.danger),
          const SizedBox(width: 8),
          Text(AppStrings.t('emergency', l)),
        ]),
        content: Text(AppStrings.t('emergency_info', l)),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10)),
            child: Text(AppStrings.t('close', l)),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, String l) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppStrings.t('logout', l)),
        content: Text(AppStrings.t('logout_confirm', l)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.t('cancel', l)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context); // close dialog
              await context.read<UserProvider>().logout();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10)),
            child: Text(AppStrings.t('logout', l)),
          ),
        ],
      ),
    );
  }
}

// ─── Profile header ───────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  final UserProvider user;
  const _ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.white.withOpacity(0.5), width: 2),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 42),
          ),
          const SizedBox(height: 12),
          Text(
            user.name.isNotEmpty ? user.name : 'Patient',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.patientId,
            style: TextStyle(
                color: Colors.white.withOpacity(0.85), fontSize: 13),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Chip('Day ${user.treatmentDay}',
                  Icons.calendar_today_outlined),
              if (user.cancerType.isNotEmpty) ...[
                const SizedBox(width: 8),
                _Chip(user.cancerType,
                    Icons.medical_information_outlined),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _Chip(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 13),
          const SizedBox(width: 4),
          Text(label,
              style:
                  const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}

// ─── Section label ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.textSecondary,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

// ─── White card container ─────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final List<Widget> children;
  const _Card({required this.children});

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder, width: 0.8),
      ),
      child: Column(children: children),
    );
  }
}

// ─── Info row ─────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 12),
              Text(label,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textPrimary)),
              const Spacer(),
              Text(value,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textSecondary)),
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 1, indent: 46, color: AppColors.cardBorder),
      ],
    );
  }
}

// ─── Action row (tappable) ────────────────────────────────────────────────────

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;
  final bool isLast;

  const _ActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? AppColors.primary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: labelColor ?? AppColors.textPrimary,
                ),
              ),
            ),
            Icon(Icons.chevron_right,
                color: Colors.grey.shade300, size: 20),
          ],
        ),
      ),
    );
  }
}

// ─── Language toggle widget ───────────────────────────────────────────────────

class _LangToggle extends StatelessWidget {
  final LanguageProvider lang;
  const _LangToggle({required this.lang});

  @override
  Widget build(BuildContext context) {
    final isEn = lang.lang == 'en';
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ToggleChip(
            label: 'EN',
            active: isEn,
            onTap: () => lang.setLanguage('en'),
          ),
          _ToggleChip(
            label: 'हि',
            active: !isEn,
            onTap: () => lang.setLanguage('hi'),
          ),
        ],
      ),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _ToggleChip(
      {required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
