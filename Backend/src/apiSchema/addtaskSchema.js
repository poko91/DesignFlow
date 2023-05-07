const Ajv = require('ajv')
const addFormats = require('ajv-formats')
const ajvErrors = require('ajv-errors')

const ajv_addTask = new Ajv({ allErrors: true })
addFormats(ajv_addTask)
ajvErrors(ajv_addTask)
const addTaskSchema = {
        type: "object",
        properties: {
          task_title: {type: "string", maxLength: 255},
          priority: {type: "string", enum: ["High", "Medium", "Low"]},
          task_description: {type: "string", maxLength: 255},
          due_date : {type: "string", format: "date"},
          project_name: {type: "string", maxLength: 255},
        },
        required: ["task_title", "priority", "task_description", "due_date"],
        errorMessage: {
          properties: {
            task_title: "Task title should be a string with a maximum length of 255 characters",
            priority: "Priority should be one of the following values: High, Medium, or Low",
            task_description: "Task description should be a string with a maximum length of 255 characters",
            due_date: "Due date should be in date format (YYYY-MM-DD)",
            project_name: "Project name should be a string with a maximum length of 255 characters"
          }
        }
      } 
      const validateSchema = ajv_addTask.compile(addTaskSchema)
      module.exports = validateSchema