import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import '../utils/strings.dart';
import '../utils/providers.dart';
import '../utils/module_data.dart';
import 'module_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _greeting(String l) {
    final h = DateTime.now().hour;
    if (h < 12) return AppStrings.t('good_morning', l);
    if (h < 17) return AppStrings.t('good_afternoon', l);
    return AppStrings.t('good_evening', l);
  }

  @override
  Widget build(BuildContext context) {
    final lang  = context.watch<LanguageProvider>();
    final user  = context.watch<UserProvider>();
    final tasks = context.watch<TaskProvider>();
    final l     = lang.lang;

    final modulesDone =
        allModules.where((m) => tasks.completedCount(m.id) > 0).length;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          // ── Gradient App Bar ────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0F6E56), Color(0xFF1D9E75)],
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).padding.top + 12, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${_greeting(l)}, ${user.name} 👋',
                              style: const TextStyle(color: Colors.white,
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Row(children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  '🏥 ${AppStrings.t('treatment_day', l)} ${user.treatmentDay}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12)),
                                child: Text('🔥 $modulesDone/7',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              ),
                            ]),
                          ],
                        )),
                        // Language toggle
                        GestureDetector(
                          onTap: lang.toggle,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                            child: Text(l == 'en' ? 'हिंदी' : 'EN',
                              style: const TextStyle(
                                  color: AppColors.primary, fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Adherence bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStrings.t('adherence', l),
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 11)),
                            Text('${user.treatmentDay > 0 ? "Good" : "Start"} Progress 💪',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 11)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: (modulesDone / 7).clamp(0.0, 1.0),
                            backgroundColor: Colors.white.withOpacity(0.25),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // ── Today's message ─────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryLight,
                        AppColors.primaryLight.withOpacity(0.5)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: const Border(
                      left: BorderSide(color: AppColors.primary, width: 4)),
                  ),
                  child: Row(children: [
                    const Text('💊', style: TextStyle(fontSize: 22)),
                    const SizedBox(width: 10),
                    Expanded(child: Text(
                      AppStrings.t('daily_tip', l),
                      style: const TextStyle(fontSize: 13,
                          color: AppColors.primaryDark, height: 1.6,
                          fontWeight: FontWeight.w500),
                    )),
                  ]),
                ),
                const SizedBox(height: 22),

                // ── Modules heading ──────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.t('your_modules', l),
                      style: const TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary)),
                    Text('$modulesDone/${allModules.length} ${AppStrings.t('modules_done', l)}',
                      style: TextStyle(fontSize: 12,
                          color: AppColors.primary.withOpacity(0.8),
                          fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 12),

                // ── Module grid (2 columns) ──────────────────────────
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allModules.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.82,
                  ),
                  itemBuilder: (ctx, i) => _ModuleCard(
                    module: allModules[i],
                    l: l,
                    completed: tasks.completedCount(allModules[i].id),
                    total: allModules[i].tasks(l).length,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Colorful Module Card with image ─────────────────────────────────────────
class _ModuleCard extends StatelessWidget {
  final ModuleData module;
  final String l;
  final int completed;
  final int total;

  const _ModuleCard({
    required this.module, required this.l,
    required this.completed, required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? completed / total : 0.0;

    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(
              builder: (_) => ModuleDetailScreen(module: module))),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: module.color.withOpacity(0.18),
              blurRadius: 12,
              offset: const Offset(0, 4)),
          ],
          border: Border.all(color: module.color.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image area ─────────────────────────────────────────
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18)),
              child: Stack(
                children: [
                  // Module card image
                  Image.asset(
                    module.cardImage,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 110,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            module.color,
                            module.color.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Icon(module.icon,
                          color: Colors.white, size: 42),
                    ),
                  ),
                  // Color overlay
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          module.color.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                  // Module icon badge
                  Positioned(
                    top: 8, left: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 4)],
                      ),
                      child: Icon(module.icon,
                          color: module.color, size: 18),
                    ),
                  ),
                  // Completion badge
                  if (completed > 0)
                    Positioned(
                      top: 8, right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                        child: Text('$completed/$total',
                          style: TextStyle(fontSize: 10,
                              color: module.color,
                              fontWeight: FontWeight.w700)),
                      ),
                    ),
                ],
              ),
            ),

            // ── Text area ──────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(module.name(l),
                      style: const TextStyle(fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(module.sub(l),
                      style: const TextStyle(fontSize: 11,
                          color: AppColors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                    const Spacer(),
                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: pct,
                        backgroundColor: module.color.withOpacity(0.12),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            module.color),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
