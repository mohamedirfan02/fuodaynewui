import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class KImagePickerOptionsBottomSheet extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const KImagePickerOptionsBottomSheet({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.h, right: 10.w, left: 10.w, bottom: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            height: 2.h,
            width: 40.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColors.greyColor,
            ),
          ),

          KVerticalSpacer(height: 12.h),

          // Title
          Text(
            "Pick an Image Options",
            style: GoogleFonts.sora(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          KVerticalSpacer(height: 12.h),

          // PDF
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text("Pick an Image from Camera"),
            onTap: onCameraTap,
          ),

          // Excel
          ListTile(
            leading: const Icon(Icons.file_copy_rounded),
            title: const Text("Pick an Image from Gallery"),
            onTap: onGalleryTap,
          ),
        ],
      ),
    );
  }
}
