import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tryve/components/common_leading.dart';
import 'package:tryve/components/common_loader.dart';
import 'package:tryve/components/common_loading_overlay.dart';
import 'package:tryve/components/rounded_input.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/helpers/toast_helper.dart';
import 'package:tryve/services/api/parse/user_api/user_api.dart';
import 'package:tryve/services/auth/auth_service.dart';
import 'package:tryve/theme/palette.dart';
import 'package:provider/provider.dart';

class CustomizeProfileScreen extends StatefulWidget {
  static String routeName = "/customize_profile";

  final User user;
  CustomizeProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _CustomizeProfileScreenState createState() => _CustomizeProfileScreenState();
}

class _CustomizeProfileScreenState extends State<CustomizeProfileScreen> {
  File _image;
  final picker = ImagePicker();

  bool _loading = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  dynamic _userObj;

  void _submit() async {
    if (_nameController.text != _userObj['displayName'] ||
        _descriptionController.text != _userObj['description'] ||
        _image != null) {
      setState(() {
        _loading = true;
      });

      final _user = ParseObject("Person")
        ..objectId = _userObj['objectId']
        ..set("displayName", _nameController.text)
        ..set("description", _descriptionController.text);

      if (_image != null &&
          !(UserAPI.social(context.read<AuthenticationService>().getUser()))) {
        _user.set("image", ParseFile(_image));
      }

      final response = await _user.save();

      setState(() {
        _loading = false;
      });

      if (response.success) {
        toast("Profile saved !");
      } else {
        toast("Couldn't save profile !");
      }

      pop(context);
    } else {
      print("useless call");
    }
  }

  void _pickImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 60,
      maxHeight: 200,
      maxWidth: 200,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _imagePreview() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              actionsPadding: EdgeInsets.zero,
              content: Image.file(_image),
            ));
  }

  Widget _body() {
    return CommonLoadingOverlay(
      loading: _loading,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: RoundedInput(
                controller: _nameController,
                backgroundColor: Colors.grey.withOpacity(0.15),
                icon: PhosphorIcons.user,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: RoundedInput(
                controller: _descriptionController,
                backgroundColor: Colors.grey.withOpacity(0.15),
                hint: "Description",
                lines: 10,
                icon: PhosphorIcons.text_align_justify,
              ),
            ),
            ListTile(
              title: Text(
                "Pick image".toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              subtitle: Text(
                _image != null ? "Hold to preview image" : "No image picked",
                style: TextStyle(color: Colors.black),
              ),
              onTap: _pickImage,
              onLongPress: _imagePreview,
            ),
          ],
        ),
      ),
    );
  }

  Widget _loader() {
    return Center(
      child: CommonLoader(),
    );
  }

  void _setData(ParseResponse response) {
    if (response.success) {
      _userObj = response.result[0];
      _nameController.text = _userObj['displayName'];
      _descriptionController.text = _userObj['description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CommonLeading(),
        brightness: Brightness.dark,
        elevation: 12.0,
        backgroundColor: Palette.primary,
        title: Text("Customize profile"),
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: UserAPI.getUserbyMail(widget.user.email),
        builder: (context, AsyncSnapshot<ParseResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.success) {
              _setData(snapshot.data);
              return _body();
            } else {
              final style = TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              );
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Couldn't fetch profile",
                      style: style,
                    ),
                    Text(
                      "Please try again later",
                      style: style.copyWith(fontSize: 18),
                    )
                  ],
                ),
              );
            }
          } else {
            return _loader();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Submit"),
        icon: Icon(PhosphorIcons.paper_plane_right),
        onPressed: _submit,
        backgroundColor: Palette.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
