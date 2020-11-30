import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumnaam/services/storage/avatar_service.dart';
import 'package:gumnaam/services/storage/avatar_storage_service.dart';
import 'package:provider/provider.dart';
import '../../models/community.dart';
import '../../models/facility.dart';
import '../../models/model.dart';
import '../../services/auth/auth_service.dart';
import '../../services/db/community_service.dart';
import '../../services/db/facility_service.dart';
import '../../models/user.dart';

class FormUtility {
  static final int _minPasswordLength = 6;
  static final int _maxCommunityTitleLength = 10;
  static final int _maxCommunityDescriptionLength = 25;

  static final String _emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String fieldValidator(String value, String label) {
    if (value == null || value.isEmpty) {
      if (label == 'First Name') {
        return "First Name is mandatory.";
      } else if (label == 'Last Name') {
        return "Last Name is mandatory.";
      } else if (label == 'Email') {
        return "Email is mandatory.";
      } else if (label == 'Password') {
        return "Password is mandatory.";
      } else if (label == 'Community Title') {
        return "Community Title is mandatory.";
      } else if (label == 'Short Description') {
        return "Short Description is mandatory.";
      } else if (label == 'Facility Title') {
        return "Facility Title is mandatory.";
      } else if (label == 'Long Description') {
        return "Long Description is mandatory.";
      } else if (label == 'Community') {
        return "Community is mandatory.";
      }
    } else {
      if (label == 'Email') {
        bool emailValid = RegExp(_emailPattern).hasMatch(value);
        if (!emailValid) {
          return 'The Email address is badly formatted';
        }
      } else if (label == 'Password') {
        if (value.length < _minPasswordLength) {
          return "Password should be at least of $_minPasswordLength characters.";
        }
      } else if (label == 'Community Title') {
        if (value.length > _maxCommunityTitleLength) {
          return "Community Title should be less than of $_maxCommunityTitleLength characters.";
        }
      } else if (label == 'Short Description') {
        if (value.length > _maxCommunityDescriptionLength) {
          return "Short Description should be less than of $_maxCommunityDescriptionLength characters.";
        }
      }
    }
    return null;
  }

  static Future<Object> proceed(
    GlobalKey<FormState> key,
    Model model,
    String action,
  ) async {
    try {
      AuthService _authService = AuthService();

      if (!key.currentState.validate()) {
        return null;
      }

      switch (action) {
        case 'Login':
          User user = model;
          final String response = await _authService.loginWithEmailAndPassword(
            user: user,
          );
          print('hsdbhjds');
          return response;
        //break;
        case 'Signup':
          User user = model;
          await _authService.registerUser(
            user: user,
          );
          return null;
        case 'Add Community':
          Community community = model;
          CommunityService _communityService = CommunityService(
            uid: null,
          );
          await _communityService.addCommunity(community);
          return null;
        case 'Add Facility':
          Facility facility = model;
          if (facility.file == null) {
            return null;
          }
          FacilityService _facilityService = FacilityService(
            uid: null,
          );
          AvatarStorageService serv = AvatarStorageService(
            uid: null,
          );
          final String imageURL = await serv.uploadFacility(
            file: facility.file,
            key: facility.title,
          );
          facility.imageURL = imageURL;
          await _facilityService.addFacility(facility);
          break;
        case 'Edit Facility':
          Facility facility = model;
          if (facility.file == null && facility.imageURL == null) {
            return null;
          }
          FacilityService _facilityService = FacilityService(
            uid: null,
          );
          AvatarStorageService serv = AvatarStorageService(
            uid: null,
          );
          if (facility.file != null) {
            final String imageURL = await serv.uploadFacility(
              file: facility.file,
              key: facility.title,
            );
            facility.imageURL = imageURL;
          }

          await _facilityService.updateFacility(facility);
          break;
        default:
          return null;
      }
    } catch (err) {
      print('Error ' + err.toString());
    }
  }
}
