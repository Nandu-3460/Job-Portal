import 'package:flutter/material.dart';
import '../models/job.dart';
import '../widgets/job_card.dart';

/// Find Jobs Tab allowing search by title/company and filtering by job type.
class FindJobsTab extends StatefulWidget {
  final List<Job> jobs;
  final Set<String> appliedJobIds;
  final String initialSearchQuery;
  final Function(Job job) onViewJobDetails;
  final Function(Job job) onApplyToJob;

  const FindJobsTab({
    super.key,
    required this.jobs,
    required this.appliedJobIds,
    this.initialSearchQuery = '',
    required this.onViewJobDetails,
    required this.onApplyToJob,
  });

  @override
  State<FindJobsTab> createState() => _FindJobsTabState();
}

class _FindJobsTabState extends State<FindJobsTab> {
  late TextEditingController _searchController;
  String _selectedJobType = 'All';

  final List<String> _jobTypeFilters = ['All', 'Full-time', 'Internship'];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialSearchQuery);
  }

  @override
  void didUpdateWidget(covariant FindJobsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSearchQuery != oldWidget.initialSearchQuery &&
        widget.initialSearchQuery != _searchController.text) {
      _searchController.text = widget.initialSearchQuery;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Job> get _filteredJobs {
    final query = _searchController.text.trim().toLowerCase();
    return widget.jobs.where((job) {
      final matchesQuery = query.isEmpty ||
          job.title.toLowerCase().contains(query) ||
          job.company.toLowerCase().contains(query) ||
          job.requiredSkills.any((s) => s.toLowerCase().contains(query));

      final matchesType = _selectedJobType == 'All' ||
          job.jobType.toLowerCase() == _selectedJobType.toLowerCase();

      return matchesQuery && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filtered = _filteredJobs;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title & Description
              Text(
                'Explore Entry-Level Jobs',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Showing ${filtered.length} of ${widget.jobs.length} curated positions for fresh graduates',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),

              // Search & Filter Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(100)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(6),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search bar
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search jobs',
                        hintText: 'Search by title, company, or skill (e.g. Flutter, Infoserve, Python)...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                  });
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        isDense: true,
                      ),
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 14),

                    // Filter chips row
                    Row(
                      children: [
                        Text(
                          'Filter by Type: ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Wrap(
                            spacing: 8,
                            children: _jobTypeFilters.map((type) {
                              final isSelected = _selectedJobType == type;
                              return ChoiceChip(
                                label: Text(type),
                                selected: isSelected,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() {
                                      _selectedJobType = type;
                                    });
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Results List or Empty State
              if (filtered.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(80)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.search_off_rounded, size: 54, color: Colors.grey.shade400),
                      const SizedBox(height: 14),
                      Text(
                        'No matching jobs found',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Try searching with another keyword or resetting the filter.',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _selectedJobType = 'All';
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset Search & Filters'),
                      ),
                    ],
                  ),
                )
              else
                ...filtered.map((job) {
                  return JobCard(
                    job: job,
                    isAlreadyApplied: widget.appliedJobIds.contains(job.id),
                    onViewDetails: () => widget.onViewJobDetails(job),
                    onApply: () => widget.onApplyToJob(job),
                  );
                }),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
