import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumnaam/models/facility.dart';
import 'package:gumnaam/models/user.dart';
import 'package:gumnaam/screens/private/admin/add_community.dart';
import 'package:gumnaam/screens/private/admin/add_facility.dart';
import 'package:gumnaam/screens/private/admin/admin_dashboard.dart';
import 'package:gumnaam/widgets/text_widget.dart';

class AdminHome extends StatefulWidget {
  final User user;
  final int currentIndex;
  final Function changeBottomIndex;
  AdminHome({
    this.user,
    this.currentIndex,
    this.changeBottomIndex,
  });
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Facility _facility;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Center(child: _resolveAdminHome(context)),
    );
  }

  Widget _resolveAdminHome(BuildContext context) {
    switch (widget.currentIndex) {
      case 0:
        return _getHome(context);
        break;
      case 1:
        return _getCommunity(context);
        break;
      case 2:
        return _getFacility(context);
        break;
      default:
        return _getHome(context);
    }
  }

  void _changeSelectedIndex(int index, Facility facility){
    setState(() {
      _facility = facility;
    });
    widget.changeBottomIndex(index);
  }

  Widget _getHome(BuildContext context) {
    return AdminDashboard(
      changeIndex: _changeSelectedIndex,
    );
  }

  Widget _getFacility(BuildContext context) {
    return AddFacility(
      facility: _facility,
    );
  }

  Widget _getCommunity(BuildContext context) {
    return AddCommunity();
  }
}
