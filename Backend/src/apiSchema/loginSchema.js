const Ajv = require('ajv')
const addFormats = require('ajv-formats')
const ajvErrors = require('ajv-errors')

const ajv_login = new Ajv({ allErrors: true })
addFormats(ajv_login)
ajvErrors(ajv_login)
const loginSchema = {
    type: "object",
    properties: {
      email: { type: "string", format: "email" },
      password: { type: "string", minLength: 8, maxLength: 60 },
      studio_name: { type: "string", maxLength: 255 },
    },
    required: ["email", "password"],
    errorMessage: {
      properties: {
        email: "Email should be a string and must be a valid email address",
        password: "Password must be at least 8 characters long and must not be more than 60 characters long",
      }
    }
  }
  const validateLogin = ajv_login.compile(loginSchema)

module.exports = validateLogin