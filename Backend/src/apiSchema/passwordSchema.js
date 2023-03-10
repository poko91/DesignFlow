const Ajv = require('ajv')
const addFormats = require('ajv-formats')
const ajvErrors = require('ajv-errors')

const ajv_password = new Ajv({ allErrors: true })
addFormats(ajv_password)
ajvErrors(ajv_password)
const passwordSchema = {
    type: "object",
    properties: {
      password: { type: "string", minLength: 8, maxLength: 60 }
    },
    required: ["password"],
    errorMessage: {
      properties: {
        password: "Password must be at least 8 characters long and must not be more than 60 characters long",
      }
  }
}
  const validatePassword = ajv_password.compile(passwordSchema)

module.exports = validatePassword