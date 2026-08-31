import 'package:flutter/material.dart';
import 'app_state.dart';
import 'common.dart';
import 'data.dart';
import 'image_slot.dart';
import 'theme.dart';

/// Little "U" wordmark used across the pre-app stages.
class _Wordmark extends StatelessWidget {
  const _Wordmark({this.onDark = false, this.small = false});
  final bool onDark;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final box = small ? 28.0 : 30.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: box,
          height: box,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: onDark ? kButter : kInk,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text('U',
              style: display(small ? 14 : 15,
                  weight: FontWeight.w800, color: onDark ? kInk : kButter)),
        ),
        const SizedBox(width: 9),
        Text('UniCore',
            style: display(small ? 16 : 17,
                weight: FontWeight.w700, color: onDark ? kCream : kInk)),
      ],
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    return Container(
      color: kInk,
      child: Stack(
        children: [
          Positioned(
            right: -70,
            top: -40,
            child: _Blob(240, kCoral.withValues(alpha: 0.3)),
          ),
          Positioned(
            left: -90,
            bottom: 120,
            child: _Blob(220, kPeri.withValues(alpha: 0.28)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(26, 36, 26, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Wordmark(onDark: true),
                  const Spacer(),
                  Text('Your whole campus,\nin one quiet place.',
                      style: display(44,
                          weight: FontWeight.w800,
                          color: kCream,
                          height: 1.02,
                          letterSpacing: -1.4)),
                  const SizedBox(height: 16),
                  Text(
                    'Courses, departments, cafeteria, libraries, grades and the people — without having to ask anyone for directions.',
                    style: body(15, color: const Color(0xFFC7BCAC), height: 1.6),
                  ),
                  const SizedBox(height: 26),
                  PillButton(label: 'Get started', onTap: s.startOnboard),
                  const SizedBox(height: 10),
                  PillButton(
                    label: 'I already have an account',
                    onTap: s.goAuth,
                    bg: Colors.transparent,
                    fg: kCream,
                    border: const Color(0xFF4A4238),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob(this.size, this.color);
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final slide = kSlides[s.slide];
    return Container(
      color: kCream,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 28, 26, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Tap(
                  onTap: s.skipOnboard,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text('Skip',
                        style: body(13.5, weight: FontWeight.w700, color: kMuted)),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: ImageSlot(
                          height: 250,
                          width: double.infinity,
                          radius: 28,
                          tint: slide.tint,
                          label: 'Illustration',
                        ),
                      ),
                      const SizedBox(height: 26),
                      Eyebrow(slide.badge, color: kAccent, size: 11),
                      const SizedBox(height: 10),
                      Text(slide.title,
                          style: display(31,
                              weight: FontWeight.w800, height: 1.06, letterSpacing: -0.9)),
                      const SizedBox(height: 12),
                      Text(slide.bodyText,
                          style: body(14.5, color: kMutedInk, height: 1.6)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: List.generate(kSlides.length, (i) {
                        final on = i == s.slide;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(right: 6),
                          height: 7,
                          width: on ? 22 : 7,
                          decoration: BoxDecoration(
                            color: on ? kInk : const Color(0xFFD3C6B2),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        );
                      }),
                    ),
                  ),
                  Tap(
                    onTap: s.nextSlide,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      decoration: BoxDecoration(
                        color: kInk,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        s.slide == kSlides.length - 1 ? 'Get started' : 'Next',
                        style: body(15, weight: FontWeight.w700, color: kCream),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final isIn = s.authMode == 'in';
    return Container(
      color: kCream,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(26, 32, 26, 30),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height - 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Wordmark(small: true),
                const SizedBox(height: 34),
                Text(isIn ? 'Welcome back' : 'Create your account',
                    style: display(32,
                        weight: FontWeight.w800, height: 1.05, letterSpacing: -0.96)),
                const SizedBox(height: 8),
                Text(
                  isIn
                      ? 'Use the student ID printed on your card.'
                      : 'Your ID is checked against the registrar list.',
                  style: body(14, color: kMuted, height: 1.5),
                ),
                const SizedBox(height: 26),
                _Field(
                  label: 'Student ID',
                  hint: 'UC/2941/16',
                  value: s.idDraft,
                  onChanged: s.setIdDraft,
                ),
                const SizedBox(height: 11),
                _Field(
                  label: 'Password',
                  hint: '••••••••',
                  value: s.pwDraft,
                  onChanged: s.setPwDraft,
                  obscure: true,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 18,
                  child: Text(s.authError,
                      style: body(13, weight: FontWeight.w600, color: kAccent)),
                ),
                const SizedBox(height: 4),
                PillButton(
                  label: isIn ? 'Sign in' : 'Create account',
                  onTap: s.submitAuth,
                ),
                const SizedBox(height: 18),
                Center(
                  child: Tap(
                    onTap: s.toggleAuthMode,
                    child: Text(
                      isIn ? 'New here? Create an account' : 'Already registered? Sign in',
                      style: body(13.5, weight: FontWeight.w700, color: kInk),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Only registrar-verified IDs get in. Nobody outside the university can see your profile.',
                  textAlign: TextAlign.center,
                  style: body(12, color: const Color(0xFFA2957F), height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.hint,
    required this.value,
    required this.onChanged,
    this.obscure = false,
  });
  final String label;
  final String hint;
  final String value;
  final ValueChanged<String> onChanged;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Eyebrow(label, size: 10.5),
          TextFormField(
            initialValue: value,
            onChanged: onChanged,
            obscureText: obscure,
            style: body(16, weight: FontWeight.w600),
            cursorColor: kCoral,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.only(top: 6),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: body(16, weight: FontWeight.w600, color: const Color(0xFFBCae9b)),
            ),
          ),
        ],
      ),
    );
  }
}

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    return Container(
      color: kCream,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 30, 26, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Eyebrow('Step 2 of 2', color: kAccent),
                  const SizedBox(height: 8),
                  Text('Which department are you in?',
                      style: display(29,
                          weight: FontWeight.w800, height: 1.08, letterSpacing: -0.87)),
                  const SizedBox(height: 7),
                  Text(
                    'This sets your schedule, courses and career track. You can change it later.',
                    style: body(14, color: kMuted, height: 1.5),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(26, 8, 26, 12),
                children: [
                  for (final d in kDepartments) ...[
                    _DeptPick(
                      dept: d,
                      selected: s.pickDept == d.id,
                      onTap: () => s.setPickDept(d.id),
                    ),
                    const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 12),
                  Text('And your year?', style: display(18, weight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      for (final y in [1, 2, 3, 4, 5]) ...[
                        Expanded(
                          child: Tap(
                            onTap: () => s.setPickYear(y),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: s.pickYear == y ? kInk : kCard,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: s.pickYear == y ? kInk : kLine),
                              ),
                              child: Text('Year $y',
                                  style: body(12.5,
                                      weight: FontWeight.w700,
                                      color: s.pickYear == y ? kCream : kMutedInk)),
                            ),
                          ),
                        ),
                        if (y != 5) const SizedBox(width: 7),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 14, 26, 26),
              child: PillButton(
                label: 'Enter UniCore',
                onTap: s.enterApp,
                bg: kInk,
                fg: kCream,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeptPick extends StatelessWidget {
  const _DeptPick({required this.dept, required this.selected, required this.onTap});
  final Department dept;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
        decoration: BoxDecoration(
          color: selected ? kInk : kCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? kInk : kLine),
        ),
        child: Row(
          children: [
            Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                color: selected ? kButter : dept.color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dept.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: body(15,
                          weight: FontWeight.w700, color: selected ? kCream : kInk)),
                  const SizedBox(height: 3),
                  Text('${dept.years} · ${dept.load}',
                      style: body(12.5,
                          color: selected ? const Color(0xB3F7EFE3) : kMuted)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
