const { getAllUserTasks } = require('../../services/tasks')

module.exports = {
    getAllUserTasks: async (req, res)=> {
        try {
            const user_id = req.payload.aud
            const tasks = await getAllUserTasks(user_id)
            if (tasks.length == 0) {
                console.log("Tasks not found");
                return res.status(400).send({ message: "Tasks not found" });
              }
            res.status(200).send(tasks)
        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error"})
        }
    }
}