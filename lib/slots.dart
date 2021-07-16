import 'package:flutter/material.dart';

class Slots extends StatefulWidget {
  final List slots;

  const Slots({
    Key? key,
    required this.slots,
  }) : super(key: key);
  @override
  _SlotsState createState() => _SlotsState();
}

class _SlotsState extends State<Slots> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Available Slots',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: widget.slots.length,
            itemBuilder: (BuildContext context, index) {
              if (widget.slots[index]['available_capacity_dose1'] == 0 &&
                  widget.slots[index]['available_capacity_dose2'] == 0)
                return SizedBox.shrink();
              return Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.all(12.0),
                height: 300.0,
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Center ID: ' +
                          widget.slots[index]['center_id'].toString(),
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text('Center Name: ' + widget.slots[index]['name'],
                        style: TextStyle(fontSize: 18.0)),
                    Text('Center Address: ' + widget.slots[index]['address'],
                        style: TextStyle(fontSize: 18.0)),
                    Divider(),
                    Text('Vaccine Name: ' + widget.slots[index]['vaccine'],
                        style: TextStyle(fontSize: 18.0)),
                    Divider(),
                    Text('Slots: ' + widget.slots[index]['slots'].toString(),
                        style: TextStyle(fontSize: 18.0)),
                    const SizedBox(height: 8.0),
                    Text(
                        'Available Dose1: ' +
                            widget.slots[index]['available_capacity_dose1']
                                .toString(),
                        style: TextStyle(fontSize: 18.0)),
                    Text(
                        'Available Dose2: ' +
                            widget.slots[index]['available_capacity_dose2']
                                .toString(),
                        style: TextStyle(fontSize: 18.0))
                  ],
                ),
              );
            }),
      ),
    );
  }
}
