const { updateStudioName, getUserById } = require("../../services/users")
const validateUser = require("../../apiSchema/userSchema")

module.exports = {
    updateStudioName: async (req, res) => {
        // Validate incoming data
        if (!validateUser(req.body)) {
            console.log(validateUser.errors)
            return res.status(400).send({ message: "Invalid data" })
        }
        try {
            const { studio_name } = req.body
            const user_id = req.payload.aud
            const user = await getUserById(user_id)
            if (user.length == 0){
                console.log("User not found")
                return res.status(400).send({ message: "User not found" })
            }
            const result = await updateStudioName(studio_name,user_id)
            if (result.affectedRows > 0) {
                console.log("Updated successfully")
                res.status(200).send({ message: "Updated successfully" })  
            } else {
                console.log("User not found")
                res.status(400).send({ message: "User not found" })  
            }
        } catch (error) {
            console.log("Internal Server error")
            res.status(500).send({ message: "Internal Server error" })
        }
    },
}
