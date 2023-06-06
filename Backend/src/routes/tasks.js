const express = require('express')
const router = express.Router()
const { createTask } = require('../controllers/tasks/createTask')
const { getProjectTasks } = require('../controllers/tasks/getProjectTasks')
const { getTaskById } = require('../controllers/tasks/getTaskById')
const { updateTask } = require('../controllers/tasks/updateTask')
const { deleteTask } = require('../controllers/tasks/deleteTask')
const { getAllUserTasks } = require('../controllers/tasks/getAllUserTasks')
const { getTasksByDate } = require('../controllers/tasks/getTasksByDate')


router.post('/tasks', createTask)
router.get('/tasks/project', getProjectTasks)
router.get('/tasks/:task_id', getTaskById)
router.put('/tasks/:task_id', updateTask)
router.post('/tasks/:task_id', deleteTask)
router.get('/tasks', getAllUserTasks)
router.post('/tasksByDate', getTasksByDate)

module.exports = router 