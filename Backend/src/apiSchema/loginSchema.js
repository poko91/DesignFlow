// Required modules
const Ajv = require('ajv');
const addFormats = require('ajv-formats');

const ajv_login = new Ajv({ allErrors: true });
addFormats(ajv_login);
const loginSchema = {
    type: "object",
    properties: {
      email: { type: "string", format: "email" },
      password: { type: "string", maxLength: 60 },
      studio_name: { type: "string", maxLength: 255 },
      business_add: { type: "string", maxLength: 255 },
    },
    required: ["email", "password"]
  };
  const validateLogin = ajv_login.compile(loginSchema);

module.exports = validateLogin;