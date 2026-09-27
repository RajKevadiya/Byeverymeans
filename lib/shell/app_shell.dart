import 'package:flutter/material.dart';

import '../pages/contact_page.dart';
import '../pages/home_page.dart';
import '../pages/process_page.dart';
import '../pages/services_page.dart';
import '../pages/work_page.dart';
import '../theme/app_colors.dart';
import '../widgets/site_footer.dart';
import '../widgets/site_nav.dart';
import '../widgets/reveal.dart';
import 'app_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppPage _page = AppPage.home;
  final _scrollController = ScrollController();

  void _navigate(AppPage page) {
    if (_page == page) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
      return;
    }
    setState(() => _page = page);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    });
  }

  Widget get _body {
    return switch (_page) {
      AppPage.home => HomePage(onNavigate: _navigate),
      AppPage.services => ServicesPage(onNavigate: _navigate),
      AppPage.process => ProcessPage(onNavigate: _navigate),
      AppPage.work => WorkPage(onNavigate: _navigate),
      AppPage.contact => const ContactPage(),
    };
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          SiteNav(current: _page, onNavigate: _navigate),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 550),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) {
                      final offset = Tween<Offset>(
                        begin: const Offset(0, 0.03),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(position: offset, child: child),
                      );
                    },
                    child: KeyedSubtree(
                      key: ValueKey(_page),
                      child: _body,
                    ),
                  ),
                  Reveal(child: SiteFooter(current: _page, onNavigate: _navigate)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
