import 'package:flutter/material.dart';

/// Represents a job opening specifically targeted for fresh graduates.
class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String jobType; // e.g. Full-time, Internship, Remote, Hybrid
  final String salary;
  final List<String> requiredSkills;
  final String description;
  final String eligibility;
  final bool isFeatured;
  final String postedDate;
  final IconData companyIcon;

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.jobType,
    required this.salary,
    required this.requiredSkills,
    required this.description,
    required this.eligibility,
    this.isFeatured = false,
    required this.postedDate,
    this.companyIcon = Icons.business,
  });
}
