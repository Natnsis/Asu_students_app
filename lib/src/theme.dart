import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palette originally lifted from `UniCore.dc.html`, now re-cast around a
/// "Forest & Sage Green" identity — education, calm, stability. The warm
/// cream paper is kept; the accents move to green.
///
/// Two anchor greens drive everything:
///   Forest  #064E3B  — primary actions, headings-on-tint, deep accent
///   Emerald #059669  — secondary accent, eyebrows, links, highlights
const kForest = Color(0xFF064E3B);
const kEmerald = Color(0xFF059669);

const kCoral = kForest; // primary accent (buttons, seed colour)
const kAccent = kEmerald; // secondary accent (eyebrows, small emphasis)

const kPeri = Color(0xFF0F766E); // supporting teal-green
const kButter = Color(0xFFAFDCB9); // light sage (was an amber; kept as a soft banner tone)
const kSage = Color(0xFF6BAF92);
const kInk = Color(0xFF1B231F); // near-black with a green cast
const kCream = Color(0xFFF6F1E7);
const kCard = Color(0xFFFFFDF8);
const kLine = Color(0xFFDEE3D0);
const kBackdrop = Color(0xFFDCE4D2);

const kMuted = Color(0xFF7C7F72);
const kMutedInk = Color(0xFF5F6358);
const kBodyInk = Color(0xFF333A31);
// kPink / kPinkInk are the one warm pair kept on purpose — reserved for
// negative / alert states (failing grade, safety notices) so they read as
// "attention", not decoration.
const kPink = Color(0xFFFBD8CD);
const kPinkInk = Color(0xFF9E3B1D);
const kPeriTint = Color(0xFFCDE6E1); // teal-green tint
const kButterTint = Color(0xFFE6EFC9); // lime-sage tint
const kSageTint = Color(0xFFD3E4D8); // cool green tint
const kMint = Color(0xFFDDEAD0); // yellow-green tint

// Decorative tint rotation — all green so cards read as one family.
const kTints = [kSageTint, kPeriTint, kButterTint, kMint];

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

/// Serif fallback chain for the body face. Georgia ships on Apple platforms,
/// Windows and most browsers; elsewhere the platform's default serif stands in.
const List<String> kSerifFallback = <String>[
  'Georgia',
  'Iowan Old Style',
  'Times New Roman',
  'Times',
  'serif',
];

/// Merriweather — display / headline face. A sturdy academic serif.
TextStyle display(
  double size, {
  FontWeight weight = FontWeight.w700,
  Color color = kInk,
  double height = 1.18,
  double? letterSpacing,
}) {
  return GoogleFonts.merriweather(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );
}

/// Georgia — body / UI face. Reads as print, pairs with Merriweather.
TextStyle body(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = kInk,
  double height = 1.45,
  double? letterSpacing,
}) {
  return TextStyle(
    fontFamily: 'Georgia',
    fontFamilyFallback: kSerifFallback,
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );
}

/// The all-caps eyebrow label used everywhere in the design.
TextStyle eyebrow(Color color, {double size = 11, double spacing = 1.6}) {
  return GoogleFonts.merriweather(
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
      seedColor: kForest,
      primary: kForest,
      secondary: kEmerald,
      surface: kCream,
    ),
    scaffoldBackgroundColor: kCream,
  );
  final serifText = base.textTheme
      .apply(
        fontFamily: 'Georgia',
        fontFamilyFallback: kSerifFallback,
        bodyColor: kInk,
        displayColor: kInk,
      )
      .copyWith(
        displayLarge: GoogleFonts.merriweather(textStyle: base.textTheme.displayLarge, color: kInk),
        displayMedium: GoogleFonts.merriweather(textStyle: base.textTheme.displayMedium, color: kInk),
        displaySmall: GoogleFonts.merriweather(textStyle: base.textTheme.displaySmall, color: kInk),
        headlineLarge: GoogleFonts.merriweather(textStyle: base.textTheme.headlineLarge, color: kInk),
        headlineMedium: GoogleFonts.merriweather(textStyle: base.textTheme.headlineMedium, color: kInk),
        headlineSmall: GoogleFonts.merriweather(textStyle: base.textTheme.headlineSmall, color: kInk),
        titleLarge: GoogleFonts.merriweather(textStyle: base.textTheme.titleLarge, color: kInk),
      );
  return base.copyWith(
    textTheme: serifText,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
  );
}
