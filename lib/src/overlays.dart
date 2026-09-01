import 'package:flutter/material.dart';
import 'app_state.dart';
import 'common.dart';
import 'data.dart';
import 'image_slot.dart';
import 'theme.dart';

/// Full-bleed overlay host — the design's `overlayOpen` layer with a back
/// header and a body that switches on `state.overlay`.
class OverlayHost extends StatelessWidget {
  const OverlayHost({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    return Container(
      color: kCream,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
              child: Row(
                children: [
                  RoundIconButton(
                      icon: Icons.chevron_left, onTap: s.back, size: 38),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.overlayTitle ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: display(19, weight: FontWeight.w700, height: 1.15)),
                        if ((s.overlaySub ?? '').isNotEmpty)
                          Text(s.overlaySub!, style: body(12, color: kMuted)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 28),
                child: _OverlayBody(overlay: s.overlay ?? ''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverlayBody extends StatelessWidget {
  const _OverlayBody({required this.overlay});
  final String overlay;

  @override
  Widget build(BuildContext context) {
    switch (overlay) {
      case 'departments':
        return const _DepartmentsOverlay();
      case 'dept':
        return const _DeptDetailOverlay();
      case 'place':
        return const _PlaceDetailOverlay();
      case 'cafeteria':
        return const _CafeteriaOverlay();
      case 'schedule':
        return const _ScheduleOverlay();
      case 'post':
        return const _PostOverlay();
      case 'chat':
        return const _ChatOverlay();
      case 'code':
        return const _CodeOverlay();
      case 'collection':
        return const _CollectionOverlay();
      case 'notifs':
        return const _NotifsOverlay();
      case 'announcements':
        return const _AnnouncementsOverlay();
      case 'news':
        return const _NewsOverlay();
      case 'criticism':
        return const _CriticismOverlay();
      default:
        return const SizedBox.shrink();
    }
  }
}

// ---------------------------------------------------------------------------
// Departments
// ---------------------------------------------------------------------------
class _DepartmentsOverlay extends StatelessWidget {
  const _DepartmentsOverlay();
  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Read before you commit. Each one lists what you’d actually study and where it takes you.',
          style: body(13.5, color: kMuted, height: 1.55),
        ),
        const SizedBox(height: 14),
        for (final d in kDepartments) ...[
          Tap(
            onTap: () => s.openOverlay('dept', deptId: d.id),
            child: SoftCard(
              radius: 24,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: d.color, borderRadius: BorderRadius.circular(3)),
                      ),
                      const SizedBox(width: 10),
                      Text(d.name, style: display(18, weight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(d.blurb, style: body(13, color: kMutedInk, height: 1.5)),
                  const SizedBox(height: 11),
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: [
                      Tag(d.years),
                      Tag(d.load),
                      Tag(d.cutoff),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 11),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Department detail
// ---------------------------------------------------------------------------
class _DeptDetailOverlay extends StatelessWidget {
  const _DeptDetailOverlay();
  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final d = s.currentDept;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: d.color, borderRadius: BorderRadius.circular(26)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${d.years} · ${d.load}'.toUpperCase(),
                  style: eyebrow(const Color(0xA61B231F), size: 11, spacing: 1.7)),
              const SizedBox(height: 6),
              Text(d.name, style: display(24, weight: FontWeight.w700, height: 1.15)),
              const SizedBox(height: 8),
              Text(d.long, style: body(13.5, height: 1.55)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Graduates go into', style: display(18, weight: FontWeight.w700)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final cr in d.careers)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                decoration: BoxDecoration(
                  color: kCard,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: kLine),
                ),
                child: Text(cr, style: body(12.5, weight: FontWeight.w700)),
              ),
          ],
        ),
        const SizedBox(height: 20),
        Text('Courses', style: display(18, weight: FontWeight.w700)),
        const SizedBox(height: 3),
        Text('Tap one for the description.', style: body(12.5, color: kMuted)),
        const SizedBox(height: 12),
        for (final c in d.courses) ...[
          Tap(
            onTap: () => s.toggleCourse(c.code),
            child: SoftCard(
              radius: 20,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(c.code,
                          style: body(11, weight: FontWeight.w800, color: kAccent, letterSpacing: 0.4)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(c.name,
                            style: body(14.5, weight: FontWeight.w700, height: 1.25)),
                      ),
                      const SizedBox(width: 8),
                      Text('${c.credits} cr',
                          style: body(11.5, weight: FontWeight.w700, color: kMuted)),
                    ],
                  ),
                  if (s.openCourse == c.code) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: Color(0xFFE8F0DF))),
                      ),
                      child: Text(c.desc, style: body(13, color: kMutedInk, height: 1.55)),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 9),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Place detail
// ---------------------------------------------------------------------------
class _PlaceDetailOverlay extends StatelessWidget {
  const _PlaceDetailOverlay();
  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final p = s.currentPlace;
    Color statColor(String v) => v == 'High'
        ? kAccent
        : v == 'Low'
            ? const Color(0xFF4A6B45)
            : kInk;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageSlot(height: 190, width: double.infinity, radius: 26, tint: p.tint, label: 'Photo of this place'),
        const SizedBox(height: 14),
        Row(
          children: [
            Tag(p.kind, bg: p.tint, caps: true),
            const SizedBox(width: 8),
            Text(p.hours, style: body(12.5, color: kMuted)),
          ],
        ),
        const SizedBox(height: 8),
        Text(p.name, style: display(26, weight: FontWeight.w700, height: 1.1)),
        const SizedBox(height: 7),
        Text(p.long, style: body(13.5, color: kMutedInk, height: 1.55)),
        const SizedBox(height: 16),
        Row(
          children: [
            for (var i = 0; i < p.stats.length; i++) ...[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: kLine),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Eyebrow(p.stats[i].label, size: 10.5),
                      const SizedBox(height: 5),
                      Text(p.stats[i].value,
                          style: display(20,
                              weight: FontWeight.w800, color: statColor(p.stats[i].value))),
                    ],
                  ),
                ),
              ),
              if (i != p.stats.length - 1) const SizedBox(width: 9),
            ],
          ],
        ),
        const SizedBox(height: 14),
        SoftCard(
          radius: 22,
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              ImageSlot(width: 86, height: 78, radius: 16, label: 'Map'),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Eyebrow('Where', size: 11),
                    const SizedBox(height: 4),
                    Text(p.where, style: body(14, weight: FontWeight.w600, height: 1.35)),
                    const SizedBox(height: 4),
                    Text('${p.walk} from the main gate', style: body(12.5, color: kMuted)),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (p.hasMenu) ...[
          const SizedBox(height: 20),
          Text('Menu', style: display(18, weight: FontWeight.w700)),
          const SizedBox(height: 11),
          for (final m in p.menu) ...[
            SoftCard(
              radius: 16,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m.name, style: body(14, weight: FontWeight.w600)),
                        const SizedBox(height: 2),
                        Text(m.note, style: body(12, color: kMuted)),
                      ],
                    ),
                  ),
                  Text(m.price, style: display(15, weight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
          decoration: BoxDecoration(color: kPeri, borderRadius: BorderRadius.circular(22)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('QUIET CORNER',
                  style: eyebrow(Colors.white.withValues(alpha: 0.85), size: 11, spacing: 1.6)),
              const SizedBox(height: 6),
              Text(p.quiet, style: body(13.5, color: Colors.white, height: 1.55)),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Cafeteria weekly menu
// ---------------------------------------------------------------------------
class _CafeteriaOverlay extends StatelessWidget {
  const _CafeteriaOverlay();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Posted every Sunday by Student Services. Fasting menu runs Wed & Fri.',
          style: body(13.5, color: kMuted, height: 1.55),
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < kWeek.length; i++) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
            decoration: BoxDecoration(
              color: i == 0 ? kButterTint : kCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: i == 0 ? const Color(0xFFDBE7C2) : kLine),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(kWeek[i].day, style: display(17, weight: FontWeight.w700)),
                    if (kWeek[i].tag.isNotEmpty)
                      Text(kWeek[i].tag.toUpperCase(),
                          style: eyebrow(
                              kWeek[i].tag == 'Fasting'
                                  ? const Color(0xFF0F5E4A)
                                  : const Color(0xFF2F5C29),
                              size: 10.5,
                              spacing: 1.1)),
                  ],
                ),
                const SizedBox(height: 11),
                for (final m in kWeek[i].meals)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 62,
                          child: Text(m.slot.toUpperCase(),
                              style: eyebrow(kMuted, size: 11, spacing: 0.9)),
                        ),
                        Expanded(
                          child: Text(m.food, style: body(13.5, height: 1.4)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 11),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Schedule
// ---------------------------------------------------------------------------
class _ScheduleOverlay extends StatelessWidget {
  const _ScheduleOverlay();
  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final classes = kSchedule[s.day] ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (final d in kSchedule.keys) ...[
              Expanded(
                child: Tap(
                  onTap: () => s.setDay(d),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      color: s.day == d ? kInk : kCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: s.day == d ? kInk : kLine),
                    ),
                    child: Column(
                      children: [
                        Text(d,
                            style: body(11,
                                weight: FontWeight.w700,
                                color: s.day == d ? kCream : kMutedInk)),
                        const SizedBox(height: 3),
                        Text('${kSchedule[d]!.length} cls',
                            style: body(10,
                                color: (s.day == d ? kCream : kMutedInk)
                                    .withValues(alpha: 0.65))),
                      ],
                    ),
                  ),
                ),
              ),
              if (d != kSchedule.keys.last) const SizedBox(width: 7),
            ],
          ],
        ),
        const SizedBox(height: 16),
        for (final c in classes) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 58,
                child: Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(c.start, style: display(15, weight: FontWeight.w800)),
                      const SizedBox(height: 2),
                      Text(c.end, style: body(11, color: const Color(0xFF8B988C))),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: kCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kLine),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(width: 5, color: c.color),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 14, 15, 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(c.name,
                                    style: body(15, weight: FontWeight.w700, height: 1.2)),
                                const SizedBox(height: 5),
                                Text('${c.room} · ${c.teacher}',
                                    style: body(12.5, color: kMuted)),
                                const SizedBox(height: 7),
                                Text(c.type,
                                    style: body(11.5, weight: FontWeight.w700, color: c.color)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 6),
        Center(
          child: Text(
            s.day == 'Wed'
                ? 'Lab report due at the end of the session.'
                : 'Rooms confirmed for this week.',
            style: body(12.5, color: kMuted),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Post / event detail with comments
// ---------------------------------------------------------------------------
class _PostOverlay extends StatelessWidget {
  const _PostOverlay();
  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final isEvent = s.postKind == 'event';
    final String id;
    final String title;
    final String meta;
    final String bodyText;
    final int baseHeartOrGoing;
    final List<Comment> baseComments;
    if (isEvent) {
      final e = s.currentEvent;
      id = e.id;
      title = e.title;
      meta = '${e.when} · ${e.place}';
      bodyText = e.body;
      baseHeartOrGoing = e.going;
      baseComments = e.comments;
    } else {
      final g = s.currentGalleryPost;
      id = g.id;
      title = g.title;
      meta = g.meta;
      bodyText = g.body;
      baseHeartOrGoing = g.hearts;
      baseComments = g.comments;
    }

    final reactionDefs = [
      ('heart', '♥', baseHeartOrGoing, const Color(0xFF0E7A54), kPink),
      ('clap', '✦', 46, const Color(0xFF2F5C29), kButterTint),
      ('proud', '★', 22, const Color(0xFF0F5E4A), kPeriTint),
    ];
    final rx = s.reactions[id] ?? const {};
    final comments = s.commentsFor(id, baseComments);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageSlot(height: 230, width: double.infinity, radius: 26, label: 'Photo'),
        const SizedBox(height: 14),
        Text(title, style: display(24, weight: FontWeight.w700, height: 1.15)),
        const SizedBox(height: 5),
        Text(meta, style: body(12.5, color: kMuted)),
        const SizedBox(height: 10),
        Text(bodyText, style: body(13.5, color: kMutedInk, height: 1.6)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final r in reactionDefs)
              Builder(builder: (_) {
                final on = r.$1 == 'heart' ? (s.hearts[id] == true) : (rx[r.$1] == true);
                return Tap(
                  onTap: () => r.$1 == 'heart'
                      ? s.toggleHeart(id)
                      : s.toggleReaction(id, r.$1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      color: on ? r.$5 : kCard,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: on ? r.$5 : kLine),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(r.$2,
                            style: body(14, color: on ? r.$4 : kMuted)),
                        const SizedBox(width: 6),
                        Text('${r.$3 + (on ? 1 : 0)}',
                            style: body(12.5,
                                weight: FontWeight.w700, color: on ? r.$4 : kMuted)),
                      ],
                    ),
                  ),
                );
              }),
          ],
        ),
        const SizedBox(height: 22),
        Text('${comments.length} comments', style: display(18, weight: FontWeight.w700)),
        const SizedBox(height: 12),
        for (var i = 0; i < comments.length; i++) ...[
          _CommentRow(comment: comments[i], tint: kTints[i % 4]),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 4),
        _Composer(
          value: s.commentDraft,
          hint: 'Say something kind…',
          onChanged: s.setCommentDraft,
          onSend: s.sendComment,
          sendColor: kCoral,
          sendIconColor: Colors.white,
        ),
      ],
    );
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({required this.comment, required this.tint});
  final Comment comment;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
          child: Text(initialsOf(comment.who),
              style: body(12, weight: FontWeight.w800)),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border.all(color: kLine),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(comment.who,
                          style: body(13, weight: FontWeight.w700)),
                    ),
                    Text(comment.when,
                        style: body(11, color: const Color(0xFF8B988C))),
                  ],
                ),
                const SizedBox(height: 4),
                Text(comment.text, style: body(13.5, color: kBodyInk, height: 1.5)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Input + round send button.
class _Composer extends StatelessWidget {
  const _Composer({
    required this.value,
    required this.hint,
    required this.onChanged,
    required this.onSend,
    required this.sendColor,
    required this.sendIconColor,
  });
  final String value;
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;
  final Color sendColor;
  final Color sendIconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kLine),
            ),
            child: DraftField(
              value: value,
              onChanged: onChanged,
              onSubmit: onSend,
              hint: hint,
            ),
          ),
        ),
        const SizedBox(width: 9),
        Tap(
          onTap: onSend,
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
                color: sendColor, borderRadius: BorderRadius.circular(16)),
            child: Icon(Icons.arrow_forward, size: 18, color: sendIconColor),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Chat thread
// ---------------------------------------------------------------------------
class _ChatOverlay extends StatelessWidget {
  const _ChatOverlay();
  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final msgs = s.chatMessages;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final m in msgs) ...[
          Align(
            alignment: m.mine ? Alignment.centerRight : Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.72),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                decoration: BoxDecoration(
                  color: m.mine ? kInk : kCard,
                  borderRadius: BorderRadius.circular(18),
                  border: m.mine ? null : Border.all(color: kLine),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.text,
                        style: body(13.5,
                            color: m.mine ? kCream : kInk, height: 1.5)),
                    const SizedBox(height: 4),
                    Text(m.time,
                        style: body(10.5,
                            color: (m.mine ? kCream : kInk).withValues(alpha: 0.6))),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 9),
        ],
        const SizedBox(height: 8),
        _Composer(
          value: s.chatDraft,
          hint: 'Message…',
          onChanged: s.setChatDraft,
          onSend: s.sendChat,
          sendColor: kInk,
          sendIconColor: kCream,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Add by code
// ---------------------------------------------------------------------------
class _CodeOverlay extends StatelessWidget {
  const _CodeOverlay();
  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SoftCard(
          radius: 26,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: 168,
                height: 168,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: kInk, borderRadius: BorderRadius.circular(22)),
                child: GridView.count(
                  crossAxisCount: 7,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: [
                    for (final v in kQr)
                      Container(
                        decoration: BoxDecoration(
                          color: v == 1 ? kCream : const Color(0xFF2A332B),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text('@natnael', style: display(20, weight: FontWeight.w700)),
              const SizedBox(height: 5),
              Text(
                'Let someone scan this, or type their username below. No phone numbers, ever.',
                textAlign: TextAlign.center,
                style: body(13, color: kMuted, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: kLine),
                ),
                child: DraftField(
                  value: s.codeDraft,
                  onChanged: s.setCodeDraft,
                  onSubmit: s.addByCode,
                  hint: '@username',
                ),
              ),
            ),
            const SizedBox(width: 9),
            Tap(
              onTap: s.addByCode,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                decoration: BoxDecoration(
                    color: kCoral, borderRadius: BorderRadius.circular(16)),
                child: Text('Request',
                    style: body(14, weight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ],
        ),
        if (s.codeStatus.isNotEmpty) ...[
          const SizedBox(height: 12),
          Center(
            child: Text(s.codeStatus,
                textAlign: TextAlign.center, style: body(13, color: kMuted)),
          ),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Collection detail
// ---------------------------------------------------------------------------
class _CollectionOverlay extends StatelessWidget {
  const _CollectionOverlay();
  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    final col = s.currentCollection;
    final items = kAllGallery.where((g) => g.col == col.id).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(color: col.tint, borderRadius: BorderRadius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${items.length} PHOTOS',
                  style: eyebrow(kMutedInk, size: 11, spacing: 1.5)),
              const SizedBox(height: 7),
              Text(col.note, style: body(13.5, color: kBodyInk, height: 1.55)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _MasonryPairsOverlay(
          items: items,
          state: s,
          onOpen: (g) => s.openOverlay('post', postKind: 'gallery', postId: g.id),
        ),
      ],
    );
  }
}

/// Local two-column grid for the collection overlay.
class _MasonryPairsOverlay extends StatelessWidget {
  const _MasonryPairsOverlay({required this.items, required this.onOpen, required this.state});
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
    Widget card(GalleryItem g) => Tap(
          onTap: () => onOpen(g),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: kLine),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageSlot(height: g.h * 0.72, width: double.infinity, radius: 0, label: 'Photo'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 11, 12, 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(g.title, style: body(13.5, weight: FontWeight.w700, height: 1.25)),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          Text('♥ ${state.galleryHearts(g)}',
                              style: body(12,
                                  weight: FontWeight.w700,
                                  color: state.hearts[g.id] == true ? kAccent : kMuted)),
                          const SizedBox(width: 10),
                          Text('${state.galleryComments(g)} notes',
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Column(children: [for (final g in left) card(g)])),
        const SizedBox(width: 12),
        Expanded(child: Column(children: [for (final g in right) card(g)])),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Notifications
// ---------------------------------------------------------------------------
class _NotifsOverlay extends StatelessWidget {
  const _NotifsOverlay();
  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    const filters = ['All', 'Chats', 'Events', 'Gallery', 'Announcements'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (_, _) => const SizedBox(width: 7),
            itemBuilder: (_, i) {
              final k = filters[i];
              final n = s.notifFilterCount(k);
              return SelectPill(
                label: n > 0 ? '$k · $n' : k,
                selected: s.notifFilter == k,
                onTap: () => s.setNotifFilter(k),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        for (final n in s.filteredNotifs) ...[
          _NotifRow(
            notif: n,
            unread: s.notifUnread(n),
            onTap: () => s.openNotif(n),
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 8),
        Center(
          child: Tap(
            onTap: s.markAllRead,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Mark everything read',
                  style: body(13, weight: FontWeight.w700, color: kMuted)),
            ),
          ),
        ),
      ],
    );
  }
}

class _NotifRow extends StatelessWidget {
  const _NotifRow({required this.notif, required this.unread, required this.onTap});
  final NotifItem notif;
  final bool unread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        decoration: BoxDecoration(
          color: unread ? kCard : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: unread ? const Color(0xFFD9E3CE) : kLine),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                  color: notif.tint, borderRadius: BorderRadius.circular(13)),
              child: Icon(notif.icon, size: 17, color: kInk),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        child: Text(notif.kind.toUpperCase(),
                            style: eyebrow(notif.kindColor, size: 10.5, spacing: 1.2)),
                      ),
                      Text(notif.when,
                          style: body(11, color: const Color(0xFF8B988C))),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(notif.title,
                      style: body(14, weight: FontWeight.w700, height: 1.3)),
                  const SizedBox(height: 3),
                  Text(notif.body,
                      style: body(12.5, color: kMutedInk, height: 1.45)),
                ],
              ),
            ),
            if (unread) ...[
              const SizedBox(width: 8),
              Container(
                margin: const EdgeInsets.only(top: 6),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: kCoral, shape: BoxShape.circle),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Announcements
// ---------------------------------------------------------------------------
class _AnnouncementsOverlay extends StatelessWidget {
  const _AnnouncementsOverlay();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final a in kAnnouncements) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: a.bg,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: a.bc),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(a.from.toUpperCase(),
                          style: eyebrow(a.fromColor, size: 10.5, spacing: 1.2)),
                    ),
                    Text(a.when, style: body(11.5, color: const Color(0xFF8B988C))),
                  ],
                ),
                const SizedBox(height: 7),
                Text(a.title, style: body(15, weight: FontWeight.w700, height: 1.3)),
                const SizedBox(height: 5),
                Text(a.body, style: body(13, color: kMutedInk, height: 1.55)),
              ],
            ),
          ),
          const SizedBox(height: 11),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// News
// ---------------------------------------------------------------------------
class _NewsOverlay extends StatelessWidget {
  const _NewsOverlay();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final n in kNews) ...[
          Container(
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: kLine),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ImageSlot(height: 130, width: double.infinity, radius: 0, label: 'Photo'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 15, 17, 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(n.tag.toUpperCase(),
                          style: eyebrow(kAccent, size: 10.5, spacing: 1.2)),
                      const SizedBox(height: 6),
                      Text(n.title,
                          style: display(18, weight: FontWeight.w700, height: 1.2)),
                      const SizedBox(height: 6),
                      Text(n.body, style: body(13, color: kMutedInk, height: 1.55)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Criticism / report
// ---------------------------------------------------------------------------
class _CriticismOverlay extends StatelessWidget {
  const _CriticismOverlay();
  @override
  Widget build(BuildContext context) {
    final s = AppScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (s.reportSent) ...[
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(color: kSage, borderRadius: BorderRadius.circular(26)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Filed. Ticket #${s.ticket}',
                    style: display(22,
                        weight: FontWeight.w700, color: const Color(0xFF12240F), height: 1.2)),
                const SizedBox(height: 8),
                Text(
                  'Routed to ${s.reportOffice}. They have 5 working days to respond. You’ll get a notification either way.',
                  style: body(13.5, color: const Color(0xE612240F), height: 1.55),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 12),
        Text('Pick the category — it decides which office gets it.',
            style: body(13.5, color: kMuted, height: 1.55)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final c in kReportCats)
              SelectPill(
                label: c.label,
                selected: s.reportCat == c.label,
                onTap: () => s.setReportCat(c.label),
              ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kLine),
          ),
          padding: const EdgeInsets.all(15),
          child: DraftField(
            value: s.reportText,
            onChanged: s.setReportText,
            minLines: 5,
            maxLines: 8,
            hint: 'What happened, where, and when? Specifics get fixed faster.',
            style: body(14, height: 1.55),
            hintStyle: body(14, color: kMuted, height: 1.55),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kLine),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('File anonymously',
                        style: body(14.5, weight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text('Your name is hidden from officials. You keep the ticket.',
                        style: body(12.5, color: kMuted, height: 1.4)),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Tap(
                onTap: s.toggleAnon,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 50,
                  height: 29,
                  padding: const EdgeInsets.all(3),
                  alignment: s.anon ? Alignment.centerRight : Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: s.anon ? kSage : const Color(0xFFCFD9CD),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Container(
                    width: 23,
                    height: 23,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        PillButton(
          label: 'Send to ${s.reportOffice}',
          onTap: s.submitReport,
          radius: 20,
          padding: const EdgeInsets.symmetric(vertical: 16),
          fontSize: 15,
        ),
        const SizedBox(height: 24),
        Text('Your past reports', style: display(18, weight: FontWeight.w700)),
        const SizedBox(height: 12),
        for (final r in kMyReports) ...[
          SoftCard(
            radius: 20,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('#${r.id} · ${r.cat}'.toUpperCase(),
                          style: eyebrow(kMuted, size: 11, spacing: 1)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                          color: r.statusBg, borderRadius: BorderRadius.circular(999)),
                      child: Text(r.status,
                          style: body(11, weight: FontWeight.w800, color: r.statusFg)),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(r.text, style: body(13.5, color: kBodyInk, height: 1.5)),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
