const mockProfileResponseSuccess = {
  "data": {
    "id": "97104c45-45d5-49db-a061-c0aa9e9c77b2",
    "role": 1,
    "name": "Updated",
    "email": "phunv@vaixgroup.com",
    "email_verified_at": null,
    "gender": null,
    "birth": null,
    "avatar_path":
        "https://lumiere-a.akamaihd.net/v1/images/nt_avatarmcfarlanecomic-con_223_01_2deace02.jpeg",
    "confirmation_code": null,
    "created_at": "2022-08-20T02:29:08.000000Z",
    "updated_at": "2022-10-03T13:33:48.000000Z",
    "deleted_at": null
  }
};

const mockProfileResponseError = {
  "success": false,
  "message": "Not Found",
  "data": null,
  "error_code": 1
};

const mockUpdateAvatarResponseSuccess = {
  "success": true,
  "data":
      "/storage/uploads/profiles/20221026/1666792714.GLBvweOjj8aTz4N7F04xwtCFMgfYkJ3Sdt9a3yd5.png",
  "message": "Update successful"
};

const mockUpdateAvatarResponseError = {
  "success": false,
  "message": "The avatar field is required.",
  "data": null,
  "errors": {
    "avatar": ["The avatar field is required."]
  },
  "error_code": 9
};
