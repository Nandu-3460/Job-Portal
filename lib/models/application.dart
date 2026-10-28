/// Represents an in-memory job application submitted by a candidate.
class JobApplication {
  final String id;
  final String jobId;
  final String jobTitle;
  final String companyName;
  final String candidateName;
  final String candidateEmail;
  final String education;
  final String graduationYear;
  final String skills;
  final DateTime appliedDate;
  final String status; // e.g. "Applied", "Under Review"

  const JobApplication({
    required this.id,
    required this.jobId,
    required this.jobTitle,
    required this.companyName,
    required this.candidateName,
    required this.candidateEmail,
    required this.education,
    required this.graduationYear,
    required this.skills,
    required this.appliedDate,
    this.status = 'Applied',
  });
}
