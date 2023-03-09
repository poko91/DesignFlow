const { editPassword, getPassword } = require('../../services/users')
const bcrypt = require('bcrypt')
const validatePassword = require('../../apiSchema/passwordSchema')

module.exports = {
    editPassword: async (req, res)=> {
        if (!validatePassword(req.body)){
            return res.status(400).send({ message: "Invalid data" })
        }
        try {
            const { password } = req.body
            const { user_id } = req.params
            const user = await getPassword(user_id)
            // Verify password
            const isValidPassword = await bcrypt.compare(password, user[0].password)
            if (!isValidPassword) {
                console.log("Old password is not valid")
                return res.status(401).send({ message: "Old password is not valid" })
            }
            const result = await editPassword(password, user_id) 
            if (result.affectedRows > 0){
                console.log("Password changed successfully")
                res.status(200).send({ message: "Password changed successfully" })
            }
            console.log("Password not updated")        
        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server error "})
        }
    }
}