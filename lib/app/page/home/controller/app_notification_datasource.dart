const mockCreateFCMDeviceTokenResponseSuccess = {
  "success": true,
  "message": "Create successful token.",
  "data": {
    "user_id": "9769d241-3a27-4bd4-aeef-895eb8485bf5",
    "token":
        "APA91bFoi3lMMre9G3XzR1LrF4ZT82_15MsMdEICogXSLB8-MrdkRuRQFwNI5u8Dh0cI90ABD3BOKnxkEla8cGdisbDHl5cVIkZah5QUhSAxzx4Roa7b4xy9tvx9iNSYw-eXBYYd8k1XKf8Q_Qq1X9-x-U-Y79vdPq",
    "device_name": "iOS",
    "agent_info":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36",
    "login_count": 1,
    "ip_address": "172.68.253.68",
    "updated_at": "2022-10-08T09:53:48.000000Z",
    "created_at": "2022-10-08T09:53:48.000000Z"
  }
};

const mockCreateFCMDeviceTokenResponseError = {
  "success": false,
  "message": "The token field is required.",
  "data": null,
  "errors": {
    "token": ["The token field is required."]
  },
  "error_code": 1
};

const mockTestNotiResponse = {
  "success": true,
  "message": "Push notice successfull!",
  "data": null
};

const mockFCMCreateTaskResponse = {
  "notification": {
    "title": "Có task mới",
    "description": "Mô tả task mới",
    "icon": "https://i.imgur.com/UuCaWFA.png"
  },
  "data": {"action": "NEW_TASK", "task_id": "96be3494-f808-468a-a977-6672239561ae"}
};

const mockFCMTaskExpiredResponse = {
  "notification": {
    "title": "Task sắp hết hạn",
    "description": "Mô tả",
    "icon": "https://i.imgur.com/UuCaWFA.png"
  },
  "data": {"action": "TASK_INPROGRESS", "task_id": "96be3494-f808-468a-a977-6672239561ae"}
};

const mockFCMReceiveBoxResponse = {
  "notification": {
    "title": "Nhận đc bonus box",
    "description": "Mô tả",
    "icon": "https://i.imgur.com/UuCaWFA.png"
  },
  "data": {"action": "BOX", "box_id": "1323-1312-3213-3123123"}
};

const mockFCMReceiveVoucherResponse = {
  "notification": {
    "title": "Nhận đc voucher",
    "description": "Mô tả",
    "icon": "https://i.imgur.com/UuCaWFA.png"
  },
  "data": {"action": "VOUCHER", "voucher_id": "1323-1312-3213-3123123"}
};
