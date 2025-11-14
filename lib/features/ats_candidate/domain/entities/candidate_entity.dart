class CandidateEntity {
  final int id;
  final String candidateName;
  final String mobileNumber;
  final String email;
  final String resume;
  final String totalExperience;
  final String disposition;
  final String recruiterName;

  CandidateEntity({
    required this.id,
    required this.candidateName,
    required this.mobileNumber,
    required this.email,
    required this.resume,
    required this.totalExperience,
    required this.disposition,
    required this.recruiterName,
  });
}

class CountsEntity {
  final int applied;
  final int shortlisted;
  final int holded;
  final int rejected;

  CountsEntity({
    required this.applied,
    required this.shortlisted,
    required this.holded,
    required this.rejected,
  });
}

class CandidatesResponse {
  final List<CandidateEntity> candidates;
  final CountsEntity counts;

  CandidatesResponse({
    required this.candidates,
    required this.counts,
  });
}