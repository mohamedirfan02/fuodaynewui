import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  //   // Option 1: Deep blue to bright blue gradient
  //   static const List<Color> employeeGradientColor = [
  //     Color(0xFF1a237e), // Deep indigo blue
  //     Color(0xFF283593), // Dark blue
  //     Color(0xFF3949ab), // Medium blue
  //     Color(0xFF5e35b1), // Blue purple
  //     Color(0xFF1976d2), // Bright blue
  //   ];
  //
  // // Option 2: Navy to royal blue (closer to your image)
  //   static const List<Color> employeeGradientColorAlt = [
  //     Color(0xFF0d47a1), // Dark navy blue
  //     Color(0xFF1565c0), // Navy blue
  //     Color(0xFF1976d2), // Royal blue
  //     Color(0xFF1e88e5), // Bright blue
  //     Color(0xFF42a5f5), // Li ght blue
  //   ];
  //
  // // Option 3: Custom blue gradient matching your UI
  //   static const List<Color> employeeGradientColorCustom = [
  //     Color(0xFF0a1e3d), // Very dark blue
  //     Color(0xFF1a3a5c), // Dark blue
  //     Color(0xFF2d5a87), // Medium blue
  //     Color(0xFF4a7bb7), // Lighter blue
  //     Color(0xFF6ba3d6), // Light blue
  //   ];

  // Employee gradient Colors
  static const List<Color> employeeGradientColor = [
    Color(0xCC500357),
    Color(0xCC4810C2),
    Color(0xCC1311B1),
    Color(0xCC830DF1),
    Color(0xCC4D0CC5),
  ];

  //ATS Drwaer and Appbar bg
  static const List<Color> atsDrawerGradientColor = [
    Color(0xCC830DF1),
    Color(0xCC4D0CC5),
  ];

  static const List<Color> cardGradientColor = [
    Color(0xFF8B5CB7),
    Color(0xFFEFF1F7),
    Colors.white,
  ];
  //ATS Button color
  static const List<Color> atsButtonGradientColor = [
    Color(0xFFB683F7),
    Color(0xFF7C2F7F),
  ];
  static const List<Color> recruiterGradientColor = [
    Color(0xFF2B57F1), // rgba(43, 87, 241, 1.0)
    Color(0xFF4756A5), // rgba(71, 86, 165, 1.0)
  ];

  static const List<Color> recruiterBorderGradient = [
    Color(0xFFF30066), // pink
    Color(0xFF4B23B3), // purple
    Color(0xFF0062FF), // blue
  ];

  // ATS Homepage PieChat Color
  static const Color closed = Color(0xFF2DD4BF); // rgba(45, 212, 191, 1)
  static const Color pending = Color(0xFF8C62FF); // rgba(140, 98, 255, 1)
  static const Color unactive = Color(0xFFFE964A); // rgba(254, 150, 74, 1)
  //HRMS Chat Colors
  static const Color todoColor = Color(0xFF643DFF); //#643DFF
  static const Color inProgressColor = Color(0xFFFF692E); //#FF692E
  static const Color inReviewedColor = Color(0xFF32ABB9); //#32ABB9
  static const Color completedColor = Color(0xFFFFC84C); //#FFC84C

  static const Color transparentColor = Colors.transparent;

  //Ats Homepage Bg
  static const Color atsHomepageBg = Color(0xFFFAFAFA);

  // Ats tittle Color
  static const Color atsTittleText = Color(0xFF061B2E);

  // Primary Color
  static const Color primaryColor = Color(0xFF8B5CB7);

  // Secondary Color
  static const Color secondaryColor = Colors.white;

  // Title Color
  static const Color titleColor = Color(0xFF000000);

  // subTitle Color
  static const Color subTitleColor = Color(0xFF5584FF);

  // auth Bg Color
  static const Color authBgColor = Color(0xFFE8EEFE);

  static const Color homeBtnBgColor = Color(0xFFE6E8EA);
  static const Color newCheckInColor = Color(0xFF593DD0);

  // onboarding btn
  static const Color onBoardingBgColor = Color(0xFFFFFFFF);
  static const Color onBoardingTextColor = Color(0xFF2B57F1);

  // auth TextField Colors
  static const Color authTextFieldSuffixIconColor = Color(0xFFC1B1B1);
  static const Color authUnderlineBorderColor = Color(0xFFC1B1B1);
  static const Color softRed = Color(0xFFE03137);

  // ats drawer selected color
  static const Color softBlue = Color(0xFF3FA2F6);

  // chat bg color
  static const Color chatBg = Color(0xFFEEF4FF);

  // Text Btn Color
  static const Color textBtnColor = Color(0xFF3342FD);

  //divider line color
  static const Color lightGreyColor = Color(0xFFE5E7EB); // 👈 Added this

  // authBtnColor
  static const Color authBtnColor = Color(0xFF5584FF);
  static const Color authBackToLoginColor = Color(0xFFAACBED);

  // Card hint color
  static const Color cardBorderColor = Color(0xFFD9D9D9);
  static const Color organizationalColor = Color(0xFFDFC148);
  static const Color announcementColor = Color(0xFF6DC57A);

  // check in color
  static const Color checkInColor = Color(0xFF009F00);
  static const Color checkOutColor = Colors.red;
  static const Color locationOnSiteColor = Color(0xFF0043FF);

  static const Color greyColor = Color(0xFF636364);
  static const Color chipColor = Color(0xFFD1D7E8);
  static const Color approvedColor = Color(0xFF009F00);
  static const Color pendingColor = Color(0xFFFFCF28);

  // attendance card light color
  static const Color attendanceCardTextLightColor = Color(0xFFC6CEE4);

  /// for dark mode color //////////////////////

  // 🌙 Dark Mode Colors - Blue Themed
  static const List<Color> employeeGradientColorDark = [
    Color(0xFF0A2463), // Deep Navy Blue
    Color(0xFF1E3A8A), // Royal Blue
    Color(0xFF0F4C81), // Ocean Blue
    Color(0xFF1B4965), // Deep Sea Blue
    Color(0xFF133E7C), // Midnight Blue
  ];

  static const List<Color> cardGradientColorDark = [
    Color(0xFF0D1B2A), // Dark blue-black
    Color(0xFF1B263B), // Deep slate blue
    Color(0xFF0A1628), // Very dark navy
  ];

  static const List<Color> recruiterGradientColorDark = [
    Color(0xFF1C3A8C), // Muted blue
    Color(0xFF0F2557), // Deep navy
  ];

  static const Color transparentColorDark = Colors.transparent;

  // Primary Color (blue-tinted instead of purple)
  static const Color primaryColorDark = Color(0xFF5B9FFF);

  // Secondary Color
  static const Color secondaryColorDark = Color(0xFF1A2332);

  // Title Color
  static const Color titleColorDark = Color(0xFFFFFFFF);

  // Subtitle Color (keeping the nice blue)
  static const Color subTitleColorDark = Color(0xFF88A8FF);

  // Auth Background
  static const Color authBgColorDark = Color(0xFF0A1628);

  // Onboarding
  static const Color onBoardingBgColorDark = Color(0xFF0A2463);
  static const Color onBoardingTextColorDark = Color(0xFF5B9FFF);

  // Auth TextField Colors
  static const Color authTextFieldSuffixIconColorDark = Color(0xFF6B7A99);
  static const Color authUnderlineBorderColorDark = Color(0xFF4A5B7C);
  static const Color softRedDark = Color(0xFFE57373);

  // Text Button
  static const Color textBtnColorDark = Color(0xFF5B9FFF);

  // Auth Button
  static const Color authBtnColorDark = Color(0xFF1E5FCC);
  static const Color authBackToLoginColorDark = Color(0xFF2A4A7C);

  // Card Border
  static const Color cardBorderColorDark = Color(0xFF2C3E5A);
  static const Color organizationalColorDark = Color(0xFFFFB74D);
  static const Color announcementColorDark = Color(0xFF4CAF70);

  // Check-in/out
  static const Color checkInColorDark = Color(0xFF66BB6A);
  static const Color checkOutColorDark = Color(0xFFE57373);
  static const Color locationOnSiteColorDark = Color(0xFF5B9FFF);

  // Neutral Colors
  static const Color greyColorDark = Color(0xFF9DA7C5);
  static const Color chipColorDark = Color(0xFF1E2D45);
  static const Color approvedColorDark = Color(0xFF66BB6A);
  static const Color pendingColorDark = Color(0xFFFFB74D);

  // Attendance Card Light Text
  static const Color attendanceCardTextLightColorDark = Color(0xFF9DA7C5);

  // Additional helpful colors for consistency
  static const Color dividerColorDark = Color(0xFF1F3A5F);
  static const Color iconColorDark = Color(0xFF88A8FF);
  static const Color disabledColorDark = Color(0xFF4A5B7C);
  static const Color errorColorDark = Color(0xFFE57373);
  static const Color successColorDark = Color(0xFF66BB6A);
  static const Color warningColorDark = Color(0xFFFFB74D);
  static const Color infoColorDark = Color(0xFF5B9FFF);
  //==========ATS SCREENS==========
  static const Color softBlueDark = Color(0xFF8FD0FF);
  static const Color unactiveDark = Color(0xFFCC6A1E);
  static const Color closedDark = Color(0xFF178A7A);
  static const Color chatBgDark = Color(0xFF1C2333);
}

class AppTheme {
  // ======================= LIGHT THEME ========================= //
  static ThemeData lightTheme =
      ThemeData(
        brightness: Brightness.light,
        fontFamily: GoogleFonts.inter().fontFamily,

        scaffoldBackgroundColor: AppColors.atsHomepageBg, // your bg color

        primaryColor: AppColors.primaryColor,
        secondaryHeaderColor: AppColors.secondaryColor,

        //=====ATS Background color========
        cardColor: AppColors.atsHomepageBg,
        //=================================
        dividerColor: AppColors.lightGreyColor,

        textTheme: TextTheme(
          headlineLarge: TextStyle(color: AppColors.titleColor),
          bodyLarge: TextStyle(color: AppColors.greyColor),
        ),

        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.authUnderlineBorderColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.subTitleColor),
          ),
          suffixIconColor: AppColors.authTextFieldSuffixIconColor,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.authBtnColor,
            foregroundColor: AppColors.secondaryColor,
          ),
        ),
      ).copyWith(
        //  ATSPrimaryColor
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppColors.softBlue,
        ),
      );

  // ======================= DARK THEME ========================= //
  static ThemeData darkTheme =
      ThemeData(
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.inter().fontFamily,

        scaffoldBackgroundColor: AppColors.authBgColorDark,

        primaryColor: AppColors.primaryColorDark,
        secondaryHeaderColor: AppColors.secondaryColorDark,

        cardColor: AppColors.secondaryColorDark,
        dividerColor: AppColors.greyColorDark,

        textTheme: TextTheme(
          headlineLarge: TextStyle(color: AppColors.titleColorDark),
          bodyLarge: TextStyle(
            color: AppColors.attendanceCardTextLightColorDark,
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.authUnderlineBorderColorDark,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.subTitleColorDark),
          ),
          suffixIconColor: AppColors.authTextFieldSuffixIconColorDark,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.authBtnColorDark,
            foregroundColor: AppColors.secondaryColorDark,
          ),
        ),
      ).copyWith(
        // ATSPrimaryColor DARK
        colorScheme: const ColorScheme.dark().copyWith(
          primary: AppColors.softBlueDark,
        ),
      );
}
