const { getProjects } = require('../../services/projects')

module.exports = {
    getProjects: async (req, res)=> {
        try {
            const user_id = req.payload.aud
            const projects = await getProjects(user_id)
            if (projects.length == 0){
                console.log("No projects found")
                return res.status(400).send({ message: "No projects found" })
              }
            res.status(200).send(projects)
        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error"})
        }
    }
}