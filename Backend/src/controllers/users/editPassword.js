const { editPassword, getPassword } = require('../../services/users')
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
            const { user_id } = req.params
            // Find user by email
            const user = await getPassword(user_id)
            // Verify password
            const isValidPassword = await bcrypt.compare(old_password, user.password)
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