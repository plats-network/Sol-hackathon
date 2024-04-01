const mockRegisterAccount = {
  'fullName': 'test',
  'email': 'hopthucuatin@yopmail.com',
  'password': '12345678',
  'confirmPassword': '12345678',
};

const mockRegisterSuccess = {
  "success": true,
  "message": "We have e-mailed your password reset link!",
  "data": null
};

const mockRegisterFail = {
  "success": false,
  "message": "The email has already been taken.",
  "data": null,
  "errors": {
    "email": ["The email field is required."],
    "password": ["The password field is required."],
    "name": ["The name field is required."]
  },
  "error_code": 1
};
