const pool = require('../config/database')

module.exports = {
    userExists: async (email)=> {
        try {
            const [rows] = await pool.query("SELECT * FROM users WHERE deleted = 0 AND email = ?", 
        [email])
        return rows
        } catch (error) {
            console.log(error)
        }
    },

    // Insert new user
    insertUser: async (email, password, studio_name)=> {
        try {
            const [rows] = await pool.query(
                "INSERT INTO users (email, password, studio_name) VALUES (?, ?, ?)",
                [email, password, studio_name]
              )
              return rows
        } catch (error) {
            console.log(error)
        }
    } 
}