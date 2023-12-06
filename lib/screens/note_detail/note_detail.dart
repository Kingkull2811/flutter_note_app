import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:note_app/network/model/note_model/note_model.dart';

import '../../network/provider/dark_mode_provider.dart';
import '../../util/app_theme.dart';

class NoteDetail extends StatefulHookConsumerWidget {
  final NoteModel? noteDetail;

  const NoteDetail({super.key, this.noteDetail});

  @override
  ConsumerState<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends ConsumerState<NoteDetail> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool isShowDone = false;
  final String currentTime = DateFormat('dd/MM/yyyy HH:mm aa').format(DateTime.now());

  double fontSize = 14.0;
  FontWeight fontWeight = FontWeight.normal;
  Color textColor = Colors.black;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  // void _scrollListener() {
  //   double offset = _scrollController.offset;
  //   var direction = _scrollController.position.userScrollDirection;
  //
  //   if (direction == ScrollDirection.reverse) {
  //     _allowForward = true;
  //     if (_allowReverse) {
  //       _allowReverse = false;
  //       _prevOffset = offset;
  //       _prevForwardOffset = _fromTop;
  //     }
  //
  //     var difference = offset - _prevOffset;
  //     _fromTop = _prevForwardOffset + difference;
  //     if (_fromTop > 0) _fromTop = 0;
  //   } else if (direction == ScrollDirection.forward) {
  //     _allowReverse = true;
  //     if (_allowForward) {
  //       _allowForward = false;
  //       _prevOffset = offset;
  //       _prevReverseOffset = _fromTop;
  //     }
  //
  //     var difference = offset - _prevOffset;
  //     _fromTop = _prevReverseOffset + difference;
  //     if (_fromTop < -_containerHeight) _fromTop = -_containerHeight;
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final isDarkMode = ref.watch(darkModeProvider).isDarkMode();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check, size: 24))],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10, 8, 10, MediaQuery.of(context).viewInsets.bottom),
              // physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    color: Colors.yellow,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(currentTime, style: TextStyle(color: isDarkMode ? AppColor.greyChateau : AppColor.linkWater)),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: isDarkMode ? AppColor.greyChateau : AppColor.linkWater),
                          alignment: Alignment.center,
                          child: Text('folder name'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.redAccent,
                    // height: 45,
                    width: w - 20,
                    child: TextFormField(
                      controller: titleController,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      maxLines: null,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(contentPadding: EdgeInsets.zero, hintText: 'Title', border: InputBorder.none, filled: false),
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    // height: MediaQuery.of(context).size.height - 30 - 45 - 100,
                    width: w - 20,
                    // padding:  EdgeInsets.only(top: contentController.text != ''?  6: 0),
                    // alignment: Alignment.topLeft,
                    child: TextFormField(
                      controller: contentController,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      maxLines: null,
                      decoration: const InputDecoration(contentPadding: EdgeInsets.zero, hintText: 'Content', border: InputBorder.none, filled: false),
                      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: textColor),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom != 0 ? 60 : 20),
                ],
              ),
            ),
            if (MediaQuery.of(context).viewInsets.bottom != 0)
              Positioned(
                bottom: 0,
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: BorderDirectional(top: BorderSide(color: Colors.grey, width: 0.5), bottom:BorderSide(color: Colors.grey, width: 0.5) ),
                    color: Colors.transparent,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.add,
                        size: 30,
                      ),
                      Icon(
                        Icons.add,
                        size: 30,
                      ),
                      Icon(
                        Icons.add,
                        size: 30,
                      ),
                      Icon(
                        Icons.add,
                        size: 30,
                      ),
                      Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
