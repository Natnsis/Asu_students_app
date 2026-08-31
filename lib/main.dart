import 'package:flutter/material.dart';

import 'src/app_state.dart';
import 'src/flows.dart';
import 'src/home_shell.dart';
import 'src/theme.dart';

void main() => runApp(const UniCoreApp());

class UniCoreApp extends StatefulWidget {
  const UniCoreApp({super.key});

  @override
  State<UniCoreApp> createState() => _UniCoreAppState();
}

class _UniCoreAppState extends State<UniCoreApp> {
  final AppState _state = AppState();

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniCore',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: AppScope(
        state: _state,
        child: const _PhoneFrame(child: _RootRouter()),
      ),
    );
  }
}

/// On wide viewports (web / desktop / tablet) the app is shown inside the
/// 390×844 device frame from the design; on a phone it just fills the screen.
class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final framed = c.maxWidth >= 460 && c.maxHeight >= 720;
        if (!framed) return Material(color: kCream, child: child);
        return ColoredBox(
          color: kBackdrop,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(38),
              child: SizedBox(
                width: 390,
                height: 844,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(padding: EdgeInsets.zero),
                  child: Material(color: kCream, child: child),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RootRouter extends StatelessWidget {
  const _RootRouter();

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return AnimatedBuilder(
      animation: state,
      builder: (context, _) {
        final Widget screen = switch (state.stage) {
          'onboard' => const OnboardScreen(),
          'auth' => const AuthScreen(),
          'setup' => const SetupScreen(),
          'app' => const AppHome(),
          _ => const WelcomeScreen(),
        };
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          transitionBuilder: (child, anim) =>
              FadeTransition(opacity: anim, child: child),
          child: KeyedSubtree(key: ValueKey(state.stage), child: screen),
        );
      },
    );
  }
}
