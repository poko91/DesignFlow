const { deleteProject } = require('../../services/projects')

module.exports = {
    deleteProject: async (req, res)=> {
        try {
            const { user_id, project_id } = req.params
            const result = await deleteProject(user_id, project_id)
            if (result.length == 0){
                console.log("Project not found")
                res.status(401).send({ message: "Project not found" })
            }
            if (result.affectedRows > 0){
                console.log("Project deleted")
                res.status(200).send({ message: "Project deleted successfully!" })
            } else {
                console.log("Project not found")
                res.status(400).send({ message: "Project not found" })
            }     
        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error" })
        }
    }
}