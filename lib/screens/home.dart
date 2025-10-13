import 'package:bingo/widgets/image_slider.dart';
import 'package:bingo/widgets/pub_elon.dart';
import 'package:flutter/material.dart';
import 'package:bingo/widgets/app_bar.dart';
import 'package:bingo/widgets/darkbtn.dart';
import 'package:bingo/widgets/infoCard.dart';
import 'package:bingo/widgets/list.dart';
import 'package:bingo/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFFFF7D6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              Text(
                loc.hero_title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                loc.hero_sub,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AnnouncementForm(type: "lost"),
                          ),
                        );
                      },
                      child: Text(
                        loc.btn_lost,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AnnouncementForm(type: "found"),
                          ),
                        );
                      },
                      child: Text(
                        loc.btn_found,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    DarkButton(
                      text: loc.btn_lostlist,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ElonPage(listType: "lost_list"),
                          ),
                        );
                      },
                    ),
                    DarkButton(
                      text: loc.btn_reward,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ElonPage(listType: "reward_list"),
                          ),
                        );
                      },
                    ),
                    DarkButton(
                      text: loc.btn_foundlist,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ElonPage(listType: "found_list"),
                          ),
                        );
                      },
                    ),
                    DarkButton(
                      text: loc.btn_mine,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ElonPage(listType: "mine_list"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),
              ImageSlider(),
              SizedBox(height: 30),

              InfoCard(
                title: AppLocalizations.of(context)!.foundTitle1,
                description: AppLocalizations.of(context)!.foundDescription1,
              ),
              const SizedBox(height: 16),
              InfoCard(
                title: AppLocalizations.of(context)!.foundTitle2,
                description: AppLocalizations.of(context)!.foundDescription2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
