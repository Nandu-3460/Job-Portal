import 'package:flutter/material.dart';
import '../models/job.dart';
import '../widgets/job_card.dart';
import '../widgets/sdg_section.dart';

/// Home Page Tab displaying hero banner, search bar, SDG impact, and featured jobs.
class HomeTab extends StatelessWidget {
  final List<Job> jobs;
  final Set<String> appliedJobIds;
  final Function(String query) onSearchSubmitted;
  final Function(Job job) onViewJobDetails;
  final Function(Job job) onApplyToJob;
  final VoidCallback onNavigateToFindJobs;

  const HomeTab({
    super.key,
    required this.jobs,
    required this.appliedJobIds,
    required this.onSearchSubmitted,
    required this.onViewJobDetails,
    required this.onApplyToJob,
    required this.onNavigateToFindJobs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final featuredJobs = jobs.where((j) => j.isFeatured).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Banner
              _buildHeroBanner(context, theme),
              const SizedBox(height: 28),

              // Highlights/Stats row
              _buildStatsRow(theme),
              const SizedBox(height: 28),

              // SDG Impact Section
              const SdgImpactSection(isCompact: true),
              const SizedBox(height: 32),

              // Featured Jobs Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Featured Opportunities',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Top handpicked starter roles hiring fresh graduates now',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton.icon(
                    onPressed: onNavigateToFindJobs,
                    icon: const Text('View All Jobs'),
                    label: const Icon(Icons.arrow_forward_rounded, size: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Featured Job Cards
              ...featuredJobs.map((job) {
                return JobCard(
                  job: job,
                  isAlreadyApplied: appliedJobIds.contains(job.id),
                  onViewDetails: () => onViewJobDetails(job),
                  onApply: () => onApplyToJob(job),
                );
              }),

              const SizedBox(height: 24),

              // Bottom CTA
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withAlpha(20),
                      theme.colorScheme.primary.withAlpha(5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.colorScheme.primary.withAlpha(40)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Ready to kickstart your professional career?',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Explore our full list of verified entry-level openings and internships.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: onNavigateToFindJobs,
                      icon: const Icon(Icons.search),
                      label: const Text('Browse All 12+ Jobs'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context, ThemeData theme) {
    final searchController = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade900,
            Colors.blue.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade900.withAlpha(50),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(35),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.school, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  'Academic Project • College Capstone',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Job Portal for Fresh Graduates',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: const Text(
              'Your dedicated platform to find first-time jobs, trainee roles, and graduate internships without prior commercial experience requirements.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Search Box inside Hero
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.search, color: Colors.grey),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search by job title or company (e.g. Flutter, QA)...',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          onSearchSubmitted(value.trim());
                        }
                      },
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      if (searchController.text.trim().isNotEmpty) {
                        onSearchSubmitted(searchController.text.trim());
                      } else {
                        onNavigateToFindJobs();
                      }
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(ThemeData theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 600;
        final stats = [
          _StatTile(icon: Icons.work, label: '12+ Starter Roles', subtitle: 'Curated for graduates'),
          _StatTile(icon: Icons.verified_user, label: '0 Yrs Required', subtitle: 'Fresh talent welcome'),
          _StatTile(icon: Icons.domain, label: 'Verified Firms', subtitle: 'Direct HR review'),
          _StatTile(icon: Icons.money_off, label: '100% Free', subtitle: 'For students & grads'),
        ];

        if (isSmall) {
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: stats
                .map((s) => SizedBox(width: (constraints.maxWidth - 20) / 2, child: s))
                .toList(),
          );
        }

        return Row(
          children: stats
              .map((s) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: s,
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;

  const _StatTile({required this.icon, required this.label, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(80)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: theme.colorScheme.primary.withAlpha(20),
            child: Icon(icon, size: 18, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
