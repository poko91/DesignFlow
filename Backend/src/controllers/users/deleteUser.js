const { deleteAllProjects } = require('../../services/projects')
const { deleteAllTasks } = require('../../services/tasks')
const { deleteUser, getUserById } = require('../../services/users')

module.exports = {
    deleteUser: async (req, res)=> {
        try {
            const user_id = req.payload.aud
            const result = await getUserById(user_id)
            if (result.length == 0){
                console.log("User not found")
                res.status(400).send({ message: "User not found" })
            }
            const user = await deleteUser(user_id)
            if (user.affectedRows > 0){
                console.log("User deleted successfully")
                res.status(200).send({ message: "User deleted successfully" })
            } else {
                console.log("User not found")
                res.status(401).send({ message: "User not found" })
            }   

            const projects = await deleteAllProjects(user_id)
            if (projects.affectedRows > 0) {
                console.log("All projects deleted")
            } else {
                console.log("No projects deleted")
            }

            await deleteAllTasks(user_id)

        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error" })
        }
    }
}