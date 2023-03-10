const express = require('express')
const router = express.Router()
const { createProject } = require('../controllers/projects/createProject')
const { getProjects } = require('../controllers/projects/getProjects')
const { getProjectById } = require('../controllers/projects/getProjectById')
const { updateProject } = require('../controllers/projects/updateProject')
const { deleteProject } = require('../controllers/projects/deleteProject')

router.post('/:user_id/projects', createProject)
router.get('/:user_id/projects', getProjects)
router.get('/:user_id/projects/:project_id', getProjectById)
router.put('/:user_id/projects/:project_id', updateProject)
router.delete('/:user_id/projects/:project_id', deleteProject)

module.exports = router 