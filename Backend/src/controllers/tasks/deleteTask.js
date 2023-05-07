const { deleteTask, check_project } = require('../../services/tasks')

module.exports = {
    deleteTask: async (req, res)=> {
        try {
            const { task_id } = req.params
            const task = await deleteTask(task_id)
    
            if (task.affectedRows > 0){
                console.log("Task deleted")
                res.status(200).send({ message: "Task deleted successfully!" })
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