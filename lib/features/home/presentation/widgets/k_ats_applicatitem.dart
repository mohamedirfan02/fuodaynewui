import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class ApplicantItem extends StatefulWidget {
  final int? sno;
  final String name;
  final String? email;
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
  final bool showAvatar;

  const ApplicantItem({
    Key? key,
    this.sno,
    required this.name,
    this.email,
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
    this.showAvatar = true,
  }) : super(key: key);

  /// ✅ HEADER WIDGET
  static Widget buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      height: 56.h,
      color: AppColors.atsHomepageBg,
      child: Row(
        children: [
          _headerCell("S.No", 60.w),
          _headerCell("Name", 200.w),
          _headerCell("Phone Number", 100.w),
          _headerCell("CV", 100.w),
          _headerCell("Created Date", 120.w),
          _headerCell("Stages", 100.w),
          _headerCell("Action", 120.w),
        ],
      ),
    );
  }

  static Widget _headerCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Center(
        child: KText(
          text: text,
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
          color: AppColors.greyColor,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static const List<String> availableStages = [
    'Applied',
    'Screening',
    '1st Interview',
    '2nd Interview',
    'Hiring',
    'Rejected',
  ];

  @override
  State<ApplicantItem> createState() => _ApplicantItemState();
}

class _ApplicantItemState extends State<ApplicantItem> {
  String? selectedStage;

  Widget _buildStageDropdown() {
    return SizedBox(
      width: 100.w,
      child: Center(
        child: DropdownButton<String>(
          value: selectedStage,
          isExpanded: true,
          underline: Container(),
          alignment: Alignment.center,
          hint: Center(
            child: KText(
              text: "Select Stage",
              fontSize: 10.sp,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
          ),
          items: ApplicantItem.availableStages.map((String stage) {
            return DropdownMenuItem<String>(
              value: stage,
              alignment: Alignment.center,
              child: KText(
                text: stage,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.titleColor,
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
          onChanged: (String? newStage) {
            if (newStage != null) {
              setState(() => selectedStage = newStage);
              widget.onStageChanged?.call(newStage);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // ✅ S.No
            _cell(
              width: 60.w,
              child: KText(
                text: widget.sno?.toString() ?? "-",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.titleColor,
                textAlign: TextAlign.center,
              ),
            ),

            // ✅ Name + Avatar + Email
            _cell(
              width: 200.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (widget.showAvatar)
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
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.asset(
                                AppAssetsConstants.personPlaceHolderImg,
                              ),
                            ),
                    ),
                  if (widget.showAvatar) SizedBox(width: 8.w),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: widget.name,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.titleColor,
                          textAlign: TextAlign.center,
                        ),
                        if (widget.email != null && widget.email!.isNotEmpty)
                          KText(
                            text: widget.email!,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor,
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Phone Number
            _cell(
              width: 100.w,
              child: KText(
                text: widget.phoneNumber,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.titleColor,
                textAlign: TextAlign.center,
              ),
            ),

            // ✅ CV
            _cell(
              width: 100.w,
              child: (widget.cv != null && widget.cv!.isNotEmpty)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: KText(
                            text: widget.cv!,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.titleColor,
                            textAlign: TextAlign.center,
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
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                      textAlign: TextAlign.center,
                    ),
            ),

            // ✅ Created Date
            _cell(
              width: 120.w,
              child: KText(
                text: widget.createdDate ?? "-",
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.titleColor,
                textAlign: TextAlign.center,
              ),
            ),

            // ✅ Stage Dropdown
            _cell(width: 100.w, child: _buildStageDropdown()),

            // ✅ Action Buttons
            _cell(
              width: 120.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _actionButton(
                    color: AppColors.primaryColor,
                    icon: AppAssetsConstants.editIcon,
                    onTap: widget.onEdit,
                  ),
                  SizedBox(width: 8.w),
                  _actionButton(
                    color: AppColors.softRed,
                    icon: AppAssetsConstants.deleteIcon,
                    onTap: widget.onDelete,
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

  Widget _cell({required double width, required Widget child}) {
    return SizedBox(
      width: width,
      child: Center(child: child),
    );
  }

  Widget _actionButton({
    required Color color,
    required String icon,
    VoidCallback? onTap,
  }) {
    return Container(
      width: 30.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          icon,
          height: 14.h,
          fit: BoxFit.contain,
          color: Colors.white,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
