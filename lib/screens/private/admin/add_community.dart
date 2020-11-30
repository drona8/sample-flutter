import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumnaam/models/community.dart';
import 'package:gumnaam/services/utility/form_utility.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/text_widget.dart';

class AddCommunity extends StatefulWidget {
  @override
  _AddCommunityState createState() => _AddCommunityState();
}

class _AddCommunityState extends State<AddCommunity> {
  final GlobalKey<FormState> _communityFormKey = GlobalKey<FormState>();

  TextEditingController _titleController, _descriptionController;

  @override
  void initState() {
    _titleController = new TextEditingController();
    _descriptionController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _communityFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                hintText: 'Community Title',
                suffixIconPath: 'assets/icons/phone.png',
                obscureText: false,
                controller: _titleController,
              ),
              TextWidget(
                hintText: 'Short Description',
                suffixIconPath: 'assets/icons/phone.png',
                obscureText: false,
                controller: _descriptionController,
                maxLine: 5,
              ),
              AppButton(
                label: _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Add Community',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                onPressed: () async {
                  Community _community = Community(
                    label: _titleController.text,
                    description: _descriptionController.text,
                  );
                  setState(() {
                    _isLoading = true;
                  });
                  await FormUtility.proceed(
                      _communityFormKey, _community, 'Add Community');
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
