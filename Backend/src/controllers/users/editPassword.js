const { editPassword, getPassword, getUserById } = require('../../services/users')
const bcrypt = require('bcrypt')
const validatePassword = require('../../apiSchema/passwordSchema')

module.exports = {
    editPassword: async (req, res) => {
        if (!validatePassword(req.body)) {
            console.log(validatePassword.errors)
            return res.status(400).send({ message: "Invalid data" })
        }
        try {
            const { old_password, password } = req.body
            const user_id = req.payload.aud
            const check_user = await getUserById(user_id)
            if (check_user.length == 0){
                console.log("User not found")
                return res.status(400).send({ message: "User not found" })
            }
            // Find user by email
            const user = await getPassword(user_id)
            // Verify password
            if (user.length == 0 ){
                console.log("User not found")
                return res.status(400).send({ message: "User not found" })
            }
            const isValidPassword = await bcrypt.compare(old_password, user[0].password)
            if (!isValidPassword) {
                console.log("Old password is not valid")
                return res.status(401).send({ message: "Old password is not valid" })
            }
            // Hash password
            const hashedPassword = await bcrypt.hash(password, 10);
            const result = await editPassword(hashedPassword, user_id)
            if (result.affectedRows > 0) {
                console.log("Password changed successfully")
                res.status(200).send({ message: "Password changed successfully" })
            }
            console.log("Password not updated")
        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server error " })
        }
    }
}