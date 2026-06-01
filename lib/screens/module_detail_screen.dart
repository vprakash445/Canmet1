import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import '../utils/strings.dart';
import '../utils/providers.dart';
import '../utils/module_data.dart';

class ModuleDetailScreen extends StatelessWidget {
  final ModuleData module;
  const ModuleDetailScreen({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    final lang     = context.watch<LanguageProvider>();
    final l        = lang.lang;
    final tasks    = context.watch<TaskProvider>();
    final taskList = module.tasks(l);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          // ── Coloured App Bar with module image ────────────────────
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: module.color,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Module card image as header
                  Image.asset(
                    module.cardImage,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [module.color,
                              module.color.withOpacity(0.7)],
                        ),
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          module.color.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                  // Module name text at bottom
                  Positioned(
                    bottom: 16, left: 20, right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(module.icon, color: Colors.white,
                                  size: 14),
                              const SizedBox(width: 4),
                              Text(module.name(l),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(module.sub(l),
                          style: const TextStyle(color: Colors.white,
                              fontSize: 20, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Body ─────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Key message
                _KeyMessageCard(module: module, l: l),
                const SizedBox(height: 14),

                // Sections label
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    l == 'hi' ? 'इस मॉड्यूल में' : 'In This Module',
                    style: const TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary)),
                ),

                // Education sections — each OPEN by default, not collapsible
                ...List.generate(module.sections.length, (i) =>
                  _SectionCard(
                    section: module.sections[i],
                    color: module.color,
                    l: l,
                    index: i + 1,
                  ),
                ),

                const SizedBox(height: 4),

                // Daily reminder
                _DailyReminderCard(module: module, l: l),
                const SizedBox(height: 14),

                // Tasks checklist
                _TaskCard(
                  module: module, l: l,
                  taskList: taskList, tasks: tasks),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Key message card ─────────────────────────────────────────────────────────
class _KeyMessageCard extends StatelessWidget {
  final ModuleData module;
  final String l;
  const _KeyMessageCard({required this.module, required this.l});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          module.color.withOpacity(0.08),
          module.color.withOpacity(0.03),
        ],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: module.color.withOpacity(0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: module.color,
            borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.format_quote_rounded,
              color: Colors.white, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(module.keyMsg(l),
          style: TextStyle(fontSize: 13.5, color: module.color,
              fontStyle: FontStyle.italic, height: 1.65,
              fontWeight: FontWeight.w600))),
      ],
    ),
  );
}

// ─── Section card — image ALWAYS shown, Q&A style, drawer CLOSED ─────────────
class _SectionCard extends StatefulWidget {
  final ModuleSection section;
  final Color color;
  final String l;
  final int index;
  const _SectionCard({required this.section, required this.color,
      required this.l, required this.index});

  @override
  State<_SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<_SectionCard>
    with SingleTickerProviderStateMixin {
  // CLOSED by default — user taps to open answer
  bool _open = false;
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 280));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _open = !_open);
    if (_open) _ctrl.forward(); else _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final imgPath = widget.section.imagePath(widget.l);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 3)),
        ],
        border: Border.all(
            color: _open
                ? widget.color.withOpacity(0.4)
                : widget.color.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Image (ALWAYS visible) ──────────────────────────────
          if (imgPath != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16)),
              child: Image.asset(
                imgPath,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (ctx, err, st) => Container(
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.color.withOpacity(0.15),
                        widget.color.withOpacity(0.05),
                      ],
                    ),
                  ),
                  child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_outlined,
                          color: widget.color.withOpacity(0.4), size: 36),
                      const SizedBox(height: 6),
                      Text(
                        widget.l == 'hi'
                            ? 'छवि यहाँ दिखेगी'
                            : 'Image will appear here',
                        style: TextStyle(fontSize: 11,
                            color: widget.color.withOpacity(0.5)),
                      ),
                    ],
                  )),
                ),
              ),
            ),

          // ── Question / Title row (tappable) ────────────────────
          InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.vertical(
              top: imgPath == null
                  ? const Radius.circular(16) : Radius.zero,
              bottom: _open
                  ? Radius.zero : const Radius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 13, 12, 13),
              decoration: BoxDecoration(
                color: _open
                    ? widget.color.withOpacity(0.06)
                    : Colors.transparent,
                borderRadius: BorderRadius.vertical(
                  top: imgPath == null
                      ? const Radius.circular(16) : Radius.zero,
                  bottom: _open
                      ? Radius.zero : const Radius.circular(16),
                ),
              ),
              child: Row(children: [
                // Number badge
                Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: _open ? widget.color : widget.color.withOpacity(0.1),
                    shape: BoxShape.circle),
                  child: Center(child: Text('${widget.index}',
                    style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700,
                      color: _open ? Colors.white : widget.color))),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(
                  widget.section.title(widget.l),
                  style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w700,
                    color: _open
                        ? widget.color : AppColors.textPrimary),
                )),
                // Chevron indicator
                AnimatedRotation(
                  turns: _open ? 0.5 : 0,
                  duration: const Duration(milliseconds: 280),
                  child: Container(
                    width: 28, height: 28,
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.08),
                      shape: BoxShape.circle),
                    child: Icon(Icons.keyboard_arrow_down_rounded,
                        color: widget.color, size: 20),
                  ),
                ),
              ]),
            ),
          ),

          // ── Answer / Body (animated expand) ────────────────────
          SizeTransition(
            sizeFactor: _anim,
            child: Column(children: [
              Divider(height: 1, color: widget.color.withOpacity(0.2)),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.03),
                  borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(16)),
                ),
                child: Text(
                  widget.section.body(widget.l),
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: AppColors.textSecondary,
                    height: 1.75,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// ─── Daily reminder card ──────────────────────────────────────────────────────
class _DailyReminderCard extends StatelessWidget {
  final ModuleData module;
  final String l;
  const _DailyReminderCard({required this.module, required this.l});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFFFFBEB), Color(0xFFFFF8E1)]),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.warning.withOpacity(0.35)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.warning.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10)),
          child: const Text('📱', style: TextStyle(fontSize: 20)),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l == 'hi' ? 'दैनिक याद' : 'Daily Reminder',
              style: const TextStyle(fontSize: 11,
                  color: AppColors.warning,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5)),
            const SizedBox(height: 4),
            Text(module.dailyReminder(l),
              style: const TextStyle(fontSize: 13,
                  color: Color(0xFF78350F), height: 1.6)),
          ],
        )),
      ],
    ),
  );
}

// ─── Tasks checklist card ─────────────────────────────────────────────────────
class _TaskCard extends StatelessWidget {
  final ModuleData module;
  final String l;
  final List<String> taskList;
  final TaskProvider tasks;

  const _TaskCard({required this.module, required this.l,
      required this.taskList, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completed = tasks.completedCount(module.id);
    final pct = taskList.isNotEmpty ? completed / taskList.length : 0.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(
            color: module.color.withOpacity(0.10),
            blurRadius: 10, offset: const Offset(0, 3))],
        border: Border.all(color: module.color.withOpacity(0.15)),
      ),
      child: Column(children: [
        // Header
        Container(
          padding: const EdgeInsets.fromLTRB(14, 13, 14, 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              module.color.withOpacity(0.08),
              module.color.withOpacity(0.03),
            ]),
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16)),
          ),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: module.color,
                borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.checklist_rounded,
                  color: Colors.white, size: 16)),
            const SizedBox(width: 10),
            Expanded(child: Text(
              AppStrings.t('todays_tasks', l),
              style: const TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary))),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('$completed/${taskList.length}',
                style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.w800, color: module.color)),
              Text(l == 'hi' ? 'पूर्ण' : 'done',
                style: const TextStyle(fontSize: 10,
                    color: AppColors.textSecondary)),
            ]),
          ]),
        ),
        // Progress bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: module.color.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation<Color>(module.color),
              minHeight: 5,
            ),
          ),
        ),
        const SizedBox(height: 4),

        Divider(height: 1, color: module.color.withOpacity(0.12)),

        // Task items
        ...List.generate(taskList.length, (i) {
          final done = tasks.isTaskDone(module.id, i);
          return _TaskItem(
            text: taskList[i], isDone: done, color: module.color,
            onToggle: () => context.read<TaskProvider>()
                .toggleTask(module.id, i, taskList.length),
            isLast: i == taskList.length - 1,
          );
        }),
      ]),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final String text;
  final bool isDone;
  final Color color;
  final VoidCallback onToggle;
  final bool isLast;

  const _TaskItem({required this.text, required this.isDone,
      required this.color, required this.onToggle, required this.isLast});

  @override
  Widget build(BuildContext context) => Column(children: [
    InkWell(
      onTap: onToggle,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 12),
        child: Row(children: [
          // Animated checkbox
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.elasticOut,
            width: 24, height: 24,
            decoration: BoxDecoration(
              color: isDone ? color : Colors.transparent,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                  color: isDone ? color : Colors.grey.shade300,
                  width: 2)),
            child: isDone
                ? const Icon(Icons.check, color: Colors.white, size: 15)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: TextStyle(
            fontSize: 13,
            fontWeight: isDone ? FontWeight.w400 : FontWeight.w500,
            color: isDone
                ? AppColors.textSecondary : AppColors.textPrimary,
            decoration: isDone ? TextDecoration.lineThrough : null,
            decorationColor: AppColors.textSecondary))),
          if (isDone)
            Icon(Icons.star_rounded,
                color: color.withOpacity(0.5), size: 16),
        ]),
      ),
    ),
    if (!isLast)
      Divider(height: 1, indent: 50,
          color: color.withOpacity(0.08)),
  ]);
}
