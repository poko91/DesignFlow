const validateLogin = require('../../apiSchema/loginSchema')
const bcrypt = require('bcrypt')
const { userExists } = require('../../services/authentication')
const { signAccessToken, signRefreshToken } = require('../../helpers/jwt_token')

module.exports = {
  loginUser: async (req, res, next) => {
    // Validate incoming data
    if (!validateLogin(req.body)) {
      console.log(validateLogin.errors)
      return res.status(400).send({ message: "Invalid data" })
    }
    try {
        const { email, password } = req.body
        // Find user by email
        const user = await userExists(email)
        if (user.length == 0) {
          console.log("User not found")
          return res.status(401).send({ message: "User not found" })
        }   
        // Verify password
        const isValidPassword = await bcrypt.compare(password, user[0].password)
        if (!isValidPassword) {
          console.log("Invalid email or password")
          return res.status(401).send({ message: "Invalid email or password" })
        }   
        // Create tokens
        const access_token = await signAccessToken(user[0].user_id)
        const refresh_token = await signRefreshToken(user[0].user_id)
        console.log("Logged in successfully");  
        res.status(200).send({ access_token, refresh_token })
      } catch (error) {
        console.log(error)
        res.status(500).send()
      }
  },
};
