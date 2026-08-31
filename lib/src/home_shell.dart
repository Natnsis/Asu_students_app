import 'package:flutter/material.dart';
import 'app_state.dart';
import 'common.dart';
import 'data.dart';
import 'overlays.dart';
import 'tabs.dart';
import 'theme.dart';

/// The in-app frame: scrollable tab body, floating tab bar, and the overlay
/// layer on top.
class AppHome extends StatelessWidget {
  const AppHome({super.key});

  Widget _tabBody(String tab) {
    switch (tab) {
      case 'campus':
        return const CampusTab();
      case 'academics':
        return const AcademicsTab();
      case 'social':
        return const SocialTab();
      case 'me':
        return const MeTab();
      default:
        return const HomeTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    return Container(
      color: kCream,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 260),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween(begin: const Offset(0, 0.03), end: Offset.zero)
                      .animate(anim),
                  child: child,
                ),
              ),
              child: KeyedSubtree(
                key: ValueKey(s.tab),
                child: SafeArea(bottom: false, child: _tabBody(s.tab)),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _TabBar(current: s.tab, onSelect: s.setTab),
          ),
          if (s.overlay != null)
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween(begin: const Offset(0, 0.04), end: Offset.zero)
                        .animate(anim),
                    child: child,
                  ),
                ),
                child: KeyedSubtree(
                  key: ValueKey('ov-${s.overlay}'),
                  child: const OverlayHost(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.current, required this.onSelect});
  final String current;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: kInk.withValues(alpha: 0.28),
            blurRadius: 34,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: [
          for (final t in kTabs)
            Expanded(
              child: Tap(
                onTap: () => onSelect(t.id),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(2, 9, 2, 7),
                  decoration: BoxDecoration(
                    color: current == t.id ? const Color(0xFF3A332A) : Colors.transparent,
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        current == t.id ? t.activeIcon : t.icon,
                        size: 19,
                        color: current == t.id ? kButter : const Color(0xFF8E8375),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        t.label,
                        style: body(10,
                            weight: FontWeight.w700,
                            color: current == t.id ? kButter : const Color(0xFF8E8375)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
