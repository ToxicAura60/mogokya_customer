import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({
    List<Widget>? children,
    String? title,
    Color titleColor = const Color(0xFF737373),
    double titleSize = 14,
    bool showBorder = false,
    super.key,
  })  : _children = children,
        _title = title,
        _titleColor = titleColor,
        _titleSize = titleSize,
        _showBorder = showBorder;

  final List<Widget>? _children;
  final String? _title;
  final Color _titleColor;
  final double _titleSize;
  final bool _showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: _showBorder == true
            ? const Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color(0xFFF0F0F0),
                ),
              )
            : null,
        color: const Color(0xFFFFFFFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_title != null)
            Text(
              _title,
              style: TextStyle(
                color: _titleColor,
                fontWeight: FontWeight.w700,
                fontSize: _titleSize,
              ),
            ),
          const SizedBox(
            height: 5,
          ),
          ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: _children ?? [],
          ),
        ],
      ),
    );
  }
}
