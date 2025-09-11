import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class ApplicantItem extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final Color avatarColor;
  final bool showInitials;
  final String? initials;
  final String? cv;
  final String? createdDate;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;
  final Function(String)? onStageChanged; // callback when stage changes
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ApplicantItem({
    Key? key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.avatarColor,
    this.showInitials = false,
    this.initials,
    this.cv,
    this.createdDate,
    this.onEditTap,
    this.onDeleteTap,
    this.onStageChanged,
    this.onEdit, // Add this
    this.onDelete, // Add this
  }) : super(key: key);

  /// ✅ HEADER WIDGET
  static Widget buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      height: 56.h,
      color: AppColors.atsHomepageBg,
      child: Row(
        children: [
          SizedBox(
            width: 190.w,
            child: KText(
              text: "Name",
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.greyColor,
            ),
          ),
          SizedBox(
            width: 100.w,
            child: KText(
              text: "Phone Number",
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.greyColor,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 100.w,
            child: KText(
              text: "CV",
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.greyColor,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 120.w,
            child: KText(
              text: "Created Date",
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.greyColor,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 100.w,
            child: KText(
              text: "Stages",
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.greyColor,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 100.w,
            child: KText(
              text: "Action",
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.greyColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<ApplicantItem> createState() => _ApplicantItemState();

  // Available stages for the dropdown
  static const List<String> availableStages = [
    'Applied',
    'Screening',
    '1st Interview',
    '2nd Interview',
    'Hiring',
    'Rejected',
  ];
}

class _ApplicantItemState extends State<ApplicantItem> {
  String? selectedStage;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildStageDropdown() {
    return SizedBox(
      width: 100.w,
      child: DropdownButton<String>(
        value: selectedStage,
        isExpanded: true,
        underline: Container(),
        // removes the default underline
        hint: KText(
          text: "Select Stage",
          fontSize: 10.sp,
          color: AppColors.greyColor,
          fontWeight: FontWeight.w400,
        ),
        items: ApplicantItem.availableStages.map((String stage) {
          return DropdownMenuItem<String>(
            value: stage,
            child: KText(
              text: stage,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.titleColor,
            ),
          );
        }).toList(),
        onChanged: (String? newStage) {
          if (newStage != null) {
            setState(() {
              selectedStage = newStage;
            });
            if (widget.onStageChanged != null) {
              widget.onStageChanged!(newStage);
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Replace this part inside ApplicantItem -> Name & Avatar section
            SizedBox(
              width: 200.w, // give more width since it's now stacked
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First row -> Avatar + Name
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          color: widget.avatarColor,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: widget.showInitials && widget.initials != null
                            ? Center(
                                child: KText(
                                  text: widget.initials!,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: Image.asset(
                                  AppAssetsConstants.personPlaceHolderImg,
                                ),
                              ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: KText(
                          text: widget.name,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.titleColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  // Second row -> Email
                  Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    // indent to align with text (after avatar)
                    child: KText(
                      text: widget.email,
                      fontSize: 12.sp,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // Phone
            SizedBox(
              width: 100.w,
              child: Center(
                child: KText(
                  text: widget.phoneNumber,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.titleColor,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // CV
            SizedBox(
              width: 100.w, // give more width if needed for text + icon
              child: Center(
                child: (widget.cv != null && widget.cv!.isNotEmpty)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: KText(
                              text: widget.cv!,
                              fontSize: 12.sp,
                              color: AppColors.titleColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.download_outlined,
                            size: 16.sp,
                            color: AppColors.greyColor,
                          ),
                        ],
                      )
                    : KText(
                        text: "-",
                        fontSize: 12.sp,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
              ),
            ),

            // Created Date
            SizedBox(
              width: 120.w,
              child: Center(
                child: KText(
                  text: widget.createdDate ?? "-",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.titleColor,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Stage Dropdown
            _buildStageDropdown(),

            // Replace your existing SizedBox with this:
            SizedBox(
              width: 120.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Edit Button
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor, // Blue color for edit
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                        onPressed: () {
                          print("Edit button pressed");
                        },
                        icon: SvgPicture.asset(
                          AppAssetsConstants.editIcon,
                          // Replace with your edit SVG
                          height: 13.h,
                          width: 11.67.w,
                          fit: BoxFit.contain,
                          color: Colors.white, // Optional: tint the SVG
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w), // Space between buttons
                  // Delete Button
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: AppColors.softRed, // Red color for delete
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                        onPressed: () {
                          print("Delete button pressed");
                        },
                        icon: SvgPicture.asset(
                          AppAssetsConstants.deleteIcon,
                          // Replace with your delete SVG
                          height: 12.07.h,
                          width: 11.66.w,
                          fit: BoxFit.contain,
                          color: Colors.white, // Optional: tint the SVG
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Divider
        SizedBox(height: 10.h),
        Divider(thickness: 1, color: AppColors.primaryColor.withOpacity(0.10)),
      ],
    );
  }
}
