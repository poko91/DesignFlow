const { getProjectById } = require('../../services/projects')

module.exports = {
    getProjectById: async (req, res)=> {
        try {
            const user_id = req.payload.aud
            const { project_id } = req.params
            const project = await getProjectById(user_id, project_id)
            if (!project.length){
                console.log("Project not found")
                return res.status(400).send({ message: "Project not found" })     
            }
            res.status(200).send({ project: project })
        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error"})
        }
    }
}