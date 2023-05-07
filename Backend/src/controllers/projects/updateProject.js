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
                due_date } = req.body

            const user_id = req.payload.aud
            const { project_id } = req.params

            if (!req.body.project_name) {
                res.status(400).send({
                  message: "Project name can not be empty!",
                });
                return;
              } else if (!req.body.project_add) {
                res.status(400).send({
                  message: "Project address can not be empty!",
                });
                return;
              } else if (!req.body.due_date) {
                res.status(400).send({
                  message: "Due date can not be empty!",
                });
                return;
              }

            const project = await updateProject(project_name, project_type,
                project_status, project_add,
                due_date, user_id, project_id)

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