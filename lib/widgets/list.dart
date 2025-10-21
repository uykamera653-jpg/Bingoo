import 'package:bingo/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:bingo/widgets/chat.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Yangi DeleteButton widgeti
class DeleteButton extends StatelessWidget {
  final Future<void> Function() onDelete;
  final bool compact;
  final double height;
  final String? label;

  const DeleteButton({
    Key? key,
    required this.onDelete,
    this.compact = false,
    this.height = 40.0,
    this.label,
  }) : super(key: key);

  Future<bool?> _showConfirm(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('E’lonni oʻchirish'),
        content: Text(loc.confirm_del),   // Lokalizatsiyadan tarjima
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Oʻchirish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.error;
    final textColor = Colors.white;
    return Semantics(
      button: true,
      label: label ?? 'Oʻchirish',
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          final confirmed = await _showConfirm(context);
          if (confirmed == true) {
            await onDelete();
          }
        },
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.18),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.delete, color: textColor, size: compact ? 16 : 18),
              if (!compact) ...[
                const SizedBox(width: 8),
                Text(
                  label ?? 'Oʻchirish',
                  style: TextStyle(color: textColor, fontSize: 14),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ElonItem {
  final String id;
  final String item;         // nomi
  final String kind;         // lost | found
  final String contact;
  final String? notes;
  final String place;
  final int? reward;
  final String date;
  final String uid;
  final String? authorEmail;
  final String? authorName;

  ElonItem({
    required this.id,
    required this.item,
    required this.kind,
    required this.contact,
    this.notes,
    required this.place,
    this.reward,
    required this.date,
    required this.uid,
    this.authorEmail,
    this.authorName,
  });

  factory ElonItem.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ElonItem(
      id: doc.id,
      item: data['item'] ?? '',
      kind: data['kind'] ?? '',
      contact: data['contact'] ?? '',
      notes: data['notes'],
      place: data['place'] ?? '',
      reward: data['reward'],
      date: data['date'] ?? '',
      uid: data['uid'] ?? '',
      authorEmail: data['authorEmail'],
      authorName: data['authorName'],
    );
  }
}

class ElonPage extends StatefulWidget {
  final String listType;           // lost_list | found_list | mine_list | reward_list
  final String? currentUserEmail;  // delete ko‘rsatish uchun

  const ElonPage({super.key, required this.listType, this.currentUserEmail});

  @override
  State<ElonPage> createState() => _ElonPageState();
}

class _ElonPageState extends State<ElonPage> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7D6),
      appBar: CustomAppBar(),
      body: Column(
        children: [
          // Qidiruv
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: loc.searchHint,
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF0F172A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() => query = value),
            ),
          ),

          // Roʻyxat
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("posts").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text(loc.noData));
                }

                final allElonlar =
                    snapshot.data!.docs.map((doc) => ElonItem.fromDoc(doc)).toList();

                // Filtrlash: tur bo‘yicha
                List<ElonItem> filtered = allElonlar;
                if (widget.listType == "lost_list") {
                  filtered = allElonlar.where((e) => e.kind == "lost").toList();
                } else if (widget.listType == "found_list") {
                  filtered = allElonlar.where((e) => e.kind == "found").toList();
                } else if (widget.listType == "mine_list") {
                  filtered = allElonlar
                      .where((e) => e.authorEmail == widget.currentUserEmail)
                      .toList();
                } else if (widget.listType == "reward_list") {
                  filtered = allElonlar.where((e) => (e.reward ?? 0) > 0).toList();
                }

                // Qidiruv bo‘yicha filtrlash
                final lowerQuery = query.toLowerCase();
                filtered = filtered.where((item) {
                  return item.item.toLowerCase().contains(lowerQuery) ||
                      item.place.toLowerCase().contains(lowerQuery) ||
                      (item.notes?.toLowerCase().contains(lowerQuery) ?? false);
                }).toList();

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final item = filtered[index];

                    // Faqat egasiga o‘chirish tugmasini ko‘rsatamiz
                    final bool canDelete = widget.listType == "mine_list" ||
                        (item.authorEmail != null &&
                            item.authorEmail == widget.currentUserEmail);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Yuqori chiziq: holat + sana
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.kind == "lost"
                                          ? "❗ Yo‘qoldi"
                                          : "✅ Topildi",
                                      style: TextStyle(
                                        color: item.kind == "lost"
                                            ? Colors.red
                                            : Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      item.date,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // (xohlasangiz shu yerda ⋮ menyu ham qo‘shishingiz mumkin)
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Nomi
                          Text(
                            item.item,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Joy
                          Text(
                            item.place,
                            style: const TextStyle(color: Colors.white70),
                          ),

                          // Izoh (bo‘lsa)
                          if (item.notes != null && item.notes!.isNotEmpty)
                            Text(
                              item.notes!,
                              style: const TextStyle(color: Colors.white70),
                            ),

                          const SizedBox(height: 10),

                          // Muallif (bo‘lsa)
                          if (item.authorName != null || item.authorEmail != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (item.authorName != null)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        color: Colors.white70,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        item.authorName!,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (item.authorEmail != null)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.email,
                                        color: Colors.white70,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        item.authorEmail!,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),

                          const SizedBox(height: 6),

                          // Telefon
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Colors.grey,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.contact,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),

                          // Mukofot (bo‘lsa)
                          if ((item.reward ?? 0) > 0) ...[
                            const SizedBox(height: 6),
                            Text(
                              "🎁 Mukofot: ${item.reward} so‘m",
                              style: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],

                          const SizedBox(height: 12),

                          // Tugmalar: Xabar | Ulashish | (O‘chirish)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Xabar
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Chat(postId: item.id),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.mail, size: 16),
                                label: Text(loc.btn_message),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[800],
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),

                              // Ulashish
                              ElevatedButton.icon(
                                onPressed: () {
                                  final shareText = """
📢 E’lon: ${item.item}
📍 Joy: ${item.place}
📞 Tel: ${item.contact}
${item.notes ?? ""}
""";
                                  Share.share(shareText);
                                },
                                icon: const Icon(Icons.link, size: 16),
                                label: Text(loc.btn_share),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),

                              // Oʻchirish (faqat egasiga)
                              if (canDelete)
                                DeleteButton(
                                  compact: false,
                                  onDelete: () async {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('posts')
                                          .doc(item.id)
                                          .delete();

                                      if (mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('E’lon o‘chirildi'),
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Xatolik: $e'),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}