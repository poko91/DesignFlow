const pool = require('../config/database')

module.exports = {
    getUserById: async (user_id)=> {
        try {
            const [rows] = await pool.query("SELECT * FROM users WHERE user_id = ?",
            [user_id])
            return rows[0]
        } catch (error) {
            console.log(error)
        }
    },

    updateUser: async (email, studio_name, business_add, user_id)=> {
        try {
            const [rows] = await pool.query("UPDATE users SET email = ?, studio_name = ?, business_add =? WHERE user_id = ?",
            [email, studio_name, business_add, user_id])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    getPassword: async (user_id)=> {
        try {
            const [rows] = await pool.query("SELECT password FROM users WHERE user_id = ?",
            [user_id])
            return rows[0]
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
    }
}