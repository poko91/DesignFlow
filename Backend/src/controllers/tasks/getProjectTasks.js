const { getProjectTasks } = require('../../services/tasks')

module.exports = {
    getProjectTasks: async (req, res)=> {
        try {
            const project_name = req.body.project_name
            const tasks = await getProjectTasks(project_name)
            if (tasks.length == 0){
                console.log("No tasks found")
                return res.status(400).send({ message: "No tasks found" })
              }
            res.status(200).send(tasks)
        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error"})
        }
    }
}