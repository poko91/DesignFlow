const Ajv = require("ajv")
const addFormats = require('ajv-formats')
const ajvErrors = require('ajv-errors')

const ajv_registration = new Ajv({ allErrors: true })
addFormats(ajv_registration)
ajvErrors(ajv_registration)
const registrationSchema = {
    type: "object",
    properties: {
      email: { type: "string", format: "email" },
      password: { type: "string", minLength: 8, maxLength: 60 },
      studio_name: { type: "string", minLength:1, maxLength: 255 }
    },
    required: ["email", "password", "studio_name"],
    errorMessage: {
      properties: {
        email: "Email should be a string and must be a valid email address",
        password: "Password must be at least 8 characters long and must not be more than 60 characters long",
        studio_name: "Studio_name must be a string and must be at least 1 character long ang must not be more than 255 characters long"
      }
    }
  }
  const validateRegistration = ajv_registration.compile(registrationSchema)

module.exports = validateRegistration