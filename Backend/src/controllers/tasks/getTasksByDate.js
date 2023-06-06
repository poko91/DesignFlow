const { getTasksByDate } = require('../../services/tasks')

module.exports = {
    getTasksByDate: async (req, res)=> {
        try {
            const user_id = req.payload.aud
            const { due_date } = req.body
            const tasks = await getTasksByDate(due_date, user_id)
            if (tasks.length == 0) {
                console.log("Tasks not found");
                return res.status(404).send({ message: "Tasks not found" });
              }
            res.status(200).send(tasks)
        } catch (error) {
            console.log(error)
            res.status(500).send({ message: "Internal Server Error"})
        }
    }
}