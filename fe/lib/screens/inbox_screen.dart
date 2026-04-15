import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/report.dart';
import 'report_detail_screen.dart';
<<<<<<< HEAD
import '../widgets/sapa_hse_header.dart';


=======

// ── Dummy current user (same as profile) ─────────────────────────────────────
const String _currentUser = 'Noor Lintang Bhaskara';
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86

// ── Dummy announcements ───────────────────────────────────────────────────────
class Announcement {
  final String id;
  final String title;
  final String body;
  final String from;
  final DateTime createdAt;

  const Announcement({
    required this.id,
    required this.title,
    required this.body,
    required this.from,
    required this.createdAt,
  });
}

final List<Announcement> dummyAnnouncements = [
  Announcement(
    id: 'a1',
    title: 'Pelatihan K3 Wajib Maret 2026',
    body: 'Seluruh karyawan diwajibkan mengikuti pelatihan K3 pada tanggal 28 Maret 2026 pukul 08.00 di Aula Utama. Kehadiran bersifat wajib.',
    from: 'Admin HSE',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  Announcement(
    id: 'a2',
    title: 'Inspeksi Rutin Area Tambang',
    body: 'Akan dilaksanakan inspeksi rutin menyeluruh di seluruh area tambang pada minggu ini. Harap semua peralatan dalam kondisi siap periksa.',
    from: 'Supervisor K3',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Announcement(
    id: 'a3',
    title: 'Update SOP Penanganan Bahan B3',
    body: 'SOP penanganan limbah B3 telah diperbarui sesuai regulasi KLHK terbaru. Silakan unduh dokumen terbaru di portal internal perusahaan.',
    from: 'Admin HSE',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Announcement(
    id: 'a4',
    title: 'Jadwal Pemeriksaan APAR Bulanan',
    body: 'Pemeriksaan APAR bulanan akan dilaksanakan pada 30 Maret 2026. Pastikan semua unit APAR di area tanggung jawab Anda dalam kondisi baik.',
    from: 'Tim HSE',
    createdAt: DateTime.now().subtract(const Duration(days: 4)),
  ),
];

<<<<<<< HEAD
enum _SubFilter { all, unread }
=======
// ── Inbox item type ───────────────────────────────────────────────────────────
enum _InboxTab { all, personal, announcement, unread }
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

<<<<<<< HEAD
class _InboxScreenState extends State<InboxScreen>
    with SingleTickerProviderStateMixin {
  late TabController _mainTabController;
  _SubFilter _activeFilter = _SubFilter.all;
=======
class _InboxScreenState extends State<InboxScreen> {
  _InboxTab _activeTab = _InboxTab.all;
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

<<<<<<< HEAD
  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 2, vsync: this);
    _mainTabController.addListener(() {
      if (!_mainTabController.indexIsChanging) {
        setState(() {
          _activeFilter = _SubFilter.all; // Reset filter when switching tabs
        });
      }
    });
  }

  // Track read IDs (in-memory)
  final Set<String> _readReportIds = {};
  final Set<String> _readAnnouncementIds = {};

  // ── Filtered reports ───────────────────────────────────────────────────────
  List<Report> get _baseReports {
    if (_activeFilter == _SubFilter.unread) {
      return dummyReports.where((r) => !_readReportIds.contains(r.id)).toList();
    }
    return dummyReports;
  }

  List<Report> get _activeReports {
    final base = _baseReports;
=======
  // Track read report IDs (in-memory)
  final Set<String> _readReportIds = {};
  final Set<String> _readAnnouncementIds = {};

  // ── Filtered lists per tab ─────────────────────────────────────────────────
  List<Report> get _allReports => dummyReports;

  List<Report> get _personalReports =>
      dummyReports.where((r) => r.reportedBy == _currentUser).toList();

  List<Report> get _unreadReports =>
      dummyReports.where((r) => !_readReportIds.contains(r.id)).toList();

  // Active list based on tab + search
  List<Report> get _activeReports {
    List<Report> base;
    switch (_activeTab) {
      case _InboxTab.all:
        base = _allReports;
        break;
      case _InboxTab.personal:
        base = _personalReports;
        break;
      case _InboxTab.unread:
        base = _unreadReports;
        break;
      default:
        base = [];
    }
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
    if (_searchQuery.isEmpty) return base;
    final q = _searchQuery.toLowerCase();
    return base.where((r) =>
        r.title.toLowerCase().contains(q) ||
        r.reportedBy.toLowerCase().contains(q) ||
        r.location.toLowerCase().contains(q)).toList();
  }

<<<<<<< HEAD
  // ── Filtered announcements ─────────────────────────────────────────────────
  List<Announcement> get _baseAnnouncements {
    if (_activeFilter == _SubFilter.unread) {
      return dummyAnnouncements
          .where((a) => !_readAnnouncementIds.contains(a.id))
          .toList();
    }
    return dummyAnnouncements;
  }

  List<Announcement> get _activeAnnouncements {
    final base = _baseAnnouncements;
    if (_searchQuery.isEmpty) return base;
    final q = _searchQuery.toLowerCase();
    return base.where((a) =>
=======
  List<Announcement> get _activeAnnouncements {
    if (_activeTab != _InboxTab.announcement) return [];
    if (_searchQuery.isEmpty) return dummyAnnouncements;
    final q = _searchQuery.toLowerCase();
    return dummyAnnouncements.where((a) =>
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
        a.title.toLowerCase().contains(q) ||
        a.body.toLowerCase().contains(q) ||
        a.from.toLowerCase().contains(q)).toList();
  }

  // ── Badge counts ───────────────────────────────────────────────────────────
  int get _unreadReportCount =>
      dummyReports.where((r) => !_readReportIds.contains(r.id)).length;

  int get _unreadAnnouncementCount =>
      dummyAnnouncements.where((a) => !_readAnnouncementIds.contains(a.id)).length;

<<<<<<< HEAD
  int get _activeUnreadCount {
    if (!mounted) return 0;
    return _mainTabController.index == 0
        ? _unreadReportCount
        : _unreadAnnouncementCount;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mainTabController.dispose();
=======
  @override
  void dispose() {
    _searchController.dispose();
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
    super.dispose();
  }

  void _markReportRead(String id) {
    if (!_readReportIds.contains(id)) {
      setState(() => _readReportIds.add(id));
    }
  }

  void _markAnnouncementRead(String id) {
    if (!_readAnnouncementIds.contains(id)) {
      setState(() => _readAnnouncementIds.add(id));
    }
  }

  String _formatDate(DateTime dt) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    if (diff.inDays == 1) return 'Kemarin';
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  String _levelResiko(ReportSeverity s) {
    switch (s) {
      case ReportSeverity.low:    return 'P3 - Low';
      case ReportSeverity.medium: return 'P2 - Medium';
      case ReportSeverity.high:   return 'P1 - High';
    }
  }

  Color _statusColor(ReportStatus s) {
    switch (s) {
<<<<<<< HEAD
      case ReportStatus.open:       return const Color(0xFF2196F3); // Biru
      case ReportStatus.inProgress: return const Color(0xFF9C27B0); // Ungu
      case ReportStatus.closed:     return const Color(0xFF757575); // Abu
=======
      case ReportStatus.open:       return const Color(0xFF4CAF50);
      case ReportStatus.inProgress: return const Color(0xFFFF9800);
      case ReportStatus.closed:     return const Color(0xFFF44336);
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
    }
  }

  String _statusLabel(ReportStatus s) {
    switch (s) {
      case ReportStatus.open:       return 'Open';
      case ReportStatus.inProgress: return 'In Progress';
      case ReportStatus.closed:     return 'Closed';
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Material(
      color: const Color(0xFFF5F5F5),
      child: SafeArea(
        child: Column(
          children: [
            // ── Custom Header matching Profile design (Unified Container) ────
            Container(
              color: const Color(0xFFF8F8F8),
              child: Column(
                children: [
                  SapaHseHeader(
                    isSearching: _isSearching,
                    searchController: _searchController,
                    searchHint: 'Cari...',
                    onSearchChanged: (v) => setState(() => _searchQuery = v),
                    onSearchToggle: () {
                      setState(() {
                        _isSearching = !_isSearching;
                        if (!_isSearching) {
                          _searchController.clear();
                          _searchQuery = '';
                        }
                      });
                    },
                  ),
                  TabBar(
                    controller: _mainTabController,
                    labelColor: const Color(0xFF1565C0),
                    unselectedLabelColor: Colors.black54,
                    indicatorColor: const Color(0xFF1565C0),
                    indicatorWeight: 2.5,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 14),
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Personal'),
                            if (_unreadReportCount > 0) ...[
                              const SizedBox(width: 6),
                              _TabBadge(count: _unreadReportCount),
                            ],
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Announcement'),
                            if (_unreadAnnouncementCount > 0) ...[
                              const SizedBox(width: 6),
                              _TabBadge(count: _unreadAnnouncementCount),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // ── Sub-filter: All | Unread (Keep UI consistent) ─────────────
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: _SubFilterChip(
                      label: 'All',
                      isActive: _activeFilter == _SubFilter.all,
                      onTap: () =>
                          setState(() => _activeFilter = _SubFilter.all),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _SubFilterChip(
                      label: 'Unread',
                      isActive: _activeFilter == _SubFilter.unread,
                      badge: _activeUnreadCount > 0 ? _activeUnreadCount : null,
                      onTap: () =>
                          setState(() => _activeFilter = _SubFilter.unread),
                    ),
=======
    final reports = _activeReports;
    final announcements = _activeAnnouncements;
    final isEmpty = _activeTab == _InboxTab.announcement
        ? announcements.isEmpty
        : reports.isEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {},
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Cari...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(fontSize: 16),
                onChanged: (v) => setState(() => _searchQuery = v),
              )
            : const Text(
                'Inbox',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
        centerTitle: !_isSearching,
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.black87,
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _searchQuery = '';
                }
              });
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // ── Tab bar ──────────────────────────────────────────────────
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _TabChip(
                    label: 'All',
                    isActive: _activeTab == _InboxTab.all,
                    badge: null,
                    onTap: () => setState(() => _activeTab = _InboxTab.all),
                  ),
                  const SizedBox(width: 8),
                  _TabChip(
                    label: 'Personal',
                    isActive: _activeTab == _InboxTab.personal,
                    badge: _personalReports.length,
                    onTap: () => setState(() => _activeTab = _InboxTab.personal),
                  ),
                  const SizedBox(width: 8),
                  _TabChip(
                    label: 'Announcement',
                    isActive: _activeTab == _InboxTab.announcement,
                    badge: _unreadAnnouncementCount > 0
                        ? _unreadAnnouncementCount
                        : null,
                    onTap: () =>
                        setState(() => _activeTab = _InboxTab.announcement),
                  ),
                  const SizedBox(width: 8),
                  _TabChip(
                    label: 'Unread',
                    isActive: _activeTab == _InboxTab.unread,
                    badge: _unreadReportCount > 0 ? _unreadReportCount : null,
                    onTap: () => setState(() => _activeTab = _InboxTab.unread),
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
                  ),
                ],
              ),
            ),
<<<<<<< HEAD

            // ── Content (TabBarView for smooth animations) ───────────────
            Expanded(
              child: TabBarView(
                controller: _mainTabController,
                children: [
                  _buildListTab(false),
                  _buildListTab(true),
                ],
              ),
            ),
          ],
        ),
=======
          ),

          // ── Content ──────────────────────────────────────────────────
          Expanded(
            child: isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _activeTab == _InboxTab.announcement
                              ? Icons.campaign_outlined
                              : _activeTab == _InboxTab.unread
                                  ? Icons.mark_email_read_outlined
                                  : Icons.inbox_outlined,
                          size: 52,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _activeTab == _InboxTab.unread
                              ? 'Semua sudah dibaca!'
                              : 'Tidak ada item ditemukan',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                    itemCount: _activeTab == _InboxTab.announcement
                        ? announcements.length
                        : reports.length,
                    itemBuilder: (context, i) {
                      if (_activeTab == _InboxTab.announcement) {
                        final ann = announcements[i];
                        return _AnnouncementCard(
                          announcement: ann,
                          isRead: _readAnnouncementIds.contains(ann.id),
                          formatDate: _formatDate,
                          onTap: () {
                            _markAnnouncementRead(ann.id);
                            _showAnnouncementDetail(context, ann);
                          },
                        );
                      }
                      final r = reports[i];
                      final isRead = _readReportIds.contains(r.id);
                      return _InboxCard(
                        report: r,
                        isRead: isRead,
                        formatDate: _formatDate,
                        levelResiko: _levelResiko,
                        statusColor: _statusColor,
                        statusLabel: _statusLabel,
                        onDetail: () {
                          _markReportRead(r.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ReportDetailScreen(report: r),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildListTab(bool isAnnouncement) {
    final list = isAnnouncement ? _activeAnnouncements : _activeReports;
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isAnnouncement ? Icons.campaign_outlined : _activeFilter == _SubFilter.unread ? Icons.mark_email_read_outlined : Icons.inbox_outlined,
              size: 52,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 12),
            Text(
              _activeFilter == _SubFilter.unread ? 'Semua sudah dibaca!' : 'Tidak ada item ditemukan',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemCount: list.length,
      itemBuilder: (context, i) {
        if (isAnnouncement) {
          final ann = list[i] as Announcement;
          return _AnnouncementCard(
            announcement: ann,
            isRead: _readAnnouncementIds.contains(ann.id),
            formatDate: _formatDate,
            onTap: () {
              _markAnnouncementRead(ann.id);
              _showAnnouncementDetail(context, ann);
            },
          );
        } else {
          final r = list[i] as Report;
          return _InboxCard(
            report: r,
            isRead: _readReportIds.contains(r.id),
            formatDate: _formatDate,
            levelResiko: _levelResiko,
            statusColor: _statusColor,
            statusLabel: _statusLabel,
            onDetail: () {
              _markReportRead(r.id);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ReportDetailScreen(report: r)),
              );
            },
          );
        }
      },
    );
  }

=======
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
  void _showAnnouncementDetail(BuildContext context, Announcement ann) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (_, sc) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20),
<<<<<<< HEAD
          child: Column(
=======
          child: ListView(
            controller: sc,
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
<<<<<<< HEAD
              Expanded(
                child: ListView(
                  controller: sc,
                  children: [
                    // Icon
                    Row(
                      children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A56C4).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.campaign,
                              color: Color(0xFF1A56C4), size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ann.from,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Color(0xFF1A56C4))),
                              Text(_formatDate(ann.createdAt),
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(ann.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17, height: 1.3)),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    Text(ann.body,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black87, height: 1.6)),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
=======
              // Icon
              Row(
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A56C4).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.campaign,
                        color: Color(0xFF1A56C4), size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ann.from,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Color(0xFF1A56C4))),
                        Text(_formatDate(ann.createdAt),
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(ann.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17, height: 1.3)),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Text(ann.body,
                  style: const TextStyle(
                      fontSize: 14, color: Colors.black87, height: 1.6)),
              const SizedBox(height: 24),
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A56C4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

<<<<<<< HEAD
// ── TAB BADGE Widget ─────────────────────────────────────────────────────────
class _TabBadge extends StatelessWidget {
  final int count;
  const _TabBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: const Color(0xFF1565C0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ── SUB FILTER CHIP (All | Unread) ─────────────────────────────────────────────
class _SubFilterChip extends StatelessWidget {
=======
// ── TAB CHIP ──────────────────────────────────────────────────────────────────
class _TabChip extends StatelessWidget {
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
  final String label;
  final bool isActive;
  final int? badge;
  final VoidCallback onTap;

<<<<<<< HEAD
  const _SubFilterChip({
=======
  const _TabChip({
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
    required this.label,
    required this.isActive,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    const blue = Color(0xFF1A56C4);
=======
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
<<<<<<< HEAD
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? blue.withValues(alpha: 0.1) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? blue : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
=======
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1A56C4) : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
          children: [
            Text(
              label,
              style: TextStyle(
<<<<<<< HEAD
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? blue : Colors.black54,
              ),
            ),
            if (badge != null && badge! > 0) ...[
              const SizedBox(width: 5),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: isActive ? blue : Colors.black26,
=======
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.black54,
              ),
            ),
            if (badge != null && badge! > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : const Color(0xFF1A56C4),
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$badge',
<<<<<<< HEAD
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
=======
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isActive ? const Color(0xFF1A56C4) : Colors.white,
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── INBOX CARD (Report) ───────────────────────────────────────────────────────
class _InboxCard extends StatelessWidget {
  final Report report;
  final bool isRead;
  final String Function(DateTime) formatDate;
  final String Function(ReportSeverity) levelResiko;
  final Color Function(ReportStatus) statusColor;
  final String Function(ReportStatus) statusLabel;
  final VoidCallback onDetail;

  const _InboxCard({
    required this.report,
    required this.isRead,
    required this.formatDate,
    required this.levelResiko,
    required this.statusColor,
    required this.statusLabel,
    required this.onDetail,
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return GestureDetector(
      onTap: onDetail,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: isRead ? const Color(0xFFFAFAFA) : const Color(0xFFF0F8FF),
          borderRadius: BorderRadius.circular(14),
          border: isRead
              ? null
              : Border.all(color: const Color(0xFF1A56C4).withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13), // 1px inside the 14px border
        child: Column(
          children: [
            // ── Unread indicator bar ────────────────────────────────────
=======
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: isRead
            ? null
            : Border.all(color: const Color(0xFF1A56C4).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Unread indicator bar ────────────────────────────────────
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
          if (!isRead)
            Container(
              height: 3,
              decoration: const BoxDecoration(
                color: Color(0xFF1A56C4),
                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
              ),
            ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Title + Status + unread dot ───────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Unread dot
                    if (!isRead)
                      Container(
                        width: 8, height: 8,
                        margin: const EdgeInsets.only(top: 5, right: 8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1A56C4),
                          shape: BoxShape.circle,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        report.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: statusColor(report.status),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        statusLabel(report.status),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                _DetailRow(label: 'Nama PJA', value: report.reportedBy),
                const SizedBox(height: 4),
                _DetailRow(label: 'Lokasi', value: report.location),
                const SizedBox(height: 4),
                _DetailRow(label: 'Tanggal', value: formatDate(report.createdAt)),
                const SizedBox(height: 4),
                _DetailRow(
                    label: 'Level Resiko',
                    value: levelResiko(report.severity)),

<<<<<<< HEAD
=======
                const SizedBox(height: 14),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onDetail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A56C4),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Lihat Detail Laporan',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
              ],
            ),
          ),
        ],
      ),
<<<<<<< HEAD
      ),
    ));
=======
    );
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
  }
}

// ── ANNOUNCEMENT CARD ─────────────────────────────────────────────────────────
class _AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  final bool isRead;
  final String Function(DateTime) formatDate;
  final VoidCallback onTap;

  const _AnnouncementCard({
    required this.announcement,
    required this.isRead,
    required this.formatDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
<<<<<<< HEAD
          color: isRead ? const Color(0xFFFAFAFA) : const Color(0xFFF0F8FF),
          borderRadius: BorderRadius.circular(14),
          border: isRead
              ? null
              : Border.all(color: const Color(0xFF1A56C4).withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
=======
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: isRead
              ? null
              : Border.all(color: const Color(0xFF1A56C4).withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
<<<<<<< HEAD
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Column(
            children: [
=======
        child: Column(
          children: [
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
            if (!isRead)
              Container(
                height: 3,
                decoration: const BoxDecoration(
                  color: Color(0xFF1A56C4),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(14)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    width: 42, height: 42,
                    decoration: BoxDecoration(
<<<<<<< HEAD
                      color: const Color(0xFF1A56C4).withValues(alpha: 0.1),
=======
                      color: const Color(0xFF1A56C4).withOpacity(0.1),
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.campaign,
                        color: Color(0xFF1A56C4), size: 22),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (!isRead)
                              Container(
                                width: 7, height: 7,
                                margin: const EdgeInsets.only(right: 6, top: 2),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1A56C4),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            Expanded(
                              child: Text(
                                announcement.title,
                                style: TextStyle(
                                  fontWeight: isRead
                                      ? FontWeight.w500
                                      : FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          announcement.body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              height: 1.4),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.person_outline,
                                size: 12, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(announcement.from,
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                            const Spacer(),
                            Text(formatDate(announcement.createdAt),
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
<<<<<<< HEAD
            ],
          ),
=======
          ],
>>>>>>> 2ee61afce10cfc11d227c60d52e0f4f53e990d86
        ),
      ),
    );
  }
}

// ── DETAIL ROW ────────────────────────────────────────────────────────────────
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(label,
              style: const TextStyle(fontSize: 13, color: Colors.black54)),
        ),
        const Text(': ',
            style: TextStyle(fontSize: 13, color: Colors.black54)),
        Expanded(
          child: Text(value,
              style: const TextStyle(fontSize: 13, color: Colors.black87)),
        ),
      ],
    );
  }
}