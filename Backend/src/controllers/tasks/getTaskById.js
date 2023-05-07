const { getTaskById } = require('../../services/tasks')

module.exports = {
    getTaskById: async (req, res)=> {
        try {
            const { task_id } = req.params
            const task = await getTaskById(task_id)
            if (!task.length){
                console.log("Task not found")
                return res.status(400).send({ message: "Task not found" })     
            }
            res.status(200).send({ task })
        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error"})
        }
    }
}