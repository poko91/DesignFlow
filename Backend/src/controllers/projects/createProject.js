const { createProject } = require('../../services/projects')
const validateSchema = require('../../apiSchema/updateProjectSchema')

module.exports = {
    createProject: async (req, res)=> {
        if (!validateSchema(req.body)) {
            console.log(validateSchema.errors)
            return res.status(400).send({ message: "Invalid data" })
          }
        try {
            const { project_name, project_type,
                project_status, project_add,
                start_date, end_date, budget,
                denomination } = req.body
    
            const user_id = req.params.user_id
    
            const project = await createProject(project_name, project_type,
                project_status, project_add,
                start_date, end_date, budget,
                denomination, user_id)
            console.log("Project created")
            res.status(200).send({ message: "Project created successfully!" })

        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error" })
        }
    }
}