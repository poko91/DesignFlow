const pool = require('../config/database')

module.exports = {
    userExists: async (email) => {
        try {
            const [rows] = await pool.query("SELECT * FROM users WHERE email = ?",
                [email])
            return rows
        } catch (error) {
            console.log(error)
        }
    },

    // Insert new user
    insertUser: async (email, password, studio_name, business_add) => {
        try {
            const [rows] = await pool.query(
                "INSERT INTO users (email, password, studio_name, business_add) VALUES (?, ?, ?, ?)",
                [email, password, studio_name, business_add]
            )
            return rows
        } catch (error) {
            console.log(error)
        }
    }
}