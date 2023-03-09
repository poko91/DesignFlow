const { updateUser} = require("../../services/users")
const validateUser = require("../../apiSchema/userSchema")

module.exports = {
    updateUser: async (req, res) => {
        // Validate incoming data
        if (!validateUser(req.body)) {
            console.log("Invalid data")
            return res.status(400).send()
        }
        try {
            const { email, studio_name, business_add } = req.body
            const { user_id } = req.params
            const result = await updateUser(
                email,
                studio_name,
                business_add,
                user_id
            )
            if (result.affectedRows > 0) {
                console.log("Updated successfully")
                res.status(200).send({ message: "Updated successfully" })  
            } else {
                console.log("No rows updated")
            }
        } catch (error) {
            console.log("Internal Server error")
            res.status(500).send()
        }
    }
}
