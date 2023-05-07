const express = require('express')
const router = express.Router()
const { getUserById } = require('../controllers/users/getUserbById')
const { editPassword } = require('../controllers/users/editPassword')
const { deleteUser } = require('../controllers/users/deleteUser')
const { updateStudioName } = require('../controllers/users/updateStudioName')


router.post('/', getUserById)
router.post('/editStudioName', updateStudioName)
router.post('/editpassword', editPassword)
router.post('/deleteprofile', deleteUser)

module.exports = router;