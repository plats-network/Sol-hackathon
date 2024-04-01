part of 'task_detail_page.dart';

extension TaskDetailControllerPageAction on _TaskDetailPageState {
  Future<void> loadGoogleMapMarkers() async {
    // if (mapController == null) return;
    await googleMapControllerCompleter.future;

    final locations = taskDetailController.taskDetail?.locations;

    if (locations == null) return;

    final icon = BitmapDescriptor.fromBytes(await _getBytesFromAsset(
        getAssetImage(AssetImagePath.checkin_marker_inactive), 120));

    final markers = locations.map((e) => Marker(
          markerId: MarkerId(e.id!),
          position: LatLng(double.tryParse(e.lat!)!, double.tryParse(e.long!)!),
          // infoWindow: InfoWindow(title: e.name ?? '', snippet: e.address),
          icon: icon,
          onTap: () {
            var index = locations?.indexWhere((element) => element.id == e.id);

            if (index != null) {
              taskDetailController.setSelectedLocationIndex(index);
              animateToLocation(index);
            }
          },
        ));

    // Override mapMarkers
    taskDetailController.mapMarkers.value = markers.toList();

    taskDetailController.update();
  }

  // This function will be called first when in: screen ready, refresh
  Future<void> refetchTaskDetail() async {
    try {
      taskDetailController.setSelectedLocationIndex(0);
      await taskDetailController.fetchTaskDetail(taskId);
      taskDetailController.sortTaskDetailLocations();

      // this is required from google_maps_flutter, because there is no ways to real time
      // update map markers
      loadGoogleMapMarkers();
    } catch (e) {
      // will catch when the async task is continue to run after the screen is disposed
      devDebugMock(() {
        print('refetchTaskDetail error: $e');
      });
    }
  }

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void animateToLocation(int index) async {
    await googleMapControllerCompleter.future;

    final location = CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(
          double.tryParse(
              taskDetailController.taskDetail?.locations?[index].lat ?? '0')!,
          double.tryParse(
              taskDetailController.taskDetail?.locations?[index].long ?? '0')!,
        ),
        zoom: 14.4746,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 200), () {
        if (mounted) {
          googleMapController.animateCamera(location);
        }
      });
    });
  }
}
