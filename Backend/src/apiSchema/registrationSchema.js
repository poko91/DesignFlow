// Required modules
const Ajv = require("ajv");
const addFormats = require('ajv-formats');

const ajv_registration = new Ajv({ allErrors: true });
addFormats(ajv_registration);
const registrationSchema = {
    type: "object",
    properties: {
      email: { type: "string", format: "email" },
      password: { type: "string", maxLength: 60 },
      studio_name: { type: "string", maxLength: 255 },
      business_add: { type: ["string", "null"], maxLength: 255 },
    },
    required: ["email", "password", "studio_name"]
  };
  const validateRegistration = ajv_registration.compile(registrationSchema);

module.exports = validateRegistration;