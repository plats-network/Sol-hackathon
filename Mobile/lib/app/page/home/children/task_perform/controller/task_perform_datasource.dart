const mockDoingTaskSuccess = {
  "success": true,
  "message": null,
  "data": {
    "id": "977de94f-458f-4461-a7dc-02e453e81765",
    "time_left": 1665673409,
    "duration": 50,
    "time_start": 1665670409,
    "time_end": 1665673409,
    "time_start_orginal": "2022-10-13 21:13:29",
    "time_end_orginal": "2022-10-13 22:03:29",
    "wallet_address": null,
    "time_expried": false,
    "task": {
      "id": "96be3494-f808-468a-a977-6672239561ae",
      "name": "Check-in at McDonald's",
      "cover_url": "https:\/\/via.placeholder.com\/250x130?text=Cover Image"
    },
    "task_locations": {
      "id": "96be3495-1fbe-434b-8b73-b7098985b502",
      "name": "McDonald's H\u1ed3 G\u01b0\u01a1m",
      "address":
          "2 P. H\u00e0ng B\u00e0i, Tr\u00e0ng Ti\u1ec1n, Ho\u00e0n Ki\u1ebfm, H\u00e0 N\u1ed9i",
      "long": "105.7821377",
      "lat": "21.0467718",
      "sort": 0,
      "close_time": null,
      "open_time": null,
      "phone_number": null
    }
  }
};

const mockCheckInLocationInTaskSuccess = {
  "success": true,
  "message": null,
  "data": {
    "id": "97518a3c-ab78-4e3d-8a13-fae2dd54fd72",
    "user_id": "975188e9-1697-4937-a448-e3e7f68ca6a2",
    "location_id": "96c4006b-53b5-4cf6-a707-4c80dd713c6e",
    "started_at": "2022-09-21 12:51:13",
    "ended_at": "2022-09-21T14:14:33.634132Z",
    "checkin_image":
        "https://dhms0p1aun79c.cloudfront.net/user_tasks/975188e9-1697-4937-a448-e3e7f68ca6a2/96c4006b-08b3-451c-a7e6-ee78d5e76747//E1oGgJh3QEvVbILUrFaCMzxhT4vHg5WtUxKHcnjM.png",
    "activity_log": null
  }
};

const mockCheckInLocationInTaskImageError = {
  "success": false,
  "message": "The image field is required.",
  "data": null,
  "errors": {
    "image": ["The image field is required."]
  },
  "error_code": 1
};

const mockCheckInLocationInTaskError = {
  "message": "Location has been checked-in",
  "exception": "Symfony\\Component\\HttpKernel\\Exception\\HttpException",
  "file":
      "/var/www/actions-plats/vendor/laravel/framework/src/Illuminate/Foundation/Application.php",
  "line": 1151,
  "trace": [
    {
      "file":
          "/var/www/actions-plats/vendor/laravel/framework/src/Illuminate/Foundation/helpers.php",
      "line": 44,
      "function": "abort",
      "class": "Illuminate\\Foundation\\Application",
      "type": "->"
    },
  ]
};

const mockCancelTaskResponseSuccess = {
  "data": {"message": "DONE!"}
};

const mockCancelTaskResponseError = {
  "message": "",
  "exception":
      "Symfony\\Component\\HttpKernel\\Exception\\NotFoundHttpException",
  "file":
      "/var/www/actions-plats/vendor/laravel/framework/src/Illuminate/Routing/AbstractRouteCollection.php",
  "line": 44,
  "trace": [
    {
      "file":
          "/var/www/actions-plats/vendor/laravel/framework/src/Illuminate/Routing/RouteCollection.php",
      "line": 162,
      "function": "handleMatchedRoute",
      "class": "Illuminate\\Routing\\AbstractRouteCollection",
      "type": "->"
    }
  ]
};
