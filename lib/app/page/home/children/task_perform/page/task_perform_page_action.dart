part of 'task_perform_page.dart';

extension TaskPerformPageAction on _TaskPerformPageState {
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timeRemaining.value == 0) {
          timer.cancel();
        } else if (timeRemaining.value - 1 >= 0) {
          final doingTask = taskPerformController.doingTask.value.data;
          if (doingTask?.timeEndOrginalDateTime != null &&
              doingTask?.timeStartOrginalDateTime != null) {
            final startTimeMillis = doingTask
                ?.timeStartOrginalDateTime?.millisecondsSinceEpoch as int;
            final endTimeMillis = doingTask
                ?.timeEndOrginalDateTime?.millisecondsSinceEpoch as int;
            maxTime.value = (endTimeMillis - startTimeMillis) ~/ 1000;
            if (maxTime.value == 0) {
              maxTime.value = 1;
            }
            final nowMillis = DateTime.now().toLocal().millisecondsSinceEpoch;
            if (nowMillis > endTimeMillis) {
              timeRemaining.value = 0;
            } else {
              timeRemaining.value = (endTimeMillis - nowMillis) ~/ 1000;
            }
          }
        } else {
          timeRemaining.value = 0;
        }
        double percent = timeRemaining.value / maxTime.value;
        if (percent <= 0.0) {
          percent = 0.0;
        } else if (percent >= 1.0) {
          percent = 1.0;
        }
        progressPercent.value = percent;
        if (progressPercent.value < PERCENT_COLOR_CHANGE) {
          progressBackgroundColor.value = colorF6D8DA;
          progressColor.value = colorD13E45;
        } else {
          progressBackgroundColor.value = colorE9F4EC;
          progressColor.value = color469B59;
        }
        timeRemainingStr.value = formatDoingTaskTime(timeRemaining.value);
        checkIfCanCheckin();
      },
    );
  }

  /// Check if can checkin
  Future<void> checkIfCanCheckin() async {
    try {
      final currentTaskPerformLocation =
          taskPerformController.doingTask.value.data?.data?.taskLocations;
      if (myLocation != null &&
          myLocation?.latitude != null &&
          myLocation?.longitude != null &&
          currentTaskPerformLocation != null &&
          currentTaskPerformLocation.lat != null &&
          currentTaskPerformLocation.long != null) {
        final endLatitude = double.parse(currentTaskPerformLocation.lat!);
        final endLongitude = double.parse(currentTaskPerformLocation.long!);
        final distanceInMeters = getDistanceFromLatLonInM(myLocation!.latitude!,
            myLocation!.longitude!, endLatitude, endLongitude);
        isCheckinButtonEnable.value = distanceInMeters <=
            (taskPerformController.doingTask.value.data?.data?.near?.radius ??
                100);
      }
    } catch (e) {
      e.printError();
    }
  }

  Future<void> updateMarkers() async {
    final Map<MarkerId, Marker> markers = {};
    // Place my location marker
    try {
      print('Placing my location marker');
      myLocation ??= await Location.instance.getLocation();
      final markerId = MarkerId('MyLocationMarker');
      final marker = Marker(
        markerId: markerId,
        position:
            LatLng(myLocation?.latitude ?? 0.0, myLocation?.longitude ?? 0.0),
        icon: _myLocationMarkerIcon.value!,
      );
      markers[markerId] = marker;
      print('Placed my location marker');
    } catch (e) {
      e.printError();
    }

    print('Placing doing task marker');
    // Place doing task marker
    final currentTaskPerformLocation =
        taskPerformController.doingTask.value.data?.data?.taskLocations;
    if (taskPerformController.doingTask.value.data?.success == true &&
        currentTaskPerformLocation != null) {
      try {
        final markerId = MarkerId(currentTaskPerformLocation.id ?? 'Marker_0');
        final marker = Marker(
          markerId: markerId,
          position: LatLng(double.parse(currentTaskPerformLocation.lat ?? '0'),
              double.parse(currentTaskPerformLocation.long ?? '0')),
          icon: _doingTaskMarkerIcon.value!,
        );
        markers[markerId] = marker;
        print('Placed doing task marker');
        await fetchPolyline(
            currentTaskPerformLocation.lat, currentTaskPerformLocation.long);
      } catch (e) {
        e.printError();
      }
    }
    _markers.value = markers;
  }

  Future<void> fetchPolyline(String? endLat, String? endLong) async {
    try {
      final start =
          LatLng(myLocation?.latitude ?? 0.0, myLocation?.longitude ?? 0.0);
      final end =
          LatLng(double.parse(endLat ?? '0'), double.parse(endLong ?? '0'));
      print('Checking polylines from $start and $end');
      // Check if has saved polylines
      List<LatLng>? lines = fetchSavedPolyLines();
      print('Saved polylines: ${lines?.length}');
      if (lines == null || lines.isEmpty == true) {
        print('Fetching polylines from $start and $end');
        // Fetch polylines and save to storage
        lines = await googleMapPolyline.getCoordinatesWithLocation(
            origin: start, destination: end, mode: RouteMode.driving);
        print('Polylines from $start to $end: ${lines?.length}');
        savePolyline(lines);
      }
      if (lines?.isNotEmpty == true) {
        addPolyline(lines);
      }
    } catch (e) {
      e.printError();
      print('Fetching polylines error: ${e.toString()}');
    }
  }

  List<LatLng>? fetchSavedPolyLines() {
    try {
      final storage = GetStorage();
      final str = storage.read(keySavedPolyLines);
      if (str != null) {
        final jsonArray = jsonDecode(str) as List<dynamic>;
        final coordinates = jsonArray.map((e) => LatLng.fromJson(e) as LatLng);
        return coordinates.toList();
      } else {
        return null;
      }
    } catch (e) {
      e.printError();
    }
    return null;
  }

  Future<void> savePolyline(List<LatLng>? coordinates) async {
    try {
      final storage = GetStorage();
      final jsonArray = coordinates?.map((e) => e.toJson()).toList();
      final json = jsonEncode(jsonArray);
      await storage.write(keySavedPolyLines, json);
    } catch (e) {
      e.printError();
    }
  }

  void addPolyline(List<LatLng>? coordinates) {
    PolylineId id = PolylineId("poly$_polylineCount");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: [],
        color: color469B59,
        points: coordinates!,
        width: dimen4.toInt(),
        onTap: () {});

    if (!mounted) return;

    setState(() {
      _polylines[id] = polyline;
      _polylineCount++;
    });
  }

  void showCheckValidPhoto() {
    GetXDefaultBottomSheet.rawBottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(dimen16),
          child: Column(
            children: [
              Text(
                'check_valid_photos'.tr,
                style: text22_32302D_700,
                textAlign: TextAlign.start,
              ),
              verticalSpace24,
              ClipRRect(
                borderRadius: border16,
                child: Image.network(
                  'https://noithatkendesign.vn/storage/app/media/uploaded-files/duong-restaurant-4.jpg',
                  width: double.infinity,
                  height: dimen300,
                  fit: BoxFit.cover,
                ),
              ),
              verticalSpace24,
              validPhotoCheckSection('face_clearly_fully'.tr),
              verticalSpace24,
              validPhotoCheckSection('brand_logo_included'.tr),
              verticalSpace24,
              validPhotoCheckSection('not_use_bokeh_effect'.tr),
              verticalSpace24,
              AppButton(
                title: 'got_it'.tr,
                onTap: () {
                  Get.back();
                  Get.toNamed(Routes.takePhoto);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget validPhotoCheckSection(String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          getAssetImage(AssetImagePath.ic_check_green),
          width: dimen24,
          height: dimen24,
        ),
        horizontalSpace4,
        Text(
          content,
          style: text14_625F5C_400,
        ),
      ],
    );
  }

  Future<void> _createDoingTaskMarkerImageFromAsset() async {
    if (_doingTaskMarkerIcon.value == null) {
      final Uint8List markerIcon = await getBytesFromAsset(
          getAssetImage(AssetImagePath.checkin_marker_inactive));
      _doingTaskMarkerIcon.value = BitmapDescriptor.fromBytes(markerIcon);
    }
  }

  Future<void> _createMyLocationMarkerImageFromAsset() async {
    if (_myLocationMarkerIcon.value == null) {
      final Uint8List markerIcon = await getBytesFromAsset(
          getAssetImage(AssetImagePath.my_location_marker));
      _myLocationMarkerIcon.value = BitmapDescriptor.fromBytes(markerIcon);
    }
  }

  Future<Uint8List> getBytesFromAsset(String path) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: dimen48.toInt());
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List() as Uint8List;
  }

  void showCancelTaskBottomSheet() {
    GetXDefaultBottomSheet.rawBottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(dimen16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'canceling_your_task'.tr,
                style: text22_32302D_700,
                textAlign: TextAlign.center,
              ),
              verticalSpace24,
              ClipRRect(
                borderRadius: border16,
                child: Image.asset(
                  getAssetImage(AssetImagePath.ic_warning),
                  width: dimen80,
                ),
              ),
              verticalSpace24,
              Center(
                child: Text(
                  'are_you_sure_cancel_task'.tr,
                  style: text14_32302D_400,
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpace24,
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'no'.tr,
                      isPrimaryStyle: false,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                  horizontalSpace16,
                  Expanded(
                    child: AppButton(
                      title: 'yes'.tr,
                      onTap: () {
                        Get.back();
                        taskPerformController.patchCancelTask();
                      },
                    ),
                  ),
                ],
              ),
              verticalSpace16,
            ],
          ),
        ),
      ),
    );
  }
}
