import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    required String title,
    void Function()? onTap,
    IconData? icon,
    Widget? trailing,
    Color? titleColor,
    bool showTrailing = true,
    super.key,
  })  : _title = title,
        _icon = icon,
        _onTap = onTap,
        _trailing = trailing,
        _titleColor = titleColor,
        _showTrailing = showTrailing;

  final IconData? _icon;
  final String _title;
  final void Function()? _onTap;
  final Widget? _trailing;
  final Color? _titleColor;
  final bool _showTrailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 50,
      contentPadding: const EdgeInsets.all(0),
      leading: _icon == null ? null : Icon(_icon),
      title: Text(
        _title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: _titleColor,
        ),
      ),
      onTap: _onTap,
      trailing: _showTrailing == true
          ? _trailing ?? const Icon(Icons.chevron_right_rounded)
          : null,
    );
  }
}
