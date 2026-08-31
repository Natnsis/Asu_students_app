import 'package:flutter/material.dart';
import 'theme.dart';

// ===========================================================================
// Models + static content, transcribed from the `data-dc-script` block of
// UniCore.dc.html.
// ===========================================================================

class PlaceStat {
  const PlaceStat(this.label, this.value);
  final String label;
  final String value;
}

class MenuEntry {
  const MenuEntry(this.name, this.note, this.price);
  final String name;
  final String note;
  final String price;
}

class Place {
  const Place({
    required this.id,
    required this.name,
    required this.kind,
    required this.walk,
    required this.note,
    required this.temp,
    required this.busy,
    required this.busyN,
    required this.hours,
    required this.tint,
    required this.long,
    required this.where,
    required this.quiet,
    this.hasMenu = false,
    required this.stats,
    this.menu = const [],
  });

  final String id, name, kind, walk, note, temp, busy, hours, long, where, quiet;
  final int busyN;
  final Color tint;
  final bool hasMenu;
  final List<PlaceStat> stats;
  final List<MenuEntry> menu;

  Color get busyColor =>
      busyN > 75 ? kAccent : (busyN > 50 ? const Color(0xFF8A6A16) : const Color(0xFF4A6B45));
}

const kPlaces = <Place>[
  Place(
    id: 'lib1',
    name: 'Main Library — Silent Wing',
    kind: 'Library',
    walk: '4 min',
    note: 'Level 3, north end',
    temp: '21°C',
    busy: 'Calm · 34%',
    busyN: 34,
    hours: 'Open until 22:00',
    tint: kPeriTint,
    long:
        'The quietest room on campus. Individual carrels with dividers, no group tables, phones off at the door.',
    where: 'Library Building, Level 3 north',
    quiet:
        'Carrels 41–58 face the wall — nobody can see your screen, and nobody will ask to sit with you.',
    stats: [PlaceStat('Temp', '21°C'), PlaceStat('Seats free', '112'), PlaceStat('Noise', 'Low')],
  ),
  Place(
    id: 'caf1',
    name: 'Acacia Coffee',
    kind: 'Cafe',
    walk: '2 min',
    note: 'Behind the Science Block',
    temp: '24°C',
    busy: 'Busy · 78%',
    busyN: 78,
    hours: '07:00 – 19:00',
    tint: kPink,
    long:
        'Cheapest macchiato within walking distance, and the only place with sockets at every table.',
    where: 'Science Block courtyard',
    quiet: 'The back bench by the window fits one person and gets ignored until 4pm.',
    hasMenu: true,
    stats: [PlaceStat('Temp', '24°C'), PlaceStat('Wait', '6 min'), PlaceStat('Noise', 'High')],
    menu: [
      MenuEntry('Macchiato', 'Ethiopian single origin', '35 br'),
      MenuEntry('Buna & sambusa', 'Two pieces', '50 br'),
      MenuEntry('Firfir', 'Served till 11:00', '90 br'),
      MenuEntry('Avocado juice', 'Layered', '60 br'),
    ],
  ),
  Place(
    id: 'lounge1',
    name: 'Block C Student Lounge',
    kind: 'Lounge',
    walk: '6 min',
    note: 'Ground floor, west',
    temp: '23°C',
    busy: 'Filling · 61%',
    busyN: 61,
    hours: 'Open 24h',
    tint: kButterTint,
    long:
        'Beanbags, a projector nobody books, and the department noticeboard that actually gets updated.',
    where: 'Block C, ground floor west',
    quiet: 'Mornings before 9:00 it is empty — good for a first visit.',
    stats: [PlaceStat('Temp', '23°C'), PlaceStat('Seats free', '18'), PlaceStat('Noise', 'Medium')],
  ),
  Place(
    id: 'lib2',
    name: 'Engineering Reading Room',
    kind: 'Library',
    walk: '9 min',
    note: 'Attached to Lab 2',
    temp: '20°C',
    busy: 'Calm · 22%',
    busyN: 22,
    hours: 'Open until 20:00',
    tint: kPeriTint,
    long:
        'Reference-only engineering stacks, huge tables, and the best afternoon light on campus.',
    where: 'Engineering Faculty, 1st floor',
    quiet: 'Almost always under a quarter full. Sit anywhere.',
    stats: [PlaceStat('Temp', '20°C'), PlaceStat('Seats free', '74'), PlaceStat('Noise', 'Low')],
  ),
  Place(
    id: 'caf2',
    name: 'Self Cafe (Main Hall)',
    kind: 'Cafe',
    walk: '3 min',
    note: 'Subsidised meals',
    temp: '26°C',
    busy: 'Packed · 92%',
    busyN: 92,
    hours: 'Meals 07:00 / 12:00 / 18:00',
    tint: kPink,
    long:
        'The university cafeteria. Fixed weekly menu, student card only, queue moves fast after the first 20 minutes.',
    where: 'Main Hall, east entrance',
    quiet: 'Go at 13:20 — the rush is gone and the food is still out.',
    hasMenu: true,
    stats: [PlaceStat('Temp', '26°C'), PlaceStat('Queue', '11 min'), PlaceStat('Noise', 'High')],
    menu: [
      MenuEntry('Lunch (today)', 'Shiro, injera, salad', 'Card'),
      MenuEntry('Dinner (today)', 'Pasta & lentil sauce', 'Card'),
      MenuEntry('Fasting tray', 'Wed & Fri', 'Card'),
    ],
  ),
  Place(
    id: 'lounge2',
    name: 'Rooftop Garden Terrace',
    kind: 'Lounge',
    walk: '7 min',
    note: 'Above the Library',
    temp: '19°C',
    busy: 'Calm · 15%',
    busyN: 15,
    hours: '06:00 – 18:30',
    tint: kButterTint,
    long:
        'Open-air benches, shade sails, and a view of the whole quad. No wifi, which is the point.',
    where: 'Library Building roof, stair D',
    quiet: 'Barely anyone knows the stair D door is unlocked.',
    stats: [PlaceStat('Temp', '19°C'), PlaceStat('Seats free', '26'), PlaceStat('Noise', 'Low')],
  ),
];

class CatalogCourse {
  const CatalogCourse(this.code, this.name, this.credits, this.desc);
  final String code;
  final String name;
  final int credits;
  final String desc;
}

class Department {
  const Department({
    required this.id,
    required this.name,
    required this.color,
    required this.years,
    required this.load,
    required this.cutoff,
    required this.blurb,
    required this.long,
    required this.careers,
    required this.courses,
  });
  final String id, name, years, load, cutoff, blurb, long;
  final Color color;
  final List<String> careers;
  final List<CatalogCourse> courses;
}

const kDepartments = <Department>[
  Department(
    id: 'cs',
    name: 'Computer Science',
    color: kPeriTint,
    years: '4 years',
    load: '148 credits',
    cutoff: 'Entry 520+',
    blurb:
        'Software, algorithms, systems. Heaviest maths load in the first two years, most job openings after.',
    long:
        'You spend Year 1 on maths and programming fundamentals, Year 2 on data structures and systems, then specialise: AI, networks, or software engineering. Expect four labs a week.',
    careers: ['Software engineer', 'Data analyst', 'DevOps', 'ML engineer', 'Founder'],
    courses: [
      CatalogCourse('CS201', 'Data Structures II', 4,
          'Trees, graphs, hashing and amortised analysis. Weekly implementation labs in C. The course most students say separates people who keep coding from people who stop.'),
      CatalogCourse('CS204', 'Computer Organisation', 3,
          'From logic gates up to assembly and the memory hierarchy. You build a small CPU simulator as the final project.'),
      CatalogCourse('MTH210', 'Discrete Mathematics', 3,
          'Logic, proof technique, combinatorics, graph theory. Directly feeds algorithm analysis next semester.'),
      CatalogCourse('CS208', 'Object-Oriented Programming', 4,
          'Java, design patterns, testing and version control. First course with a real team project and code review.'),
      CatalogCourse('CS230', 'Intro to Databases', 3,
          'Relational modelling, SQL, normalisation and transactions. Ends with a small full-stack app against Postgres.'),
    ],
  ),
  Department(
    id: 'eng',
    name: 'Civil Engineering',
    color: kButterTint,
    years: '5 years',
    load: '182 credits',
    cutoff: 'Entry 540+',
    blurb:
        'Structures, water, transport. Long studio hours, strong government and contractor demand.',
    long:
        'Mechanics and materials early, then structural design, geotechnics and site management. Two mandatory site internships before graduation.',
    careers: ['Site engineer', 'Structural designer', 'Water resources', 'Project manager'],
    courses: [
      CatalogCourse('CE202', 'Strength of Materials', 4,
          'Stress, strain, torsion and beam deflection. Heavy problem sets; the lab work is genuinely satisfying.'),
      CatalogCourse('CE210', 'Fluid Mechanics', 3,
          'Statics, flow in pipes and open channels. Feeds water-resources design in Year 3.'),
      CatalogCourse('CE221', 'Surveying', 3,
          'Levelling, traversing and total-station work. Half the course happens outdoors on the north field.'),
    ],
  ),
  Department(
    id: 'med',
    name: 'Medicine',
    color: kPink,
    years: '6 years',
    load: '240 credits',
    cutoff: 'Entry 590+',
    blurb:
        'Pre-clinical then hospital rotations. The longest programme here, and the least free time.',
    long:
        'Two pre-clinical years of anatomy, physiology and biochemistry, then clerkships across internal medicine, surgery, paediatrics and community health.',
    careers: ['General practitioner', 'Specialist residency', 'Public health', 'Research'],
    courses: [
      CatalogCourse('MD101', 'Human Anatomy I', 6,
          'Regional anatomy with cadaver dissection. Attendance is non-negotiable and the practical exams are oral.'),
      CatalogCourse('MD115', 'Physiology', 5,
          'Organ systems, homeostasis and clinical correlations. Pairs with anatomy across the whole year.'),
    ],
  ),
  Department(
    id: 'bus',
    name: 'Business & Economics',
    color: kSageTint,
    years: '4 years',
    load: '140 credits',
    cutoff: 'Entry 470+',
    blurb:
        'Accounting, management, economics. Lightest lab load, most group work, widest exit options.',
    long:
        'Core accounting and micro/macro first, then a track: finance, marketing or management. A live consulting project with a local firm in Year 4.',
    careers: ['Analyst', 'Accountant', 'Marketing', 'Banking', 'Entrepreneur'],
    courses: [
      CatalogCourse('ACC101', 'Financial Accounting', 3,
          'The full cycle from journal entries to statements. Rote at first, indispensable later.'),
      CatalogCourse('ECO120', 'Microeconomics', 3,
          'Consumer and firm behaviour, market structure, welfare. Graph-heavy, exam-heavy.'),
    ],
  ),
  Department(
    id: 'arch',
    name: 'Architecture',
    color: kPeriTint,
    years: '5 years',
    load: '176 credits',
    cutoff: 'Entry 530+',
    blurb:
        'Studio-based. You will live in the studio, and portfolio beats GPA on the way out.',
    long:
        'Design studio every semester, with history, structures and environmental systems alongside. Reviews are public and blunt.',
    careers: ['Architect', 'Urban designer', 'Interior design', 'Heritage'],
    courses: [
      CatalogCourse('AR201', 'Design Studio III', 6,
          'A public building on a real site. Weekly pin-ups, one final jury. Model-making costs are on you.'),
      CatalogCourse('AR215', 'History of Architecture', 2,
          'Antiquity to modernism, with an Ethiopian and East African focus in the second half.'),
    ],
  ),
];

class ClassSlot {
  const ClassSlot(this.start, this.end, this.name, this.room, this.teacher, this.type, this.color);
  final String start, end, name, room, teacher, type;
  final Color color;
}

const _cOrg = Color(0xFFC9502F);
const kSchedule = <String, List<ClassSlot>>{
  'Mon': [
    ClassSlot('08:30', '10:00', 'Discrete Mathematics', 'A-118', 'Dr. Yared', 'Lecture', kPeri),
    ClassSlot('10:00', '11:30', 'Data Structures II', 'B-204', 'Dr. Alemu', 'Lecture', kCoral),
    ClassSlot('14:00', '17:00', 'OOP Lab', 'Lab 4', 'Mr. Kebede', 'Lab · bring laptop', kSage),
  ],
  'Tue': [
    ClassSlot('10:00', '11:30', 'Data Structures II', 'B-204', 'Dr. Alemu', 'Lecture', kCoral),
    ClassSlot('11:30', '13:00', 'Computer Organisation', 'A-210', 'Dr. Sara', 'Lecture', _cOrg),
    ClassSlot('15:00', '16:30', 'Intro to Databases', 'B-101', 'Ms. Hiwot', 'Lecture', kPeri),
  ],
  'Wed': [
    ClassSlot('08:30', '11:30', 'Data Structures Lab', 'Lab 2', 'Mr. Kebede', 'Lab · graded', kSage),
    ClassSlot('14:00', '15:30', 'Discrete Mathematics', 'A-118', 'Dr. Yared', 'Tutorial', kPeri),
  ],
  'Thu': [
    ClassSlot('09:00', '10:30', 'Object-Oriented Programming', 'B-306', 'Mr. Kebede', 'Lecture', kButter),
    ClassSlot('13:00', '14:30', 'Computer Organisation', 'A-210', 'Dr. Sara', 'Tutorial', _cOrg),
  ],
  'Fri': [
    ClassSlot('08:30', '10:00', 'Intro to Databases', 'B-101', 'Ms. Hiwot', 'Lecture', kPeri),
    ClassSlot('10:30', '13:00', 'Database Lab', 'Lab 1', 'Ms. Hiwot', 'Lab', kSage),
  ],
};

class Meal {
  const Meal(this.slot, this.food);
  final String slot;
  final String food;
}

class WeekDay {
  const WeekDay(this.day, this.tag, this.meals);
  final String day;
  final String tag;
  final List<Meal> meals;
}

const kWeek = <WeekDay>[
  WeekDay('Monday', 'Today', [
    Meal('Breakfast', 'Firfir, bread & tea'),
    Meal('Lunch', 'Shiro, injera & salad'),
    Meal('Dinner', 'Pasta with lentil sauce'),
  ]),
  WeekDay('Tuesday', '', [
    Meal('Breakfast', 'Kinche & tea'),
    Meal('Lunch', 'Doro alicha, rice'),
    Meal('Dinner', 'Misir wot, injera'),
  ]),
  WeekDay('Wednesday', 'Fasting', [
    Meal('Breakfast', 'Fatira, tea'),
    Meal('Lunch', 'Beyaynetu (full fasting tray)'),
    Meal('Dinner', 'Atkilt wot, injera'),
  ]),
  WeekDay('Thursday', '', [
    Meal('Breakfast', 'Bread, egg & tea'),
    Meal('Lunch', 'Key wot, injera'),
    Meal('Dinner', 'Rice, vegetable stew'),
  ]),
  WeekDay('Friday', 'Fasting', [
    Meal('Breakfast', 'Kinche & tea'),
    Meal('Lunch', 'Shiro fitfit'),
    Meal('Dinner', 'Pasta, tomato sauce'),
  ]),
  WeekDay('Saturday', 'Brunch only', [
    Meal('Brunch', 'Chechebsa & tea, 09:00–11:00'),
    Meal('Dinner', 'Tibs, injera'),
  ]),
  WeekDay('Sunday', 'Late start', [
    Meal('Brunch', 'Doro wot, injera, 11:00'),
    Meal('Dinner', 'Soup & bread'),
  ]),
];

class Comment {
  const Comment(this.who, this.when, this.text);
  final String who, when, text;
}

class GalleryItem {
  const GalleryItem({
    required this.id,
    required this.col,
    required this.title,
    required this.meta,
    required this.h,
    required this.hearts,
    required this.body,
    this.comments = const [],
  });
  final String id, col, title, meta, body;
  final double h;
  final int hearts;
  final List<Comment> comments;
}

const kGallery = <GalleryItem>[
  GalleryItem(
    id: 'g1',
    col: 'grad',
    title: 'Class of 2024 walking out',
    meta: 'Alumni Office · 3 days ago',
    h: 190,
    hearts: 214,
    body:
        'Six hundred graduates, one very long queue for photos by the fountain. Full album is up.',
    comments: [
      Comment('Meron A.', '2d', 'That last shot of the quad is unreal.'),
      Comment('Dawit', '1d', 'Whoever organised the queue — thank you.'),
    ],
  ),
  GalleryItem(
    id: 'g2',
    col: 'comp',
    title: 'Robotics finals, 2nd place',
    meta: 'CS Department · 1 week ago',
    h: 150,
    hearts: 168,
    body:
        'Our line-follower lost by 0.4 seconds. Team is already rebuilding the chassis for next year.',
    comments: [Comment('Sami', '5d', 'The gearbox was the problem, not the code.')],
  ),
  GalleryItem(
    id: 'g3',
    col: 'life',
    title: 'Freshman welcome week',
    meta: 'Student Union · 2 weeks ago',
    h: 150,
    hearts: 97,
    body:
        'Tents, terrible name games, surprisingly good coffee. If you missed it, the hubs are still open.',
    comments: [Comment('Bethel', '9d', 'Came alone, left with a study group. Worth it.')],
  ),
  GalleryItem(
    id: 'g4',
    col: 'life',
    title: 'Night of the rain, Block C',
    meta: 'Yohannes T. · 3 weeks ago',
    h: 190,
    hearts: 141,
    body:
        'Power cut, everyone stuck in the lounge, someone brought a guitar. Best evening of the semester.',
  ),
];

const kGallery2 = <GalleryItem>[
  GalleryItem(
    id: 'g5',
    col: 'grad',
    title: 'Hoods and hats, Faculty of Science',
    meta: 'Alumni Office · 3 days ago',
    h: 150,
    hearts: 132,
    body:
        'The science faculty went first this year. Someone will find their tassel in the fountain eventually.',
  ),
  GalleryItem(
    id: 'g6',
    col: 'grad',
    title: 'Families on the lawn',
    meta: 'Alumni Office · 4 days ago',
    h: 190,
    hearts: 88,
    body:
        'Four hundred families, one lawn, zero complaints. The best photos of the day were the unposed ones.',
  ),
  GalleryItem(
    id: 'g7',
    col: 'comp',
    title: 'Debate finals, national round',
    meta: 'Debate Club · 2 weeks ago',
    h: 190,
    hearts: 76,
    body:
        'Third year running in the national final. The motion was on public transport subsidies.',
  ),
  GalleryItem(
    id: 'g8',
    col: 'comp',
    title: 'Bridge-building contest',
    meta: 'Civil Engineering · 3 weeks ago',
    h: 150,
    hearts: 104,
    body:
        'Balsa, glue, and 14 kg before the winning bridge cracked. Video of the failures is in the hub.',
  ),
  GalleryItem(
    id: 'g9',
    col: 'life',
    title: 'Coffee ceremony in Block C',
    meta: 'Student Union · 1 week ago',
    h: 150,
    hearts: 119,
    body:
        'Every Friday at 16:00, free, no signup. Sit down, take a cup, nobody will make you introduce yourself.',
    comments: [Comment('Bethel', '3d', 'Went alone twice. Nobody minded. Recommend.')],
  ),
  GalleryItem(
    id: 'g10',
    col: 'life',
    title: 'Rain on the quad',
    meta: 'Yohannes T. · 2 weeks ago',
    h: 190,
    hearts: 64,
    body: 'Nine minutes of downpour, then the light came back. Shot from the library steps.',
  ),
  GalleryItem(
    id: 'g11',
    col: 'sport',
    title: 'Semi-final, away leg',
    meta: 'Sports Office · 5 days ago',
    h: 190,
    hearts: 187,
    body:
        'Two buses of students, one goal, extra time. First semi in nine years and it showed on every face.',
  ),
  GalleryItem(
    id: 'g12',
    col: 'sport',
    title: 'Inter-department athletics',
    meta: 'Sports Office · 2 weeks ago',
    h: 150,
    hearts: 71,
    body: 'Medicine took the relay, Engineering took everything else. CS entered chess.',
  ),
];

List<GalleryItem> get kAllGallery => [...kGallery, ...kGallery2];

class Collection {
  const Collection(this.id, this.name, this.tint, this.sub, this.note);
  final String id, name, sub, note;
  final Color tint;
}

const kCollections = <Collection>[
  Collection('grad', 'Graduation 2024', kPink, 'Alumni Office',
      'Six hundred graduates across two days. Full-resolution downloads open to the class.'),
  Collection('comp', 'Competitions', kPeriTint, 'Clubs & departments',
      'Robotics, debate, bridges. Every entry from this academic year.'),
  Collection('life', 'Everyday campus', kSageTint, 'Students',
      'Ordinary afternoons, posted by students. The easiest place to start commenting.'),
  Collection('sport', 'Sport', kButterTint, 'Sports Office',
      'Football, athletics and the long bus rides in between.'),
];

class EventItem {
  const EventItem({
    required this.id,
    required this.title,
    required this.when,
    required this.place,
    required this.going,
    required this.body,
    this.comments = const [],
  });
  final String id, title, when, place, body;
  final int going;
  final List<Comment> comments;
}

const kEvents = <EventItem>[
  EventItem(
    id: 'e1',
    title: 'Career Fair: 40 employers',
    when: 'Thu · 09:00',
    place: 'Main Hall',
    going: 312,
    body:
        'Bring twelve printed CVs. Software, construction and banking are the biggest floors. Dress code is smart-casual, nobody will turn you away.',
    comments: [
      Comment('Liya', '4h', 'Are internships open to 2nd years?'),
      Comment('Career Office', '2h', 'Yes — three firms take Year 2 interns this cycle.'),
    ],
  ),
  EventItem(
    id: 'e2',
    title: 'Hackathon: 36 hours',
    when: 'Sat · 18:00',
    place: 'Lab 4 & Block C',
    going: 128,
    body:
        'Teams of four, any stack. Food covered both nights. Beginner track has mentors — you do not need to be good yet.',
    comments: [Comment('Natnael', '1d', 'Looking for one more person for a team. Comment if in.')],
  ),
  EventItem(
    id: 'e3',
    title: 'Quiet Study Marathon',
    when: 'Sun · 10:00',
    place: 'Silent Wing',
    going: 74,
    body:
        'Six hours, no talking, free tea at every break. No introductions, no icebreakers. Just sit and work near people.',
  ),
  EventItem(
    id: 'e4',
    title: 'Departmental Culture Night',
    when: 'Fri · 19:00',
    place: 'Rooftop Terrace',
    going: 205,
    body:
        'Food from nine regions, live music, and the annual dance competition between departments. CS has lost four years running.',
    comments: [Comment('Selam', '6h', 'This is the year we win.')],
  ),
];

class Hub {
  const Hub(this.id, this.name, this.meta, this.tint, this.badge);
  final String id, name, meta, badge;
  final Color tint;
}

const kHubs = <Hub>[
  Hub('h1', 'CS Year 2 — Official', 'Telegram · 412 members · notes & past papers', kPeriTint, 'CS2'),
  Hub('h2', 'Quiet Study Buddies', 'Telegram · 96 members · no small talk allowed', kSageTint, 'QSB'),
  Hub('h3', 'UniCore Photography', 'Instagram · 1.2k · campus shoots every Sunday', kPink, 'PHO'),
  Hub('h4', 'Housing & Roommates', 'Telegram · 780 members · verified listings', kButterTint, 'HSE'),
  Hub('h5', 'Women in Engineering', 'WhatsApp · 240 members · mentorship pairs', kPeriTint, 'WIE'),
  Hub('h6', 'Freshers 2016 E.C.', 'Telegram · 1.5k members · ask anything, anonymously', kPink, 'NEW'),
];

class ChatMsg {
  const ChatMsg(this.mine, this.text, this.time);
  final bool mine;
  final String text, time;
}

class ChatThread {
  const ChatThread(this.id, this.name, this.initials, this.tint, this.time, this.last, this.messages);
  final String id, name, initials, time, last;
  final Color tint;
  final List<ChatMsg> messages;
}

const kChats = <ChatThread>[
  ChatThread('c1', 'Meron A.', 'MA', kPink, '09:12', 'did you finish the graph lab?', [
    ChatMsg(false, 'did you finish the graph lab?', '09:10'),
    ChatMsg(true, 'BFS part yes, Dijkstra no', '09:11'),
    ChatMsg(false, 'same. library at 4? silent wing, no talking, just sitting', '09:12'),
  ]),
  ChatThread('c2', 'Hackathon Team', 'HT', kPeriTint, 'Yesterday', 'Natnael: I can do the backend', [
    ChatMsg(false, 'we still need a 4th', '19:02'),
    ChatMsg(true, 'I can do the backend', '19:20'),
    ChatMsg(false, 'perfect. Sat 18:00, Lab 4', '19:22'),
  ]),
  ChatThread('c3', 'Dawit (from Gallery)', 'DK', kSageTint, 'Mon', 'you took the rooftop photo right?', [
    ChatMsg(false, 'you took the rooftop photo right? saw your comment', 'Mon'),
    ChatMsg(true, 'yeah, stair D at sunset', 'Mon'),
  ]),
  ChatThread('c4', 'Ms. Hiwot (DB course)', 'MH', kButterTint, 'Sun', 'Office hours moved to Wed 15:00', [
    ChatMsg(false, 'Office hours moved to Wed 15:00 this week.', 'Sun'),
  ]),
];

class Announcement {
  const Announcement(this.from, this.when, this.title, this.body, this.bg, this.bc, this.fromColor);
  final String from, when, title, body;
  final Color bg, bc, fromColor;
}

const kAnnouncements = <Announcement>[
  Announcement('Registrar', '2h ago', 'Add/drop closes Friday 5:00 PM',
      'Forms submitted after the deadline need a dean signature and a written reason. The online portal locks itself at 17:00 sharp.',
      kPink, Color(0xFFF0BCA9), Color(0xFF9E3B1D)),
  Announcement('Library', 'Today', 'Silent Wing closes early Saturday',
      'Electrical maintenance from 14:00. Engineering Reading Room stays open until 20:00 as usual.',
      kCard, kLine, Color(0xFF3B45A8)),
  Announcement('Student Services', 'Yesterday', 'Cafeteria cards recharge online now',
      'No more queueing at Window 3. Recharge through the app or any bank app using your student ID as reference.',
      kCard, kLine, Color(0xFF4A6B45)),
  Announcement('CS Department', '2 days ago', 'Data Structures II mid-exam: Mar 29',
      'Covers trees through hashing. Open notes, no laptops. Room assignments posted on the Block B noticeboard Thursday.',
      kButterTint, Color(0xFFEBD59B), Color(0xFF7A5B10)),
  Announcement('Health Centre', '3 days ago', 'Free counselling slots, no referral needed',
      'Walk in Mon–Thu 09:00–16:00, or book anonymously through the app. Twenty-minute first sessions.',
      kCard, kLine, Color(0xFF3B45A8)),
];

class NewsItem {
  const NewsItem(this.tag, this.title, this.body);
  final String tag, title, body;
}

const kNews = <NewsItem>[
  NewsItem('Campus', 'New 400-seat reading hall breaks ground in May',
      'Built on the old parking lot behind the Library. Twenty-four hour access is in the plan, according to the facilities office.'),
  NewsItem('Research', 'Water lab wins national grant for river monitoring',
      'Three-year funding, and eight undergraduate research assistant positions opening to Year 2 and above.'),
  NewsItem('Sport', 'Football team through to the inter-university semis',
      'First semi-final appearance in nine years. Free student buses to the away leg, sign up at the Union desk.'),
  NewsItem('Student life', 'Union votes to extend lounge hours to 24/7',
      'Block C and the Engineering lounge stay open all night from next semester, with a security desk added at both.'),
];

class ReportCat {
  const ReportCat(this.label, this.office);
  final String label, office;
}

const kReportCats = <ReportCat>[
  ReportCat('Facilities', 'Facilities Office'),
  ReportCat('Safety', 'Campus Security'),
  ReportCat('Teaching', 'Academic Dean'),
  ReportCat('Harassment', 'Gender Office'),
  ReportCat('Cafeteria', 'Student Services'),
  ReportCat('Corruption', "President's Office"),
];

class MyReport {
  const MyReport(this.id, this.cat, this.status, this.text, this.statusBg, this.statusFg);
  final String id, cat, status, text;
  final Color statusBg, statusFg;
}

const kMyReports = <MyReport>[
  MyReport('4417', 'Facilities', 'Fixed',
      'Broken window in Lab 2 — rain gets onto the desks nearest the wall.', kSageTint, Color(0xFF2F5C29)),
  MyReport('4402', 'Safety', 'In review',
      'No lighting on the path between Block C and the south gate after 19:00.', kButterTint, Color(0xFF7A5B10)),
  MyReport('4388', 'Cafeteria', 'Answered',
      'Fasting tray ran out before 13:00 three Wednesdays in a row.', kPeriTint, Color(0xFF3B45A8)),
];

class NotifGo {
  const NotifGo(this.overlay, {this.chatId, this.postKind, this.postId, this.collectionId});
  final String overlay;
  final String? chatId, postKind, postId, collectionId;
}

class NotifItem {
  const NotifItem({
    required this.id,
    required this.kind,
    required this.when,
    required this.title,
    required this.body,
    required this.tint,
    required this.kindColor,
    required this.unread,
    required this.icon,
    required this.go,
  });
  final String id, kind, when, title, body;
  final Color tint, kindColor;
  final bool unread;
  final IconData icon;
  final NotifGo go;
}

const kNotifs = <NotifItem>[
  NotifItem(
    id: 'n1',
    kind: 'Chat',
    when: '9:12',
    title: 'Meron A. sent you a message',
    body: '“library at 4? silent wing, no talking, just sitting”',
    tint: kPeriTint,
    kindColor: Color(0xFF3B45A8),
    unread: true,
    icon: Icons.chat_bubble_outline,
    go: NotifGo('chat', chatId: 'c1'),
  ),
  NotifItem(
    id: 'n2',
    kind: 'Announcement',
    when: '2h',
    title: 'Add/drop closes Friday 5:00 PM',
    body: 'Registrar · late forms need a dean signature.',
    tint: kPink,
    kindColor: Color(0xFF9E3B1D),
    unread: true,
    icon: Icons.notifications_none,
    go: NotifGo('announcements'),
  ),
  NotifItem(
    id: 'n3',
    kind: 'Gallery',
    when: '4h',
    title: 'Dawit replied to your comment',
    body: 'On “Night of the rain, Block C” — “you took the rooftop photo right?”',
    tint: kSageTint,
    kindColor: Color(0xFF2F5C29),
    unread: true,
    icon: Icons.image_outlined,
    go: NotifGo('post', postKind: 'gallery', postId: 'g4'),
  ),
  NotifItem(
    id: 'n4',
    kind: 'Event',
    when: 'Today',
    title: 'Career Fair starts in 2 days',
    body: 'Thu 09:00, Main Hall. Three firms take Year 2 interns.',
    tint: kButterTint,
    kindColor: Color(0xFF7A5B10),
    unread: false,
    icon: Icons.event_outlined,
    go: NotifGo('post', postKind: 'event', postId: 'e1'),
  ),
  NotifItem(
    id: 'n5',
    kind: 'Gallery',
    when: 'Yesterday',
    title: 'New collection: Sport',
    body: '2 photos added by the Sports Office.',
    tint: kSageTint,
    kindColor: Color(0xFF2F5C29),
    unread: false,
    icon: Icons.image_outlined,
    go: NotifGo('collection', collectionId: 'sport'),
  ),
  NotifItem(
    id: 'n6',
    kind: 'Chat',
    when: 'Yesterday',
    title: 'Hackathon Team · 3 new messages',
    body: '“perfect. Sat 18:00, Lab 4”',
    tint: kPeriTint,
    kindColor: Color(0xFF3B45A8),
    unread: false,
    icon: Icons.chat_bubble_outline,
    go: NotifGo('chat', chatId: 'c2'),
  ),
  NotifItem(
    id: 'n7',
    kind: 'Event',
    when: '2 days',
    title: 'Quiet Study Marathon — 74 going',
    body: 'Sun 10:00, Silent Wing. No introductions, no icebreakers.',
    tint: kButterTint,
    kindColor: Color(0xFF7A5B10),
    unread: false,
    icon: Icons.event_outlined,
    go: NotifGo('post', postKind: 'event', postId: 'e3'),
  ),
  NotifItem(
    id: 'n8',
    kind: 'Announcement',
    when: '3 days',
    title: 'Free counselling slots, no referral',
    body: 'Health Centre · walk in Mon–Thu, or book anonymously.',
    tint: kPink,
    kindColor: Color(0xFF9E3B1D),
    unread: false,
    icon: Icons.notifications_none,
    go: NotifGo('announcements'),
  ),
];

class TabDef {
  const TabDef(this.id, this.label, this.icon, this.activeIcon);
  final String id, label;
  final IconData icon, activeIcon;
}

const kTabs = <TabDef>[
  TabDef('home', 'Home', Icons.home_outlined, Icons.home),
  TabDef('campus', 'Campus', Icons.place_outlined, Icons.place),
  TabDef('academics', 'Grades', Icons.insert_chart_outlined, Icons.insert_chart),
  TabDef('social', 'Together', Icons.groups_outlined, Icons.groups),
  TabDef('me', 'Me', Icons.person_outline, Icons.person),
];

/// 7×7 QR-ish grid for the "Add by code" overlay.
const kQr = [
  1, 0, 1, 1, 0, 1, 1, //
  0, 1, 0, 1, 1, 0, 0,
  1, 1, 1, 0, 0, 1, 1,
  0, 0, 1, 1, 0, 1, 0,
  1, 0, 1, 0, 1, 1, 1,
  1, 1, 0, 1, 1, 0, 0,
  0, 1, 1, 0, 1, 1, 1,
];

class OnboardSlide {
  const OnboardSlide(this.badge, this.title, this.bodyText, this.tint);
  final String badge, title, bodyText;
  final Color tint;
}

const kSlides = <OnboardSlide>[
  OnboardSlide('Campus, live', 'Know before you walk over.',
      'Temperature, free seats, queue length and noise for every library, cafe and lounge. Cafeteria menu posted a week ahead.',
      kPeriTint),
  OnboardSlide('Your academics', 'Grades, without the guesswork.',
      'Your schedule by year and department, a GPA calculator that takes credit hours, and the exact average you need to reach a target.',
      kButterTint),
  OnboardSlide('Together, gently', 'Arrive at your own pace.',
      'Join hubs and read for weeks before you say anything. Comment on a photo, then chat one-to-one when you feel like it.',
      kSageTint),
];

class CareerStep {
  const CareerStep(this.key, this.title, this.detail);
  final String key, title, detail;
}

const kCareerSteps = <CareerStep>[
  CareerStep('s1', 'Write code every week, however small',
      'Twenty commits beats one perfect project. Start with the lab exercises you already have.'),
  CareerStep('s2', 'Put three projects on GitHub',
      'A CLI tool, something with a database, something with an API. README in plain English.'),
  CareerStep('s3', 'Solve 100 algorithm problems',
      'Arrays and strings first. This is what the interviews are, fairly or not.'),
  CareerStep('s4', 'Do one internship before Year 4',
      'Career Fair on Thursday takes Year 2 interns at three firms.'),
  CareerStep('s5', 'Contribute to one open-source repo',
      'Documentation fixes count. It proves you can read code you did not write.'),
];

class QuickAction {
  const QuickAction(this.label, this.tint, this.icon);
  final String label;
  final Color tint;
  final IconData icon;
}

class MeRow {
  const MeRow(this.label, this.sub, this.tint, this.icon, this.overlay, {this.deptId});
  final String label, sub, overlay;
  final Color tint;
  final IconData icon;
  final String? deptId;
}

const kMeRows = <MeRow>[
  MeRow('Notifications', 'Chats, events, galleries, offices', kPink, Icons.notifications_none, 'notifs'),
  MeRow('Announcements', 'From offices you follow', kPeriTint, Icons.campaign_outlined, 'announcements'),
  MeRow('University news', 'Reading hall, grants, football', kPeriTint, Icons.article_outlined, 'news'),
  MeRow('Departments', 'Compare before you switch', kSageTint, Icons.account_balance_outlined, 'departments'),
  MeRow('My courses', 'CS · 5 this semester', kButterTint, Icons.menu_book_outlined, 'dept', deptId: 'cs'),
  MeRow('My reports', '1 in review, 1 fixed', kPink, Icons.flag_outlined, 'criticism'),
];
