const pool = require('../config/database')

module.exports = {
    
    getProjects: async (user_id)=> {
        try {
            const [rows] = await pool.query(`SELECT * FROM projects WHERE user_id = ?`, [user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    getProjectById: async (user_id, project_id)=> {
        try {
            const [rows] = await pool.query(`SELECT * FROM projects WHERE (user_id = ? AND project_id = ?)`, 
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
            WHERE (user_id = ? AND project_id = ?)`,
            [project_name, project_type, project_status, project_add,
            start_date, end_date, budget, denomination, user_id, project_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    deleteProject: async (user_id, project_id)=> {
        try {
            const [rows] = await pool.query(`DELETE FROM projects WHERE (user_id = ? AND project_id = ?)`,
            [user_id, project_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    }
}
