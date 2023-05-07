const { userExists, insertUser } = require("../../services/authentication")
const validateRegistration = require("../../apiSchema/registrationSchema")
const bcrypt = require('bcrypt')
const { signAccessToken, signRefreshToken } = require('../../helpers/jwt_token')

module.exports = {
  registerUser: async (req, res) => {
    // Validate incoming data
    if (!validateRegistration(req.body)) {
      console.log(validateRegistration.errors)
      return res.status(400).json({ message: "Invalid data" })
    }
    try {
      const { email, password, studio_name, business_add } = req.body

      // Check if user already exists
      const user = await userExists(email)
      if (user.length != 0) {
        console.log("User already exists")
        return res.status(409).send({ message: "User already exists" })
      }

      // Hash password
      const hashedPassword = await bcrypt.hash(password, 10)

      // Insert new user
      const result = await insertUser(email, hashedPassword, studio_name, business_add)

      // Create Access token
      const user_id = result.insertId
      const access_token = await signAccessToken(user_id)
      const refresh_token = await signRefreshToken(user_id)

      console.log("User created")
      res.status(201).send({ access_token, refresh_token })
    } catch (error) {
      console.error(error)
      res.status(500).send()
    }
  },
};
