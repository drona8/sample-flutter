import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:gumnaam/services/db/booking_service.dart';
import '../services/auth/auth_service.dart';
import '../services/db/community_service.dart';
import '../services/db/facility_service.dart';
import '../services/storage/avatar_service.dart';
import '../services/storage/avatar_storage_service.dart';
import '../services/db/user_service.dart';
import 'package:provider/provider.dart';

class AppWrapperBuilder extends StatelessWidget {
  const AppWrapperBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<auth.User>) builder;
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<auth.User>(
      stream: authService.user,
      builder: (context, snapshot) {
        final auth.User user = snapshot.data;

        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<auth.User>.value(value: user),
              Provider<UserService>(
                create: (_) => UserService(uid: user.uid),
              ),
              Provider<AvatarService>(
                create: (_) => AvatarService(uid: user.uid),
              ),
              Provider<AvatarStorageService>(
                create: (_) => AvatarStorageService(uid: user.uid),
              ),
              Provider<CommunityService>(
                create: (_) => CommunityService(uid: user.uid),
              ),
              Provider<FacilityService>(
                create: (_) => FacilityService(uid: user.uid),
              ),
              Provider<BookingService>(
                create: (_) => BookingService(uid: user.uid),
              ),
              
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
