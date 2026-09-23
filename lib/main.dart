import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const SiraatCompassApp());
}

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
class AppColors {
  static const slate50 = Color(0xFFF8FAFC);
  static const slate100 = Color(0xFFF1F5F9);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate400 = Color(0xFF94A3B8);
  static const slate500 = Color(0xFF64748B);
  static const slate600 = Color(0xFF475569);
  static const slate700 = Color(0xFF334155);
  static const slate800 = Color(0xFF1E293B);

  static const indigo50 = Color(0xFFEEF2FF);
  static const indigo100 = Color(0xFFE0E7FF);
  static const indigo600 = Color(0xFF4F46E5);
  static const indigo700 = Color(0xFF4338CA);
  static const indigo950 = Color(0xFF1E1B4B);

  static const emerald50 = Color(0xFFECFDF5);
  static const emerald100 = Color(0xFFD1FAE5);
  static const emerald600 = Color(0xFF059669);
  static const emerald700 = Color(0xFF047857);

  static const amber100 = Color(0xFFFEF3C7);
  static const amber500 = Color(0xFFF59E0B);
  static const amber700 = Color(0xFFB45309);

  static const purple600 = Color(0xFF9333EA);
}

class SiraatCompassApp extends StatelessWidget {
  const SiraatCompassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siraat Compass Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.slate50,
        textTheme: ThemeData.light().textTheme,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.indigo600,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final width = MediaQuery.of(context).size.width;

                if (width < 800) {
                  return const SizedBox.shrink();
                }

                return const Sidebar();
              },
            ),
            const Expanded(
              child: MainContent(),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sidebar
// ---------------------------------------------------------------------------
class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: AppColors.slate200,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.slate100,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.indigo600,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/image.png',
                    width: 22,
                    height: 22,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Siraat Compass',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.indigo950,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _NavItem(
                    label: 'Dashboard',
                    selected: true,
                  ),
                  _NavItem(
                    label: 'Students',
                    selected: false,
                  ),
                  _NavItem(
                    label: 'Analytics',
                    selected: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final bool selected;

  const _NavItem({
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: selected ? AppColors.indigo50 : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? AppColors.indigo600 : AppColors.slate600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Main content
// ---------------------------------------------------------------------------
class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: AppColors.slate200,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Aggregated Counselor Insights',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.slate800,
                ),
              ),
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.indigo100,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  'SC',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.indigo700,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Scrollable body
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SummaryCardsGrid(),
                const SizedBox(height: 24),
                const AnalyticsGrid(),
                const SizedBox(height: 24),
                const TagsGrid(),
                const SizedBox(height: 24),
                const AchievementsTable(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Summary cards
// ---------------------------------------------------------------------------
class SummaryCardsGrid extends StatelessWidget {
  const SummaryCardsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      _SummaryCardData(
        'TOP RIASEC PAIR',
        'Social + \nInvestigative',
        '38% of tested cohort',
        AppColors.indigo600,
      ),
      _SummaryCardData(
        'TOP PROBLEM TO SOLVE',
        'Healthcare \nAccess',
        'Selected by 52 students',
        AppColors.emerald600,
      ),
      _SummaryCardData(
        'TOP LIFESTYLE CHOICE',
        'Work-Life Balance',
        '64% priority rating',
        AppColors.amber500,
      ),
      _SummaryCardData(
        'ACTION PLAN PROGRESS',
        '72% Completed',
        'Avg per active student',
        AppColors.purple600,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900
            ? 4
            : constraints.maxWidth > 600
                ? 2
                : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            return _SummaryCard(
              data: cards[index],
            );
          },
        );
      },
    );
  }
}

class _SummaryCardData {
  final String label;
  final String value;
  final String caption;
  final Color color;

  _SummaryCardData(
    this.label,
    this.value,
    this.caption,
    this.color,
  );
}

class _SummaryCard extends StatelessWidget {
  final _SummaryCardData data;

  const _SummaryCard({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.slate200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            data.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.slate500,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.value,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: data.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.caption,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.slate400,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Charts
// ---------------------------------------------------------------------------
class AnalyticsGrid extends StatelessWidget {
  const AnalyticsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;

        final riasec = const _ChartCard(
          title: 'Dominant RIASEC Combinations (Top 2)',
          child: RiasecBarChart(),
        );

        final lifestyle = const _ChartCard(
          title: 'Lifestyle Priorities Breakdown',
          child: LifestyleDoughnutChart(),
        );

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: riasec),
              const SizedBox(width: 24),
              Expanded(child: lifestyle),
            ],
          );
        }

        return Column(
          children: [
            riasec,
            const SizedBox(height: 24),
            lifestyle,
          ],
        );
      },
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _ChartCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.slate200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.slate800,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 256,
            child: child,
          ),
        ],
      ),
    );
  }
}

class RiasecBarChart extends StatelessWidget {
  const RiasecBarChart({super.key});

  static const labels = [
    'Social +\nInvest.',
    'Artist. +\nSocial',
    'Enterp. +\nReal.',
    'Conv. +\nEnterp.',
    'Invest. +\nReal.',
  ];

  static const values = [
    48.0,
    35.0,
    22.0,
    15.0,
    8.0,
  ];

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: 55,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 10,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.slate100,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 10,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.slate400,
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();

                if (i < 0 || i >= labels.length) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.only(
                    top: 6,
                  ),
                  child: Text(
                    labels[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.slate500,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: List.generate(values.length, (i) {
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: values[i],
                color: AppColors.indigo600,
                width: 28,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class LifestyleDoughnutChart extends StatelessWidget {
  const LifestyleDoughnutChart({
    super.key,
  });

  static const data = [
    _Slice(
      'Work-Life Balance',
      64,
      AppColors.amber500,
    ),
    _Slice(
      'Remote Flexibility',
      42,
      Color(0xFF10B981),
    ),
    _Slice(
      'High Salary',
      38,
      Color(0xFF6366F1),
    ),
    _Slice(
      'Entrepreneurial Freedom',
      20,
      Color(0xFF8B5CF6),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: data
                  .map(
                    (s) => PieChartSectionData(
                      value: s.value,
                      color: s.color,
                      title: '',
                      radius: 55,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: data
                .map(
                  (s) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: s.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            s.label,
                            style: TextStyle(
                              fontSize: 10.5,
                              color: AppColors.slate600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _Slice {
  final String label;
  final double value;
  final Color color;

  const _Slice(
    this.label,
    this.value,
    this.color,
  );
}

// ---------------------------------------------------------------------------
// Tag sections
// ---------------------------------------------------------------------------
class TagsGrid extends StatelessWidget {
  const TagsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final problems = const _TagSection(
      title: 'Top Problems Students Want to Solve',
      background: AppColors.indigo50,
      foreground: AppColors.indigo700,
      tags: [
        'Healthcare Access (52)',
        'Climate Change (48)',
        'AI & Automation (41)',
        'Education Equity (35)',
        'Financial Inclusion (29)',
      ],
    );

    final careers = const _TagSection(
      title: 'Most Selected Career Choices',
      background: AppColors.emerald50,
      foreground: AppColors.emerald700,
      tags: [
        'Software Engineer (64)',
        'Biomedical Researcher (42)',
        'Data Scientist (39)',
        'UX/UI Designer (31)',
        'Environmental Scientist (27)',
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: problems),
              const SizedBox(width: 24),
              Expanded(child: careers),
            ],
          );
        }

        return Column(
          children: [
            problems,
            const SizedBox(height: 24),
            careers,
          ],
        );
      },
    );
  }
}

class _TagSection extends StatelessWidget {
  final String title;
  final Color background;
  final Color foreground;
  final List<String> tags;

  const _TagSection({
    required this.title,
    required this.background,
    required this.foreground,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.slate200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.slate800,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags
                .map(
                  (t) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      t,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: foreground,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Achievements table
// ---------------------------------------------------------------------------
class AchievementsTable extends StatelessWidget {
  const AchievementsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final rows = [
      _AchievementRow(
        '100% Completed (All Milestones)',
        42,
        '33%',
        'On Track',
        AppColors.emerald100,
        AppColors.emerald700,
      ),
      _AchievementRow(
        '50% - 99% Completed',
        58,
        '45%',
        'In Progress',
        AppColors.indigo100,
        AppColors.indigo700,
      ),
      _AchievementRow(
        'Less than 50% Completed',
        28,
        '22%',
        'Needs Follow-up',
        AppColors.amber100,
        AppColors.amber700,
      ),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.slate200,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------------------------------------------------------
          // Table title
          // ---------------------------------------------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 30,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.slate100,
                ),
              ),
            ),
            child: Text(
              'Action Plan Achievements',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.slate800,
              ),
            ),
          ),

          // ---------------------------------------------------------------
          // Header + rows
          // ---------------------------------------------------------------
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3.2),
              1: FlexColumnWidth(1.8),
              2: FlexColumnWidth(1.8),
              3: FlexColumnWidth(2.0),
            },
            border: TableBorder(
              horizontalInside: BorderSide(
                color: AppColors.slate100,
                width: 1,
              ),
            ),
            children: [
              // -----------------------------------------------------------
              // Header row
              // -----------------------------------------------------------
              TableRow(
                decoration: BoxDecoration(
                  color: AppColors.slate50,
                ),
                children: [
                  _TableHeader(
                    'Achievement Level',
                  ),
                  _TableHeader(
                    'Student Count',
                  ),
                  _TableHeader(
                    'Percentage',
                  ),
                  _TableHeader(
                    'Status',
                  ),
                ],
              ),

              // -----------------------------------------------------------
              // Data rows
              // -----------------------------------------------------------
              ...rows.map(
                (r) => TableRow(
                  children: [
                    _TableCell(
                      child: Text(
                        r.level,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate700,
                        ),
                      ),
                    ),
                    _TableCell(
                      child: Text(
                        r.count.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.slate700,
                        ),
                      ),
                    ),
                    _TableCell(
                      child: Text(
                        r.percentage,
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.slate700,
                        ),
                      ),
                    ),
                    _TableCell(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: r.badgeBg,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            r.status,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: r.badgeFg,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Table Header
// ---------------------------------------------------------------------------
class _TableHeader extends StatelessWidget {
  final String text;

  const _TableHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
        vertical: 14,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.slate500,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Table Cell
// ---------------------------------------------------------------------------
class _TableCell extends StatelessWidget {
  final Widget child;

  const _TableCell({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
        vertical: 10,
      ),
      child: child,
    );
  }
}

// ---------------------------------------------------------------------------
// Achievement row model
// ---------------------------------------------------------------------------
class _AchievementRow {
  final String level;
  final int count;
  final String percentage;
  final String status;
  final Color badgeBg;
  final Color badgeFg;

  _AchievementRow(
    this.level,
    this.count,
    this.percentage,
    this.status,
    this.badgeBg,
    this.badgeFg,
  );
}
