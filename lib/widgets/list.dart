import 'package:bingo/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:bingo/widgets/chat.dart';
import 'package:share_plus/share_plus.dart';

class ElonItem {
  final String id;
  final String item;
  final String kind;
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
  final String listType;
  final String? currentUserEmail;

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
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("posts")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text(loc.noData));
                }

                final allElonlar = snapshot.data!.docs
                    .map((doc) => ElonItem.fromDoc(doc))
                    .toList();

                List<ElonItem> filtered = allElonlar;

                if (widget.listType == "lost_list") {
                  filtered = allElonlar.where((e) => e.kind == "lost").toList();
                } else if (widget.listType == "found_list") {
                  filtered = allElonlar
                      .where((e) => e.kind == "found")
                      .toList();
                } else if (widget.listType == "mine_list") {
                  filtered = allElonlar
                      .where((e) => e.authorEmail == widget.currentUserEmail)
                      .toList();
                } else if (widget.listType == "reward_list") {
                  filtered = allElonlar
                      .where((e) => (e.reward ?? 0) > 0)
                      .toList();
                }

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Text(
                                item.date,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Text(
                            item.item,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),

                          Text(
                            item.place,
                            style: const TextStyle(color: Colors.white70),
                          ),

                          if (item.notes != null && item.notes!.isNotEmpty)
                            Text(
                              item.notes!,
                              style: const TextStyle(color: Colors.white70),
                            ),

                          const SizedBox(height: 10),

                          if (item.authorName != null ||
                              item.authorEmail != null)
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Chat(postId: item.id),
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
                              ElevatedButton.icon(
                                onPressed: () {
                                  final shareText =
                                      """
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
