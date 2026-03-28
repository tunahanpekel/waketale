// lib/core/theme/app_theme.dart
// Waketale v2 — Dark sleep-themed design system.
// Deep navy + soft indigo + warm amber.
// Material 3 + Google Fonts (Inter).

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // ─── Brand Palette ────────────────────────────────────────────────────────
  // Deep sleep-inspired navy backgrounds
  static const Color bgDeep        = Color(0xFF080E1A); // Scaffold
  static const Color bgMid         = Color(0xFF0F1927); // Cards
  static const Color bgSurface     = Color(0xFF162234); // Elevated surfaces
  static const Color bgBorder      = Color(0xFF1E3048); // Borders / dividers

  // Primary — soft blue-indigo (calming, trustworthy)
  static const Color primary       = Color(0xFF5B8DEF);
  static const Color primaryDark   = Color(0xFF3D6AD4);
  static const Color primaryLight  = Color(0xFF7AAAF5);

  // Accent — warm amber (energy, score highlights)
  static const Color accent        = Color(0xFFF5A623);
  static const Color accentDark    = Color(0xFFD98A10);

  // Supporting palette
  static const Color accentTeal    = Color(0xFF4ECDC4); // sleep stage: light
  static const Color accentPurple  = Color(0xFF9B8FD4); // sleep stage: REM
  static const Color accentGreen   = Color(0xFF56C99A); // success / streak
  static const Color accentRose    = Color(0xFFE88A8A); // warning / mood: bad

  // Text
  static const Color textPrimary   = Color(0xFFF0F4FF);
  static const Color textSecondary = Color(0xFF8A9BBD);
  static const Color textHint      = Color(0xFF4A5A78);

  // Semantic
  static const Color success       = Color(0xFF56C99A);
  static const Color warning       = Color(0xFFF5A623);
  static const Color error         = Color(0xFFE88A8A);
  static const Color info          = Color(0xFF5B8DEF);

  // Sleep score colors
  static const Color scorePoor     = Color(0xFFE88A8A);  // 0-39
  static const Color scoreFair     = Color(0xFFF5A623);  // 40-59
  static const Color scoreGood     = Color(0xFF5B8DEF);  // 60-79
  static const Color scoreGreat    = Color(0xFF56C99A);  // 80-89
  static const Color scoreExcellent = Color(0xFF4ECDC4); // 90-100

  // ─── Gradients ────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF5B8DEF), Color(0xFF3D6AD4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient nightGradient = LinearGradient(
    colors: [Color(0xFF080E1A), Color(0xFF0F1927), Color(0xFF162234)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient scoreGradient = LinearGradient(
    colors: [Color(0xFF4ECDC4), Color(0xFF5B8DEF), Color(0xFF9B8FD4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ─── Spacing ──────────────────────────────────────────────────────────────
  static const double xs  = 4.0;
  static const double sm  = 8.0;
  static const double md  = 16.0;
  static const double lg  = 24.0;
  static const double xl  = 32.0;
  static const double xxl = 48.0;

  // ─── Border Radius ────────────────────────────────────────────────────────
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 100.0;

  // ─── Theme ────────────────────────────────────────────────────────────────
  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = GoogleFonts.interTextTheme(base.textTheme).copyWith(
      displayLarge:  GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w700, color: textPrimary),
      displayMedium: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700, color: textPrimary),
      headlineLarge: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, color: textPrimary),
      headlineMedium: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary),
      titleLarge:    GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
      titleMedium:   GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: textPrimary),
      titleSmall:    GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: textPrimary),
      bodyLarge:     GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: textPrimary),
      bodyMedium:    GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: textSecondary),
      bodySmall:     GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: textHint),
      labelLarge:    GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimary),
      labelMedium:   GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: textSecondary),
      labelSmall:    GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w400, color: textHint),
    );

    return base.copyWith(
      scaffoldBackgroundColor: bgDeep,
      colorScheme: ColorScheme.dark(
        primary:   primary,
        secondary: accent,
        surface:   bgSurface,
        error:     error,
        onPrimary: textPrimary,
        onSecondary: bgDeep,
        onSurface: textPrimary,
        onError:   textPrimary,
        outline:   bgBorder,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: bgDeep,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),
      cardTheme: CardThemeData(
        color: bgMid,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          side: const BorderSide(color: bgBorder, width: 0.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: textPrimary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          side: const BorderSide(color: bgBorder),
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLg),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: bgMid,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: bgBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: bgBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        hintStyle: GoogleFonts.inter(color: textHint, fontSize: 14),
        labelStyle: GoogleFonts.inter(color: textSecondary, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: md, vertical: md),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: bgMid,
        selectedItemColor: primary,
        unselectedItemColor: textHint,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: bgBorder,
        thickness: 0.5,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: bgSurface,
        contentTextStyle: GoogleFonts.inter(color: textPrimary, fontSize: 14),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
      ),
    );
  }

  // ─── Helper methods ───────────────────────────────────────────────────────
  static Color scoreColor(int score) {
    if (score < 40) return scorePoor;
    if (score < 60) return scoreFair;
    if (score < 80) return scoreGood;
    if (score < 90) return scoreGreat;
    return scoreExcellent;
  }
}
