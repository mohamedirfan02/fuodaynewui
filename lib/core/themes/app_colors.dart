import 'package:flutter/material.dart';

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
  //     Color(0xFF42a5f5), // Light blue
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

  static const List<Color> cardGradientColor = [
    Color(0xFFD1D7E8),
    Color(0xFFEFF1F7),
    Colors.white,
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
  static const Color TestColor = Color(0xFFFFCF28);

  // attendance card light color
  static const Color attendanceCardTextLightColor = Color(0xFFC6CEE4);

  /// for dark mode color //////////////////////

  // // 🌙 Dark Mode Colors
  // static const List<Color> employeeGradientColorDark = [
  //   Color(0xFF2C0030),
  //   Color(0xFF22075E),
  //   Color(0xFF0F1150),
  //   Color(0xFF4A0C7D),
  //   Color(0xFF2B0A52),
  // ];
  //
  // static const List<Color> cardGradientColorDark = [
  //   Color(0xFF1E1E1E),
  //   Color(0xFF2C2C2C),
  //   Color(0xFF121212),
  // ];
  //
  // static const List<Color> recruiterGradientColorDark = [
  //   Color(0xFF1C3A8C), // muted blue
  //   Color(0xFF27305C), // deep navy
  // ];
  //
  // static const Color transparentColorDark = Colors.transparent;
  //
  // // Primary Color (darker variant)
  // static const Color primaryColorDark = Color(0xFFA678D6);
  //
  // // Secondary Color
  // static const Color secondaryColorDark = Color(0xFF1E1E1E);
  //
  // // Title Color
  // static const Color titleColorDark = Color(0xFFFFFFFF);
  //
  // // Subtitle Color
  // static const Color subTitleColorDark = Color(0xFF88A8FF);
  //
  // // Auth Background
  // static const Color authBgColorDark = Color(0xFF121212);
  //
  // // Onboarding
  // static const Color onBoardingBgColorDark = Color(0xFF1E1E1E);
  // static const Color onBoardingTextColorDark = Color(0xFF5584FF);
  //
  // // Auth TextField Colors
  // static const Color authTextFieldSuffixIconColorDark = Color(0xFF8A8A8A);
  // static const Color authUnderlineBorderColorDark = Color(0xFF707070);
  // static const Color softRedDark = Color(0xFFEF9A9A);
  //
  // // Text Button
  // static const Color textBtnColorDark = Color(0xFF6C78FF);
  //
  // // Auth Button
  // static const Color authBtnColorDark = Color(0xFF3A66D7);
  // static const Color authBackToLoginColorDark = Color(0xFF375E89);
  //
  // // Card Border
  // static const Color cardBorderColorDark = Color(0xFF3A3A3A);
  // static const Color organizationalColorDark = Color(0xFFE6C94C);
  // static const Color announcementColorDark = Color(0xFF4CAF70);
  //
  // // Check-in/out
  // static const Color checkInColorDark = Color(0xFF66BB6A);
  // static const Color checkOutColorDark = Color(0xFFE57373);
  // static const Color locationOnSiteColorDark = Color(0xFF4A6BFF);
  //
  // // Neutral Colors
  // static const Color greyColorDark = Color(0xFFB0B0B0);
  // static const Color chipColorDark = Color(0xFF3E3E3E);
  // static const Color approvedColorDark = Color(0xFF81C784);
  // static const Color pendingColorDark = Color(0xFFFFE082);
  //
  // // Attendance Card Light Text (in dark mode = muted gray)
  // static const Color attendanceCardTextLightColorDark = Color(0xFF9DA7C5);
}
