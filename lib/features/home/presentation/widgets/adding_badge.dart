import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_image_picker_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/image_picker.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/data/model/recognition_model.dart';
import 'package:fuoday/features/home/domain/entities/recognition_entity.dart';
import 'package:fuoday/features/home/presentation/provider/badge_provider.dart';
import 'package:fuoday/features/home/presentation/provider/recognition_provider.dart';
import 'package:provider/provider.dart';

class Badge {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  String? id; // backend id (nullable)
  File? imageFile;

  Badge({this.id})
    : titleController = TextEditingController(),
      descriptionController = TextEditingController();

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
  }

  bool get isEmpty {
    return titleController.text.trim().isEmpty &&
        descriptionController.text.trim().isEmpty &&
        imageFile == null;
  }

  // Local state mapping (for UI only)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': titleController.text.trim(),
      'description': descriptionController.text.trim(),
      'imagePath': imageFile?.path,
    };
  }

  // API mapping (used for submission)
  Map<String, dynamic> toApiMap() {
    return {
      'title': titleController.text.trim(),
      'count': int.tryParse(descriptionController.text.trim()) ?? 1,
      'imagePath': imageFile?.path, // ✅ ensure path is passed
    };
  }
}

class RecognitionWallWidget extends StatefulWidget {
  // final String? title;
  final String? description;
  final Function(List<Map<String, dynamic>>)? onBadgesSubmitted;
  final VoidCallback? onBadgesUpdated;

  const RecognitionWallWidget({
    super.key,
    // this.title,
    this.description,
    this.onBadgesSubmitted,
    this.onBadgesUpdated,
  });

  @override
  State<RecognitionWallWidget> createState() => _RecognitionWallWidgetState();
}

class _RecognitionWallWidgetState extends State<RecognitionWallWidget> {
  List<Badge> _badges = [];
  List<Map<String, dynamic>> _submittedBadges = []; // Store submitted badges

  late VoidCallback _badgeListener;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final hiveService = getIt<HiveStorageService>();
      final employeeDetails = hiveService.employeeDetails;

      // Dynamically get web_user_id
      final int id =
          int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;
      if (id == 0) return;

      final badgeProvider = context.read<BadgeProvider>();

      // Define the listener
      _badgeListener = () {
        if (!mounted) return; // ✅ Check if the widget is still in the tree
        setState(() {
          _submittedBadges = badgeProvider.badges
              .map(
                (b) => {
                  'id': b.id,
                  'title': b.title,
                  'description': b.count.toString(),
                  'imagePath': b.imageUrl,
                },
              )
              .toList();
        });
      };

      badgeProvider.addListener(_badgeListener);

      await badgeProvider.fetchBadges(id); // Fetch badges
    });
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    final badgeProvider = context.read<BadgeProvider>();
    badgeProvider.removeListener(_badgeListener);

    for (var badge in _badges) {
      badge.dispose();
    }
    super.dispose();
  }

  void _showImagePickerOptions(Badge badge, Function setDialogState) {
    final appImagePicker = AppImagePicker();

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return KImagePickerOptionsBottomSheet(
          onCameraTap: () async {
            final image = await appImagePicker.pickImageFromCamera();
            if (image != null) {
              setDialogState(() {
                badge.imageFile = image;
              });
              Navigator.of(context).pop();
            }
          },
          onGalleryTap: () async {
            final image = await appImagePicker.pickImageFromGallery();
            if (image != null) {
              setDialogState(() {
                badge.imageFile = image;
              });
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }

  void _showBadgeManagementPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Manage Badges',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              content: Container(
                width: double.maxFinite,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          setDialogState(() {
                            _badges.add(Badge());
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add New Badge'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,
                          side: BorderSide(color: AppColors.primaryColor),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      ..._badges.asMap().entries.map((entry) {
                        int index = entry.key;
                        Badge badge = entry.value;

                        return Card(
                          margin: EdgeInsets.only(bottom: 12.h),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Badge ${index + 1}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.titleColor,
                                      ),
                                    ),
                                    if (_badges.length > 1)
                                      IconButton(
                                        onPressed: () {
                                          setDialogState(() {
                                            _badges[index].dispose();
                                            _badges.removeAt(index);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                          size: 18.sp,
                                        ),
                                        constraints: const BoxConstraints(),
                                        padding: EdgeInsets.zero,
                                      ),
                                  ],
                                ),

                                SizedBox(height: 12.h),

                                Container(
                                  width: double.infinity,
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.greyColor.withOpacity(
                                        0.3,
                                      ),
                                      width: 1.w,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: badge.imageFile != null
                                      ? Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              child: Image.file(
                                                badge.imageFile!,
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              top: 8.h,
                                              right: 8.w,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setDialogState(() {
                                                    badge.imageFile = null;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(4.w),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red
                                                        .withOpacity(0.8),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 16.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : GestureDetector(
                                          onTap: () => _showImagePickerOptions(
                                            badge,
                                            setDialogState,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_photo_alternate_outlined,
                                                size: 32.sp,
                                                color: AppColors.greyColor,
                                              ),
                                              SizedBox(height: 8.h),
                                              Text(
                                                'Add Badge Image',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColors.greyColor,
                                                ),
                                              ),
                                              Text(
                                                '(Optional)',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: AppColors.greyColor
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),

                                SizedBox(height: 12.h),

                                KAuthTextFormField(
                                  label: "Badge Title",
                                  controller: badge.titleController,
                                  hintText: "Enter badge title",
                                  keyboardType: TextInputType.text,
                                ),

                                SizedBox(height: 12.h),

                                KAuthTextFormField(
                                  label: "Badge Count",
                                  controller: badge.descriptionController,
                                  hintText: "Enter badge Count",
                                  keyboardType: TextInputType.text,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),

                      if (_badges.isEmpty)
                        Container(
                          padding: EdgeInsets.all(20.w),
                          child: Text(
                            'No badges added yet. Click "Add New Badge" to get started.',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.greyColor,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    for (var badge in _badges) {
                      badge.dispose();
                    }
                    _badges.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    _submitBadges();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                  ),
                  child: KText(
                    text:
                        'Submit (${_badges.length} Badge${_badges.length != 1 ? 's' : ''})',
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _submitBadges() {
    List<Badge> validBadges = _badges.where((badge) => !badge.isEmpty).toList();

    final recognitions = validBadges.map((badge) {
      return RecognitionModel(
        id: badge.id,
        title: badge.titleController.text.trim(),
        count: int.tryParse(badge.descriptionController.text.trim()) ?? 1,
        imagePath: badge.imageFile?.path, // ✅ keep local file path
      );
    }).toList();

    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final int id =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    if (id != 0) {
      context.read<RecognitionProvider>().saveRecognitions(
        webUserId: id,
        badges: recognitions,
      );
    }
  }

  // Method to remove a submitted badge
  void _removeSubmittedBadge(int index) {
    setState(() {
      _submittedBadges.removeAt(index);
    });

    KSnackBar.success(context, 'Badge removed successfully!');
  }

  // Widget to display submitted badges
  Widget _buildSubmittedBadgesDisplay() {
    if (_submittedBadges.isEmpty) {
      return Container(
        padding: EdgeInsets.all(20.w),
        child: KText(
          text: 'No badges added yet. Click the edit icon to add badges.',
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          color: AppColors.secondaryColor,
        ),
      );
    }

    return Column(
      children: [
        SizedBox(height: 16.h),

        CarouselSlider.builder(
          itemCount: _submittedBadges.length,
          itemBuilder: (context, index, realIndex) {
            final badge = _submittedBadges[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.secondaryColor.withOpacity(0.1),

                      /// color for card
                      AppColors.secondaryColor.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge header with remove button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: KText(
                            text: badge['title'] ?? 'Untitled Badge',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.titleColor,
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () => _removeSubmittedBadge(index),
                        //   child: Icon(
                        //     Icons.close,
                        //     size: 18.sp,
                        //     color: Colors.red.withOpacity(0.7),
                        //   ),
                        // ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    // Badge image
                    Expanded(
                      child: badge['imagePath'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: badge['imagePath'].startsWith('http')
                                  ? Image.network(
                                      badge['imagePath'],
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: AppColors.greyColor
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: Icon(
                                                Icons.broken_image,
                                                color: AppColors.greyColor,
                                                size: 32.sp,
                                              ),
                                            );
                                          },
                                    )
                                  : Image.file(
                                      File(badge['imagePath']),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: AppColors.greyColor
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: Icon(
                                                Icons.broken_image,
                                                color: AppColors.greyColor,
                                                size: 32.sp,
                                              ),
                                            );
                                          },
                                    ),
                            )
                          : Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.greyColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: AppColors.greyColor.withOpacity(0.3),
                                ),
                              ),
                              child: Icon(
                                Icons.badge_outlined,
                                color: AppColors.primaryColor,
                                size: 32.sp,
                              ),
                            ),
                    ),

                    SizedBox(height: 8.h),

                    // Badge description
                    if (badge['description'] != null &&
                        badge['description'].isNotEmpty)
                      Text(
                        badge['description'],
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.greyColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 280.h,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            viewportFraction: 0.75,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.w,
          color: AppColors.greyColor.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.employeeGradientColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header with title and edit icon
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Expanded(
          //       child: KText(
          //         text: widget.title ?? "Recognition Wall",
          //         fontWeight: FontWeight.w800,
          //         fontSize: 14,
          //         color: AppColors.secondaryColor,
          //       ),
          //     ),
          //     IconButton(
          //       onPressed: _showBadgeManagementPopup,
          //       icon: Icon(
          //         Icons.edit,
          //         color: AppColors.secondaryColor,
          //         size: 20.sp,
          //       ),
          //       constraints: const BoxConstraints(),
          //       padding: EdgeInsets.zero,
          //       tooltip: 'Manage Badges',
          //     ),
          //   ],
          // ),
          KVerticalSpacer(height: 10.h),
          // Display submitted badges or empty message
          _buildSubmittedBadgesDisplay(),

          KVerticalSpacer(height: 10.h),

          // Description text
          KText(
            text:
                widget.description ??
                'Recognizing our team\'s extraordinary efforts, we express heartfelt gratitude for your dedication, hard work, and the positive impact you bring daily',
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.secondaryColor,
          ),
        ],
      ),
    );
  }
}
