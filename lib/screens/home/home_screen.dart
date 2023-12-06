import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/library/amin_search_bar.dart';

import '../../network/provider/dark_mode_provider.dart';
import '../../routes.dart';
import '../../util/app_theme.dart';
import '../../widgets/custom_input_field.dart';
import 'list_notes.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();

  bool isShowClearText = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(darkModeProvider).isDarkMode();

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) * 0.3;
    final double itemWidth = size.width / 2;
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 2,
          actions: [IconButton(onPressed: () => Navigator.pushNamed(context, AppRoute.settings), icon: const Icon(Icons.settings))],
        ),
        floatingActionButton: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () => Navigator.pushNamed(context, AppRoute.noteDetail, arguments: {'data': null}),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: isDarkMode ? AppColor.midGrey : AppColor.whisper,
              border: Border.all(color: AppColor.linkWater, width: 1),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.add, size: 36),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
              child: SizedBox(
                height: 36,
                child: InputFieldCustom(
                  controller: _searchController,
                  prefixIcon: Icons.search,
                  hintText: 'Search ...',
                  showSuffix: _searchController.text.isNotEmpty,
                  suffix1: Icons.cancel_outlined,
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            //   child: AminSearchBar(
            //     width: size.width - 20,
            //     height: 48,
            //     controller: _searchController,
            //     onSuffixTap: () => _searchController.clear(),
            //     onSubmitted: (v) {},
            //     searchBarOpen: (v) {},
            //   ),
            // ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RefreshIndicator(onRefresh: () async {}, color: isDarkMode ? Colors.white : Colors.grey, child: ListNotes()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
