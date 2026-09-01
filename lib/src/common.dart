import 'package:flutter/material.dart';
import 'theme.dart';

/// Tap target with no ripple — the design uses plain `cursor:pointer` divs.
class Tap extends StatelessWidget {
  const Tap({super.key, required this.onTap, required this.child});
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    );
  }
}

/// White card with the standard hairline border.
class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.radius = 22,
    this.color = kCard,
    this.border = kLine,
    this.dashed = false,
  });
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color color;
  final Color border;
  final bool dashed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: border),
      ),
      child: child,
    );
  }
}

/// All-caps eyebrow line.
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.color = kMuted, this.size = 11});
  final String text;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) =>
      Text(text.toUpperCase(), style: eyebrow(color, size: size));
}

/// Small rounded label chip.
class Tag extends StatelessWidget {
  const Tag(this.text, {super.key, this.bg = kCream, this.fg = kMutedInk, this.caps = false});
  final String text;
  final Color bg;
  final Color fg;
  final bool caps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(
        caps ? text.toUpperCase() : text,
        style: caps
            ? eyebrow(fg, size: 10.5, spacing: 1)
            : body(11.5, weight: FontWeight.w700, color: fg),
      ),
    );
  }
}

/// Selectable pill (chip row). Selected → ink bg, cream text.
class SelectPill extends StatelessWidget {
  const SelectPill({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.offBg = kCard,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color offBg;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? kInk : offBg,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selected ? kInk : kLine),
        ),
        child: Text(
          label,
          style: body(13, weight: FontWeight.w600, color: selected ? kCream : kMutedInk),
        ),
      ),
    );
  }
}

/// Big pill button (primary / outline / light).
class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.label,
    required this.onTap,
    this.bg = kCoral,
    this.fg = Colors.white,
    this.border,
    this.padding = const EdgeInsets.symmetric(vertical: 17),
    this.radius = 20,
    this.fontSize = 15.5,
  });
  final String label;
  final VoidCallback onTap;
  final Color bg;
  final Color fg;
  final Color? border;
  final EdgeInsets padding;
  final double radius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(radius),
          border: border == null ? null : Border.all(color: border!),
        ),
        child: Text(label, style: body(fontSize, weight: FontWeight.w700, color: fg)),
      ),
    );
  }
}

/// Round icon button used for the back chevron / bell.
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 42,
    this.bg = kCard,
    this.fg = kInk,
  });
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFDEE7D6)),
        ),
        child: Icon(icon, size: size * 0.42, color: fg),
      ),
    );
  }
}

/// Small square icon tile (quick actions, me rows).
class IconTile extends StatelessWidget {
  const IconTile(this.icon, this.tint, {super.key, this.size = 36, this.radius = 12});
  final IconData icon;
  final Color tint;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(radius)),
      child: Icon(icon, size: size * 0.47, color: kInk),
    );
  }
}

/// Section header: display title on the left, action link on the right.
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.action, this.onAction, this.size = 19});
  final String title;
  final String? action;
  final VoidCallback? onAction;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(child: Text(title, style: display(size, weight: FontWeight.w700))),
        if (action != null)
          Tap(
            onTap: onAction ?? () {},
            child: Text(action!, style: body(13, weight: FontWeight.w600, color: kAccent)),
          ),
      ],
    );
  }
}

/// Simple looping pulse for the "Next up" indicator dot.
class PulseDot extends StatefulWidget {
  const PulseDot({super.key, this.color = kButter, this.size = 7});
  final Color color;
  final double size;

  @override
  State<PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<PulseDot> with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.35, end: 1.0).animate(_c),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }
}

/// Avatar bubble with initials.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar(this.initials, {super.key, this.size = 44, this.tint = kMint, this.fg = kForest});
  final String initials;
  final double size;
  final Color tint;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
      child: Text(initials, style: display(size * 0.36, weight: FontWeight.w800, color: fg)),
    );
  }
}

/// Text field backed by [AppState] draft strings. Keeps its own controller so
/// keystrokes don't fight the rebuild, but syncs when the value is cleared
/// externally (e.g. after "send").
class DraftField extends StatefulWidget {
  const DraftField({
    super.key,
    required this.value,
    required this.onChanged,
    this.onSubmit,
    this.hint = '',
    this.minLines = 1,
    this.maxLines = 1,
    this.style,
    this.hintStyle,
    this.contentPadding,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSubmit;
  final String hint;
  final int minLines;
  final int maxLines;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;

  @override
  State<DraftField> createState() => _DraftFieldState();
}

class _DraftFieldState extends State<DraftField> {
  late final TextEditingController _c = TextEditingController(text: widget.value);

  @override
  void didUpdateWidget(DraftField old) {
    super.didUpdateWidget(old);
    if (widget.value != _c.text) {
      _c.value = TextEditingValue(
        text: widget.value,
        selection: TextSelection.collapsed(offset: widget.value.length),
      );
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _c,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmit == null ? null : (_) => widget.onSubmit!(),
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      cursorColor: kCoral,
      style: widget.style ?? body(14),
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            widget.contentPadding ?? const EdgeInsets.symmetric(vertical: 13),
        border: InputBorder.none,
        hintText: widget.hint,
        hintStyle: widget.hintStyle ?? body(14, color: kMuted),
      ),
    );
  }
}

String initialsOf(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  final s = parts.map((w) => w.isEmpty ? '' : w[0]).join();
  return s.substring(0, s.length < 2 ? s.length : 2).toUpperCase();
}
