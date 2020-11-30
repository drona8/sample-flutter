import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gumnaam/models/booking.dart';
import 'package:gumnaam/models/facility.dart';
import 'package:gumnaam/services/db/booking_service.dart';
import 'package:gumnaam/services/image/app_cached_network_image.dart';
import 'package:gumnaam/services/utility/alert_utility.dart';
import 'package:gumnaam/services/utility/time_utility.dart';
import 'package:gumnaam/style/color.dart';
import 'package:gumnaam/widgets/label_widget.dart';
import 'package:gumnaam/widgets/time_slot.dart';
import 'package:provider/provider.dart';

class FacilityDetails extends StatefulWidget {
  final Facility facility;
  FacilityDetails({this.facility});
  @override
  _FacilityDetailsState createState() => _FacilityDetailsState();
}

class _FacilityDetailsState extends State<FacilityDetails> {
  TimeOfDay startTime;
  TimeOfDay endTime;
  Duration step;
  BookingService _bookingService;

  List<String> times;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    startTime = TimeOfDay(hour: 8, minute: 0);
    endTime = TimeOfDay(hour: 20, minute: 0);
    step = Duration(minutes: 60);
    times = TimeUtility.getTimes(startTime, endTime, step)
        .map((tod) => tod.format(context))
        .toList();
  }

  Widget _getDialogMessage(int j) {
    return RichText(
      text: TextSpan(
        text: 'Do you want to book ',
        style: Theme.of(context).textTheme.headline3,
        children: <TextSpan>[
          TextSpan(
              text: widget.facility.title,
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' at ', style: Theme.of(context).textTheme.headline3),
          TextSpan(
            text: times.elementAt(j),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Map<String, List<String>> _buildMap(QuerySnapshot qs) {
    List<Booking> _bookingList;
    Map<String, List<String>> _map;
    _bookingList = qs.docs.map((e) {
      Booking booking = Booking.fromMap(e.data());
      booking.id = e.id;
      return booking;
    }).toList();
    for (Booking book in _bookingList) {
      if (book.facilityId != widget.facility.id) {
        continue;
      }
      if (_map == null) {
        _map = new Map<String, List<String>>();
      }
      if (_map.containsKey(book.bookingDate.day.toString())) {
        List<String> _list = _map.entries
            .firstWhere(
                (element) => element.key == book.bookingDate.day.toString(),
                orElse: () => null)
            .value;
        _list.add(book.bookingTimeSlot);
        _map.update(book.bookingDate.day.toString(), (value) => _list);
      } else {
        List<String> _list = [book.bookingTimeSlot];
        _map.putIfAbsent(book.bookingDate.day.toString(), () => _list);
      }
    }
    return _map;
  }

  Widget _getBookingWidget(BuildContext context) {
    return StreamBuilder(
      stream: _bookingService.getAllBookings(),
      builder: (context, snapshot) {
        print('gggg');
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        QuerySnapshot qs = snapshot.data;
        Map<String, List<String>> _map;

        if (qs != null && qs.docs != null && qs.docs.length > 0) {
          _map = _buildMap(qs);
        } else {}
        print('MAP '+_map.toString());
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 10,
              columns: _getDataColumn(context),
              rows: _getDataRow(context, _map),
            ),
          ),
        );
      },
    );
  }

  List<DataColumn> _getDataColumn(BuildContext context) {
    return <DataColumn>[
      for (int k = 0; k < 7; k++)
        DataColumn(
          label: Align(
            child: TimeUtility.getFittedBox(context, k),
            alignment: Alignment.centerLeft,
          ),
        ),
    ];
  }

  List<DataRow> _getDataRow(
      BuildContext context, Map<String, List<String>> map) {
    return <DataRow>[
      for (int j = 0; j < times.length; j++)
        DataRow(
          cells: <DataCell>[
            for (int k = 0; k < 7; k++)
              DataCell(
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () async {
                      if (map != null &&
                          map.containsKey(DateTime.now()
                              .add(Duration(days: k))
                              .day
                              .toString())) {
                        List<String> _list = map.entries
                            .firstWhere(
                              (element) =>
                                  element.key ==
                                  (DateTime.now().add(Duration(days: k)).day)
                                      .toString(),
                              orElse: () => null,
                            )
                            .value;
                        if (_list.contains(times.elementAt(j))) {
                          return;
                        }
                      }
                      Booking _booking = Booking(
                        bookingDate: DateTime(
                          DateTime.now().add(Duration(days: k)).year,
                          DateTime.now().add(Duration(days: k)).month,
                          DateTime.now().add(Duration(days: k)).day,
                          0,
                          0,
                          0,
                        ),
                        bookingTimeSlot: times.elementAt(j),
                        facilityId: widget.facility.id,
                      );
                      await AlertUtility.showAlertDialog(context,
                          _getDialogMessage(j), _booking, _bookingService);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TimeSlot(
                        slot: times.elementAt(j),
                        color: map != null
                            ? map.entries.firstWhere(
                                      (element) =>
                                          element.key ==
                                          (DateTime.now()
                                                  .add(Duration(days: k))
                                                  .day)
                                              .toString(),
                                      orElse: () => null,
                                    ) !=
                                    null
                                ? map.entries
                                        .firstWhere(
                                          (element) =>
                                              element.key ==
                                              (DateTime.now()
                                                      .add(Duration(days: k))
                                                      .day)
                                                  .toString(),
                                          orElse: () => null,
                                        )
                                        .value
                                        .contains(times.elementAt(j))
                                    ? AppColor.green
                                    : AppColor.BLUE
                                : AppColor.BLUE
                            : AppColor.BLUE,
                        textColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
    ];
  }

  Widget _getBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Hero(
                  tag: 'hero-${widget.facility.id}',
                  child: AppCachedNetworkImage(
                    imageURL: widget.facility.imageURL,
                  ),
                ),
              ),
              LabelWidget(
                label: widget.facility.shortDescription,
              ),
              LabelWidget(
                label: widget.facility.longDescription,
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10)),
            height: MediaQuery.of(context).size.height * 0.4,
            child: _getBookingWidget(context),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _bookingService = Provider.of<BookingService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.facility.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(child: _getBody(context)),
    );
  }
}
