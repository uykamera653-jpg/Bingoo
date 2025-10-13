import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bingo/widgets/app_bar.dart';
import 'package:bingo/l10n/app_localizations.dart';

class AnnouncementForm extends StatefulWidget {
  final String type;

  const AnnouncementForm({super.key, required this.type});

  @override
  State<AnnouncementForm> createState() => _AnnouncementFormState();
}

class _AnnouncementFormState extends State<AnnouncementForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _narsaController = TextEditingController();
  final TextEditingController _shaharController = TextEditingController();
  final TextEditingController _joyController = TextEditingController();
  final TextEditingController _sanaVaqtController = TextEditingController();
  final TextEditingController _aloqaController = TextEditingController();
  final TextEditingController _mukofotController = TextEditingController();
  final TextEditingController _qoshimchaController = TextEditingController();

  @override
  void dispose() {
    _narsaController.dispose();
    _shaharController.dispose();
    _joyController.dispose();
    _sanaVaqtController.dispose();
    _aloqaController.dispose();
    _mukofotController.dispose();
    _qoshimchaController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint, {String? helper}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      helperText: helper,
      helperStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: const Color(0xFF0F172A),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bu maydon majburiy';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('posts').add({
          'kind': widget.type,
          'item': _narsaController.text,
          'city': _shaharController.text,
          'place': _joyController.text,
          'date': _sanaVaqtController.text,
          'contact': _aloqaController.text,
          'reward': _mukofotController.text.isNotEmpty
              ? int.tryParse(_mukofotController.text) ?? 0
              : 0,
          'notes': _qoshimchaController.text,
          'photo': null,
          'created': DateTime.now().millisecondsSinceEpoch,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("E'lon muvaffaqiyatli joylandi ✅")),
        );

        _formKey.currentState!.reset();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Xatolik: $e")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Barcha majburiy maydonlarni to‘ldiring")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: const Color(0xFFFFF7D6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.type == "lost"
                      ? loc.lostFormTitle
                      : loc.foundFormTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                _buildLabel(loc.item),
                TextFormField(
                  controller: _narsaController,
                  style: const TextStyle(color: Colors.white),
                  validator: _requiredValidator,
                  decoration: _inputDecoration(
                    loc.itemHint,
                    helper: loc.itemHelper,
                  ),
                ),
                const SizedBox(height: 12),

                _buildLabel(loc.city),
                TextFormField(
                  controller: _shaharController,
                  style: const TextStyle(color: Colors.white),
                  validator: _requiredValidator,
                  decoration: _inputDecoration(loc.cityHint),
                ),
                const SizedBox(height: 12),

                _buildLabel(loc.place),
                TextFormField(
                  controller: _joyController,
                  style: const TextStyle(color: Colors.white),
                  validator: _requiredValidator,
                  decoration: _inputDecoration(loc.placeHint),
                ),
                const SizedBox(height: 12),

                _buildLabel(loc.dateTime),
                TextFormField(
                  controller: _sanaVaqtController,
                  style: const TextStyle(color: Colors.white),
                  validator: _requiredValidator,
                  decoration: _inputDecoration(loc.dateTimeHint),
                ),
                const SizedBox(height: 12),

                _buildLabel(loc.contact),
                TextFormField(
                  controller: _aloqaController,
                  style: const TextStyle(color: Colors.white),
                  validator: _requiredValidator,
                  decoration: _inputDecoration(loc.contactHint),
                ),
                const SizedBox(height: 12),

                _buildLabel(loc.reward),
                TextFormField(
                  controller: _mukofotController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration(loc.rewardHint),
                ),
                const SizedBox(height: 12),

                _buildLabel(loc.extra),
                TextFormField(
                  controller: _qoshimchaController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 5,
                  decoration: _inputDecoration(loc.extraHint),
                ),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _submitForm,
                    child: Text(
                      loc.submit,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
