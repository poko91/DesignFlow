const { updateTask } = require('../../services/tasks')
const validateSchema = require('../../apiSchema/addtaskSchema')

module.exports = {
    updateTask: async (req, res) => {
        if (!validateSchema(req.body)) {
            console.log(validateSchema.errors)
            return res.status(400).send({ message: "Invalid data" })
          }
        try {
            const { task_title, priority, task_description,
                due_date, project_name } = req.body
            const { task_id } = req.params

            if (!req.body.task_title) {
                res.status(400).send({
                  message: "Task title can not be empty!",
                });
                return;
              } else if (!req.body.project_name) {
                res.status(400).send({
                  message: "Project name can not be empty!",
                });
                return;
              } 

            const task = await updateTask(task_title, priority, task_description,
                due_date, project_name, task_id)

            if (task.length == 0) {
                console.log("Task not found")
                return res.status(401).send({ message: "Task not found" })
            }
            if (task.affectedRows > 0) {
                console.log("Task Updated successfully")
                res.status(200).send({ message: "Task Updated successfully" })  
            } else {
                console.log("Task not found")  
                res.status(400).send({ message: "Task not found" })  
            }
        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error" })
        }
    }
}