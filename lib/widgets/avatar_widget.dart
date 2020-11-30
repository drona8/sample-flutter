import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumnaam/services/image/app_cached_network_image.dart';
import 'package:gumnaam/services/storage/avatar_service.dart';
import 'package:gumnaam/services/storage/avatar_storage_service.dart';
import 'package:gumnaam/services/utility/image_utility.dart';
import 'package:gumnaam/style/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AvatarWidget extends StatefulWidget {
  final String imageURL;
  AvatarWidget({
    this.imageURL,
  });
  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<AvatarStorageService>(context, listen: false);
    final database = Provider.of<AvatarService>(context, listen: false);
    return Container(
      child: widget.imageURL != null
              ? GestureDetector(
                  onTap: () async {
                    /*setState(() {
                                    _isLoading = true;
                                  });*/
                    PickedFile _pFile;
                    await ImageUtility.showImageDialog(context,
                        (PickedFile file) {
                      setState(() {
                        _pFile = file;
                        Navigator.pop(context);
                      });
                    });
                    if (_pFile != null) {
                      final downloadUrl =
                          await storage.uploadAvatar(file: File(_pFile.path));

                      await database.setAvatarReference(downloadUrl);
                      //await _image.delete();
                    }
                    /*setState(() {
                                    _isLoading = false;
                                  });*/
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColor.BLACK,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: ClipOval(
                      child: AppCachedNetworkImage(
                        imageURL: widget.imageURL,
                        fit: BoxFit.fill,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () async {
                    PickedFile _pFile;
                    await ImageUtility.showImageDialog(context,
                        (PickedFile file) {
                      /*setState(() {
                                      _isLoading = true;
                                    });*/
                      print('sdvgf');
                      setState(() {
                        _pFile = file;
                        Navigator.pop(context);
                      });
                    });
                    if (_pFile != null) {
                      final downloadUrl =
                          await storage.uploadAvatar(file: File(_pFile.path));

                      await database.setAvatarReference(downloadUrl);
                      //await _image.delete();
                    }
                    /* setState(() {
                                    _isLoading = false;
                                  });*/
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: new BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                      /*image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/defaultProfile.png'),),*/
                    ),
                    child: FloatingActionButton(
                      backgroundColor: Colors.amber,
                      onPressed: () async {
                        /* setState(() {
                                        _isLoading = true;
                                      });*/
                        PickedFile _pFile;
                        await ImageUtility.showImageDialog(context,
                            (PickedFile file) {
                          print('sdvgf');
                          setState(() {
                            _pFile = file;
                            Navigator.pop(context);
                          });
                        });
                        if (_pFile != null) {
                          final downloadUrl = await storage.uploadAvatar(
                              file: File(_pFile.path));

                          await database.setAvatarReference(downloadUrl);
                          //await _image.delete();
                        }
                        /*setState(() {
                                        _isLoading = false;
                                      });*/
                      },
                      child: Icon(Icons.add_a_photo_rounded),
                      mini: true,
                      splashColor: AppColor.blue,
                    ),
                  ),
                ),
    );
  }
}
