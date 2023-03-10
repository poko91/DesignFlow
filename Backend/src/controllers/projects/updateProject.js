const { updateProject } = require('../../services/projects')
const validateSchema = require('../../apiSchema/updateProjectSchema')

module.exports = {
    updateProject: async (req, res) => {
        if (!validateSchema(req.body)) {
            console.log(validateSchema.errors)
            return res.status(400).send({ message: "Invalid data" })
          }
        try {
            const { project_name, project_type,
                project_status, project_add,
                start_date, end_date, budget,
                denomination } = req.body

            const { user_id, project_id } = req.params

            const project = await updateProject(project_name, project_type,
                project_status, project_add,
                start_date, end_date, budget,
                denomination, user_id, project_id)

            if (project.length == 0) {
                console.log("Project not found")
                return res.status(401).send({ message: "Project not found" })
            }
            if (project.affectedRows > 0) {
                console.log("Updated successfully")
                res.status(200).send({ message: "Updated successfully" })  
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