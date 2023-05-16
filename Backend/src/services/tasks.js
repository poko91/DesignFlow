const pool = require('../config/database')

module.exports = {
    createTask: async (task_title, priority, task_description,
        due_date, project_id, user_id )=> {
        try {
            const [rows] = await pool.query(`INSERT INTO tasks (task_title, priority, task_description, 
                due_date, project_id, user_id ) VALUES (?, ?, ?, ?, ?, ?)`,
            [task_title, priority, task_description, due_date, project_id, user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    updateTask: async (task_title, priority, task_description,
        due_date, project_id, task_id)=> {
        try {
            const [rows] = await pool.query(`UPDATE tasks SET task_title=?,
            priority=?, task_description=?, due_date =?, project_id=?
            WHERE deleted = 0 AND task_id = ?`,
            [task_title, priority, task_description,
            due_date, project_id, task_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    getAllUserTasks: async (user_id)=> {
        try {
            const [rows] = await pool.query(`SELECT *
            FROM task_details WHERE user_id = ?`, 
            [user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },
    
    getProjectTasks: async (project_id)=> {
        try {
            const [rows] = await pool.query(`SELECT * FROM task_details WHERE project_id = ?`, [project_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    getTaskById: async (task_id)=> {
        try {
            const [rows] = await pool.query(`SELECT * FROM task_details WHERE task_id = ?`, 
            [task_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    getTasksByDate: async (due_date, user_id)=> {
        try {
            const [rows] = await pool.query(`SELECT *
            FROM task_details
            WHERE due_date = ? AND user_id = ?`, 
            [due_date, user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    deleteTask: async (task_id)=> {
        try {
            const [rows] = await pool.query(`UPDATE tasks SET deleted = 1 WHERE deleted = 0 AND task_id = ?`,
            [task_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    deleteAllTasks : async (project_id)=> {
        try {
            const [rows] = await pool.query(`UPDATE tasks SET tasks.deleted = 1
            WHERE project_id IN (SELECT project_id FROM projects WHERE user_id = ?)`,
            [project_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    }
}
