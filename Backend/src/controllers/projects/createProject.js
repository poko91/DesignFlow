const { createProject, check_user } = require('../../services/projects')
const validateSchema = require('../../apiSchema/updateProjectSchema')

module.exports = {
    createProject: async (req, res)=> {
        if (!validateSchema(req.body)) {
            console.log(validateSchema.errors)
            return res.status(400).send({ message: "Invalid data" })
          }
        try {
            const user_id = req.payload.aud
            const user = await check_user(user_id)
            if (user.length == 0){
              console.log("User not found")
              return res.status(400).send({ message: "User not found" })
            }

            const { project_name, project_type,
                project_status, project_add,
                start_date, end_date, budget,
                denomination } = req.body
    
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