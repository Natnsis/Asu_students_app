import 'dart:math';
import 'package:flutter/widgets.dart';
import 'data.dart';
import 'theme.dart';

/// A mutable course row on the Academics screen (`state.courses` in the source).
class CourseRow {
  CourseRow(this.id, this.name, this.credits, this.grade);
  final int id;
  String name;
  int credits;
  String grade;
}

/// Single source of truth — mirrors the `Component.state` object plus every
/// handler from `renderVals()` in UniCore.dc.html.
class AppState extends ChangeNotifier {
  // ---- onboarding / auth --------------------------------------------------
  // `--dart-define=START=app` (or auth/setup/onboard) skips ahead on launch;
  // defaults to the full first-run flow.
  String stage = const String.fromEnvironment('START', defaultValue: 'welcome');
  int slide = 0;
  String idDraft = '';
  String pwDraft = '';
  String authMode = 'in'; // in | up
  String authError = '';
  String pickDept = 'cs';
  int pickYear = 2;

  // ---- app nav ----------------------------------------------------------
  String tab = 'home';
  String? overlay;
  String socialTab = 'gallery';

  // ---- campus ---------------------------------------------------------
  String placeQuery = '';
  String placeFilter = 'All';
  String? placeId;

  // ---- overlays -----------------------------------------------------
  String? deptId;
  String? openCourse;
  String day = 'Mon';
  String? postKind;
  String? postId;
  String? chatId;
  String? collectionId;

  String commentDraft = '';
  final Map<String, List<Comment>> extraComments = {};
  final Map<String, bool> hearts = {};
  final Map<String, Map<String, bool>> reactions = {};

  String chatDraft = '';
  final Map<String, List<ChatMsg>> extraMsgs = {};
  String codeDraft = '';
  String codeStatus = '';

  final Map<String, bool> joined = {'h1': true};

  // ---- academics ----------------------------------------------------
  double target = 3.8;
  int deadline = 2;
  final List<CourseRow> courses = [
    CourseRow(1, 'Data Structures II', 4, 'A-'),
    CourseRow(2, 'Discrete Mathematics', 3, 'B+'),
    CourseRow(3, 'Object-Oriented Programming', 4, 'A'),
    CourseRow(4, 'Computer Organisation', 3, 'B'),
  ];
  String newCourse = '';
  int _nextId = 5;
  final Map<String, bool> steps = {'s1': true, 's2': true, 's3': false, 's4': false, 's5': false};

  // ---- report -----------------------------------------------------
  String reportCat = 'Facilities';
  String reportText = '';
  bool anon = true;
  bool reportSent = false;
  String ticket = '4431';

  // ---- notifications --------------------------------------------------
  String notifFilter = 'All';
  final Map<String, bool> read = {};

  final _rng = Random();

  // =======================================================================
  // Derived — GPA solver
  // =======================================================================
  ({double gpa, int cr}) get semGpa {
    final cr = courses.fold<int>(0, (a, c) => a + c.credits);
    if (cr == 0) return (gpa: 0, cr: 0);
    final pts = courses.fold<double>(0, (a, c) => a + (kGradePoints[c.grade] ?? 0) * c.credits);
    return (gpa: pts / cr, cr: cr);
  }

  double get cumGpa {
    final sem = semGpa;
    final pastSum = kPastGpa.reduce((a, b) => a + b);
    return (pastSum + sem.gpa) / (kPastGpa.length + (sem.cr > 0 ? 1 : 0));
  }

  double get needAvg {
    final rem = deadline;
    final pastSum = kPastGpa.reduce((a, b) => a + b);
    return (target * (kPastGpa.length + rem) - pastSum) / rem;
  }

  bool get solverReachable => needAvg <= 4.001;

  static const deadlineLabels = {1: 'Y2 S1', 2: 'Y2 S2', 4: 'Y3 S2'};

  String get solverLead =>
      'To hit ${target.toStringAsFixed(1)} by ${deadlineLabels[deadline]}, average';

  String get solverValue => solverReachable ? needAvg.toStringAsFixed(2) : 'Out of reach';

  Color get solverColor =>
      solverReachable ? (needAvg > 3.8 ? kButter : kSage) : kCoral;

  String get solverNote {
    final rem = deadline;
    if (solverReachable) {
      final n = needAvg;
      final roughly = n >= 3.9
          ? 'all A grades'
          : n >= 3.6
              ? 'A in three courses, A- in the rest'
              : n >= 3.2
                  ? 'mostly B+ with two A grades'
                  : 'steady B work';
      return 'across the next $rem semester${rem > 1 ? 's' : ''}. That is roughly $roughly.';
    }
    final pastSum = kPastGpa.reduce((a, b) => a + b);
    final cap = ((pastSum + 4 * rem) / (kPastGpa.length + rem)).toStringAsFixed(2);
    return 'Even straight A grades top out at $cap. Push the deadline out a semester.';
  }

  // =======================================================================
  // Derived — misc lookups
  // =======================================================================
  Department get myDept =>
      kDepartments.firstWhere((d) => d.id == pickDept, orElse: () => kDepartments.first);
  String get myYearLine => 'Year $pickYear · Sem 1';
  String get myDeptLine => '${myDept.name} · Year $pickYear, Semester 1';

  Department get currentDept =>
      kDepartments.firstWhere((d) => d.id == deptId, orElse: () => kDepartments.first);
  Place get currentPlace =>
      kPlaces.firstWhere((p) => p.id == placeId, orElse: () => kPlaces.first);
  Collection get currentCollection =>
      kCollections.firstWhere((c) => c.id == collectionId, orElse: () => kCollections.first);
  ChatThread get currentChat =>
      kChats.firstWhere((c) => c.id == chatId, orElse: () => kChats.first);

  List<Place> get visiblePlaces {
    final q = placeQuery.trim().toLowerCase();
    return kPlaces.where((p) {
      final kindOk = placeFilter == 'All' || '${p.kind}s' == placeFilter;
      final qOk = q.isEmpty || '${p.name} ${p.note} ${p.long}'.toLowerCase().contains(q);
      return kindOk && qOk;
    }).toList();
  }

  int get unreadCount => kNotifs.where((n) => n.unread && read[n.id] != true).length;
  bool get hasUnread => unreadCount > 0;

  List<NotifItem> get filteredNotifs => kNotifs
      .where((n) => notifFilter == 'All' || '${n.kind}s' == notifFilter || n.kind == notifFilter)
      .toList();

  int notifFilterCount(String k) {
    if (k == 'All') return unreadCount;
    return kNotifs
        .where((n) => ('${n.kind}s' == k || n.kind == k) && n.unread && read[n.id] != true)
        .length;
  }

  bool notifUnread(NotifItem n) => n.unread && read[n.id] != true;

  int get careerDone => steps.values.where((v) => v).length;
  String get careerProgress => '$careerDone of 5 done — ahead of most of your year.';

  List<GalleryItem> get postList => postKind == 'event'
      ? const <GalleryItem>[]
      : kAllGallery; // events handled separately below
  EventItem get currentEvent =>
      kEvents.firstWhere((e) => e.id == postId, orElse: () => kEvents.first);
  GalleryItem get currentGalleryPost =>
      kAllGallery.firstWhere((g) => g.id == postId, orElse: () => kAllGallery.first);

  int galleryHearts(GalleryItem g) => g.hearts + (hearts[g.id] == true ? 1 : 0);
  int galleryComments(GalleryItem g) =>
      g.comments.length + (extraComments[g.id]?.length ?? 0);

  String? get overlayTitle => _overlayTitles[0];
  String? get overlaySub => _overlayTitles[1];

  List<String?> get _overlayTitles {
    switch (overlay) {
      case 'departments':
        return ['Departments', 'Pick a future, not a rumour'];
      case 'dept':
        return [currentDept.name, '${currentDept.years} · ${currentDept.cutoff}'];
      case 'place':
        return [currentPlace.name, '${currentPlace.kind} · live now'];
      case 'cafeteria':
        return ['Self cafe', 'Weekly menu · this week'];
      case 'schedule':
        return ['Class schedule', 'Computer Science · Year 2'];
      case 'post':
        return postKind == 'event'
            ? ['Event', 'Campus events']
            : ['Gallery', 'Moments students posted'];
      case 'chat':
        return [currentChat.name, 'End-to-end · no numbers shared'];
      case 'code':
        return ['Add someone', 'QR or username'];
      case 'collection':
        return [currentCollection.name, currentCollection.sub];
      case 'notifs':
        return ['Notifications', 'Chats, events, galleries, announcements'];
      case 'announcements':
        return ['Announcements', 'From offices you follow'];
      case 'news':
        return ['University news', 'Updated weekly'];
      case 'criticism':
        return ['Report a problem', 'Goes to the responsible office'];
      default:
        return [null, null];
    }
  }

  ReportCat get reportCatObj =>
      kReportCats.firstWhere((c) => c.label == reportCat, orElse: () => kReportCats.first);
  String get reportOffice => reportCatObj.office;

  // =======================================================================
  // Mutations
  // =======================================================================
  void _set(VoidCallback fn) {
    fn();
    notifyListeners();
  }

  // onboarding / auth
  void startOnboard() => _set(() {
        stage = 'onboard';
        slide = 0;
      });
  void skipOnboard() => _set(() => stage = 'auth');
  void goAuth() => _set(() => stage = 'auth');
  void nextSlide() => _set(() {
        if (slide == kSlides.length - 1) {
          stage = 'auth';
        } else {
          slide += 1;
        }
      });
  void toggleAuthMode() => _set(() {
        authMode = authMode == 'in' ? 'up' : 'in';
        authError = '';
      });
  void setIdDraft(String v) => _set(() {
        idDraft = v;
        authError = '';
      });
  void setPwDraft(String v) => _set(() {
        pwDraft = v;
        authError = '';
      });
  void submitAuth() => _set(() {
        if (idDraft.trim().isEmpty || pwDraft.trim().isEmpty) {
          authError = 'Both fields are required.';
          return;
        }
        stage = 'setup';
        authError = '';
      });
  void setPickDept(String id) => _set(() => pickDept = id);
  void setPickYear(int y) => _set(() => pickYear = y);
  void enterApp() => _set(() {
        stage = 'app';
        tab = 'home';
      });

  // nav
  void setTab(String t) => _set(() {
        tab = t;
        overlay = null;
      });
  void openOverlay(String name,
          {String? deptId,
          String? placeId,
          String? postKind,
          String? postId,
          String? chatId,
          String? collectionId}) =>
      _set(() {
        overlay = name;
        openCourse = null;
        if (deptId != null) this.deptId = deptId;
        if (placeId != null) this.placeId = placeId;
        if (postKind != null) this.postKind = postKind;
        if (postId != null) this.postId = postId;
        if (chatId != null) this.chatId = chatId;
        if (collectionId != null) this.collectionId = collectionId;
      });
  void back() => _set(() {
        overlay = null;
        commentDraft = '';
        reportSent = false;
      });

  void openAnnouncementsBell() => openOverlay('notifs');
  void openPlacesTab() => _set(() {
        tab = 'campus';
        overlay = null;
      });
  void openHubsTab() => _set(() {
        tab = 'social';
        socialTab = 'hubs';
        overlay = null;
      });
  void openEventsTab() => _set(() {
        tab = 'social';
        socialTab = 'events';
        overlay = null;
      });
  void openLibraryFilter() => _set(() {
        tab = 'campus';
        placeFilter = 'Librarys';
        overlay = null;
      });
  void openGpaTab() => _set(() {
        tab = 'academics';
        overlay = null;
      });

  // notifications
  void setNotifFilter(String k) => _set(() => notifFilter = k);
  void markAllRead() => _set(() {
        for (final n in kNotifs) {
          read[n.id] = true;
        }
      });
  void openNotif(NotifItem n) => _set(() {
        read[n.id] = true;
        openCourse = null;
        final go = n.go;
        overlay = go.overlay;
        if (go.chatId != null) chatId = go.chatId;
        if (go.postKind != null) postKind = go.postKind;
        if (go.postId != null) postId = go.postId;
        if (go.collectionId != null) collectionId = go.collectionId;
      });

  // campus
  void setPlaceQuery(String v) => _set(() => placeQuery = v);
  void setPlaceFilter(String f) => _set(() => placeFilter = f);

  // social
  void setSocialTab(String t) => _set(() => socialTab = t);
  void toggleJoin(String hubId) =>
      _set(() => joined[hubId] = !(joined[hubId] ?? false));

  // schedule
  void setDay(String d) => _set(() => day = d);

  // academics
  void targetUp() =>
      _set(() => target = (min(4.0, double.parse((target + 0.1).toStringAsFixed(1)))));
  void targetDown() =>
      _set(() => target = (max(2.0, double.parse((target - 0.1).toStringAsFixed(1)))));
  void setDeadline(int n) => _set(() => deadline = n);
  void cycleGrade(int id) => _set(() {
        final c = courses.firstWhere((x) => x.id == id);
        c.grade = kGradeOrder[(kGradeOrder.indexOf(c.grade) + 1) % kGradeOrder.length];
      });
  void moreCredits(int id) =>
      _set(() => courses.firstWhere((x) => x.id == id).credits =
          min(8, courses.firstWhere((x) => x.id == id).credits + 1));
  void lessCredits(int id) =>
      _set(() => courses.firstWhere((x) => x.id == id).credits =
          max(1, courses.firstWhere((x) => x.id == id).credits - 1));
  void removeCourse(int id) => _set(() => courses.removeWhere((x) => x.id == id));
  void setNewCourse(String v) => _set(() => newCourse = v);
  void addCourse() => _set(() {
        final name = newCourse.trim();
        if (name.isEmpty) return;
        courses.add(CourseRow(_nextId, name, 3, 'B+'));
        _nextId += 1;
        newCourse = '';
      });
  void toggleStep(String key) => _set(() => steps[key] = !(steps[key] ?? false));

  // dept overlay
  void toggleCourse(String code) =>
      _set(() => openCourse = openCourse == code ? null : code);

  // post overlay
  void setCommentDraft(String v) => _set(() => commentDraft = v);
  void sendComment() => _set(() {
        final text = commentDraft.trim();
        if (text.isEmpty) return;
        final id = postId ??
            (postKind == 'event' ? kEvents.first.id : kGallery.first.id);
        (extraComments[id] ??= []).add(Comment('Natnael B.', 'now', text));
        commentDraft = '';
      });
  void toggleHeart(String id) => _set(() => hearts[id] = !(hearts[id] ?? false));
  void toggleReaction(String id, String key) => _set(() {
        final m = reactions[id] ??= {};
        m[key] = !(m[key] ?? false);
      });

  // chat overlay
  void setChatDraft(String v) => _set(() => chatDraft = v);
  void sendChat() => _set(() {
        final text = chatDraft.trim();
        if (text.isEmpty) return;
        final id = chatId ?? kChats.first.id;
        (extraMsgs[id] ??= []).add(ChatMsg(true, text, 'now'));
        chatDraft = '';
      });

  // add-by-code overlay
  void setCodeDraft(String v) => _set(() {
        codeDraft = v;
        codeStatus = '';
      });
  void addByCode() => _set(() {
        final t = codeDraft.trim();
        if (t.isEmpty) {
          codeStatus = 'Type a username first.';
          return;
        }
        final handle = t.startsWith('@') ? t : '@$t';
        codeStatus =
            'Chat request sent to $handle. They see it as a request, not a message.';
        codeDraft = '';
      });

  // report overlay
  void setReportCat(String label) => _set(() => reportCat = label);
  void setReportText(String v) => _set(() => reportText = v);
  void toggleAnon() => _set(() => anon = !anon);
  void submitReport() => _set(() {
        reportSent = true;
        reportText = '';
        ticket = '${4431 + _rng.nextInt(60)}';
      });

  List<ChatMsg> get chatMessages =>
      [...currentChat.messages, ...(extraMsgs[currentChat.id] ?? const [])];

  List<Comment> commentsFor(String id, List<Comment> base) =>
      [...base, ...(extraComments[id] ?? const [])];
}

/// Inherited access to the single [AppState].
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child})
      : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found in context');
    return scope!.notifier!;
  }
}
