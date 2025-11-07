import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';

class HrAddEvents extends StatefulWidget {
  final int? eventId; // null for create
  final Map<String, dynamic>? existingEvent; // optional, used for update

  const HrAddEvents({super.key, this.eventId, this.existingEvent});

  @override
  State<HrAddEvents> createState() => _HrAddEventsState();
}

class _HrAddEventsState extends State<HrAddEvents> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  String eventAction = 'Create'; // <-- radio button value

  @override
  void initState() {
    super.initState();
    if (widget.existingEvent != null) {
      titleController.text = widget.existingEvent?['title'] ?? '';
      descriptionController.text = widget.existingEvent?['description'] ?? '';
      final date = widget.existingEvent?['date']; // assuming yyyy-MM-dd
      if (date != null) {
        final parts = date.split('-');
        if (parts.length == 3) {
          dateController.text =
              "${parts[2]}/${parts[1]}/${parts[0]}"; // dd/MM/yyyy
        }
      }
      context.dropDownProviderRead.setValue(
        'Events',
        widget.existingEvent?['event'],
      );
      eventAction = widget.eventId != null ? 'Update' : 'Create';
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    dateController.dispose();
    titleController.dispose();
    super.dispose();
  }

  void clearForm() {
    descriptionController.clear();
    dateController.clear();
    titleController.clear();
    setState(() {
      eventAction = 'Create';
    });
    context.dropDownProviderRead.setValue(
      'priority',
      null,
    ); // reset dropdown<dropDownProviderWatch>().setValue('Events', null); // reset dropdown
  }

  Future<void> submitEvent() async {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final webUserId = employeeDetails?['web_user_id'] ?? 0;

    // Use read instead of watch
    final event = context.dropDownProviderRead.getValue('Events');

    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final date = dateController.text.trim(); // dd/MM/yyyy
    final action = eventAction.toLowerCase(); // create or update

    final dateParts = date.split('/');
    final formattedDate =
        "${dateParts[2]}-${dateParts[1].padLeft(2, '0')}-${dateParts[0].padLeft(2, '0')}";

    final payload = {
      "web_user_id": webUserId,
      "event": event,
      "title": title,
      "description": description,
      "date": formattedDate,
      "action": action,
      if (action == 'update' && widget.eventId != null) "id": widget.eventId,
    };

    try {
      await DioService().post('/admin-users/save/event', data: payload);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Event ${action == 'create' ? 'created' : 'updated'} successfully',
          ),
        ),
      );
      clearForm();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate(
      BuildContext context,
      TextEditingController controller,
    ) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        initialDatePickerMode: DatePickerMode.day,
        helpText: 'Select Date',
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: AppColors.secondaryColor,
                onSurface: AppColors.titleColor,
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        controller.text = "${picked.day}/${picked.month}/${picked.year}";
      }
    }

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: "Events Types",
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
                const SizedBox(height: 10),

                // Event Dropdown
                KDropdownTextFormField<String>(
                  hintText: "Select Event",
                  value: context.dropDownProviderWatch.getValue('Events'),
                  items: const ['Celebration', 'Operation', 'Announcement'],
                  onChanged: (value) =>
                      context.dropDownProviderRead.setValue('Events', value),
                  validator: (value) => value == null || value.isEmpty
                      ? "Events is required"
                      : null,
                ),
                const SizedBox(height: 10),

                // Title
                KAuthTextFormField(
                  maxLines: 1,
                  label: "Title",
                  controller: titleController,
                  hintText: "Enter Title",
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? "Title is required"
                      : null,
                ),
                const SizedBox(height: 10),

                // Deadline
                KAuthTextFormField(
                  label: "date",
                  onTap: () async {
                    selectDate(context, dateController);
                  },
                  controller: dateController,
                  hintText: "Select date",
                  keyboardType: TextInputType.datetime,
                  suffixIcon: Icons.date_range,
                  validator: (value) => value == null || value.isEmpty
                      ? "Deadline is required"
                      : null,
                ),
                const SizedBox(height: 20),

                // Description
                KAuthTextFormField(
                  maxLines: 3,
                  label: "Description",
                  controller: descriptionController,
                  hintText: "Enter description",
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? "Description is required"
                      : null,
                ),
                const SizedBox(height: 20),

                // Radio Buttons for Create / Update
                KText(
                  text: "Action",
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Create',
                      groupValue: eventAction,
                      onChanged: (value) {
                        setState(() {
                          eventAction = value!;
                        });
                      },
                    ),
                    const Text("Create"),
                    const SizedBox(width: 20),
                    Radio<String>(
                      value: 'Update',
                      groupValue: eventAction,
                      onChanged: (value) {
                        setState(() {
                          eventAction = value!;
                        });
                      },
                    ),
                    const Text("Update"),
                  ],
                ),
                const SizedBox(width: 40),

                // Create Event Button
                KAuthFilledBtn(
                  text: eventAction == 'Create'
                      ? 'Create Event'
                      : 'Update Event',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      submitEvent();
                    }
                  },
                  backgroundColor: AppColors.primaryColor,
                  fontSize: 10.sp,
                  height: AppResponsive.responsiveBtnHeight(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
