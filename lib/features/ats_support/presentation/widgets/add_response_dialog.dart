import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';

class AddResponseDialog extends StatelessWidget {
  const AddResponseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController responseController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Close Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const KText(
                  text: "Add Response",

                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF374151), // grey tone
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Response label
            const KText(
              text: "Response",

              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
            const SizedBox(height: 8),

            // Response TextField
            TextField(
              controller: responseController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText:
                    'Hi, I can’t seem to update the app. It says “Error checking updates” when I tried to update the app via Google Play. Pls help.',
                hintStyle: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  height: 1.5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF7C3AED)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Add Image Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD1D5DB)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {},
                child: const Text(
                  "Add Image",
                  style: TextStyle(
                    color: Color(0xFF374151),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Add Response Button
            KAuthFilledBtn(
              backgroundColor: AppColors.primaryColor,
              text: "Add Response",
              onPressed: () {
                Navigator.pop(context);
              },
              height: AppResponsive.responsiveBtnHeight(context),
              fontSize: 12.sp,
            ),
          ],
        ),
      ),
    );
  }
}
