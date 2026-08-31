import 'package:flutter/material.dart';
import 'app_state.dart';
import 'common.dart';
import 'data.dart';
import 'image_slot.dart';
import 'theme.dart';

const _tabPad = EdgeInsets.fromLTRB(20, 26, 20, 132);

// ===========================================================================
// HOME
// ===========================================================================
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  static const _quickActions = [
    QuickAction('Departments', kPeriTint, Icons.account_balance_outlined),
    QuickAction('Courses', kButterTint, Icons.menu_book_outlined),
    QuickAction('Cafe menu', kPink, Icons.restaurant_outlined),
    QuickAction('Library', kSageTint, Icons.local_library_outlined),
    QuickAction('GPA', kPeriTint, Icons.leaderboard_outlined),
    QuickAction('Report', kPink, Icons.report_gmailerrorred_outlined),
  ];

  void _runQuick(AppState s, String label) {
    switch (label) {
      case 'Departments':
        s.openOverlay('departments');
      case 'Courses':
        s.openOverlay('dept', deptId: 'cs');
      case 'Cafe menu':
        s.openOverlay('cafeteria');
      case 'Library':
        s.openLibraryFilter();
      case 'GPA':
        s.openGpaTab();
      case 'Report':
        s.openOverlay('criticism');
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    return ListView(
      padding: _tabPad,
      children: [
        // greeting row
        Row(
          children: [
            const InitialsAvatar('NB', size: 48),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TUESDAY, MAR 18',
                      style: eyebrow(kMuted, size: 12, spacing: 1.7)
                          .copyWith(fontWeight: FontWeight.w600)),
                  Text('Morning, Natnael',
                      style: display(26, weight: FontWeight.w700, height: 1.1, letterSpacing: -0.5)),
                ],
              ),
            ),
            Tap(
              onTap: s.openAnnouncementsBell,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const RoundIconButton(
                      icon: Icons.notifications_none, onTap: _noop, size: 42),
                  if (s.hasUnread)
                    Positioned(
                      top: 6,
                      right: 7,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: kCoral,
                          shape: BoxShape.circle,
                          border: Border.all(color: kCard, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),

        // next-up card
        Container(
          decoration: BoxDecoration(color: kInk, borderRadius: BorderRadius.circular(26)),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned(
                right: -30,
                top: -30,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      color: kCoral.withValues(alpha: 0.22), shape: BoxShape.circle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const PulseDot(),
                        const SizedBox(width: 8),
                        Text('NEXT UP · IN 40 MIN',
                            style: eyebrow(kButter, size: 11, spacing: 1.8)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('Data Structures II',
                        style: display(27,
                            weight: FontWeight.w700, color: kCream, height: 1.15, letterSpacing: -0.5)),
                    const SizedBox(height: 6),
                    Text('10:00 – 11:30 · Block B, Room 204 · Dr. Alemu',
                        style: body(13.5, color: const Color(0xFFC7BCAC))),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Tap(
                            onTap: () => s.openOverlay('schedule'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: kCream, borderRadius: BorderRadius.circular(14)),
                              child: Text("Today's schedule",
                                  style: body(13.5, weight: FontWeight.w600, color: kInk)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Tap(
                          onTap: s.openPlacesTab,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFF4A4238)),
                            ),
                            child: Text('Find a room',
                                style: body(13.5, weight: FontWeight.w600, color: kCream)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // quick actions grid
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.0,
          children: [
            for (final qa in _quickActions)
              Tap(
                onTap: () => _runQuick(s, qa.label),
                child: Container(
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kLine),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                            color: qa.tint, borderRadius: BorderRadius.circular(12)),
                        child: Icon(qa.icon, size: 17, color: kInk),
                      ),
                      const SizedBox(height: 8),
                      Text(qa.label,
                          textAlign: TextAlign.center,
                          style: body(11.5, weight: FontWeight.w600, height: 1.25)),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),

        // lunch banner
        Tap(
          onTap: () => s.openOverlay('cafeteria'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(color: kButter, borderRadius: BorderRadius.circular(24)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SELF CAFE · LUNCH TODAY',
                          style: eyebrow(const Color(0xFF7A5B10), size: 11, spacing: 1.7)),
                      const SizedBox(height: 5),
                      Text('Shiro, injera & salad',
                          style: display(20, weight: FontWeight.w700, height: 1.2)),
                      const SizedBox(height: 4),
                      Text('Served 12:00 – 14:00 · see the whole week',
                          style: body(13, color: const Color(0xFF6B5416))),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                const ImageSlot(width: 66, height: 66, radius: 18, label: 'Food'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 26),

        SectionHeader('This week on campus',
            action: 'All events', onAction: s.openEventsTab),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: kEvents.length.clamp(0, 3),
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final ev = kEvents[i];
              return Tap(
                onTap: () => s.openOverlay('post', postKind: 'event', postId: ev.id),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: kLine),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ImageSlot(height: 112, width: double.infinity, radius: 0, label: 'Event photo'),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ev.when.toUpperCase(),
                                style: eyebrow(kAccent, size: 11, spacing: 1.1)),
                            const SizedBox(height: 5),
                            Text(ev.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: body(14.5, weight: FontWeight.w700, height: 1.25)),
                            const SizedBox(height: 4),
                            Text(ev.place, style: body(12.5, color: kMuted)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),

        // new-here card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: kPeri, borderRadius: BorderRadius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('NEW HERE?',
                  style: eyebrow(Colors.white.withValues(alpha: 0.85), size: 11, spacing: 1.7)),
              const SizedBox(height: 6),
              Text("You don't have to walk in cold.",
                  style: display(21, weight: FontWeight.w700, color: Colors.white, height: 1.2)),
              const SizedBox(height: 8),
              Text(
                "Join a hub before term starts — read for a while, say hi when you're ready. Nobody sees you lurking.",
                style: body(13.5, color: Colors.white.withValues(alpha: 0.92), height: 1.5),
              ),
              const SizedBox(height: 14),
              Tap(
                onTap: s.openHubsTab,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(14)),
                  child: Text('Browse 24 hubs',
                      style: body(13.5, weight: FontWeight.w700, color: const Color(0xFF3B45A8))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // registrar teaser
        Tap(
          onTap: s.openAnnouncementsBell,
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFD9B9A8)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: kCoral, shape: BoxShape.circle),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('REGISTRAR · 2H AGO',
                          style: eyebrow(kMuted, size: 11, spacing: 1.6)),
                      const SizedBox(height: 4),
                      Text(
                        'Add/drop closes Friday 5:00 PM. Late forms need a dean signature.',
                        style: body(14.5, weight: FontWeight.w600, height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void _noop() {}

// ===========================================================================
// CAMPUS
// ===========================================================================
class CampusTab extends StatelessWidget {
  const CampusTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final filters = ['All', 'Cafes', 'Librarys', 'Lounges'];
    return ListView(
      padding: _tabPad,
      children: [
        Text('Campus',
            style: display(30, weight: FontWeight.w700, height: 1.05, letterSpacing: -0.75)),
        const SizedBox(height: 6),
        Text('Live conditions in 32 places students actually use.',
            style: body(14, color: kMuted)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kLine),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 17, color: kMuted),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  initialValue: s.placeQuery,
                  onChanged: s.setPlaceQuery,
                  style: body(14),
                  cursorColor: kCoral,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: 'Quiet study spot, cheap coffee…',
                    hintStyle: body(14, color: kMuted),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (_, i) => SelectPill(
              label: filters[i] == 'Librarys' ? 'Libraries' : filters[i],
              selected: s.placeFilter == filters[i],
              onTap: () => s.setPlaceFilter(filters[i]),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Tap(
          onTap: () => s.openOverlay('cafeteria'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(color: kInk, borderRadius: BorderRadius.circular(22)),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: kButter, borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.restaurant, size: 19, color: kInk),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Self cafe weekly schedule',
                          style: body(15, weight: FontWeight.w700, color: kCream)),
                      const SizedBox(height: 2),
                      Text("Know what you're eating Mon–Sun",
                          style: body(12.5, color: const Color(0xFFC7BCAC))),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0xFFC7BCAC)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        for (final p in s.visiblePlaces) ...[
          _PlaceCard(place: p, onTap: () => s.openOverlay('place', placeId: p.id)),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _PlaceCard extends StatelessWidget {
  const _PlaceCard({required this.place, required this.onTap});
  final Place place;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: kLine),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSlot(width: 92, height: 100, radius: 18, tint: place.tint, label: 'Photo'),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Tag(place.kind, bg: place.tint, caps: true),
                      const SizedBox(width: 7),
                      Text(place.walk, style: body(12, color: kMuted)),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(place.name,
                      style: display(17.5, weight: FontWeight.w700, height: 1.15)),
                  const SizedBox(height: 3),
                  Text(place.note, style: body(12.5, color: kMuted)),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      Text(place.temp, style: body(12.5, weight: FontWeight.w600)),
                      Container(
                        width: 1,
                        height: 12,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        color: kLine,
                      ),
                      Text(place.busy,
                          style: body(12.5, weight: FontWeight.w600, color: place.busyColor)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// ACADEMICS
// ===========================================================================
class AcademicsTab extends StatelessWidget {
  const AcademicsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final sem = s.semGpa;
    final bars = [
      ('Y1S1', kPastGpa[0]),
      ('Y1S2', kPastGpa[1]),
      ('Now', sem.gpa),
    ];
    return ListView(
      padding: _tabPad,
      children: [
        Text('Academics',
            style: display(30, weight: FontWeight.w700, letterSpacing: -0.75)),
        const SizedBox(height: 6),
        Text(s.myDeptLine, style: body(14, color: kMuted)),
        const SizedBox(height: 18),

        // cumulative gpa
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: kSage, borderRadius: BorderRadius.circular(26)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CUMULATIVE GPA',
                            style: eyebrow(const Color(0xB312240F), size: 11, spacing: 1.7)),
                        const SizedBox(height: 6),
                        Text(s.cumGpa.toStringAsFixed(2),
                            style: display(48,
                                weight: FontWeight.w800,
                                color: const Color(0xFF12240F),
                                height: 1,
                                letterSpacing: -1.4)),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (final b in bars) ...[
                        Column(
                          children: [
                            Container(
                              width: 26,
                              height: (26 + (b.$2 / 4) * 44).roundToDouble(),
                              decoration: BoxDecoration(
                                color: b.$1 == 'Now'
                                    ? const Color(0xFF12240F)
                                    : const Color(0x5912240F),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(3),
                                  bottomRight: Radius.circular(3),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(b.$1,
                                style: body(9.5,
                                    weight: FontWeight.w700,
                                    color: const Color(0xBF12240F))),
                          ],
                        ),
                        const SizedBox(width: 7),
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text('Two semesters banked: 3.41 and 3.58. Steady climb — keep it.',
                  style: body(13, color: const Color(0xD912240F), height: 1.5)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // solver
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: kLine),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reach a target', style: display(19, weight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text('What average do the remaining semesters need?',
                  style: body(13, color: kMuted)),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
                      decoration: BoxDecoration(
                          color: kCream, borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Eyebrow('Target', size: 11),
                          const SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _RoundStep('−', s.targetDown),
                              Text(s.target.toStringAsFixed(1),
                                  style: display(24, weight: FontWeight.w800)),
                              _RoundStep('+', s.targetUp),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
                      decoration: BoxDecoration(
                          color: kCream, borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Eyebrow('By', size: 11),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              for (final e in AppState.deadlineLabels.entries)
                                Tap(
                                  onTap: () => s.setDeadline(e.key),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: s.deadline == e.key ? kInk : kCard,
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(e.value,
                                        style: body(12,
                                            weight: FontWeight.w700,
                                            color: s.deadline == e.key ? kCream : kMutedInk)),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: kInk, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.solverLead,
                        style: body(13.5, color: const Color(0xFFC7BCAC), height: 1.5)),
                    const SizedBox(height: 4),
                    Text(s.solverValue,
                        style: display(38,
                            weight: FontWeight.w800,
                            color: s.solverColor,
                            letterSpacing: -1.1)),
                    const SizedBox(height: 6),
                    Text(s.solverNote,
                        style: body(13, color: const Color(0xFFC7BCAC), height: 1.5)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // this semester
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: kLine),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('This semester', style: display(19, weight: FontWeight.w700)),
                        const SizedBox(height: 3),
                        Text('Tap a grade to change it', style: body(13, color: kMuted)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(sem.gpa.toStringAsFixed(2),
                          style: display(30, weight: FontWeight.w800, letterSpacing: -0.6, height: 1)),
                      const SizedBox(height: 3),
                      Text('${sem.cr} CR', style: eyebrow(kMuted, size: 11, spacing: 1.1)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              for (final c in s.courses) ...[
                _CourseRowTile(
                  name: c.name,
                  credits: c.credits,
                  grade: c.grade,
                  onCycle: () => s.cycleGrade(c.id),
                  onMore: () => s.moreCredits(c.id),
                  onLess: () => s.lessCredits(c.id),
                  onRemove: () => s.removeCourse(c.id),
                ),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: kLine),
                      ),
                      child: TextFormField(
                        key: ValueKey('newcourse-${s.courses.length}'),
                        initialValue: s.newCourse,
                        onChanged: s.setNewCourse,
                        onFieldSubmitted: (_) => s.addCourse(),
                        style: body(14),
                        cursorColor: kCoral,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          border: InputBorder.none,
                          hintText: 'Add a course…',
                          hintStyle: body(14, color: kMuted),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Tap(
                    onTap: s.addCourse,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                          color: kCoral, borderRadius: BorderRadius.circular(14)),
                      child: Text('Add',
                          style: body(14, weight: FontWeight.w700, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        Tap(
          onTap: () => s.openOverlay('schedule'),
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: kLine),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Class schedule', style: body(15, weight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text('CS · Year 2 · 5 days', style: body(12.5, color: kMuted)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0xFFB0A493)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // career track
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: kCoral, borderRadius: BorderRadius.circular(26)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CAREER TRACK · COMPUTER SCIENCE',
                  style: eyebrow(Colors.white.withValues(alpha: 0.85), size: 11, spacing: 1.7)),
              const SizedBox(height: 6),
              Text('Be hireable before you graduate',
                  style: display(22, weight: FontWeight.w700, color: Colors.white, height: 1.15)),
              const SizedBox(height: 16),
              for (final step in kCareerSteps) ...[
                _CareerStepTile(
                  step: step,
                  done: s.steps[step.key] ?? false,
                  onTap: () => s.toggleStep(step.key),
                ),
                const SizedBox(height: 9),
              ],
              const SizedBox(height: 5),
              Text(s.careerProgress,
                  style: body(12.5, color: Colors.white.withValues(alpha: 0.85))),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoundStep extends StatelessWidget {
  const _RoundStep(this.glyph, this.onTap);
  final String glyph;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kCard,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE7DAC6)),
        ),
        child: Text(glyph, style: body(15, weight: FontWeight.w700)),
      ),
    );
  }
}

class _CourseRowTile extends StatelessWidget {
  const _CourseRowTile({
    required this.name,
    required this.credits,
    required this.grade,
    required this.onCycle,
    required this.onMore,
    required this.onLess,
    required this.onRemove,
  });
  final String name;
  final int credits;
  final String grade;
  final VoidCallback onCycle, onMore, onLess, onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: kCream, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: body(14, weight: FontWeight.w600, height: 1.25)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _SquareStep('−', onLess),
                    SizedBox(
                      width: 44,
                      child: Text('$credits cr',
                          textAlign: TextAlign.center,
                          style: body(12, weight: FontWeight.w700, color: kMuted)),
                    ),
                    _SquareStep('+', onMore),
                  ],
                ),
              ],
            ),
          ),
          Tap(
            onTap: onCycle,
            child: Container(
              width: 46,
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: gradeTint(grade),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(grade, style: display(17, weight: FontWeight.w800)),
            ),
          ),
          Tap(
            onTap: onRemove,
            child: const Padding(
              padding: EdgeInsets.only(left: 6),
              child: Icon(Icons.close, size: 15, color: Color(0xFFB0A493)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SquareStep extends StatelessWidget {
  const _SquareStep(this.glyph, this.onTap);
  final String glyph;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: const Color(0xFFE7DAC6)),
        ),
        child: Text(glyph, style: body(13, weight: FontWeight.w700)),
      ),
    );
  }
}

class _CareerStepTile extends StatelessWidget {
  const _CareerStepTile({required this.step, required this.done, required this.onTap});
  final CareerStep step;
  final bool done;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 1),
              width: 21,
              height: 21,
              decoration: BoxDecoration(
                color: done ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.white.withValues(alpha: 0.7), width: 1.5),
              ),
              child: done
                  ? const Icon(Icons.check, size: 13, color: kCoral)
                  : null,
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: done ? 0.6 : 1,
                    child: Text(step.title,
                        style: body(14, weight: FontWeight.w700, color: Colors.white, height: 1.3)),
                  ),
                  const SizedBox(height: 3),
                  Text(step.detail,
                      style: body(12.5, color: Colors.white.withValues(alpha: 0.85), height: 1.45)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// SOCIAL / TOGETHER
// ===========================================================================
class SocialTab extends StatelessWidget {
  const SocialTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    const tabs = [
      ('gallery', 'Gallery'),
      ('events', 'Events'),
      ('chats', 'Chats'),
      ('hubs', 'Hubs'),
    ];
    return ListView(
      padding: _tabPad,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text('Together',
                  style: display(30, weight: FontWeight.w700, letterSpacing: -0.75)),
            ),
            Tap(
              onTap: () => s.openOverlay('code'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
                decoration: BoxDecoration(
                  color: kCard,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: kLine),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.qr_code_2, size: 14, color: kInk),
                    const SizedBox(width: 7),
                    Text('Add by code', style: body(12.5, weight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color(0xFFEFE4D3),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            children: [
              for (final t in tabs)
                Expanded(
                  child: Tap(
                    onTap: () => s.setSocialTab(t.$1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: s.socialTab == t.$1 ? kCard : Colors.transparent,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: s.socialTab == t.$1
                            ? [BoxShadow(color: kInk.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2))]
                            : null,
                      ),
                      child: Text(t.$2,
                          style: body(12.5,
                              weight: FontWeight.w700,
                              color: s.socialTab == t.$1 ? kInk : kMuted)),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (s.socialTab == 'gallery') ..._gallery(s),
        if (s.socialTab == 'events') ..._events(s),
        if (s.socialTab == 'chats') ..._chats(s),
        if (s.socialTab == 'hubs') ..._hubs(s),
      ],
    );
  }

  List<Widget> _gallery(AppState s) {
    return [
      Text("Graduations, competitions, small wins. React, don't perform.",
          style: body(13.5, color: kMuted, height: 1.5)),
      const SizedBox(height: 20),
      Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(child: Text('Collections', style: display(18, weight: FontWeight.w700))),
          Text('4 ALBUMS', style: eyebrow(kMuted, size: 12, spacing: 1)),
        ],
      ),
      const SizedBox(height: 12),
      SizedBox(
        height: 190,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: kCollections.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (_, i) {
            final c = kCollections[i];
            final count = kAllGallery.where((g) => g.col == c.id).length;
            return Tap(
              onTap: () => s.openOverlay('collection', collectionId: c.id),
              child: Container(
                width: 172,
                decoration: BoxDecoration(
                  color: kCard,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: kLine),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ImageSlot(height: 110, width: double.infinity, radius: 0, tint: c.tint, label: 'Cover'),
                        Positioned(
                          right: 9,
                          top: 9,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                            decoration: BoxDecoration(
                              color: kInk.withValues(alpha: 0.82),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text('$count photos',
                                style: eyebrow(kCream, size: 10.5, spacing: 0.6)),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(13, 12, 13, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: body(14, weight: FontWeight.w700, height: 1.25)),
                          const SizedBox(height: 4),
                          Text(c.sub, style: body(12, color: kMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 22),
      Text('Recent', style: display(18, weight: FontWeight.w700)),
      const SizedBox(height: 12),
      _MasonryPairs(items: kGallery, onOpen: (g) => s.openOverlay('post', postKind: 'gallery', postId: g.id), state: s),
    ];
  }

  List<Widget> _events(AppState s) {
    return [
      for (final ev in kEvents) ...[
        Tap(
          onTap: () => s.openOverlay('post', postKind: 'event', postId: ev.id),
          child: Container(
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: kLine),
            ),
            clipBehavior: Clip.antiAlias,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    width: 104,
                    child: ImageSlot(radius: 0, label: 'Photo'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(ev.when.toUpperCase(),
                              style: eyebrow(kAccent, size: 11, spacing: 1.1)),
                          const SizedBox(height: 5),
                          Text(ev.title,
                              style: display(17, weight: FontWeight.w700, height: 1.18)),
                          const SizedBox(height: 4),
                          Text(ev.place, style: body(12.5, color: kMuted)),
                          const SizedBox(height: 8),
                          Text('${ev.going} going',
                              style: body(12, weight: FontWeight.w700, color: const Color(0xFF5C6ED9))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    ];
  }

  List<Widget> _chats(AppState s) {
    return [
      for (final c in kChats) ...[
        Tap(
          onTap: () => s.openOverlay('chat', chatId: c.id),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kLine),
            ),
            child: Row(
              children: [
                InitialsAvatar(c.initials, tint: c.tint, fg: kInk),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(c.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: body(14.5, weight: FontWeight.w700)),
                          ),
                          const SizedBox(width: 8),
                          Text(c.time, style: body(11.5, color: const Color(0xFFA2957F))),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(c.last,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: body(13, color: kMuted)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    ];
  }

  List<Widget> _hubs(AppState s) {
    return [
      for (final h in kHubs) ...[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kLine),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: h.tint, borderRadius: BorderRadius.circular(13)),
                child: Text(h.badge,
                    style: body(11, weight: FontWeight.w800, letterSpacing: 0.4)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(h.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: body(14.5, weight: FontWeight.w700, height: 1.2)),
                    const SizedBox(height: 3),
                    Text(h.meta,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: body(12.5, color: kMuted)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Builder(builder: (_) {
                final on = s.joined[h.id] ?? false;
                return Tap(
                  onTap: () => s.toggleJoin(h.id),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    decoration: BoxDecoration(
                      color: on ? kSageTint : kInk,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: on ? const Color(0xFFBBD3B6) : kInk),
                    ),
                    child: Text(on ? 'Joined' : 'Join',
                        style: body(12.5,
                            weight: FontWeight.w700,
                            color: on ? const Color(0xFF2F5C29) : kCream)),
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    ];
  }
}

/// Two-column gallery grid with per-item heights.
class _MasonryPairs extends StatelessWidget {
  const _MasonryPairs({required this.items, required this.onOpen, required this.state});
  final List<GalleryItem> items;
  final void Function(GalleryItem) onOpen;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final left = <GalleryItem>[];
    final right = <GalleryItem>[];
    for (var i = 0; i < items.length; i++) {
      (i.isEven ? left : right).add(items[i]);
    }
    Widget col(List<GalleryItem> list) => Column(
          children: [
            for (final g in list) ...[
              _GalleryCard(item: g, onTap: () => onOpen(g), state: state),
              const SizedBox(height: 12),
            ],
          ],
        );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: col(left)),
        const SizedBox(width: 12),
        Expanded(child: col(right)),
      ],
    );
  }
}

class _GalleryCard extends StatelessWidget {
  const _GalleryCard({required this.item, required this.onTap, required this.state});
  final GalleryItem item;
  final VoidCallback onTap;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final hearted = state.hearts[item.id] == true;
    return Tap(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: kLine),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSlot(height: item.h * 0.72, width: double.infinity, radius: 0, label: 'Photo'),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 11, 12, 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      style: body(13.5, weight: FontWeight.w700, height: 1.25)),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Text('♥ ${state.galleryHearts(item)}',
                          style: body(12,
                              weight: FontWeight.w700,
                              color: hearted ? kAccent : kMuted)),
                      const SizedBox(width: 10),
                      Text('${state.galleryComments(item)} notes',
                          style: body(12, color: kMuted)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// ME
// ===========================================================================
class MeTab extends StatelessWidget {
  const MeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    return ListView(
      padding: _tabPad,
      children: [
        Row(
          children: [
            const InitialsAvatar('NB', size: 70),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Natnael Bekele',
                      style: display(25, weight: FontWeight.w700, height: 1.1)),
                  const SizedBox(height: 4),
                  Text('@natnael · ID UC/2941/16', style: body(13.5, color: kMuted)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(child: _MiniStat('Department', s.myDept.name)),
            const SizedBox(width: 10),
            Expanded(child: _MiniStat('Year', 'Year ${s.pickYear}')),
          ],
        ),
        const SizedBox(height: 14),
        for (final r in kMeRows) ...[
          Tap(
            onTap: () => s.openOverlay(r.overlay, deptId: r.deptId),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kLine),
              ),
              child: Row(
                children: [
                  IconTile(r.icon, r.tint),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r.label, style: body(14.5, weight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text(r.sub, style: body(12.5, color: kMuted)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, size: 18, color: Color(0xFFB0A493)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 4),
        Tap(
          onTap: () => s.openOverlay('criticism'),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: kInk, borderRadius: BorderRadius.circular(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SPEAK UP', style: eyebrow(kButter, size: 11, spacing: 1.7)),
                const SizedBox(height: 6),
                Text('Something broken, unfair, or unsafe?',
                    style: display(21, weight: FontWeight.w700, color: kCream, height: 1.2)),
                const SizedBox(height: 7),
                Text(
                  "File it to the right office — anonymously if you want. You'll still see the status.",
                  style: body(13.5, color: const Color(0xFFC7BCAC), height: 1.5),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                  decoration: BoxDecoration(
                      color: kCoral, borderRadius: BorderRadius.circular(14)),
                  child: Text('Open a report',
                      style: body(13.5, weight: FontWeight.w700, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat(this.label, this.value);
  final String label, value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Eyebrow(label, size: 11),
          const SizedBox(height: 5),
          Text(value, style: body(15, weight: FontWeight.w700)),
        ],
      ),
    );
  }
}
