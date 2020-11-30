import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../services/image/app_cached_network_image.dart';
import '../../../models/community.dart';
import '../../../models/facility.dart';
import '../../../services/db/community_service.dart';
import '../../../services/utility/form_utility.dart';
import '../../../services/utility/image_utility.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/dropdown_widget.dart';
import '../../../widgets/text_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddFacility extends StatefulWidget {
  final Facility facility;
  AddFacility({
    this.facility,
  });
  @override
  _AddFacilityState createState() => _AddFacilityState();
}

class _AddFacilityState extends State<AddFacility> {
  final GlobalKey<FormState> _facilityFormKey = GlobalKey<FormState>();
  Community _selectedCommunity;
  PickedFile _pFile;
  bool _imageError;
  String idn;

  TextEditingController _titleController,
      _shortDescriptionController,
      _longDescriptionController;

  @override
  void initState() {
    _titleController = new TextEditingController();
    _titleController.text = widget.facility?.title;
    _shortDescriptionController = new TextEditingController();
    _shortDescriptionController.text = widget.facility?.shortDescription;
    _longDescriptionController = new TextEditingController();
    _longDescriptionController.text = widget.facility?.longDescription;
    if (widget.facility != null) {
      idn = widget.facility.communityId;
    }
    _imageError = false;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _shortDescriptionController.dispose();
    _longDescriptionController.dispose();
    super.dispose();
  }

  Widget _getImageInput(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await ImageUtility.showImageDialog(context, (PickedFile file) {
          setState(() {
            _pFile = file;
          });
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: _imageError
                ? Colors.red.withOpacity(0.60)
                : Color(0xFF707070).withOpacity(0.50),
            width: 2,
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.7,
        margin: EdgeInsets.only(top: 15.0),
        height: 100,
        child: Card(
          color: Colors.grey[200],
          child: _pFile != null
              ? Image.file(
                  new File(_pFile.path),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                )
              : widget.facility != null && widget.facility.imageURL != null
                  ? AppCachedNetworkImage(
                      imageURL: widget.facility.imageURL,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.upload_sharp,
                          color: Colors.grey,
                        ),
                        Text(
                          'Upload Facility Image',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget _getCommunity(BuildContext context) {
    final CommunityService _communityService =
        Provider.of<CommunityService>(context, listen: false);
    return StreamBuilder(
      stream: _communityService.getAllCommunities(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        QuerySnapshot qs = snap.data;
        List<Community> _communityList;
        if (qs != null && qs.docs != null && qs.docs.length > 0) {
          for (QueryDocumentSnapshot qds in qs.docs) {
            Community _community = Community.fromMap(qds.data());
            _community.id = qds.id;
            if (_selectedCommunity == null &&
                idn != null &&
                _community.id == idn) {
              _selectedCommunity = _community;
            }
            if (_communityList == null) {
              _communityList = new List<Community>();
            }
            _communityList.add(_community);
          }
        }

        if (null != _communityList) {
          return DropdownWidget(
            menuItem: _communityList,
            onSaved: (Community value) {
              //_onSaved(value, 'Category');
            },
            onValidate: (Community value) {
              return FormUtility.fieldValidator(value?.label, 'Community');
            },
            onChanged: (Community v) {
              setState(() {
                _selectedCommunity = v;
              });
            },
            selectedMenu: _selectedCommunity,
            hint: 'Community',
          );
        } else {
          return Text('No Community');
        }
      },
    );
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _facilityFormKey,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                hintText: 'Facility Title',
                suffixIconPath: 'assets/icons/phone.png',
                obscureText: false,
                controller: _titleController,
              ),
              _getImageInput(context),
              _imageError
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      margin: EdgeInsets.only(top: 5.0, left: 25.0),
                      child: Align(
                        child: Text(
                          'Please upload a image',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    )
                  : SizedBox.shrink(),
              TextWidget(
                hintText: 'Short Description',
                suffixIconPath: 'assets/icons/phone.png',
                obscureText: false,
                controller: _shortDescriptionController,
              ),
              TextWidget(
                hintText: 'Long Description',
                suffixIconPath: 'assets/icons/phone.png',
                obscureText: false,
                controller: _longDescriptionController,
                maxLine: 2,
              ),
              _getCommunity(context),
              AppButton(
                label: _isLoading
                    ? CircularProgressIndicator()
                    : widget.facility == null
                        ? Text(
                            'Add Facility',
                            style: Theme.of(context).textTheme.headline4,
                          )
                        : Text(
                            'Edit Facility',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                onPressed: () async {
                  if (_pFile == null &&
                      (widget.facility != null &&
                          widget.facility.imageURL == null)) {
                    setState(() {
                      _imageError = true;
                    });
                  }
                  Facility _facility = Facility(
                    id: widget.facility?.id,
                    communityId: _selectedCommunity?.id,
                    creationTime: widget.facility == null
                        ? DateTime.now()
                        : widget.facility.creationTime,
                    imageURL: widget.facility?.imageURL,
                    longDescription: _longDescriptionController.text,
                    shortDescription: _shortDescriptionController.text,
                    title: _titleController.text,
                    file: _pFile == null ? null : new File(_pFile.path),
                    isEnabled: true,
                  );
                  setState(() {
                    _isLoading = true;
                  });
                  await FormUtility.proceed(
                      _facilityFormKey,
                      _facility,
                      widget.facility == null
                          ? 'Add Facility'
                          : 'Edit Facility');
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
