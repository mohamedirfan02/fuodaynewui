import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';

import 'k_ats_applicatitem.dart';

/// ✅ Full reusable widget: ApplicantTable
class ApplicantTable extends StatefulWidget {
  final List<Map<String, dynamic>> applicants;
  final int itemsPerPage;

  const ApplicantTable({
    Key? key,
    required this.applicants,
    this.itemsPerPage = 6,
  }) : super(key: key);

  @override
  State<ApplicantTable> createState() => _ApplicantTableState();
}

class _ApplicantTableState extends State<ApplicantTable> {
  int currentPage = 1;
  int pageWindowStart = 1;
  final int pageWindowSize = 5;

  List<Map<String, dynamic>> get paginatedApplicants {
    int totalPages = (widget.applicants.length / widget.itemsPerPage).ceil();
    if (currentPage > totalPages) currentPage = totalPages;
    if (currentPage < 1) currentPage = 1;

    int startIndex = (currentPage - 1) * widget.itemsPerPage;
    int endIndex = startIndex + widget.itemsPerPage;
    if (startIndex >= widget.applicants.length) return [];
    if (endIndex > widget.applicants.length) endIndex = widget.applicants.length;

    return widget.applicants.sublist(startIndex, endIndex);
  }

  int get totalPages => (widget.applicants.length / widget.itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table (scrollable horizontally)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ApplicantItem.buildHeader(),
              SizedBox(height: 16.h),
              Column(
                children: paginatedApplicants.map((applicant) {
                  return ApplicantItem(
                    name: applicant['name'],
                    email: applicant['email'],
                    phoneNumber: applicant['phone'],
                    cv: applicant['cv'],
                    createdDate: applicant['createdDate'],
                    avatarColor: applicant['avatarColor'],
                    showInitials: true,
                    initials: applicant['name'].substring(0, 2).toUpperCase(),
                    onStageChanged: (newStage) {
                      print("${applicant['name']} stage changed to $newStage");
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        KVerticalSpacer(height: 24.h),

        // Pagination (not scrollable)
        _buildPageNumbersRow(),
      ],
    );
  }


  /// ✅ Pagination Row
  Widget _buildPageNumbersRow() {
    int windowEnd = (pageWindowStart + pageWindowSize - 1);
    if (windowEnd > totalPages) windowEnd = totalPages;

    List<Widget> pageButtons = [];

    // Previous window arrow
    pageButtons.add(IconButton(
      icon: Icon(Icons.chevron_left, size: 16.sp),
      onPressed: pageWindowStart > 1
          ? () {
        setState(() {
          pageWindowStart -= pageWindowSize;
          currentPage = pageWindowStart;
        });
      }
          : null,
    ));

    // Page numbers
    for (int i = pageWindowStart; i <= windowEnd; i++) {
      pageButtons.add(Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: _buildPageNumber(i),
      ));
    }

    // Next window arrow
    pageButtons.add(IconButton(
      icon: Icon(Icons.chevron_right, size: 16.sp),
      onPressed: windowEnd < totalPages
          ? () {
        setState(() {
          pageWindowStart += pageWindowSize;
          currentPage = pageWindowStart;
        });
      }
          : null,
    ));

    return Row(children: pageButtons);
  }

  /// ✅ Single Page Button
  Widget _buildPageNumber(int pageNum) {
    final isActive = pageNum == currentPage;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentPage = pageNum;
        });
      },
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFFF8F8F8) : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Center(
          child: KText(
            text: pageNum.toString(),
            fontSize: 12.sp,
            color: isActive ? Colors.black : AppColors.titleColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
