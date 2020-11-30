import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumnaam/models/facility.dart';
import 'package:gumnaam/services/db/facility_service.dart';
import 'package:gumnaam/services/image/app_cached_network_image.dart';
import 'package:provider/provider.dart';

class FacilityCard extends StatefulWidget {
  final Facility facility;
  final bool flag;
  final Function changeIndex;
  FacilityCard({this.facility, this.flag, this.changeIndex});
  @override
  _FacilityCardState createState() => _FacilityCardState();
}

class _FacilityCardState extends State<FacilityCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shadowColor: Color.fromRGBO(105, 105, 105, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: _getFacilityCard(context),
      ),
    );
  }

  Widget _getFacilityCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.33,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: 'hero-${widget.facility.id}',
                              child: AppCachedNetworkImage(
                  imageURL: widget.facility.imageURL,
                ),
              ),
            ),
          ),
          _getFooter(context),
        ],
      ),
    );
  }

  Widget _getFooter(BuildContext context) {
    final facilityService =
        Provider.of<FacilityService>(context, listen: false);
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.facility.title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          widget.changeIndex != null
              ? Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await facilityService.removeFacility(
                          widget.facility.id,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        widget.changeIndex(2, widget.facility);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.pink,
                      ),
                      onPressed: () async {
                        await facilityService.disabledFacility(
                            widget.facility.id, widget.flag);
                      },
                    ),
                  ],
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
