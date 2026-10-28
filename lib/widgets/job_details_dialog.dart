import 'package:flutter/material.dart';
import '../models/job.dart';

/// Modal dialog displaying comprehensive details about a selected job.
class JobDetailsDialog extends StatelessWidget {
  final Job job;
  final bool isAlreadyApplied;
  final VoidCallback onApply;

  const JobDetailsDialog({
    super.key,
    required this.job,
    required this.isAlreadyApplied,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650, maxHeight: 700),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Title, Company and Close Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: theme.colorScheme.primary.withAlpha(25),
                    child: Icon(job.companyIcon, size: 28, color: theme.colorScheme.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          job.company,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: 'Close',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Badges row: Job Type, Location, Salary, Posted Date
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(icon: Icons.work_outline, label: job.jobType),
                  _InfoChip(icon: Icons.location_on_outlined, label: job.location),
                  _InfoChip(
                    icon: Icons.payments_outlined,
                    label: job.salary,
                    color: Colors.green.shade700,
                  ),
                  _InfoChip(icon: Icons.access_time, label: job.postedDate),
                ],
              ),
              const Divider(height: 28),

              // Scrollable content area
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Job Description
                      _SectionHeading(title: 'Job Description', icon: Icons.description_outlined),
                      const SizedBox(height: 8),
                      Text(
                        job.description,
                        style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                      ),
                      const SizedBox(height: 20),

                      // Eligibility
                      _SectionHeading(title: 'Eligibility Criteria', icon: Icons.school_outlined),
                      const SizedBox(height: 8),
                      Text(
                        job.eligibility,
                        style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                      ),
                      const SizedBox(height: 20),

                      // Required Skills
                      _SectionHeading(title: 'Required Skills', icon: Icons.build_circle_outlined),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: job.requiredSkills.map((skill) {
                          return Chip(
                            label: Text(skill),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            backgroundColor: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              const Divider(height: 24),

              // Bottom Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Back to Jobs'),
                  ),
                  const SizedBox(width: 12),
                  if (isAlreadyApplied)
                    OutlinedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                      label: const Text('Already Applied'),
                    )
                  else
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onApply();
                      },
                      icon: const Icon(Icons.send_rounded),
                      label: const Text('Apply Now'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeading({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _InfoChip({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipColor = color ?? theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: chipColor.withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: chipColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: chipColor,
            ),
          ),
        ],
      ),
    );
  }
}
