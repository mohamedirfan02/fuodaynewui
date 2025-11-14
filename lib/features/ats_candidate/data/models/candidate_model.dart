
import 'package:fuoday/features/ats_candidate/domain/entities/candidate_entity.dart';

class CandidateModel {
  final int id;
  final int webUserId;
  final String empName;
  final String empId;
  final String? name;
  final String date;
  final String atsScore;
  final String resume;
  final String candidateName;
  final String mobileNumber;
  final String email;
  final String createdAt;
  final String updatedAt;
  final String disposition;
  final String process;
  final String totalExperience;
  final String relevantExperience;
  final String presentOrganisation;
  final String organisationType;
  final String currentLocation;
  final String preferredLocation;
  final String noticePeriod;
  final String lastCtc;
  final String expCtc;
  final String offerInHand;
  final String eduQualification;
  final String recruiterName;
  final String emailStatus;
  final String dvBy;
  final String acknowledgement;
  final String interviewDate;
  final String interviewStatus;
  final String feedback;

  CandidateModel({
    required this.id,
    required this.webUserId,
    required this.empName,
    required this.empId,
    this.name,
    required this.date,
    required this.atsScore,
    required this.resume,
    required this.candidateName,
    required this.mobileNumber,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.disposition,
    required this.process,
    required this.totalExperience,
    required this.relevantExperience,
    required this.presentOrganisation,
    required this.organisationType,
    required this.currentLocation,
    required this.preferredLocation,
    required this.noticePeriod,
    required this.lastCtc,
    required this.expCtc,
    required this.offerInHand,
    required this.eduQualification,
    required this.recruiterName,
    required this.emailStatus,
    required this.dvBy,
    required this.acknowledgement,
    required this.interviewDate,
    required this.interviewStatus,
    required this.feedback,
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) {
    return CandidateModel(
      id: json['id'] ?? 0,
      webUserId: json['web_user_id'] ?? 0,
      empName: json['emp_name'] ?? '',
      empId: json['emp_id'] ?? '',
      name: json['name'],
      date: json['date'] ?? '',
      atsScore: json['ats_score'] ?? '',
      resume: json['resume'] ?? '',
      candidateName: json['candidate_name'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      email: json['email'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      disposition: json['disposition'] ?? '',
      process: json['process'] ?? '',
      totalExperience: json['total_experience'] ?? '',
      relevantExperience: json['relevant_experience'] ?? '',
      presentOrganisation: json['present_organisation'] ?? '',
      organisationType: json['organisation_type'] ?? '',
      currentLocation: json['current_location'] ?? '',
      preferredLocation: json['preferred_location'] ?? '',
      noticePeriod: json['notice_period'] ?? '',
      lastCtc: json['last_ctc'] ?? '',
      expCtc: json['exp_ctc'] ?? '',
      offerInHand: json['offer_in_hand'] ?? '',
      eduQualification: json['edu_qualification'] ?? '',
      recruiterName: json['recruiter_name'] ?? '',
      emailStatus: json['email_status'] ?? '',
      dvBy: json['dv_by'] ?? '',
      acknowledgement: json['acknowledgement'] ?? '',
      interviewDate: json['interview_date'] ?? '',
      interviewStatus: json['interview_status'] ?? '',
      feedback: json['feedback'] ?? '',
    );
  }

  CandidateEntity toEntity() {
    return CandidateEntity(
      id: id,
      candidateName: candidateName,
      mobileNumber: mobileNumber,
      email: email,
      resume: resume,
      totalExperience: totalExperience,
      disposition: disposition,
      recruiterName: recruiterName,
    );
  }
}

class CandidatesResponseModel {
  final List<CandidateModel> candidates;
  final FilterOptionsModel filterOptions;
  final CountsModel counts;

  CandidatesResponseModel({
    required this.candidates,
    required this.filterOptions,
    required this.counts,
  });

  factory CandidatesResponseModel.fromJson(Map<String, dynamic> json) {
    return CandidatesResponseModel(
      candidates: (json['candidates'] as List?)
          ?.map((e) => CandidateModel.fromJson(e))
          .toList() ??
          [],
      filterOptions: FilterOptionsModel.fromJson(json['filter_options'] ?? {}),
      counts: CountsModel.fromJson(json['counts'] ?? {}),
    );
  }
}

class FilterOptionsModel {
  final List<String> candidateNames;
  final List<String> emails;
  final List<String> dispositions;
  final List<String> recruiterNames;

  FilterOptionsModel({
    required this.candidateNames,
    required this.emails,
    required this.dispositions,
    required this.recruiterNames,
  });

  factory FilterOptionsModel.fromJson(Map<String, dynamic> json) {
    return FilterOptionsModel(
      candidateNames: List<String>.from(json['candidate_names'] ?? []),
      emails: List<String>.from(json['emails'] ?? []),
      dispositions: List<String>.from(json['dispositions'] ?? []),
      recruiterNames: List<String>.from(json['recruiter_names'] ?? []),
    );
  }
}

class CountsModel {
  final int applied;
  final int shortlisted;
  final int holded;
  final int rejected;

  CountsModel({
    required this.applied,
    required this.shortlisted,
    required this.holded,
    required this.rejected,
  });

  factory CountsModel.fromJson(Map<String, dynamic> json) {
    return CountsModel(
      applied: json['applied'] ?? 0,
      shortlisted: json['shortlisted'] ?? 0,
      holded: json['holded'] ?? 0,
      rejected: json['rejected'] ?? 0,
    );
  }

  CountsEntity toEntity() {
    return CountsEntity(
      applied: applied,
      shortlisted: shortlisted,
      holded: holded,
      rejected: rejected,
    );
  }
}