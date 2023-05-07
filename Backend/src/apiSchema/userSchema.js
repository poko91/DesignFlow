const Ajv = require('ajv')
const addFormats = require('ajv-formats')
const ajvErrors = require('ajv-errors')

const ajv_user = new Ajv({ allErrors: true })
addFormats(ajv_user)
ajvErrors(ajv_user)
const userSchema = {
    type: "object",
    properties: {
        studio_name: { type: "string", minLength: 1, maxLength: 255 },
    },
    errorMessage: {
      properties: {
        studio_name: "Studio_name must be a string and must be at least 1 character long ang must not be more than 255 characters long",
      }
    }
  };
  const validateUser = ajv_user.compile(userSchema)

module.exports = validateUser