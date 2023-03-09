// Required modules
const Ajv = require('ajv');
const addFormats = require('ajv-formats');

const ajv_password = new Ajv({ allErrors: true });
addFormats(ajv_password);
const passwordSchema = {
    type: "object",
    properties: {
      password: { type: "string", maxLength: 60 }
    },
    required: ["password"]
  };
  const validatePassword = ajv_password.compile(passwordSchema);

module.exports = validatePassword;