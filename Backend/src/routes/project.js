const express = require('express')
const router = express.Router()
const { createProject } = require('../controllers/projects/createProject')
const { getProjects } = require('../controllers/projects/getProjects')
const { getProjectById } = require('../controllers/projects/getProjectById')
const { updateProject } = require('../controllers/projects/updateProject')
const { deleteProject } = require('../controllers/projects/deleteProject')
const { getProjectNames } = require('../controllers/projects/getProjectNames')


router.post('/projects', createProject)
router.get('/projects', getProjects)
router.get('/projects/:project_id', getProjectById)
router.put('/projects/:project_id', updateProject)
router.post('/projects/:project_id', deleteProject)
router.get('/project_names', getProjectNames)

module.exports = router 