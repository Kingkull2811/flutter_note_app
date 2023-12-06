import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../network/provider/dark_mode_provider.dart';
import '../../util/app_theme.dart';

class ListNotes extends ConsumerWidget {
  const ListNotes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider).isDarkMode();

    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 6,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: isDarkMode ? AppColor.greyChateau : Colors.grey[200]),
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'title note',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(
                child: Text(
                  'content note note note note note note note note note note note note note note',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('create time note'),
            ],
          ),
        ),
      ),
      itemCount: 200,
    );
  }
}
