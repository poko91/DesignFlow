const { deleteProject } = require('../../services/projects')
const { deleteAllTasks } = require('../../services/tasks')

module.exports = {
    deleteProject: async (req, res)=> {
        try {
            const user_id = req.payload.aud
            const project_id = req.params.project_id
            const result = await deleteProject(user_id, project_id)
    
            if (result.affectedRows > 0){
                console.log("Project deleted")
                res.status(200).send({ message: "Project deleted successfully!" })
            } else {
                console.log("Project not found")
                res.status(400).send({ message: "Project not found" })
            }

            const tasks = await deleteAllTasks(project_id)
            if (tasks.affectedRows > 0){
                console.log("All tasks deleted")
            } else {
                console.log("Tasks not deleted")
            }     
        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error" })
        }
    }
}