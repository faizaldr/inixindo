import 'package:flutter/material.dart';
import 'package:inixindo/modules/location/datas/location_api.dart';
import 'package:inixindo/modules/location/models/location_model.dart';
import 'package:inixindo/widgets/forms/form_input.dart';

class LocationFormPage extends StatefulWidget {
  Data? data;

  LocationFormPage({this.data});

  @override
  State<StatefulWidget> createState() {
    return _LocationFormPageState();
  }
}

class _LocationFormPageState extends State<LocationFormPage> {
  TextEditingController _placeNameC = TextEditingController();
  TextEditingController _placeTypeC = TextEditingController();
  TextEditingController _commentC = TextEditingController();
  TextEditingController _latitudeC = TextEditingController();
  TextEditingController _longitudeC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initLocationModel();
  }

  void _initLocationModel() async {
    if (widget.data != null) {
      setState(() {
        _placeNameC.text = widget.data!.placeName!;
        _placeTypeC.text = widget.data!.placeType!;
        _commentC.text = widget.data!.comment!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.data == null ? "Tambah Lokasi" : "Ubah Info Lokasi"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            FormInput(controller: _placeNameC, labelText: "Nama Lokasi"),
            FormInput(controller: _placeTypeC, labelText: "Jenis Tempat"),
            FormInput(controller: _commentC, labelText: "Komentar"),
            Row(
              children: [
                Expanded(
                  child: FormInput(
                    controller: _latitudeC,
                    labelText: "Latitude",
                    isEnabled: false,
                  ),
                ),
                Expanded(
                  child: FormInput(
                    controller: _longitudeC,
                    labelText: "Longitude",
                    isEnabled: false,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: actionSave,
                label: Text(widget.data == null ? "Simpan" : "Ubah"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void actionSave() async {
    final bool result = await LocationApi().saveLocations(
      id: widget.data != null ? widget.data!.documentId : null,
      placeName: _placeNameC.text,
      placeType: _placeTypeC.text,
      comment: _commentC.text,
      latitude: double.tryParse(_latitudeC.text) ?? 0.0,
      longitude: double.tryParse(_longitudeC.text) ?? 0.0,
    );

    var snackBar;
    if (result == true) {
      snackBar = SnackBar(content: Text("Berhasil"));
    } else {
      snackBar = SnackBar(content: Text("Gagal"));
    }

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
