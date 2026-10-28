import 'package:flutter/material.dart';
import '../widgets/sdg_section.dart';

/// About Page detailing project purpose, SDG 8 & SDG 10 relevance, and architecture.
class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'About the Project',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Job Portal for Fresh Graduates — Connecting Emerging Talent with Genuine Opportunities',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 24),

              // Project Purpose Card
              _buildPurposeCard(theme),
              const SizedBox(height: 24),

              // SDG Impact Section (expanded)
              const SdgImpactSection(isCompact: false),
              const SizedBox(height: 24),

              // Key Modules & Architecture
              _buildModulesCard(theme),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPurposeCard(ThemeData theme) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withAlpha(100)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: theme.colorScheme.primary.withAlpha(20),
                  child: Icon(Icons.school, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 12),
                Text(
                  'Project Mission & Problem Statement',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'College graduates often face the classic entry-level paradox: to get a job, they need experience; but to get experience, they need a job. Many commercial job boards cater heavily to senior and experienced professionals, burying genuine graduate openings beneath listings that require 2-5 years of industry tenure.',
              style: TextStyle(fontSize: 14, height: 1.5, color: Colors.grey.shade800),
            ),
            const SizedBox(height: 12),
            Text(
              'This project is designed as an accessible, clean, and transparent job portal dedicated exclusively to fresh graduates, trainees, and interns. By filtering out unrealistic experience requirements and providing structured role requirements, it enables fair, equal, and rapid entry into the professional workforce.',
              style: TextStyle(fontSize: 14, height: 1.5, color: Colors.grey.shade800),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModulesCard(ThemeData theme) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withAlpha(100)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: theme.colorScheme.primary.withAlpha(20),
                  child: Icon(Icons.view_quilt_outlined, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 12),
                Text(
                  'System Modules & Architecture',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _ModuleItem(
              title: '1. Home & Discovery Module',
              description:
                  'Features a welcoming hero banner, keyword search bar, SDG alignment summary, and featured starter roles.',
            ),
            const _ModuleItem(
              title: '2. Job Catalog & Filter Module',
              description:
                  'Lists predefined graduate opportunities with live search by role/company and job type filters (Full-time vs Internship).',
            ),
            const _ModuleItem(
              title: '3. Job Details & Specification Module',
              description:
                  'Comprehensive view detailing duties, required competencies, eligibility parameters, compensation, and location.',
            ),
            const _ModuleItem(
              title: '4. Candidate Application Module',
              description:
                  'Validated input form capturing candidate name, verified email, educational background, graduation year, and skills, with duplicate application protection.',
            ),
            const _ModuleItem(
              title: '5. In-Memory Session Tracker ("My Applications")',
              description:
                  'Tracks all submitted applications in current memory with timestamps and initial "Applied" statuses.',
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleItem extends StatelessWidget {
  final String title;
  final String description;

  const _ModuleItem({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
          ),
          const SizedBox(height: 2),
          Text(
            description,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
