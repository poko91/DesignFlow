const { createTask } = require("../../services/tasks");
const validateSchema = require("../../apiSchema/addtaskSchema");

module.exports = {
  createTask: async (req, res) => {
    if (!validateSchema(req.body)) {
      console.log(validateSchema.errors);
      return res.status(400).send({ message: "Invalid data" });
    }
    try {
      const user_id = req.payload.aud;
      const {
        task_title,
        priority,
        task_description,
        due_date,
        project_id,
      } = req.body;

      if (!req.body.task_title) {
        res.status(400).send({
          message: "Task title can not be empty!",
        });
        return;
      } else if (!req.body.project_id) {
        res.status(400).send({
          message: "Project id can not be empty!",
        });
        return;
      } 

      const result = await createTask(
        task_title,
        priority,
        task_description,
        due_date,
        project_id,
        user_id
      );

      if (result.affectedRows > 0) {
        console.log("Task created");
        res.status(200).send({ message: "Task created successfully" });
      } else {
        console.log("Task not created");
        res.status(400).send({ message: "Task not created" });
      }
    } catch (error) {
      console.log(error);
      res.status(500).send({ message: "Internal Server Error" });
    }
  },
};
