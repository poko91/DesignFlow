const { createProject } = require("../../services/projects");
const validateSchema = require("../../apiSchema/updateProjectSchema");

module.exports = {
  createProject: async (req, res) => {
    if (!validateSchema(req.body)) {
      console.log(validateSchema.errors);
      return res.status(400).send({ message: "Invalid data" });
    }
    try {
      const user_id = req.payload.aud;
      const {
        project_name,
        project_type,
        project_status,
        project_add,
        due_date,
      } = req.body;

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
      const result = await createProject(
        project_name,
        project_type,
        project_status,
        project_add,
        due_date,
        user_id
      );

      if (result.affectedRows > 0) {
        console.log("Project created");
        res.status(200).send({ message: "Project created successfully" });
      } else {
        console.log("Project not created");
        res.status(400).send({ message: "Project not created" });
      }
    } catch (error) {
      console.log(error);
      res.status(500).send({ message: "Internal Server Error" });
    }
  },
};
