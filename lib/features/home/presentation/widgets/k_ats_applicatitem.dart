import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class ApplicantItem extends StatefulWidget {
  final int? sno;
  final String name;
  final String? email; // ✅ optional
  final String phoneNumber;
  final Color avatarColor;
  final bool showInitials;
  final String? initials;
  final String? cv;
  final String? createdDate;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;
  final Function(String)? onStageChanged;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showAvatar; // ✅ optional avatar

  const ApplicantItem({
    Key? key,
    this.sno,
    required this.name,
    this.email, // ✅ optional
    required this.phoneNumber,
    required this.avatarColor,
    this.showInitials = false,
    this.initials,
    this.cv,
    this.createdDate,
    this.onEditTap,
    this.onDeleteTap,
    this.onStageChanged,
    this.onEdit,
    this.onDelete,
    this.showAvatar = true, // ✅ default true
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
            width: 50.w,
            child: KText(
              text: "S.No",
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.greyColor,
              textAlign: TextAlign.center,
            ),
          ),
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

  Widget _buildStageDropdown() {
    return SizedBox(
      width: 100.w,
      child: DropdownButton<String>(
        value: selectedStage,
        isExpanded: true,
        underline: Container(),
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
            widget.onStageChanged?.call(newStage);
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
            // ✅ S.No Column
            SizedBox(
              width: 60.w,
              child: Center(
                child: KText(
                  text: widget.sno?.toString() ?? "-",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.titleColor,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // ✅ Name + Avatar + Email
            // ✅ Name + Avatar + Email
            SizedBox(
              width: 200.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.showAvatar) // ✅ Only show avatar if true
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

                      if (widget.showAvatar) SizedBox(width: 16.w), // ✅ spacing only if avatar exists

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

                  if (widget.email != null && widget.email!.isNotEmpty) // ✅ Only show email if provided
                    Padding(
                      padding: EdgeInsets.only(left: widget.showAvatar ? 40.w : 0), // ✅ indent only if avatar shown
                      child: KText(
                        text: widget.email!,
                        fontSize: 12.sp,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            ),


            // ✅ Phone
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

            // ✅ CV
            SizedBox(
              width: 100.w,
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

            // ✅ Created Date
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

            // ✅ Stage Dropdown
            _buildStageDropdown(),

            // ✅ Action Buttons
            SizedBox(
              width: 120.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Edit
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: IconButton(
                      onPressed: widget.onEdit ?? () {},
                      icon: SvgPicture.asset(
                        AppAssetsConstants.editIcon,
                        height: 13.h,
                        width: 11.67.w,
                        fit: BoxFit.contain,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Delete
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: AppColors.softRed,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: IconButton(
                      onPressed: widget.onDelete ?? () {},
                      icon: SvgPicture.asset(
                        AppAssetsConstants.deleteIcon,
                        height: 12.07.h,
                        width: 11.66.w,
                        fit: BoxFit.contain,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Divider(thickness: 1, color: AppColors.primaryColor.withOpacity(0.10)),
      ],
    );
  }
}

