import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/performance/presentation/providers/audit_report_provider.dart';
import 'package:provider/provider.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/performance/presentation/providers/audit_reporting_team_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PerformanceEmployeeAuditForm extends StatefulWidget {
  const PerformanceEmployeeAuditForm({super.key});

  @override
  State<PerformanceEmployeeAuditForm> createState() =>
      _PerformanceEmployeeAuditFormState();
}

class _PerformanceEmployeeAuditFormState
    extends State<PerformanceEmployeeAuditForm> {
  // Columns
  final columns = [
    'S.No',
    'Employee ID',
    'Name',
    'Self status',
    'Preview Audit Form',
  ];

  // Track loading state for individual buttons
  Set<int> loadingButtons = <int>{};

// Method to launch URL
  Future<void> _launchURL(String url) async {
    try {
      final uri = Uri.parse(url);

      // Try different launch modes for better compatibility
      bool launched = false;

      // First try with external application
      try {
        launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } catch (e) {
        debugPrint("External app launch failed: $e");
      }

      // If external app fails, try with platform default
      if (!launched) {
        try {
          launched = await launchUrl(
            uri,
            mode: LaunchMode.platformDefault,
          );
        } catch (e) {
          debugPrint("Platform default launch failed: $e");
        }
      }

      // If both fail, try with in-app web view as fallback
      if (!launched) {
        try {
          launched = await launchUrl(
            uri,
            mode: LaunchMode.inAppWebView,
          );
        } catch (e) {
          debugPrint("In-app web view launch failed: $e");
        }
      }

      if (!launched && mounted) {
        _showErrorDialog("Could not open the web page. Please check your internet connection.");
      }

    } catch (e) {
      if (mounted) {
        _showErrorDialog("Failed to open URL: ${e.toString()}");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final employeeDetails = await HiveStorageService().employeeDetails;
      final webUserId =
          int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

      if (webUserId != 0) {
        context.read<AuditReportingTeamProvider>().fetchAuditReportingTeam(webUserId);
      } else {
        debugPrint("❌ No valid webUserId found in Hive");
      }
    });
  }

  Future<void> _viewAuditReport(dynamic member) async {
    setState(() {
      loadingButtons.add(member.webUserId);
    });

    try {
      final auditProvider = context.read<AuditReportProvider>();

      // Clear previous data
      auditProvider.clearAuditReport();

      await auditProvider.fetchAuditReport(member.webUserId);

      if (mounted) {
        if (auditProvider.auditReport != null && auditProvider.error == null) {
          _showAuditReportDialog(auditProvider.auditReport!);
        } else {
          _showNoReportDialog(member.empName);
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog("Failed to load audit report: ${e.toString()}");
      }
    } finally {
      if (mounted) {
        setState(() {
          loadingButtons.remove(member.webUserId);
        });
      }
    }
  }

  void _showAuditReportDialog(dynamic auditReport) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(auditReport.empName),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInfoRow("Department", auditReport.department),
              _buildInfoRow("DOJ", auditReport.dateOfJoining),
              _buildInfoRow("Key Tasks", auditReport.keyTasksCompleted),
              _buildInfoRow("Challenges", auditReport.challengesFaced),
              _buildInfoRow("Proud Contribution", auditReport.proudContribution),
              _buildInfoRow("Growth Path", auditReport.growthPath),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
          ElevatedButton.icon(
            onPressed: () => _launchURL("https://fuoday.com/login"),
            icon: const Icon(Icons.open_in_browser, size: 16),
            label: const Text("Open Web"),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showNoReportDialog(String empName) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(Icons.info_outline, color: Colors.orange, size: 48),
        title: const Text("No Audit Report Found"),
        content: Text(
          "$empName has not submitted their audit form yet.\n\nPlease ask them to complete and submit their audit form.",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(Icons.error_outline, color: Colors.red, size: 48),
        title: const Text("Error"),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value.isNotEmpty ? value : "Not specified",
            style: TextStyle(
              fontSize: 13,
              color: value.isNotEmpty ? Colors.black87 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuditReportingTeamProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Text(
              "Error: ${provider.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // Map provider.team to KDataTable expected format
        final data = provider.team.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final member = entry.value;
          final isLoading = loadingButtons.contains(member.webUserId);

          return {
            'S.No': index.toString(),
            'Employee ID': member.empId,
            'Name': member.empName,
            'Self status': member.status,
            'Preview Audit Form': ElevatedButton(
              onPressed: isLoading ? null : () => _viewAuditReport(member),
              child: isLoading
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text("View"),
            ),
          };
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            spacing: 14.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              KText(
                text: "Employee Audit Form Update",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.primaryColor,
              ),

              KVerticalSpacer(height: 6.h),

              SizedBox(
                height: 600.h,
                child: KDataTable(columnTitles: columns, rowData: data),
              ),
            ],
          ),
        );
      },
    );
  }
}