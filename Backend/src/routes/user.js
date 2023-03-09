const express = require('express')
const router = express.Router()
const { getUserById } = require('../controllers/users/getUserbById')
const { updateUser } = require('../controllers/users/updateUser')
const { editPassword } = require('../controllers/users/editPassword')

router.get('/:user_id', getUserById)
router.put('/:user_id', updateUser)
router.put('/:user_id', editPassword)

module.exports = router;