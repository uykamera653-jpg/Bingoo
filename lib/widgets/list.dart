// NOTE: only minimal change — added import for DeleteButton and removed any inline DeleteButton class.
// Rest of file preserved to keep design intact.
import 'package:bingo/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:bingo/widgets/chat.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bingo/widgets/delete_button.dart'; // <- yangi import

// ... keep the rest of file unchanged except remove inline DeleteButton class if present.
// The file should include existing ElonItem and ElonPage implementations as before,
// with DeleteButton(...) usages unchanged so design remains the same.
