import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/index/model/index_reponse.dart'
    as indexReposen;
import 'package:plat_app/app/page/home/page/index/model/list_ongoing_event_reponse.dart';
import 'package:plat_app/app/page/home/page/index/model/ongoing_event_reponse.dart';
import 'package:plat_app/app/page/home/page/index/model/trending_event_reponse.dart';
import 'package:plat_app/app/page/home/page/index/provider/index_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/model/social_network_reponse.dart'
    as like_or_pin;

class IndexController extends GetxController {
  final IndexProvider indexProvider = Get.find();
  final recommendedTask =
      Rx(NetworkResource<indexReposen.IndexResponse>.init());
  final eventTask = Rx(NetworkResource<indexReposen.IndexResponse>.init());

  final participatingEventTask =
      Rx(NetworkResource<ListOngoingEventResponse>.init());
  final submitLikeOrPin =
      Rx(NetworkResource<like_or_pin.JoinOrPinResponse>.init());

  final allEvent = Rx(NetworkResource<EventResponse>.init());
  final trendingEvent = Rx(NetworkResource<EventResponse>.init());
  final upcomingEvent = Rx(NetworkResource<EventResponse>.init());
  final registeredEvent = Rx(NetworkResource<EventResponse>.init());
  final ongoingEvent = Rx(NetworkResource<OngoingEventResponse>.init());

  // events
  Future<void> fetchAllEvent() async {
    allEvent.value = NetworkResource.loading();

    final result = await indexProvider.allEvents();
    NetworkResource.handleResponse(
      result,
      EventResponse.fromJson,
      allEvent,
    );
  }

  bool isFetchingAllEvent() {
    return allEvent.value.isLoading();
  }

  bool isAllEventFetchSuccess() {
    return allEvent.value.isSuccess();
  }

  //trending event
  Future<void> fetchTrendingEvent() async {
    trendingEvent.value = NetworkResource.loading();

    final result = await indexProvider.trendingEvents();
    NetworkResource.handleResponse(
      result,
      EventResponse.fromJson,
      trendingEvent,
    );
  }

  bool isFetchingTrendingEvent() {
    return trendingEvent.value.isLoading();
  }

  bool isTrendingEventFetchSuccess() {
    return trendingEvent.value.isSuccess();
  }

  //upcoming event
  Future<void> fetchUpcomingEvent() async {
    upcomingEvent.value = NetworkResource.loading();

    final result = await indexProvider.upcomingEvents();
    NetworkResource.handleResponse(
      result,
      EventResponse.fromJson,
      upcomingEvent,
    );
  }

  bool isFetchingUpcomingEvent() {
    return upcomingEvent.value.isLoading();
  }

  bool isTrendingUpcomingSuccess() {
    return upcomingEvent.value.isSuccess();
  }

  //registered event
  Future<void> fetchRegisteredEvent() async {
    registeredEvent.value = NetworkResource.loading();

    final result = await indexProvider.registeredEvents();
    NetworkResource.handleResponse(
      result,
      EventResponse.fromJson,
      registeredEvent,
    );
  }

  bool isFetchingRegisteredEvent() {
    return registeredEvent.value.isLoading();
  }

  bool isTrendingRegisteredSuccess() {
    return registeredEvent.value.isSuccess();
  }

  //participating event
  Future<void> fetchParticipatingEvent() async {
    participatingEventTask.value = NetworkResource.loading();

    final result = await indexProvider.eventImprgress();
    NetworkResource.handleResponse(
      result,
      ListOngoingEventResponse.fromJson,
      participatingEventTask,
    );
  }

  bool isFetchingParticipatingEvent() {
    return participatingEventTask.value.isLoading();
  }

  bool isParticipatingEventFetchSuccess() {
    return participatingEventTask.value.isSuccess();
  }

  //ongoing Event
  Future<void> fetchOngoingEvent(String eventId) async {
    ongoingEvent.value = NetworkResource.loading();

    final result = await indexProvider.ongoingEvent(eventId);
    NetworkResource.handleResponse(
      result,
      OngoingEventResponse.fromJson,
      ongoingEvent,
    );
  }

  bool isFetchingOngoingEvent() {
    return ongoingEvent.value.isLoading();
  }

  bool isOngoingEventFetchSuccess() {
    return ongoingEvent.value.isSuccess();
  }

// //
//   Future<void> fetchTaskEvent() async {
//     eventTask.value = NetworkResource.loading();

//     final result = await indexProvider.topEvents('event');
//     NetworkResource.handleResponse(
//       result,
//       indexReposen.IndexResponse.fromJson,
//       eventTask,
//     );
//   }

//   bool isFetchingTopEvent() {
//     return eventTask.value.isLoading();
//   }

//   bool isTopEventFetchSuccess() {
//     return eventTask.value.isSuccess();
//   }

//   Future<void> fetchLikeOrPin(String taskId, String type) async {
//     submitLikeOrPin.value = NetworkResource.loading();

//     final result = await indexProvider.LikeOrPinTask(taskId, type);
//     NetworkResource.handleResponse(
//       result,
//       like_or_pin.JoinOrPinResponse.fromJson,
//       submitLikeOrPin,
//     );
//   }
}
