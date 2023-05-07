const pool = require('../config/database')

module.exports = {
    getUserById: async (user_id)=> {
        try {
            const [rows] = await pool.query("SELECT * FROM user_details WHERE user_id = ?",
            [user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    updateStudioName: async (studio_name, user_id)=> {
        try {
            const [rows] = await pool.query("UPDATE users SET studio_name = ? WHERE user_id = ?",
            [studio_name, user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    getPassword: async (user_id)=> {
        try {
            const [rows] = await pool.query("SELECT password FROM users WHERE user_id = ?",
            [user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    editPassword: async (password, user_id)=> {
        try {
            const [rows] = await pool.query("UPDATE users SET password =? WHERE user_id = ?", 
            [password, user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    deleteUser: async (user_id)=> {
        try {
            const [rows] = await pool.query("UPDATE users SET deleted = 1 WHERE user_id = ?",
            [user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    }
}