import 'package:flutter/material.dart';
import 'package:bingo/l10n/app_localizations.dart';

/// Improved DeleteButton: confirmation dialog, disabled while deleting,
/// shows spinner and SnackBar on success/error.
/// API compatible with existing usage: pass async onDelete callback.
class DeleteButton extends StatefulWidget {
  final Future<void> Function()? onDelete;
  final bool compact;
  final double height;
  final String? label;

  const DeleteButton({
    Key? key,
    required this.onDelete,
    this.compact = true,
    this.height = 40.0,
    this.label,
  }) : super(key: key);

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  bool _loading = false;

  Future<bool?> _showConfirm(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(loc.btn_delete),
        content: Text(loc.confirm_del),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(MaterialLocalizations.of(ctx).cancelButtonLabel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(loc.btn_delete),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePressed() async {
    if (_loading) return;
    final ctx = context;
    final confirmed = await _showConfirm(ctx);
    if (confirmed != true) return;

    setState(() => _loading = true);

    try {
      if (widget.onDelete != null) {
        await widget.onDelete!();
      }
      if (!mounted) return;
      final loc = AppLocalizations.of(ctx)!;
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text(loc.deleted_msg)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Xatolik: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (widget.compact) {
      return Semantics(
        button: true,
        label: widget.label ?? loc.btn_delete,
        child: IconButton(
          tooltip: widget.label ?? loc.btn_delete,
          icon: _loading
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
          onPressed: _loading ? null : _handlePressed,
        ),
      );
    }

    return SizedBox(
      height: widget.height,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
        ),
        icon: _loading
            ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(Icons.delete),
        label: Text(widget.label ?? loc.btn_delete),
        onPressed: _loading ? null : _handlePressed,
      ),
    );
  }
}
