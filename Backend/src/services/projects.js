const pool = require('../config/database')

module.exports = {
    
    getProjects: async (user_id)=> {
        try {
            const [rows] = await pool.query(`SELECT * FROM project_details WHERE user_id = ?`, [user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    getProjectById: async (user_id, project_id)=> {
        try {
            const [rows] = await pool.query(`SELECT * FROM project_details WHERE user_id = ? AND project_id = ?`, 
            [user_id, project_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    createProject: async (project_name, project_type, project_status,
        project_add, start_date, end_date, budget, denomination, user_id)=> {
        try {
            const [rows] = await pool.query(`INSERT INTO projects (project_name, project_type, project_status,
                project_add, start_date, end_date, budget, denomination, user_id)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [project_name, project_type, project_status, project_add, start_date, end_date, budget, denomination, user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    updateProject: async (project_name, project_type, project_status,
        project_add, start_date, end_date, budget, denomination, user_id, project_id)=> {
        try {
            const [rows] = await pool.query(`UPDATE projects SET project_name=?,
            project_type=?, project_status=?, project_add =?,
            start_date =?, end_date=?, budget=?, denomination=?
            WHERE deleted = 0 AND user_id = ? AND project_id = ?`,
            [project_name, project_type, project_status, project_add,
            start_date, end_date, budget, denomination, user_id, project_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    check_user: async (user_id)=> {
        try {
            const [rows] = await pool.query(`SELECT user_id FROM users WHERE deleted = 0 AND user_id = ?`,
            [user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    deleteProject: async (user_id, project_id)=> {
        try {
            const [rows] = await pool.query(`UPDATE projects SET deleted = 1 WHERE deleted = 0 AND user_id = ? AND project_id = ?`,
            [user_id, project_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    deleteAllProjects : async (user_id)=> {
        try {
            const [rows] = await pool.query(`Update projects SET deleted = 1 WHERE user_id = ?`,
            [user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    }
}
