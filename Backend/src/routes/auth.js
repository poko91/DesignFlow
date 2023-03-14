const express = require('express')
const router = express.Router()
const { loginUser } = require('../controllers/auth/login')
const { registerUser } = require('../controllers/auth/registration')
const { refreshToken } = require('../controllers/auth/refreshToken')
const { logout } = require('../controllers/auth/logout')

router.post('/login', loginUser)
router.post('/register', registerUser)
router.post('/refresh-token', refreshToken)
router.post('/logout', logout)

module.exports = router