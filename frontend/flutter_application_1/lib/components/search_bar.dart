import 'package:flutter/material.dart';

class MenuSearchBar extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function(String)? onFilterSelected;

  const MenuSearchBar({
    super.key,
    this.hintText = "Cari riwayat SOS kamu...",
    this.onChanged,
    this.onSubmitted,
    this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // TextField dengan custom selection color
        Expanded(
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.black54),
                SizedBox(width: 8),
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      textSelectionTheme: const TextSelectionThemeData(
                        selectionColor: Colors.black54,
                        selectionHandleColor: Colors.black,
                        cursorColor: Colors.black,
                      ),
                    ),
                    child: TextField(
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      cursorColor: Colors.black,
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: const TextStyle(color: Colors.black45),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 8),

        // PopupMenu Button untuk Filter
        PopupMenuButton<String>(
          color: const Color(0xFF5CA3C6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onSelected: (value) {
            if (onFilterSelected != null) {
              onFilterSelected!(value);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'today',
              child: Text('Hari Ini', style: TextStyle(color: Colors.white)),
            ),
            const PopupMenuItem(
              value: 'week',
              child: Text('Minggu Ini', style: TextStyle(color: Colors.white)),
            ),
            const PopupMenuItem(
              value: 'month',
              child: Text(
                'Sebulan Terakhir',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF2A4BA0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}
