const express = require('express')
const router = express.Router()
const { getUserById } = require('../controllers/users/getUserbById')
const { updateUser } = require('../controllers/users/updateUser')
const { editPassword } = require('../controllers/users/editPassword')
const { deleteUser } = require('../controllers/users/deleteUser')


router.post('/', getUserById)
router.post('/editprofile', updateUser)
router.post('/editpassword', editPassword)
router.post('/deleteprofile', deleteUser)

module.exports = router;