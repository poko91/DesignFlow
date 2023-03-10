const { getProjects } = require('../../services/projects')

module.exports = {
    getProjects: async (req, res)=> {
        try {
            const { user_id } = req.params
            const projects = await getProjects(user_id)
            res.status(200).send({projects: projects})
        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error"})
        }
    }
}