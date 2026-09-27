import 'package:flutter/material.dart';

import '../shell/app_page.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'app_buttons.dart';

class SiteNav extends StatelessWidget {
  const SiteNav({super.key, required this.current, required this.onNavigate});

  final AppPage current;
  final ValueChanged<AppPage> onNavigate;

  @override
  Widget build(BuildContext context) {
    final desktop = Breakpoints.isLg(context);
    final padded = Breakpoints.isMd(context);

    return Material(
      color: AppColors.bg.withValues(alpha: 0.95),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.5))),
        ),
        padding: EdgeInsets.symmetric(horizontal: padded ? 48 : 24, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: InkWell(
                onTap: () => onNavigate(AppPage.home),
                child: Image.asset("assets/images/logo.jpeg", height: 80, width: 80, fit: BoxFit.contain),
              ),
            ),
            Spacer(),
            if (desktop) ...[
              const SizedBox(width: 24),
              ...AppPage.navItems.map((page) {
                final active = page == current;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                    onPressed: () => onNavigate(page),
                    style: TextButton.styleFrom(
                      foregroundColor: active ? AppColors.orange : AppColors.dark,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      page.label,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.3),
                    ),
                  ),
                );
              }),
              const Spacer(),
            ] else
              const Spacer(),
            OrangeButton(label: 'Contact Us', onPressed: () => onNavigate(AppPage.contact)),
            if (!desktop) ...[
              const SizedBox(width: 4),
              IconButton(
                onPressed: () => _openDrawer(context),
                icon: const Icon(Icons.menu, color: AppColors.dark),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _openDrawer(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.bg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
                ),
                const SizedBox(height: 24),
                ...AppPage.navItems.map((page) {
                  final active = page == current;
                  return ListTile(
                    title: Text(
                      page.label,
                      style: TextStyle(fontWeight: FontWeight.w500, color: active ? AppColors.orange : AppColors.dark),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      onNavigate(page);
                    },
                  );
                }),
                ListTile(
                  title: Text(
                    'Contact Us',
                    style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.orange),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onNavigate(AppPage.contact);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
