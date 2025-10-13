import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bingo/controllers/auth_controller.dart';
import 'package:bingo/screens/home.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:bingo/main.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final AuthController _authController = AuthController();
  User? user;

  String selectedLang = "UZ";

  @override
  void initState() {
    super.initState();

    _authController.authStateChanges.listen((u) {
      setState(() {
        user = u;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedLang = Localizations.localeOf(context).languageCode.toUpperCase();
  }

  void _changeLanguage(String lang) {
    setState(() {
      selectedLang = lang;
    });

    Locale newLocale;
    if (lang == "UZ") {
      newLocale = const Locale('uz');
    } else if (lang == "RU") {
      newLocale = const Locale('ru');
    } else {
      newLocale = const Locale('en');
    }

    MyApp.setLocale(context, newLocale);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFFFFE59A),
      elevation: 0,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: const Text(
                "BG",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFA726),
                  fontSize: 16,
                ),
              ),
            ),

            const Text(
              "BINGO",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),

            DropdownButton<String>(
              value: selectedLang,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              items: const [
                DropdownMenuItem(value: "UZ", child: Text("UZ")),
                DropdownMenuItem(value: "RU", child: Text("RU")),
                DropdownMenuItem(value: "EN", child: Text("EN")),
              ],
              onChanged: (val) {
                if (val != null) {
                  _changeLanguage(val);
                }
              },
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),

            if (user == null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black87,
                  elevation: 0,
                  side: const BorderSide(color: Colors.black12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await _authController.signInWithGoogle();
                },
                child: Text(
                  loc.login_google,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            else
              Row(
                children: [
                  Text(
                    user?.displayName?.split(" ").first ?? loc.user,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black87,
                      elevation: 0,
                      side: const BorderSide(color: Colors.black12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      await _authController.signOut();
                    },
                    child: Text(loc.logout),
                  ),
                ],
              ),

            IconButton(
              onPressed: () {
                if (context.widget is HomePage) {
                  return;
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                }
              },
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.black87,
                size: 15,
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Colors.black12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(color: Colors.black26, height: 1, thickness: 1),
      ),
    );
  }
}
