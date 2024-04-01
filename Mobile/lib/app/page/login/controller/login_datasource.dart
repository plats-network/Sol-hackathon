const mockLoginResponseSuccess = {
  "success": true,
  "message": "Logged in successfully.",
  "data": {
    "id": "97104c45-45d5-49db-a061-c0aa9e9c77b2",
    "role": 1,
    "name": "Hello Test",
    "email": "phunv@vaixgroup.com",
    "email_verified_at": null,
    "created_at": "2022-08-20T02:29:08.000000Z",
    "updated_at": "2022-08-20T02:29:08.000000Z",
    "deleted_at": null,
    "jwt": {
      "access_token":
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vdXNlci5wbGF0cy5uZXR3b3JrL2FwaS9sb2dpbiIsImlhdCI6MTY2MzQwMDYyOSwiZXhwIjoxNjY1OTkyNjI5LCJuYmYiOjE2NjM0MDA2MjksImp0aSI6InRVOTVkVGJCc0FXMzh4ZkYiLCJzdWIiOiI5NzEwNGM0NS00NWQ1LTQ5ZGItYTA2MS1jMGFhOWU5Yzc3YjIiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3IiwiaWQiOiI5NzEwNGM0NS00NWQ1LTQ5ZGItYTA2MS1jMGFhOWU5Yzc3YjIiLCJyb2xlIjoxLCJuYW1lIjoiSGVsbG8gVGVzdCIsImVtYWlsIjoicGh1bnZAdmFpeGdyb3VwLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjpudWxsLCJjcmVhdGVkX2F0IjoiMjAyMi0wOC0yMFQwMjoyOTowOC4wMDAwMDBaIiwidXBkYXRlZF9hdCI6IjIwMjItMDgtMjBUMDI6Mjk6MDguMDAwMDAwWiIsImRlbGV0ZWRfYXQiOm51bGx9.ucgudKtKMaYZeTaKZQuMuSo6Og9bHfNQtH1T0SKE3P0",
      "token_type": "bearer",
      "expires_in": 870912000
    }
  }
};

const mockLoginResponseFailed = {
  "success": false,
  "message": "These credentials do not match our records.",
  "data": null,
  "error_code": 1
};

const mockLoginAccount = {
  'email': 'admin@plats.network',
  'password': '123456a@',
};
