import 'package:flutter/material.dart';
import 'package:bingo/l10n/app_localizations.dart';

class DeleteButton extends StatefulWidget {
  final Future<void> Function() onDelete;
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
  bool _isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    if (_isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.error,
          ),
        ),
      );
    }

    return Semantics(
      button: true,
      label: widget.label ?? loc.btn_delete,
      child: IconButton(
        tooltip: widget.label ?? loc.btn_delete,
        icon: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.error,
          size: 20,
        ),
        onPressed: () async {
          final confirmed = await _showConfirm(context);
          if (confirmed == true) {
            setState(() {
              _isLoading = true;
            });
            
            try {
              await widget.onDelete();
              
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(loc.deleted_msg),
                  ),
                );
              }
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                  ),
                );
              }
            } finally {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            }
          }
        },
      ),
    );
  }
}
