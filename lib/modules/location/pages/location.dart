import 'package:flutter/material.dart';
import 'package:inixindo/modules/location/datas/location_api.dart';
import 'package:inixindo/modules/location/models/location_model.dart';
import 'package:inixindo/modules/location/pages/location_form.dart';

class LocationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocationPageState();
  }
}

class _LocationPageState extends State<LocationPage> {
  LocationModel? _locationModel;

  @override
  void initState() {
    super.initState();
    _initLocationModel();
  }

  void _initLocationModel() async {
    _locationModel = await LocationApi().getLocations();
    setState(() {
      _locationModel = _locationModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: actionDetail,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("Data Lokasi"), centerTitle: true),
      body: _locationModel == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _locationModel!.data!.length,
              itemBuilder: (context, index) {
                var data = _locationModel!.data![index];
                return InkWell(
                  onTap: () {
                    actionDetail(data: data);
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Text(
                          "${data.placeName!} (${data.placeType!})",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(data.comment!),
                        Text("${data.latitude} , ${data.longitude}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void actionDetail({Data? data = null}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LocationFormPage(data: data)),
    );
  }
}
