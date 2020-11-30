import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumnaam/models/community.dart';
import 'package:gumnaam/models/facility.dart';
import 'package:gumnaam/services/db/community_service.dart';
import 'package:gumnaam/services/db/facility_service.dart';
import 'package:gumnaam/services/utility/form_utility.dart';
import 'package:gumnaam/widgets/dropdown_widget.dart';
import 'package:gumnaam/widgets/facility_card.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  final Function changeIndex;
  AdminDashboard({
    this.changeIndex,
  });
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  Community _selectedCommunity;
  FacilityService facilityService;

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

  @override
  Widget build(BuildContext context) {
    facilityService = Provider.of<FacilityService>(context, listen: false);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 100,
              child: _getCommunity(context),
            ),
            _selectedCommunity != null
                ? Align(
                    child: Text(
                      'Active Facility:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    alignment: Alignment.centerLeft,
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 20,
            ),
            _selectedCommunity != null
                ? _getFacilityStream(context, false)
                : Text(
                    'Select Community',
                    style: Theme.of(context).textTheme.headline3,
                  ),
            SizedBox(
              height: 20,
            ),
            _selectedCommunity != null
                ? Align(
                    child: Text(
                      'Inactive Facility:',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    alignment: Alignment.centerLeft,
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 20,
            ),
            _selectedCommunity != null
                ? _getFacilityStream(context, true)
                : SizedBox.shrink(),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget _getFacilityStream(BuildContext context, bool flag) {
    return StreamBuilder(
      stream: facilityService.getAllFacility(_selectedCommunity, !flag),
      builder: (context, snapshot) {
        print('sdvgsdh ' + flag.toString());
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        QuerySnapshot qs = snapshot.data;
        if (qs != null && qs.docs != null && qs.docs.length > 0) {
          List<Facility> _facilityList = qs.docs.map((QueryDocumentSnapshot e) {
            Facility fac = Facility.fromMap(e.data());
            fac.id = e.id;
            return fac;
          }).toList();
          return _getFacilityCard(context, _facilityList, flag);
        } else {
          return Text(
            'No Facility for community ${_selectedCommunity.label}',
            style: Theme.of(context).textTheme.headline3,
          );
        }
      },
    );
  }

  Widget _getFacilityCard(
      BuildContext context, List<Facility> facilityList, bool flag) {
    return Container(
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: facilityList.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: FacilityCard(
              facility: facilityList.elementAt(index),
              flag: flag,
              changeIndex: widget.changeIndex,
            ),
          );
        },
      ),
    );
  }
}
