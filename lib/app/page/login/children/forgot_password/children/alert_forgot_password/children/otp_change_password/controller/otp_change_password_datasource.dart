const mockChangePasswordResponseSuccess = {
  "data": {
    "id": "97104c45-45d5-49db-a061-c0aa9e9c77b2",
    "role": 1,
    "name": "Hello Test",
    "email": "phunv@vaixgroup.com",
    "email_verified_at": null,
    "created_at": "2022-08-20T09:29:08.000000Z",
    "updated_at": "2022-10-02T14:08:11.000000Z",
    "deleted_at": null
  }
};

const mockChangePasswordResponseError = {
  "success": false,
  "message": "The password field is required.",
  "data": {
    "id": "97104c45-45d5-49db-a061-c0aa9e9c77b2",
    "role": 1,
    "name": "Hello Test",
    "email": "phunv@vaixgroup.com",
    "email_verified_at": null,
    "created_at": "2022-08-20T09:29:08.000000Z",
    "updated_at": "2022-10-02T14:08:11.000000Z",
    "deleted_at": null
  },
  "errors": {
    "password": ["The password field is required."]
  },
  "error_code": 1
};
