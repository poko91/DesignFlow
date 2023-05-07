const Ajv = require('ajv')
const addFormats = require('ajv-formats')
const ajvErrors = require('ajv-errors')

const ajv_addProject = new Ajv({ allErrors: true })
addFormats(ajv_addProject)
ajvErrors(ajv_addProject)
const addProjectSchema = {
        type: "object",
        properties: {
          project_name: {type: "string", maxLength: 255},
          project_type: {type: "string", enum: ["Residential", "Commercial", "Other"]},
          project_status: {type: "string", enum: ["In progress", "On hold", "Completed"]},
          project_add: {type: "string", maxLength: 255},
          due_date : {type: "string", format: "date"},
        },
        required: ["project_name", "project_type", "project_status"],
        errorMessage: {
          properties: {
            project_name: "Project name should be a string with a maximum length of 255 characters",
            project_type: "Project type should be one of the following values: Residential, Commercial, or Other",
            project_status: "Project status should be one of the following values: In progress, On hold, or Completed",
            project_add: "Project address should be a string with a maximum length of 255 characters",
            due_date: "Due date should be in date format (YYYY-MM-DD)"
          }
        }
      } 
      const validateSchema = ajv_addProject.compile(addProjectSchema)
      module.exports = validateSchema