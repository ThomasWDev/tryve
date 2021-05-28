import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tryve/components/common_leading.dart';
import 'package:tryve/components/common_loader.dart';
import 'package:tryve/components/common_loading_overlay.dart';
import 'package:tryve/components/gradient_text.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/helpers/toast_helper.dart';
import 'package:provider/provider.dart';
import 'package:tryve/screens/search/complete_verification_screen.dart';
import 'package:tryve/services/api/parse/feed_api/feed_api.dart';
import 'package:tryve/services/api/parse/user_api/user_api.dart';
import 'package:tryve/state/feed_state.dart';
import 'package:tryve/theme/palette.dart';

class WritePostScreen extends StatefulWidget {
  static String routeName = "/write_post_screen";
  WritePostScreen({Key key}) : super(key: key);

  @override
  _WritePostScreenState createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<WritePostScreen> {
  final _picker = ImagePicker();
  List<File> _files = List.generate(6, (index) => null);

  bool _posting = false;

  dynamic _userObj;

  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyTextCotroller = TextEditingController();

  void _execute(List<String> tags) {
    setState(() {
      _posting = true;
    });
    final files = List.of(_files);
    files.removeWhere((element) => element == null);
    FeedAPI.createPost(
      title: _titleController.text,
      description: _bodyTextCotroller.text,
      tags: tags,
      files: files,
    ).then((response) async {
      if (response.success) {
        try {
          context.read<FeedState>().addPost(response.result);
          await UserAPI.addPost(
              userId: _userObj['objectId'],
              postId: response.result['objectId']);
        } catch (_) {
          toast("Couldn't save your post");
        }
      } else {
        toast("Couldn't post feed , try later !");
      }

      setState(() {
        _posting = false;
      });

      toast("Your post has been saved");
      replacePage(
          newPage: CompleteVerificationScreen.routeName, context: context);
    });
  }

  void _setData(ParseResponse response) {
    if (response.success) {
      _userObj = response.result[0];
    }
  }

  void _post() {
    if (_titleController.text.isNotEmpty &&
        _bodyTextCotroller.text.isNotEmpty) {
      if (_files.isNotEmpty && !_files.every((element) => element == null)) {
        List<String> tags = [];
        if (_tagsController.text.isNotEmpty) {
          final extracted = _tagsController.text.split(',');
          if (extracted.isEmpty) {
            toast("Tags not properly formatted");
          } else {
            tags = extracted;
            _execute(tags);
          }
        } else {
          _execute(tags);
        }
      } else {
        toast("At least one image is required");
      }
    } else {
      toast("Please fill in all the forms");
    }
  }

  void _addTagsPrompt() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _tagsController,
                  decoration: InputDecoration(hintText: "Add some tags"),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text("Seperate tags by comma(,)")
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => pop(context),
                child: Text("Done"),
              )
            ],
          );
        });
  }

  void _pick(int index) async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 60,
      maxHeight: 200,
      maxWidth: 200,
    );

    if (pickedFile != null) {
      setState(() {
        _files.insert(index, File(pickedFile.path));
      });
    }
  }

  Widget _imageWrapper(int index) {
    return GestureDetector(
      onTap: () => _pick(index),
      child: Container(
        height: 100,
        width: 100,
        margin: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: _files[index] == null
            ? Center(
                child: Icon(
                  PhosphorIcons.plus,
                  color: Colors.grey.shade700,
                ),
              )
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.file(_files[index],
                        fit: BoxFit.cover, width: 100, height: 100),
                  ),
                  Positioned(
                    top: -5,
                    right: -5,
                    child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                      ),
                      onPressed: () {
                        setState(() {
                          _files.removeAt(index);
                        });
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void _info() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                "The first image you pick will be the thumbnail of your post !"),
            actions: [
              TextButton(
                onPressed: () => pop(context),
                child: Text("Close"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CommonLoadingOverlay(
      loading: _posting,
      child: Scaffold(
        appBar: AppBar(
          elevation: 8.0,
          leading: CommonLeading(
            color: Colors.white,
          ),
          title: Text("Write a post"),
          brightness: Brightness.dark,
          actions: [
            IconButton(
                tooltip: "Add tags",
                onPressed: () => _addTagsPrompt(),
                icon: Icon(PhosphorIcons.tag)),
            IconButton(
                tooltip: "Clear text",
                onPressed: () {
                  _titleController.clear();
                  _bodyTextCotroller.clear();
                },
                icon: Icon(PhosphorIcons.trash)),
          ],
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
              child: TextField(
                controller: _titleController,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter title here",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 22,
                    )),
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: UserAPI.getUserbyMail(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _setData(snapshot.data);
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _bodyTextCotroller,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                        maxLines: 1000,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Your post content",
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 22,
                            )),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Upload images".toUpperCase(),
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            IconButton(
                              icon:
                                  Icon(PhosphorIcons.info, color: Colors.blue),
                              onPressed: _info,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            itemBuilder: (context, index) =>
                                _imageWrapper(index),
                            itemCount: 6,
                          ))
                    ],
                  )
                ],
              );
            } else {
              return Center(
                child: CommonLoader(),
              );
            }
          },
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0.0, -4.0),
                    blurRadius: 30),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                    child: Row(
                      children: [
                        GradientText(
                            colors: [Palette.primary, Palette.mango],
                            text: "Post",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        const SizedBox(
                          width: 4,
                        ),
                        Icon(
                          PhosphorIcons.caret_right,
                          color: Palette.mango,
                          size: 20,
                        )
                      ],
                    ),
                    onPressed: _post,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
