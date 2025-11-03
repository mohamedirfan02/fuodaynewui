import 'package:dio/dio.dart';
import 'package:fuoday/commons/providers/checkbox_provider.dart';
import 'package:fuoday/commons/providers/dropdown_provider.dart';
import 'package:fuoday/commons/widgets/k_pdf_generater_reusable_widget.dart';
import 'package:fuoday/config/flavors/flavors_config.dart';
import 'package:fuoday/core/providers/app_file_downloader_provider.dart';
import 'package:fuoday/core/providers/app_file_picker_provider.dart';
import 'package:fuoday/core/providers/app_internet_checker_provider.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/pdf_generator_service.dart';
import 'package:fuoday/core/service/secure_storage_service.dart';
import 'package:fuoday/core/utils/file_picker.dart';
import 'package:fuoday/features/attendance/data/datasources/local/total_absent_details_local_data_source.dart';
import 'package:fuoday/features/attendance/data/datasources/local/total_attendance_details_local_data_source.dart';
import 'package:fuoday/features/attendance/data/datasources/local/total_early_arrivals_details_local_data_source.dart';
import 'package:fuoday/features/attendance/data/datasources/local/total_late_arrivals_details_local_data_source.dart';
import 'package:fuoday/features/attendance/data/datasources/remote/total_absent_details_remote_data_source.dart';
import 'package:fuoday/features/attendance/data/datasources/remote/total_attendance_details_remote_data_source.dart';
import 'package:fuoday/features/attendance/data/datasources/remote/total_early_arrivals_details_remote_data_source.dart';
import 'package:fuoday/features/attendance/data/datasources/remote/total_late_arrivals_details_remote_data_source.dart';
import 'package:fuoday/features/attendance/data/datasources/remote/total_punctual_arrivals_details_remote_data_source.dart';
import 'package:fuoday/features/attendance/data/repository/total_absent_days_details_repository_impl.dart';
import 'package:fuoday/features/attendance/data/repository/total_attendance_details_repository_impl.dart';
import 'package:fuoday/features/attendance/data/repository/total_early_arrivals_details_repository_impl.dart';
import 'package:fuoday/features/attendance/data/repository/total_late_arrivals_details_repository_impl.dart';
import 'package:fuoday/features/attendance/data/repository/total_punctual_details_repository_impl.dart';
import 'package:fuoday/features/attendance/domain/repository/total_absent_details_repository.dart';
import 'package:fuoday/features/attendance/domain/repository/total_attendance_details_repository.dart';
import 'package:fuoday/features/attendance/domain/repository/total_early_arrivals_details_repository.dart';
import 'package:fuoday/features/attendance/domain/repository/total_late_arrivals_details_repository.dart';
import 'package:fuoday/features/attendance/domain/repository/total_punctual_details_repository.dart';
import 'package:fuoday/features/attendance/domain/usecases/get_total_absent_details_use_case.dart';
import 'package:fuoday/features/attendance/domain/usecases/get_total_attendance_details_use_case.dart';
import 'package:fuoday/features/attendance/domain/usecases/get_total_early_arrivals_details_use_case.dart';
import 'package:fuoday/features/attendance/domain/usecases/get_total_late_arrivals_details_use_case.dart';
import 'package:fuoday/features/attendance/domain/usecases/get_total_punctual_arrivals_details_use_case.dart';
import 'package:fuoday/features/attendance/presentation/providers/date_time_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_absent_days_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_attendance_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_early_arrivals_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_late_arrivals_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_punctual_arrivals_details_provider.dart';
import 'package:fuoday/features/auth/data/datasources/remote/employee_auth_remote_datasource.dart';
import 'package:fuoday/features/auth/data/datasources/remote/forgot_password_remote_datasource.dart';
import 'package:fuoday/features/auth/data/datasources/remote/reset_password_remote_datasource.dart';
import 'package:fuoday/features/auth/data/datasources/remote/verify_otp_remote_datasource.dart';
import 'package:fuoday/features/auth/data/repository/employee_auth_repository_impl.dart';
import 'package:fuoday/features/auth/data/repository/forgot_password_repository_impl.dart';
import 'package:fuoday/features/auth/data/repository/reset_password_repository_impl.dart';
import 'package:fuoday/features/auth/data/repository/verify_otp_repository_impl.dart';
import 'package:fuoday/features/auth/domain/repository/forgot_password_repository.dart';
import 'package:fuoday/features/auth/domain/repository/reset_password_repository.dart';
import 'package:fuoday/features/auth/domain/repository/verify_otp_repository.dart';
import 'package:fuoday/features/auth/domain/usecases/employee_auth_login_usecase.dart';
import 'package:fuoday/features/auth/domain/usecases/employee_auth_logout_usecase.dart';
import 'package:fuoday/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:fuoday/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:fuoday/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:fuoday/features/auth/presentation/providers/employee_auth_login_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/employee_auth_logout_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/reset_password_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/sliding_segmented_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/verify_otp_provider.dart';
import 'package:fuoday/features/bottom_nav/providers/bottom_nav_provider.dart';
import 'package:fuoday/features/bottom_nav/providers/recruiter_bottom_nav_provider.dart';
import 'package:fuoday/features/calendar/data/datasources/shift_schedule_remote_datasource.dart';
import 'package:fuoday/features/calendar/data/repository/shift_schedule_repository_impl.dart';
import 'package:fuoday/features/calendar/domain/repository/shift_schedule_repository.dart';
import 'package:fuoday/features/calendar/domain/usecases/get_monthly_shift_usecase.dart';
import 'package:fuoday/features/calendar/presentation/providers/shift_schedule_provider.dart';
import 'package:fuoday/features/home/data/datasources/remote/badge_remote_data_source.dart';
import 'package:fuoday/features/home/data/datasources/remote/check_in_remote_data_source.dart';
import 'package:fuoday/features/home/data/datasources/remote/checkin_status_remote_data_source.dart';
import 'package:fuoday/features/home/data/datasources/remote/event_remote_data_source.dart';
import 'package:fuoday/features/home/data/datasources/remote/home_add_task_remote_data_source.dart';
import 'package:fuoday/features/home/data/datasources/remote/home_feeds_project_remote_data_source.dart';
import 'package:fuoday/features/home/data/datasources/remote/recognition_remote_data_source.dart';
import 'package:fuoday/features/home/data/repositories/badge_repository_impl.dart';
import 'package:fuoday/features/home/data/repositories/checkin_repository.dart';
import 'package:fuoday/features/home/data/repositories/checkin_status_repository_impl.dart';
import 'package:fuoday/features/home/data/repositories/get_all_events_remote_repository_impl.dart';
import 'package:fuoday/features/home/data/repositories/home_addtask_repositoryImpl.dart';
import 'package:fuoday/features/home/data/repositories/home_feeds_project_data_repository_impl.dart';
import 'package:fuoday/features/home/data/repositories/recognition_repository_impl.dart';
import 'package:fuoday/features/home/domain/repositories/badge_repository.dart';
import 'package:fuoday/features/home/domain/repositories/checkin_repository.dart';
import 'package:fuoday/features/home/domain/repositories/checkin_status_repository.dart';
import 'package:fuoday/features/home/domain/repositories/events_repository.dart';
import 'package:fuoday/features/home/domain/repositories/home_addtask_repository.dart';
import 'package:fuoday/features/home/domain/repositories/home_feeds_project_data_repository.dart';
import 'package:fuoday/features/home/domain/repositories/recognition_repository.dart';
import 'package:fuoday/features/home/domain/usecases/checkin_usecase.dart';
import 'package:fuoday/features/home/domain/usecases/emp_list_usecase.dart';
import 'package:fuoday/features/home/domain/usecases/get_announcement_usecase.dart';
import 'package:fuoday/features/home/domain/usecases/get_badges_usecase.dart';
import 'package:fuoday/features/home/domain/usecases/get_celebrations_usecase.dart';
import 'package:fuoday/features/home/domain/usecases/get_checkin_status_usecase.dart';
import 'package:fuoday/features/home/domain/usecases/get_home_feeds_project_data_use_case.dart';
import 'package:fuoday/features/home/domain/usecases/get_organizational_program_usecase.dart';
import 'package:fuoday/features/home/domain/usecases/home_addtask_usecase.dart';
import 'package:fuoday/features/home/domain/usecases/save_recognitions_usecase.dart';
import 'package:fuoday/features/home/presentation/provider/all_events_provider.dart';
import 'package:fuoday/features/home/presentation/provider/badge_provider.dart';
import 'package:fuoday/features/home/presentation/provider/check_in_provider.dart';
import 'package:fuoday/features/home/presentation/provider/checkin_status_provider.dart';
import 'package:fuoday/features/home/presentation/provider/recognition_provider.dart';
import 'package:fuoday/features/hr/data/datasources/hr_overview_remote_datasource.dart';
import 'package:fuoday/features/hr/data/repository/hr_overview_repository_impl.dart';
import 'package:fuoday/features/hr/domain/repository/hr_overview_repository.dart';
import 'package:fuoday/features/hr/domain/usecase/get_hr_overview.dart';
import 'package:fuoday/features/hr/presentation/provider/hr_overview_provider.dart';
import 'package:fuoday/features/leave_tracker/data/datasources/leave_regulation_remote_data_source.dart';
import 'package:fuoday/features/leave_tracker/data/datasources/leave_remote_data_source.dart';
import 'package:fuoday/features/leave_tracker/data/datasources/leave_tracker_chart_remote_data_source.dart';
import 'package:fuoday/features/leave_tracker/data/repository/leave_regulation_repository_impl.dart';
import 'package:fuoday/features/leave_tracker/data/repository/leave_repository_impl.dart';
import 'package:fuoday/features/leave_tracker/data/repository/leave_tracker_chart_repository_impl.dart';
import 'package:fuoday/features/leave_tracker/domain/repository/leave_regulation_repository.dart';
import 'package:fuoday/features/leave_tracker/domain/repository/leave_repository.dart';
import 'package:fuoday/features/leave_tracker/domain/repository/leave_tracker_chart_repository.dart';
import 'package:fuoday/features/leave_tracker/domain/usecase/get_leave_summary_usecase.dart';
import 'package:fuoday/features/leave_tracker/domain/usecase/get_leave_tracker_chart_usecase.dart';
import 'package:fuoday/features/leave_tracker/domain/usecase/submit_leave_regulation_usecase.dart';
import 'package:fuoday/features/leave_tracker/presentation/providers/leave_regulation_provider.dart';
import 'package:fuoday/features/management/data/datasources/emp_audit_form_datasource.dart';
import 'package:fuoday/features/management/data/repository/emp_audit_form_repository_impl.dart';
import 'package:fuoday/features/management/domain/repository/emp_audit_form_repository.dart';
import 'package:fuoday/features/management/domain/usecase/get_employees_by_managers_usecase.dart';
import 'package:fuoday/features/management/presentation/provider/emp_audit_form_provider.dart';
import 'package:fuoday/features/manager/data/datasources/all_regulations_remote_data_source.dart';
import 'package:fuoday/features/manager/data/datasources/update_leave_status_remote_data_source.dart';
import 'package:fuoday/features/manager/data/datasources/update_regulation_status_remote_data_source.dart';
import 'package:fuoday/features/manager/data/repository/all_regulations_repository_impl.dart';
import 'package:fuoday/features/manager/data/repository/update_leave_status_repository_imp.dart';
import 'package:fuoday/features/manager/data/repository/update_regulation_status_repository_impl.dart';
import 'package:fuoday/features/manager/domain/repository/all_regulations_repository.dart';
import 'package:fuoday/features/manager/domain/repository/update_leave_status_repository.dart';
import 'package:fuoday/features/manager/domain/repository/update_regulation_status_repository.dart';
import 'package:fuoday/features/manager/domain/usecase/get_all_regulations_usecase.dart';
import 'package:fuoday/features/manager/domain/usecase/update_leave_status_usecase.dart';
import 'package:fuoday/features/manager/domain/usecase/update_regulation_status_usecase.dart';
import 'package:fuoday/features/manager/presentation/provider/all_regulations_provider.dart';
import 'package:fuoday/features/manager/presentation/provider/update_leave_status_provider.dart';
import 'package:fuoday/features/manager/presentation/provider/update_regulation_status_provider.dart';
import 'package:fuoday/features/organizations/data/datasources/remote/departmentListRemoteDataSource.dart';
import 'package:fuoday/features/organizations/data/datasources/remote/organization_about_datasource.dart';
import 'package:fuoday/features/organizations/data/datasources/remote/ser_ind_datasource.dart';
import 'package:fuoday/features/organizations/data/repositories/DepartmentListRepositoryImpl.dart';
import 'package:fuoday/features/organizations/data/repositories/organization_about_repository_impl.dart';
import 'package:fuoday/features/organizations/data/repositories/ser_ind_repo_impl.dart';
import 'package:fuoday/features/organizations/domain/repositories/DepartmentListRepository.dart';
import 'package:fuoday/features/organizations/domain/repositories/organization_about_repository.dart';
import 'package:fuoday/features/organizations/domain/repositories/ser_ind_repository.dart';
import 'package:fuoday/features/organizations/domain/usecase/GetDepartmentListUseCase.dart';
import 'package:fuoday/features/organizations/domain/usecase/get_about_organization_usecase.dart';
import 'package:fuoday/features/organizations/domain/usecase/ser_ind_usecase.dart';
import 'package:fuoday/features/organizations/presentation/providers/organization_about_provider.dart';
import 'package:fuoday/features/payslip/data/datasource/payroll_remote_data_source.dart';
import 'package:fuoday/features/payslip/data/repositories/payroll_overview_repository_impl.dart';
import 'package:fuoday/features/payslip/data/repositories/payroll_repository_impl.dart';
import 'package:fuoday/features/payslip/domain/repositories/payroll_overview_repository.dart';
import 'package:fuoday/features/payslip/domain/repositories/payroll_repository.dart';
import 'package:fuoday/features/payslip/domain/usecase/get_payroll_overview_usecase.dart';
import 'package:fuoday/features/payslip/domain/usecase/get_payroll_usecase.dart';
import 'package:fuoday/features/payslip/presentation/Provider/payroll_overview_provider.dart';
import 'package:fuoday/features/payslip/presentation/Provider/payroll_provider.dart';
import 'package:fuoday/features/performance/data/datasources/remote/audit_report_remote_datasource.dart';
import 'package:fuoday/features/performance/data/datasources/remote/audit_reporting_team_remote_datasource.dart';
import 'package:fuoday/features/performance/data/datasources/remote/employee_audit_form_remote_data_source.dart';
import 'package:fuoday/features/performance/data/datasources/remote/employee_audit_remote_data_source.dart';
import 'package:fuoday/features/performance/data/datasources/remote/performance_summary_remote_data_source.dart';
import 'package:fuoday/features/performance/data/repository/audit_report_repository_impl.dart';
import 'package:fuoday/features/performance/data/repository/audit_reporting_team_repository_impl.dart';
import 'package:fuoday/features/performance/data/repository/employee_audit_form_repository_impl.dart';
import 'package:fuoday/features/performance/data/repository/employee_audit_repository_impl.dart';
import 'package:fuoday/features/performance/data/repository/performance_summary_repository_impl.dart';
import 'package:fuoday/features/performance/domain/repository/audit_report_repository.dart';
import 'package:fuoday/features/performance/domain/repository/audit_reporting_team_repository.dart';
import 'package:fuoday/features/performance/domain/repository/employee_audit_form_repository.dart';
import 'package:fuoday/features/performance/domain/repository/employee_audit_repository.dart';
import 'package:fuoday/features/performance/domain/repository/performance_summary_repository.dart';
import 'package:fuoday/features/performance/domain/usecases/get_audit_report_usecase.dart';
import 'package:fuoday/features/performance/domain/usecases/get_audit_reporting_team_usecase.dart';
import 'package:fuoday/features/performance/domain/usecases/get_employee_audit_use_case.dart';
import 'package:fuoday/features/performance/domain/usecases/get_performance_summary_use_case.dart';
import 'package:fuoday/features/performance/domain/usecases/post_employee_audit_form_use_case.dart';
import 'package:fuoday/features/performance/presentation/providers/audit_report_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/audit_reporting_team_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/employee_audit_form_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/employee_audit_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/performance_summary_provider.dart';
import 'package:fuoday/features/profile/data/datasources/Employee_OnboardRemote_DataSource.dart';
import 'package:fuoday/features/profile/data/datasources/employee_educational_remote_data_source.dart';
import 'package:fuoday/features/profile/data/datasources/employee_profile_remote_datasource.dart';
import 'package:fuoday/features/profile/data/datasources/profile_experience_remote_data_source.dart';
import 'package:fuoday/features/profile/data/datasources/update_profile_remote_datasource.dart';
import 'package:fuoday/features/profile/data/repositories/Employee_Onboard_RepositoryImpl.dart';
import 'package:fuoday/features/profile/data/repositories/employee_educational_repository_impl.dart';
import 'package:fuoday/features/profile/data/repositories/employee_profile_repository_impl.dart';
import 'package:fuoday/features/profile/data/repositories/profile_experience_repository_impl.dart';
import 'package:fuoday/features/profile/data/repositories/update_profile_repository_impl.dart';
import 'package:fuoday/features/profile/domain/repository/Employee_Onboard_Repository.dart';
import 'package:fuoday/features/profile/domain/repository/employee_educational_repository.dart';
import 'package:fuoday/features/profile/domain/repository/employee_profile_repository.dart';
import 'package:fuoday/features/profile/domain/repository/profile_experience_repository.dart';
import 'package:fuoday/features/profile/domain/repository/update_profile_repository.dart';
import 'package:fuoday/features/profile/domain/usecases/Onboard_Employee_UseCase.dart';
import 'package:fuoday/features/profile/domain/usecases/employee_education_usecase.dart';
import 'package:fuoday/features/profile/domain/usecases/get_employee_profile_usecase.dart';
import 'package:fuoday/features/profile/domain/usecases/profile_update_experience_usecase.dart';
import 'package:fuoday/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:fuoday/features/profile/presentation/providers/profile_edit_provider.dart';
import 'package:fuoday/features/support/data/datasource/get_ticket_details_datasource.dart';
import 'package:fuoday/features/support/data/datasource/ticket_remote_datasource.dart';
import 'package:fuoday/features/support/data/repositories/get_ticket_details_repository_impl.dart';
import 'package:fuoday/features/support/data/repositories/ticket_repository_impl.dart';
import 'package:fuoday/features/support/domain/repository/get_ticket_details_repository.dart';
import 'package:fuoday/features/support/domain/repository/ticket_repository.dart';
import 'package:fuoday/features/support/domain/usecase/create_ticket_usecase.dart';
import 'package:fuoday/features/support/domain/usecase/get_ticket_details_usecase.dart';
import 'package:fuoday/features/support/persentation/provider/get_ticket_details_provider.dart';
import 'package:fuoday/features/team_leader/data/datasource/AllRoleLateArrivalsReportRemoteDataSource.dart';
import 'package:fuoday/features/team_leader/data/datasource/all_leave_requests_remote_data_source.dart';
import 'package:fuoday/features/team_leader/data/datasource/all_role_total_attendance_report_remote_datasource.dart';
import 'package:fuoday/features/team_leader/data/datasource/role_based_users_remote_datasource.dart';
import 'package:fuoday/features/team_leader/data/repositories/all_leave_requests_repository_impl.dart';
import 'package:fuoday/features/team_leader/data/repositories/all_role_total_attendance_report_repository_impl.dart';
import 'package:fuoday/features/team_leader/data/repositories/late_arrivals_repository_impl.dart';
import 'package:fuoday/features/team_leader/data/repositories/role_based_users_repository_impl.dart';
import 'package:fuoday/features/team_leader/domain/repository/all_leave_requests_repository.dart';
import 'package:fuoday/features/team_leader/domain/repository/all_role_total_attendance_report_repository.dart';
import 'package:fuoday/features/team_leader/domain/repository/late_arrivals_repository.dart';
import 'package:fuoday/features/team_leader/domain/repository/role_based_users_repository.dart';
import 'package:fuoday/features/team_leader/domain/usecases/get_all_leave_requests_by_status_usecase.dart';
import 'package:fuoday/features/team_leader/domain/usecases/get_all_role_total_attendance_report_usecase.dart';
import 'package:fuoday/features/team_leader/domain/usecases/get_late_arrivals_usecase.dart';
import 'package:fuoday/features/team_leader/domain/usecases/get_role_based_users_usecase.dart';
import 'package:fuoday/features/team_leader/presentation/provider/all_leave_requests_provider.dart';
import 'package:fuoday/features/team_leader/presentation/provider/all_role_total_attendance_report_provider.dart';
import 'package:fuoday/features/team_leader/presentation/provider/late_arrivals_provider.dart';
import 'package:fuoday/features/team_leader/presentation/provider/role_based_users_provider.dart';
import 'package:fuoday/features/team_leader/presentation/widget/total_employee_pdf_generater.dart';
import 'package:fuoday/features/team_tree/data/datasource/team_tree_remote_data_source.dart';
import 'package:fuoday/features/team_tree/data/repositories/team_tree_repository_impl.dart';
import 'package:fuoday/features/team_tree/domain/repository/team_tree_repository.dart';
import 'package:fuoday/features/team_tree/domain/usecase/get_team_tree_usecase.dart';
import 'package:fuoday/features/team_tree/presentation/provider/team_tree_provider.dart';
import 'package:fuoday/features/teams/data/datasources/local/team_member_local_data_source.dart';
import 'package:fuoday/features/teams/data/datasources/local/team_projects_local_data_source.dart';
import 'package:fuoday/features/teams/data/datasources/local/team_reportees_local_data_source.dart';
import 'package:fuoday/features/teams/data/datasources/remote/team_member_remote_data_source.dart';
import 'package:fuoday/features/teams/data/datasources/remote/team_project_remote_data_source.dart';
import 'package:fuoday/features/teams/data/datasources/remote/team_reportees_remote_data_source.dart';
import 'package:fuoday/features/teams/data/repository/team_member_repository_impl.dart';
import 'package:fuoday/features/teams/data/repository/team_project_repository_impl.dart';
import 'package:fuoday/features/teams/data/repository/team_reportees_repository_impl.dart';
import 'package:fuoday/features/teams/domain/repository/team_member_respository.dart';
import 'package:fuoday/features/teams/domain/repository/team_project_repostiory.dart';
import 'package:fuoday/features/teams/domain/repository/team_reportees_repository.dart';
import 'package:fuoday/features/teams/domain/usecases/get_team_member_usecase.dart';
import 'package:fuoday/features/teams/domain/usecases/get_team_project_usecase.dart';
import 'package:fuoday/features/teams/domain/usecases/get_team_reportees_usecase.dart';
import 'package:fuoday/features/teams/presentation/providers/team_members_provider.dart';
import 'package:fuoday/features/teams/presentation/providers/team_project_provider.dart';
import 'package:fuoday/features/teams/presentation/providers/team_reportees_provider.dart';
import 'package:fuoday/features/time_tracker/data/datasources/remote/tracker_remote_datasource.dart';
import 'package:fuoday/features/time_tracker/data/repository/time_tracker_repository_impl.dart';
import 'package:fuoday/features/time_tracker/domain/repositiory/time_tracker_repository.dart';
import 'package:fuoday/features/time_tracker/domain/usecase/get_time_and_project_tracker_UseCase.dart';
import 'package:fuoday/features/time_tracker/presentation/provider/time_tracker_provider.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/data/datasources/remote/emp_department_remote_datasource.dart';
import '../../features/home/data/repositories/employee_department_repository_impl.dart';
import '../../features/home/domain/repositories/emp_department_repository.dart';
import '../../features/home/domain/usecases/emp_department_usecase.dart';
import '../../features/home/presentation/provider/employee_department_provider.dart';

// Get It
final getIt = GetIt.instance;

void setUpServiceLocator() {
  // Commons
  getIt.registerFactory<CheckboxProvider>(() => CheckboxProvider());
  getIt.registerFactory<DropdownProvider>(() => DropdownProvider());

  // Core Services
  getIt.registerSingleton<HiveStorageService>(HiveStorageService());

  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );
  getIt.registerLazySingleton<DioService>(() => DioService());

  getIt.registerLazySingleton<AppFilePicker>(() => AppFilePicker());

  // App Utility Providers
  getIt.registerFactory<AppFilePickerProvider>(() => AppFilePickerProvider());
  getIt.registerFactory<AppFileDownloaderProvider>(
    () => AppFileDownloaderProvider(),
  );

  // Internet checker provider
  getIt.registerLazySingleton<AppInternetCheckerProvider>(
    () => AppInternetCheckerProvider(),
  );

  // UI State Providers
  getIt.registerFactory<SlidingSegmentedProvider>(
    () => SlidingSegmentedProvider(),
  );
  getIt.registerFactory<BottomNavProvider>(() => BottomNavProvider());

  getIt.registerFactory<RecruiterBottomNavProvider>(
    () => RecruiterBottomNavProvider(),
  );

  // Data Source
  getIt.registerLazySingleton<EmployeeAuthRemoteDataSource>(
    () => EmployeeAuthRemoteDataSource(dioService: getIt<DioService>()),
  );

  getIt.registerLazySingleton(() => HomeFeedsProjectRemoteDataSource(getIt()));

  // Add Check-In Data Source
  getIt.registerLazySingleton<CheckInRemoteDataSource>(
    () => CheckInRemoteDataSource(dioService: getIt<DioService>()),
  );

  getIt.registerLazySingleton<Dio>(() => getIt<DioService>().client);

  //profile personal data
  getIt.registerLazySingleton<EmployeeProfileRemoteDataSource>(
    () => EmployeeProfileRemoteDataSource(dio: getIt()),
  );

  //employee background educational
  getIt.registerLazySingleton(() => ProfileRemoteDataSource(getIt()));

  //leave tracker
  getIt.registerLazySingleton<LeaveRemoteDataSource>(
    () => LeaveRemoteDataSource(getIt<Dio>()),
  );

  // 🔹 Data Source
  getIt.registerLazySingleton<ExperienceRemoteDataSource>(
    () => ExperienceRemoteDataSourceImpl(getIt()),
  );

  // 🔹 Repository Implementation
  getIt.registerLazySingleton<ExperienceRepository>(
    () => ExperienceRepositoryImpl(getIt()),
  );

  // 🔹 Use Case
  getIt.registerLazySingleton<UpdateExperienceUseCase>(
    () => UpdateExperienceUseCase(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<EmployeeAuthRepositoryImpl>(
    () => EmployeeAuthRepositoryImpl(
      employeeAuthRemoteDataSource: getIt<EmployeeAuthRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<EmployeeOnboardRemoteDataSource>(
    () => EmployeeOnboardRemoteDataSource(getIt<DioService>()),
  );

  getIt.registerLazySingleton<EmployeeOnboardRepository>(
    () =>
        EmployeeOnboardRepositoryImpl(getIt<EmployeeOnboardRemoteDataSource>()),
  );

  getIt.registerLazySingleton<OnboardEmployeeUseCase>(
    () => OnboardEmployeeUseCase(getIt<EmployeeOnboardRepository>()),
  );

  getIt.registerLazySingleton(() => LeaveTrackerChartRemoteDataSource(getIt()));

  getIt.registerLazySingleton<LeaveTrackerChartRepository>(
    () => LeaveTrackerChartRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => GetLeaveTrackerChartUseCase(getIt()));

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt()),
  );

  // Add Check-In Repository
  getIt.registerLazySingleton<CheckInRepository>(
    () => CheckInRepositoryImpl(
      remoteDataSource: getIt<CheckInRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<HomeAddTaskRepository>(
    () => HomeAddTaskRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => HomeAddTaskUseCase(getIt()));

  getIt.registerLazySingleton<LeaveRepository>(
    () => LeaveRepositoryImpl(getIt<LeaveRemoteDataSource>()),
  );

  //profile personal data
  getIt.registerLazySingleton<EmployeeProfileRepository>(
    () => EmployeeProfileRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton<EmployeeAuthLoginUseCase>(
    () => EmployeeAuthLoginUseCase(
      employeeAuthRepository: getIt<EmployeeAuthRepositoryImpl>(),
    ),
  );

  getIt.registerLazySingleton(() => GetHomeFeedsProjectDataUseCase(getIt()));

  getIt.registerLazySingleton(() => GetEducationUseCase(getIt()));

  getIt.registerLazySingleton(() => GetSkillsUseCase(getIt()));

  getIt.registerLazySingleton<GetLeaveSummaryUseCase>(
    () => GetLeaveSummaryUseCase(getIt<LeaveRepository>()),
  );

  getIt.registerLazySingleton<EmployeeAuthLogOutUseCase>(
    () => EmployeeAuthLogOutUseCase(
      employeeAuthRepository: getIt<EmployeeAuthRepositoryImpl>(),
    ),
  );

  // Add Check-In Use Cases
  getIt.registerLazySingleton<CheckInUseCase>(
    () => CheckInUseCase(checkInRepository: getIt<CheckInRepository>()),
  );

  getIt.registerLazySingleton<CheckOutUseCase>(
    () => CheckOutUseCase(repository: getIt<CheckInRepository>()),
  );

  //personal data
  getIt.registerLazySingleton<GetEmployeeProfileUseCase>(
    () => GetEmployeeProfileUseCase(repository: getIt()),
  );

  // Providers
  getIt.registerFactory<EmployeeAuthLoginProvider>(
    () => EmployeeAuthLoginProvider(
      employeeAuthLoginUseCase: getIt<EmployeeAuthLoginUseCase>(),
    ),
  );

  getIt.registerFactory<EmployeeAuthLogoutProvider>(
    () => EmployeeAuthLogoutProvider(
      employeeAuthLogOutUseCase: getIt<EmployeeAuthLogOutUseCase>(),
    ),
  );

  // Update Check-In Provider with required dependencies
  getIt.registerFactory<CheckInProvider>(
    () => CheckInProvider(
      checkInUseCase: getIt<CheckInUseCase>(),
      checkOutUseCase: getIt<CheckOutUseCase>(),
    ),
  );

  // ✅ Register Remote Data Source
  getIt.registerLazySingleton(
    () => EventsRemoteDataSource(
      dioService: getIt<DioService>(),
      hiveStorageService: getIt<HiveStorageService>(),
      secureStorageService: getIt<SecureStorageService>(),
    ),
  );

  // Add Task dataSources
  getIt.registerLazySingleton<HomeAddTaskRemoteDataSource>(
    () => HomeAddTaskRemoteDataSourceImpl(getIt()),
  );

  // ✅ Register Repository
  getIt.registerLazySingleton<EventsRepository>(
    () => GetAllEventsRemoteRepositoryImpl(
      eventsRemoteDataSource: getIt<EventsRemoteDataSource>(),
    ),
  );

  // ✅ Register Use Cases
  getIt.registerLazySingleton<GetAnnouncementUseCase>(
    () => GetAnnouncementUseCase(eventsRepository: getIt<EventsRepository>()),
  );

  getIt.registerLazySingleton<GetCelebrationsUseCase>(
    () => GetCelebrationsUseCase(eventsRepository: getIt<EventsRepository>()),
  );

  getIt.registerLazySingleton<GetOrganizationalProgramUseCase>(
    () => GetOrganizationalProgramUseCase(
      eventsRepository: getIt<EventsRepository>(),
    ),
  );

  // ✅ Register Provider
  getIt.registerFactory<AllEventsProvider>(
    () => AllEventsProvider(
      getAnnouncementUseCase: getIt<GetAnnouncementUseCase>(),
      getCelebrationsUseCase: getIt<GetCelebrationsUseCase>(),
      getOrganizationalProgramUseCase: getIt<GetOrganizationalProgramUseCase>(),
    ),
  );

  // Home Feeds Project Data Repository
  getIt.registerLazySingleton<HomeFeedsProjectDataRepository>(
    () => HomeFeedsProjectDataRepositoryImpl(getIt()),
  );

  // Fetch Employee Use Case
  getIt.registerLazySingleton(() => FetchEmployeesUseCase(getIt()));

  // 📡 DATA SOURCE
  getIt.registerLazySingleton<ShiftScheduleRemoteDataSource>(
    () => ShiftScheduleRemoteDataSource(dioService: getIt<DioService>()),
  );

  // 🗄️ REPOSITORY
  getIt.registerLazySingleton<ShiftScheduleRepository>(
    () => ShiftScheduleRepositoryImpl(
      shiftScheduleRemoteDataSource: getIt<ShiftScheduleRemoteDataSource>(),
    ),
  );

  // ✅ USE CASE
  getIt.registerLazySingleton<GetMonthlyShiftUseCase>(
    () => GetMonthlyShiftUseCase(
      shiftScheduleRepository: getIt<ShiftScheduleRepository>(),
    ),
  );

  // 📦 PROVIDER
  getIt.registerFactory<ShiftScheduleProvider>(
    () => ShiftScheduleProvider(
      getMonthlyShiftUseCase: getIt<GetMonthlyShiftUseCase>(),
    ),
  );

  // Team Member Data Source
  getIt.registerLazySingleton<TeamMemberRemoteDataSource>(
    () => TeamMemberRemoteDataSource(dioService: getIt<DioService>()),
  );
  getIt.registerLazySingleton<TeamMemberLocalDataSource>(
    () => TeamMemberLocalDataSource(
      hiveStorageService: getIt<HiveStorageService>(),
    ),
  );

  // Team Member Repository Impl
  getIt.registerLazySingleton<TeamMemberRepository>(
    () => TeamMemberRepositoryImpl(
      remoteDataSource: getIt<TeamMemberRemoteDataSource>(),
      localDataSource: getIt<TeamMemberLocalDataSource>(),
      appInternetCheckerProvider: getIt<AppInternetCheckerProvider>(),
    ),
  );

  // Team Member Get UseCase
  getIt.registerLazySingleton<GetTeamMemberUseCase>(
    () => GetTeamMemberUseCase(
      teamMemberRepository: getIt<TeamMemberRepository>(),
    ),
  );

  // Provider
  getIt.registerFactory<TeamMembersProvider>(
    () => TeamMembersProvider(
      getTeamMemberUseCase: getIt<GetTeamMemberUseCase>(),
    ),
  );

  // Team Projects Data Source
  getIt.registerLazySingleton<TeamProjectRemoteDataSource>(
    () => TeamProjectRemoteDataSource(dioService: getIt<DioService>()),
  );
  getIt.registerLazySingleton<TeamProjectLocalDataSource>(
    () => TeamProjectLocalDataSource(
      hiveStorageService: getIt<HiveStorageService>(),
    ),
  );

  // Team Projects Repository Impl
  getIt.registerLazySingleton<TeamProjectRepository>(
    () => TeamProjectRepositoryImpl(
      remoteDataSource: getIt<TeamProjectRemoteDataSource>(),
      localDataSource: getIt<TeamProjectLocalDataSource>(),
      appInternetCheckerProvider: getIt<AppInternetCheckerProvider>(),
    ),
  );

  // Team Projects UseCase
  getIt.registerLazySingleton<GetTeamProjectsUseCase>(
    () => GetTeamProjectsUseCase(
      teamProjectRepository: getIt<TeamProjectRepository>(),
    ),
  );

  // Team Project Provider
  getIt.registerFactory<TeamProjectProvider>(
    () => TeamProjectProvider(
      getTeamProjectsUseCase: getIt<GetTeamProjectsUseCase>(),
    ),
  );

  // Team Reportees Data Source
  getIt.registerLazySingleton<TeamReporteesRemoteDataSource>(
    () => TeamReporteesRemoteDataSource(dioService: getIt<DioService>()),
  );
  getIt.registerLazySingleton<TeamReporteesLocalDataSource>(
    () => TeamReporteesLocalDataSource(
      hiveStorageService: getIt<HiveStorageService>(),
    ),
  );

  // Team Reportees Repository Impl
  getIt.registerLazySingleton<TeamReporteesRepository>(
    () => TeamReporteesRepositoryImpl(
      appInternetCheckerProvider: getIt<AppInternetCheckerProvider>(),
      localDataSource: getIt<TeamReporteesLocalDataSource>(),
      remoteDataSource: getIt<TeamReporteesRemoteDataSource>(),
    ),
  );

  // Team UseCase
  getIt.registerLazySingleton<GetTeamReporteesUseCase>(
    () => GetTeamReporteesUseCase(repository: getIt<TeamReporteesRepository>()),
  );

  // Team Reportees Provider
  getIt.registerFactory<TeamReporteesProvider>(
    () => TeamReporteesProvider(
      getTeamReporteesUseCase: getIt<GetTeamReporteesUseCase>(),
    ),
  );

  // Update Profile
  getIt.registerLazySingleton(
    () => UpdateProfileRemoteDataSource(dioService: getIt<DioService>()),
  );

  // Update Profile Provider
  getIt.registerFactory(
    () => ProfileEditProvider(
      updateProfileData: UpdateProfileUseCase(repository: getIt()),
    ),
  );

  // Update Profile Repository
  getIt.registerLazySingleton<UpdateProfileRepository>(
    () => UpdateProfileRepositoryImpl(remoteDataSource: getIt()),
  );

  //Time Tracker
  getIt.registerLazySingleton<TrackerRemoteDataSource>(
    () => TrackerRemoteDataSource(dio: getIt<DioService>()),
  );

  getIt.registerLazySingleton<TimeTrackerRepository>(
    () => TimeTrackerRepositoryImpl(remote: getIt()),
  );

  getIt.registerLazySingleton<GetTimeAndProjectTrackerUseCase>(
    () => GetTimeAndProjectTrackerUseCase(getIt()),
  );

  getIt.registerFactory<TimeTrackerProvider>(
    () => TimeTrackerProvider(usecase: getIt()),
  );

  // Total Attendance Details
  getIt.registerLazySingleton<TotalAttendanceDetailsRemoteDataSource>(
    () =>
        TotalAttendanceDetailsRemoteDataSource(dioService: getIt<DioService>()),
  );
  getIt.registerLazySingleton<TotalAttendanceDetailsLocalDataSource>(
    () => TotalAttendanceDetailsLocalDataSource(
      hiveStorageService: getIt<HiveStorageService>(),
    ),
  );

  getIt.registerLazySingleton<TotalAttendanceDetailsRepository>(
    () => TotalAttendanceDetailsRepositoryImpl(
      appInternetCheckerProvider: getIt<AppInternetCheckerProvider>(),
      totalAttendanceDetailsLocalDataSource:
          getIt<TotalAttendanceDetailsLocalDataSource>(),
      totalAttendanceDetailsRemoteDataSource:
          getIt<TotalAttendanceDetailsRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetTotalAttendanceDetailsUseCase>(
    () => GetTotalAttendanceDetailsUseCase(
      totalAttendanceDetailsRepository:
          getIt<TotalAttendanceDetailsRepository>(),
    ),
  );

  getIt.registerFactory<TotalAttendanceDetailsProvider>(
    () => TotalAttendanceDetailsProvider(
      getTotalAttendanceDetailsUseCase:
          getIt<GetTotalAttendanceDetailsUseCase>(),
    ),
  );

  // pdf generator service
  getIt.registerLazySingleton(() => PdfGeneratorService());
  //Total Emp pdf generator service
  getIt.registerLazySingleton(() => TotalEmpPdfGeneratorService());
  //Total Emp pdf generator service
  getIt.registerLazySingleton(() => PdfGeneratorServiceReusableWidget());

  // excel generator service
  getIt.registerLazySingleton(() => ExcelGeneratorService());

  //Organization About screen

  // Datasource
  getIt.registerLazySingleton<OrganizationAboutDatasource>(
    () => OrganizationAboutRemoteDatasource(getIt<DioService>()),
  );

  // Repository
  getIt.registerLazySingleton<OrganizationAboutRepository>(
    () => OrganizationAboutRepositoryImpl(getIt<OrganizationAboutDatasource>()),
  );

  // UseCase
  getIt.registerLazySingleton<GetAboutOrganizationUseCase>(
    () => GetAboutOrganizationUseCase(getIt<OrganizationAboutRepository>()),
  );

  getIt.registerFactory(
    () => OrganizationAboutProvider(getIt<GetAboutOrganizationUseCase>()),
  );

  //SerAndInd
  getIt.registerLazySingleton<ServicesAndIndustriesDatasource>(
    () => ServicesAndIndustriesRemoteDatasource(getIt<DioService>()),
  );

  getIt.registerLazySingleton<ServicesAndIndustriesRepository>(
    () => ServicesAndIndustriesRepositoryImpl(
      getIt<ServicesAndIndustriesDatasource>(),
    ),
  );

  getIt.registerLazySingleton<GetServicesAndIndustriesUseCase>(
    () => GetServicesAndIndustriesUseCase(
      getIt<ServicesAndIndustriesRepository>(),
    ),
  );

  //Organization Dept
  getIt.registerLazySingleton<DepartmentListRemoteDataSource>(
    () => DepartmentListRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<DepartmentListRepository>(
    () => DepartmentListRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<GetDepartmentListUseCase>(
    () => GetDepartmentListUseCase(getIt()),
  );

  // Total Late Arrivals Details
  getIt.registerLazySingleton<TotalLateArrivalsDetailsRemoteDataSource>(
    () => TotalLateArrivalsDetailsRemoteDataSource(
      dioService: getIt<DioService>(),
    ),
  );
  getIt.registerLazySingleton<TotalLateArrivalsDetailsLocalDataSource>(
    () => TotalLateArrivalsDetailsLocalDataSource(
      hiveStorageService: getIt<HiveStorageService>(),
    ),
  );

  getIt.registerLazySingleton<TotalLateArrivalsDetailsRepository>(
    () => TotalLateArrivalsDetailsRepositoryImpl(
      appInternetCheckerProvider: getIt<AppInternetCheckerProvider>(),
      totalLateArrivalsDetailsLocalDataSource:
          getIt<TotalLateArrivalsDetailsLocalDataSource>(),
      totalLateArrivalsDetailsRemoteDataSource:
          getIt<TotalLateArrivalsDetailsRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetTotalLateArrivalsDetailsUseCase>(
    () => GetTotalLateArrivalsDetailsUseCase(
      totalLateArrivalsDetailsRepository:
          getIt<TotalLateArrivalsDetailsRepository>(),
    ),
  );

  getIt.registerFactory(
    () => TotalLateArrivalsDetailsProvider(
      getTotalLateArrivalsDetailsUseCase:
          getIt<GetTotalLateArrivalsDetailsUseCase>(),
    ),
  );

  // Total Early Arrivals Details
  getIt.registerLazySingleton<TotalEarlyArrivalsDetailsRemoteDataSource>(
    () => TotalEarlyArrivalsDetailsRemoteDataSource(
      dioService: getIt<DioService>(),
    ),
  );
  getIt.registerLazySingleton<TotalEarlyArrivalsDetailsLocalDataSource>(
    () => TotalEarlyArrivalsDetailsLocalDataSource(
      hiveStorageService: getIt<HiveStorageService>(),
    ),
  );

  getIt.registerLazySingleton<TotalEarlyArrivalsDetailsRepository>(
    () => TotalEarlyArrivalsDetailsRepositoryImpl(
      appInternetCheckerProvider: getIt<AppInternetCheckerProvider>(),
      totalEarlyArrivalsDetailsLocalDataSource:
          getIt<TotalEarlyArrivalsDetailsLocalDataSource>(),
      totalEarlyArrivalsDetailsRemoteDataSource:
          getIt<TotalEarlyArrivalsDetailsRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetTotalEarlyArrivalsUseCase>(
    () => GetTotalEarlyArrivalsUseCase(
      totalEarlyArrivalsDetailsRepository:
          getIt<TotalEarlyArrivalsDetailsRepository>(),
    ),
  );

  getIt.registerFactory<TotalEarlyArrivalsDetailsProvider>(
    () => TotalEarlyArrivalsDetailsProvider(
      getTotalEarlyArrivalsUseCase: getIt<GetTotalEarlyArrivalsUseCase>(),
    ),
  );

  // Total Absent Days Details
  getIt.registerLazySingleton<TotalAbsentDetailsRemoteDataSource>(
    () => TotalAbsentDetailsRemoteDataSource(dioService: getIt<DioService>()),
  );
  getIt.registerLazySingleton<TotalAbsentDetailsLocalDataSource>(
    (() => TotalAbsentDetailsLocalDataSource(
      hiveStorageService: getIt<HiveStorageService>(),
    )),
  );

  getIt.registerLazySingleton<TotalAbsentDetailsRepository>(
    () => TotalAbsentDaysDetailsRepositoryImpl(
      appInternetCheckerProvider: getIt<AppInternetCheckerProvider>(),
      totalAbsentDetailsLocalDataSource:
          getIt<TotalAbsentDetailsLocalDataSource>(),
      totalAbsentDetailsRemoteDataSource:
          getIt<TotalAbsentDetailsRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetTotalAbsentDetailsUseCase>(
    () => GetTotalAbsentDetailsUseCase(
      totalAbsentDetailsRepository: getIt<TotalAbsentDetailsRepository>(),
    ),
  );

  getIt.registerFactory<TotalAbsentDaysDetailsProvider>(
    () => TotalAbsentDaysDetailsProvider(
      getTotalAbsentDetailsUseCase: getIt<GetTotalAbsentDetailsUseCase>(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(dioService: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton<GetTotalPunctualArrivalsDetailsUseCase>(
    () => GetTotalPunctualArrivalsDetailsUseCase(repository: getIt()),
  );

  // Providers
  getIt.registerFactory<TotalPunctualArrivalDetailsProvider>(
    () => TotalPunctualArrivalDetailsProvider(
      getTotalPunctualArrivalsDetailsUseCase: getIt(),
    ),
  );

  // getIt.registerFactory<TotalPunctualArrivalDetailsProvider>(
  //   () => TotalPunctualArrivalDetailsProvider(
  //     getTotalPunctualArrivalsDetailsUseCase:
  //         getIt<GetTotalPunctualArrivalsDetailsUseCase>(),
  //   ),
  // );

  //create ticket
  getIt.registerLazySingleton(
    () => TicketRemoteDataSource(getIt<DioService>()),
  );

  getIt.registerLazySingleton<TicketRepository>(
    () => TicketRepositoryImpl(getIt<TicketRemoteDataSource>()),
  );

  getIt.registerLazySingleton(
    () => CreateTicketUseCase(getIt<TicketRepository>()),
  );

  //get ticket details
  getIt.registerLazySingleton<GetTicketDetailsDataSource>(
    () => GetTicketDetailsDataSourceImpl(getIt<DioService>()),
  );

  getIt.registerLazySingleton<GetTicketDetailsRepository>(
    () => GetTicketDetailsRepositoryImpl(getIt<GetTicketDetailsDataSource>()),
  );

  getIt.registerLazySingleton(
    () => GetTicketDetailsUseCase(getIt<GetTicketDetailsRepository>()),
  );

  getIt.registerLazySingleton<GetTicketDetailsProvider>(
    () => GetTicketDetailsProvider(getIt<GetTicketDetailsUseCase>()),
  );

  // Performance Summary
  getIt.registerLazySingleton<PerformanceRemoteDataSource>(
    () => PerformanceRemoteDataSource(dioService: getIt<DioService>()),
  );

  getIt.registerLazySingleton<PerformanceSummaryRepository>(
    () => PerformanceSummaryRepositoryImpl(
      performanceRemoteDataSource: getIt<PerformanceRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetPerformanceSummaryUseCase>(
    () => GetPerformanceSummaryUseCase(
      performanceSummaryRepository: getIt<PerformanceSummaryRepository>(),
    ),
  );

  getIt.registerFactory<PerformanceSummaryProvider>(
    () => PerformanceSummaryProvider(
      getPerformanceSummaryUseCase: getIt<GetPerformanceSummaryUseCase>(),
    ),
  );

  // Employee Audit
  getIt.registerLazySingleton<EmployeeAuditRemoteDataSource>(
    () => EmployeeAuditRemoteDataSource(dioService: getIt<DioService>()),
  );

  getIt.registerLazySingleton<EmployeeAuditRepository>(
    () => EmployeeAuditRepositoryImpl(
      employeeAuditRemoteDataSource: getIt<EmployeeAuditRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetEmployeeAuditUseCase>(
    () => GetEmployeeAuditUseCase(
      employeeAuditRepository: getIt<EmployeeAuditRepository>(),
    ),
  );

  getIt.registerFactory<EmployeeAuditProvider>(
    () => EmployeeAuditProvider(
      getEmployeeAuditUseCase: getIt<GetEmployeeAuditUseCase>(),
    ),
  );

  // Employee Audit Form
  getIt.registerLazySingleton<EmployeeAuditFormRemoteDataSource>(
    () => EmployeeAuditFormRemoteDataSource(dioService: getIt<DioService>()),
  );

  getIt.registerLazySingleton<EmployeeAuditFormRepository>(
    () => EmployeeAuditFormRepositoryImpl(
      employeeAuditFormRemoteDataSource:
          getIt<EmployeeAuditFormRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<PostEmployeeAuditFormUseCase>(
    () => PostEmployeeAuditFormUseCase(
      employeeAuditFormRepository: getIt<EmployeeAuditFormRepository>(),
    ),
  );

  getIt.registerFactory<EmployeeAuditFormProvider>(
    () => EmployeeAuditFormProvider(
      postEmployeeAuditFormUseCase: getIt<PostEmployeeAuditFormUseCase>(),
    ),
  );

  // Payroll
  getIt.registerLazySingleton<PayrollRemoteDataSource>(
    () => PayrollRemoteDataSourceImpl(
      dio: getIt<DioService>(), // Using your existing DioService
      baseUrl: AppEnvironment.baseUrl, // From flavors config
    ),
  );

  getIt.registerLazySingleton<PayrollRepository>(
    () => PayrollRepositoryImpl(
      remoteDataSource: getIt<PayrollRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetPayrollUseCase>(
    () => GetPayrollUseCase(getIt<PayrollRepository>()),
  );

  getIt.registerFactory<PayrollProvider>(
    () => PayrollProvider(getPayrollUseCase: getIt<GetPayrollUseCase>()),
  );

  // Register Repository
  getIt.registerLazySingleton<PayrollOverviewRepository>(
    () => PayrollOverviewRepositoryImpl(getIt<DioService>()),
  );

  // Register Use Case
  getIt.registerLazySingleton(
    () => GetPayrollOverviewUseCase(getIt<PayrollOverviewRepository>()),
  );

  // Register Provider
  getIt.registerFactory(
    () => PayrollOverviewProvider(getPayrollOverviewUseCase: getIt()),
  );

  // hr screen

  // Data source
  getIt.registerLazySingleton<HROverviewRemoteDataSource>(
    () => HROverviewRemoteDataSourceImpl(dioService: getIt<DioService>()),
  );

  //  Repository
  getIt.registerLazySingleton<HROverviewRepository>(
    () => HROverviewRepositoryImpl(
      remoteDataSource: getIt<HROverviewRemoteDataSource>(),
    ),
  );

  //  Use case
  getIt.registerLazySingleton<GetHROverview>(
    () => GetHROverview(getIt<HROverviewRepository>()),
  );

  //  Provider
  getIt.registerFactory<HROverviewProvider>(
    () => HROverviewProvider(getHROverviewUseCase: getIt<GetHROverview>()),
  );

  // Data sources
  // In your DI setup
  getIt.registerLazySingleton<EmpAuditFormDataSource>(
    () => EmpAuditFormDataSourceImpl(
      dioService: getIt<DioService>(), // Uses your existing DioService
    ),
  );

  // Repositories
  getIt.registerLazySingleton<EmpAuditFormRepository>(
    () => EmpAuditFormRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetEmployeesByManagersUseCase(getIt()));

  // Providers
  getIt.registerFactory(() => EmpAuditFormProvider(getIt()));

  // leave regulation
  // Data source
  getIt.registerLazySingleton<LeaveRegulationRemoteDataSource>(
    () => LeaveRegulationRemoteDataSourceImpl(getIt<DioService>()),
  );

  // Repository
  getIt.registerLazySingleton<LeaveRegulationRepository>(
    () => LeaveRegulationRepositoryImpl(getIt()),
  );

  // Use case
  getIt.registerLazySingleton(() => SubmitLeaveRegulationUseCase(getIt()));
  getIt.registerFactory(() => LeaveRegulationProvider(getIt()));

  //get audit form emp list
  // Data Source
  getIt.registerLazySingleton<AuditReportingTeamRemoteDataSource>(
    () => AuditReportingTeamRemoteDataSourceImpl(getIt<DioService>()),
  );
  // Repository
  getIt.registerLazySingleton<AuditReportingTeamRepository>(
    () => AuditReportingTeamRepositoryImpl(getIt()),
  );

  // Usecase
  getIt.registerLazySingleton(() => GetAuditReportingTeamUseCase(getIt()));

  // Provider
  getIt.registerFactory(
    () => AuditReportingTeamProvider(
      getAuditReportingTeamUseCase: getIt<GetAuditReportingTeamUseCase>(),
    ),
  );

  // Data Source
  getIt.registerLazySingleton<CheckinStatusRemoteDataSource>(
    () => CheckinStatusRemoteDataSourceImpl(getIt<DioService>()),
  );

  // Repository
  getIt.registerLazySingleton<CheckinStatusRepository>(
    () => CheckinStatusRepositoryImpl(getIt()),
  );

  // Usecase
  getIt.registerLazySingleton(() => GetCheckinStatusUseCase(getIt()));

  // Provider
  getIt.registerFactory(
    () => CheckinStatusProvider(
      getCheckinStatusUseCase: getIt<GetCheckinStatusUseCase>(),
    ),
  );

  // Data Source
  getIt.registerLazySingleton<AuditReportRemoteDataSource>(
    () => AuditReportRemoteDataSourceImpl(getIt<DioService>()),
  );

  // Repository
  getIt.registerLazySingleton<AuditReportRepository>(
    () => AuditReportRepositoryImpl(getIt()),
  );

  // Usecase
  getIt.registerLazySingleton(() => GetAuditReportUseCase(getIt()));

  // Provider
  getIt.registerFactory(
    () => AuditReportProvider(
      getAuditReportUseCase: getIt<GetAuditReportUseCase>(),
    ),
  );

  // Data Source
  getIt.registerLazySingleton<TeamTreeRemoteDataSource>(
    () => TeamTreeRemoteDataSourceImpl(getIt<DioService>()),
  );

  // Repository
  getIt.registerLazySingleton<TeamTreeRepository>(
    () => TeamTreeRepositoryImpl(getIt()),
  );

  // Usecase
  getIt.registerLazySingleton(() => GetTeamTreeUseCase(getIt()));

  // Provider
  getIt.registerFactory(
    () => TeamTreeProvider(getTeamTreeUseCase: getIt<GetTeamTreeUseCase>()),
  );

  // Recognition wall
  // Data Source
  getIt.registerLazySingleton<RecognitionRemoteDataSource>(
    () => RecognitionRemoteDataSourceImpl(getIt<DioService>()),
  );

  // Repository
  getIt.registerLazySingleton<RecognitionRepository>(
    () => RecognitionRepositoryImpl(getIt()),
  );

  // Usecase
  getIt.registerLazySingleton(() => SaveRecognitionsUseCase(getIt()));

  // Provider
  getIt.registerFactory(
    () => RecognitionProvider(saveRecognitionsUseCase: getIt()),
  );

  // Data Source
  getIt.registerLazySingleton<BadgeRemoteDataSource>(
    () => BadgeRemoteDataSourceImpl(getIt<DioService>()),
  );

  // Repository
  getIt.registerLazySingleton<BadgeRepository>(
    () => BadgeRepositoryImpl(getIt()),
  );

  // Usecase
  getIt.registerLazySingleton(() => GetBadgesUseCase(getIt()));

  // Provider
  getIt.registerFactory(() => BadgeProvider(getBadgesUseCase: getIt()));

  //Date Time Provider
  getIt.registerFactory<DateTimeProvider>(() => DateTimeProvider());

  // Data Source
  getIt.registerLazySingleton<EmployeeDepartmentDataSource>(
    () => EmployeeDepartmentDataSourceImpl(dioService: getIt<DioService>()),
  );

  // Repository
  getIt.registerLazySingleton<EmployeeDepartmentRepository>(
    () => EmployeeDepartmentRepositoryImpl(
      dataSource: getIt<EmployeeDepartmentDataSource>(),
    ),
  );

  // Usecase
  getIt.registerLazySingleton(
    () => GetEmployeesByManagerUseCase(
      repository: getIt<EmployeeDepartmentRepository>(),
    ),
  );

  // Provider
  getIt.registerFactory(
    () => EmployeeDepartmentProvider(
      getEmployeesByManagerUseCase: getIt<GetEmployeesByManagerUseCase>(),
    ),
  );

  // Data Source
  getIt.registerLazySingleton<ForgotPasswordRemoteDataSource>(
    () => ForgotPasswordRemoteDataSource(dioService: getIt<DioService>()),
  );

  // Repository
  getIt.registerLazySingleton<ForgotPasswordRepository>(
    () => ForgotPasswordRepositoryImpl(
      remoteDataSource: getIt<ForgotPasswordRemoteDataSource>(),
    ),
  );

  // Use Case
  getIt.registerLazySingleton(
    () => SendOtpUseCase(repository: getIt<ForgotPasswordRepository>()),
  );

  // Provider (optional)
  getIt.registerFactory(
    () => ForgotPasswordProvider(sendOtpUseCase: getIt<SendOtpUseCase>()),
  );

  // Data Source
  getIt.registerLazySingleton<VerifyOtpRemoteDataSource>(
    () => VerifyOtpRemoteDataSource(dioService: getIt<DioService>()),
  );

  // Repository
  getIt.registerLazySingleton<VerifyOtpRepository>(
    () => VerifyOtpRepositoryImpl(
      remoteDataSource: getIt<VerifyOtpRemoteDataSource>(),
    ),
  );

  // Use Case
  getIt.registerLazySingleton(
    () => VerifyOtpUseCase(repository: getIt<VerifyOtpRepository>()),
  );

  // Provider
  getIt.registerFactory(
    () => VerifyOtpProvider(verifyOtpUseCase: getIt<VerifyOtpUseCase>()),
  );

  // 🔹 Data Source
  getIt.registerLazySingleton<ResetPasswordRemoteDataSource>(
    () => ResetPasswordRemoteDataSource(dioService: getIt<DioService>()),
  );

  // 🔹 Repository
  getIt.registerLazySingleton<ResetPasswordRepository>(
    () => ResetPasswordRepositoryImpl(
      remoteDataSource: getIt<ResetPasswordRemoteDataSource>(),
    ),
  );

  // 🔹 Use Case
  getIt.registerLazySingleton(
    () => ResetPasswordUseCase(repository: getIt<ResetPasswordRepository>()),
  );
  //Role Based User Screens like Hr,Tl,Manager
  // 🔹 Provider
  getIt.registerFactory(
    () => ResetPasswordProvider(
      resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
    ),
  );

  // 🔹 Data Source
  getIt.registerLazySingleton<RoleBasedUsersRemoteDataSource>(
    () => RoleBasedUsersRemoteDataSource(dioService: getIt<DioService>()),
  );

  // 🔹 Repository
  getIt.registerLazySingleton<RoleBasedUsersRepository>(
    () => RoleBasedUsersRepositoryImpl(
      remoteDataSource: getIt<RoleBasedUsersRemoteDataSource>(),
    ),
  );

  // 🔹 Use Case
  getIt.registerLazySingleton<GetRoleBasedUsersUseCase>(
    () =>
        GetRoleBasedUsersUseCase(repository: getIt<RoleBasedUsersRepository>()),
  );

  // 🔹 Provider
  getIt.registerFactory<RoleBasedUsersProvider>(
    () => RoleBasedUsersProvider(
      getRoleBasedUsersUseCase: getIt<GetRoleBasedUsersUseCase>(),
    ),
  );

  // 🧾 Attendance Report Screens like HR, TL, Manager

  // 🔹 Data Source
  getIt.registerLazySingleton<AllRoleTotalAttendanceReportRemoteDataSource>(
    () => AllRoleTotalAttendanceReportRemoteDataSource(
      dioService: getIt<DioService>(),
    ),
  );

  // 🔹 Repository
  getIt.registerLazySingleton<AllRoleTotalAttendanceReportRepository>(
    () => AllRoleTotalAttendanceReportRepositoryImpl(
      remoteDataSource: getIt<AllRoleTotalAttendanceReportRemoteDataSource>(),
    ),
  );

  // 🔹 Use Case
  getIt.registerLazySingleton<GetAllRoleTotalAttendanceReportUseCase>(
    () => GetAllRoleTotalAttendanceReportUseCase(
      repository: getIt<AllRoleTotalAttendanceReportRepository>(),
    ),
  );

  // 🔹 Provider
  getIt.registerFactory<AttendanceReportProvider>(
    () => AttendanceReportProvider(
      getAllRoleTotalAttendanceReportUseCase:
          getIt<GetAllRoleTotalAttendanceReportUseCase>(),
    ),
  );

  // 🔹 Late Arrival Data Source
  getIt.registerLazySingleton<LateArrivalsRemoteDataSource>(
    () => LateArrivalsRemoteDataSource(dioService: getIt<DioService>()),
  );

  // 🔹 Repository
  getIt.registerLazySingleton<LateArrivalsRepository>(
    () => LateArrivalsRepositoryImpl(
      remoteDataSource: getIt<LateArrivalsRemoteDataSource>(),
    ),
  );

  // 🔹 Use Case
  getIt.registerLazySingleton<GetLateArrivalsUseCase>(
    () => GetLateArrivalsUseCase(repository: getIt<LateArrivalsRepository>()),
  );

  // 🔹 Provider
  getIt.registerFactory<LateArrivalsProvider>(
    () => LateArrivalsProvider(
      getLateArrivalsUseCase: getIt<GetLateArrivalsUseCase>(),
    ),
  );

  // 🔹 Data Source
  getIt.registerLazySingleton<AllLeaveRequestsRemoteDataSource>(
    () => AllLeaveRequestsRemoteDataSource(dioService: getIt<DioService>()),
  );

  // 🔹 Repository
  getIt.registerLazySingleton<AllLeaveRequestsRepository>(
    () => AllLeaveRequestsRepositoryImpl(
      remoteDataSource: getIt<AllLeaveRequestsRemoteDataSource>(),
    ),
  );

  // 🔹 Use Case
  getIt.registerLazySingleton<GetAllLeaveRequestsByStatusUseCase>(
    () => GetAllLeaveRequestsByStatusUseCase(
      repository: getIt<AllLeaveRequestsRepository>(),
    ),
  );

  // 🔹 Provider
  getIt.registerFactory<AllLeaveRequestsProvider>(
    () => AllLeaveRequestsProvider(
      getAllLeaveRequestsByStatusUseCase:
          getIt<GetAllLeaveRequestsByStatusUseCase>(),
    ),
  );

  //Manager Leave Update data source
  // 🔹 Data Source
  getIt.registerLazySingleton<UpdateLeaveStatusRemoteDataSource>(
    () => UpdateLeaveStatusRemoteDataSource(dioService: getIt<DioService>()),
  );

  // 🔹 Repository
  getIt.registerLazySingleton<UpdateLeaveStatusRepository>(
    () => UpdateLeaveStatusRepositoryImpl(
      remoteDataSource: getIt<UpdateLeaveStatusRemoteDataSource>(),
    ),
  );

  // 🔹 Use Case
  getIt.registerLazySingleton<UpdateLeaveStatusUseCase>(
    () => UpdateLeaveStatusUseCase(
      repository: getIt<UpdateLeaveStatusRepository>(),
    ),
  );

  // 🔹 Provider
  getIt.registerFactory<UpdateLeaveStatusProvider>(
    () => UpdateLeaveStatusProvider(
      updateLeaveStatusUseCase: getIt<UpdateLeaveStatusUseCase>(),
    ),
  );

  //All Regulation Screen in Manger Hr,Tl
  // 🔹 Data Source
  getIt.registerLazySingleton<AllRegulationsRemoteDataSource>(
    () => AllRegulationsRemoteDataSource(dioService: getIt<DioService>()),
  );

  // 🔹 Repository
  getIt.registerLazySingleton<AllRegulationsRepository>(
    () => AllRegulationsRepositoryImpl(
      remoteDataSource: getIt<AllRegulationsRemoteDataSource>(),
    ),
  );

  // 🔹 Use Case
  getIt.registerLazySingleton<GetAllRegulationsUseCase>(
    () =>
        GetAllRegulationsUseCase(repository: getIt<AllRegulationsRepository>()),
  );

  // 🔹 Provider
  getIt.registerFactory<AllRegulationsProvider>(
    () => AllRegulationsProvider(
      getAllRegulationsUseCase: getIt<GetAllRegulationsUseCase>(),
    ),
  );

  //Regulation Approval Update
  // 🔹 Data Source
  getIt.registerLazySingleton<UpdateRegulationStatusRemoteDataSource>(
    () =>
        UpdateRegulationStatusRemoteDataSource(dioService: getIt<DioService>()),
  );

  // 🔹 Repository
  getIt.registerLazySingleton<UpdateRegulationStatusRepository>(
    () => UpdateRegulationStatusRepositoryImpl(
      remoteDataSource: getIt<UpdateRegulationStatusRemoteDataSource>(),
    ),
  );

  // 🔹 Use Case
  getIt.registerLazySingleton<UpdateRegulationStatusUseCase>(
    () => UpdateRegulationStatusUseCase(
      repository: getIt<UpdateRegulationStatusRepository>(),
    ),
  );

  // 🔹 Provider
  getIt.registerFactory<UpdateRegulationStatusProvider>(
    () => UpdateRegulationStatusProvider(
      updateRegulationStatusUseCase: getIt<UpdateRegulationStatusUseCase>(),
    ),
  );

  //===============================ATS PAGES===========================================
}
