import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palette lifted straight from `UniCore.dc.html`.
const kCoral = Color(0xFFE9613C);
const kPeri = Color(0xFF7B8BEF);
const kButter = Color(0xFFF2C14E);
const kSage = Color(0xFF8FB08A);
const kInk = Color(0xFF211C17);
const kCream = Color(0xFFF7EFE3);
const kCard = Color(0xFFFFFDF8);
const kLine = Color(0xFFEADCC8);
const kBackdrop = Color(0xFFE4D8C4);

const kMuted = Color(0xFF8C7F6E);
const kMutedInk = Color(0xFF6B6355);
const kBodyInk = Color(0xFF3C352C);
const kAccent = Color(0xFFC9502F);
const kPink = Color(0xFFFBD8CD);
const kPinkInk = Color(0xFF9E3B1D);
const kPeriTint = Color(0xFFDCE1FB);
const kButterTint = Color(0xFFFBEBC6);
const kSageTint = Color(0xFFD8E6D5);

const kTints = [kPink, kPeriTint, kButterTint, kSageTint];

/// Grade points and cycle order (`GP` / `GORDER` in the source).
const kGradePoints = <String, double>{
  'A': 4,
  'A-': 3.75,
  'B+': 3.5,
  'B': 3,
  'B-': 2.75,
  'C+': 2.5,
  'C': 2,
  'D': 1,
  'F': 0,
};
const kGradeOrder = ['A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'D', 'F'];
const kPastGpa = [3.41, 3.58];

Color gradeTint(String grade) {
  final g = kGradePoints[grade] ?? 0;
  if (g >= 3.75) return kSageTint;
  if (g >= 3) return kPeriTint;
  if (g >= 2) return kButterTint;
  return kPink;
}

/// Bricolage Grotesque — display / headline font.
TextStyle display(
  double size, {
  FontWeight weight = FontWeight.w700,
  Color color = kInk,
  double height = 1.15,
  double? letterSpacing,
}) {
  return GoogleFonts.bricolageGrotesque(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );
}

/// Plus Jakarta Sans — body / UI font.
TextStyle body(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = kInk,
  double height = 1.4,
  double? letterSpacing,
}) {
  return GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );
}

/// The all-caps eyebrow label used everywhere in the design.
TextStyle eyebrow(Color color, {double size = 11, double spacing = 1.6}) {
  return GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color,
    letterSpacing: spacing,
  );
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kCoral,
      primary: kCoral,
      surface: kCream,
    ),
    scaffoldBackgroundColor: kCream,
  );
  return base.copyWith(
    textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
      bodyColor: kInk,
      displayColor: kInk,
    ),
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
  );
}
