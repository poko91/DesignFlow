// Required modules
const Ajv = require('ajv');
const addFormats = require('ajv-formats');

const ajv_user = new Ajv({ allErrors: true });
addFormats(ajv_user);
const userSchema = {
    type: "object",
    properties: {
        user_id: { type: "integer", minimum: 1 },
        email: { type: "string", format: "email" },
        password: { type: "string", maxLength: 60 },
        studio_name: { type: "string", maxLength: 255 },
        business_add: { type: "string", maxLength: 255 },
    }
  };
  const validateUser = ajv_user.compile(userSchema);

module.exports = validateUser;