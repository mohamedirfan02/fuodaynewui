import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onDelete;

  const DeleteConfirmationDialog({
    super.key,
    required this.onDelete,
    this.title = "Delete Confirmation",
    this.message = "Are you sure you want to delete this candidate?",
  });

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onDelete,
    String? title,
    String? message,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DeleteConfirmationDialog(
        onDelete: onDelete,
        title: title ?? "Delete Confirmation",
        message: message ?? "Are you sure you want to delete this candidate?",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: theme.secondaryHeaderColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      contentPadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 16.h),
      titlePadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              color: AppColors.checkOutColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.checkOutColor.withValues(alpha: 0.1),
                child: Icon(Icons.info_outline, size: 20.sp, color: Colors.red),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          KText(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            //  color: AppColors.titleColor,
          ),
          SizedBox(height: 8.h),
          KText(
            text: message,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
          ),

          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    side: BorderSide(
                      color: const Color(0xFFCCCCCC),
                      width: 1.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: KText(
                    text: 'Cancel',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color:
                        theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    onDelete(); // 🔥 delete function callback
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(fontSize: 12.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
