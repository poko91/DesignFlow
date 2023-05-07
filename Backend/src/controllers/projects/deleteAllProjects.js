const { deleteAllProjects } = require('../../services/projects')

module.exports = {
    deleteAllProjects: async (req, res)=> {
        try {
            const user_id = req.payload.aud
            const result = await deleteAllProjects(user_id)    
            if (result.affectedRows > 0){
                console.log("All Projects deleted")
                res.status(200).send({ message: "All Projects deleted successfully!" })
            } else {
                console.log("Task not found")
                res.status(400).send({ message: "Task not found" })
            }

        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error" })
        }
    }
}