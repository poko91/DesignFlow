const { verifyRefreshToken } = require('../../helpers/jwt_token')

module.exports = {
    logout: async(req, res, next)=> {
        try {
            const { refresh_token } = req.body
            if (!refresh_token){
                console.log(error)
                return res.status(400).send({ message: "Bad request" })
            }
            const user_id = await verifyRefreshToken(refresh_token)
            if (!user_id){
                console.log("Internal Server Error")
                return res.status(500).send({ message: "Internal Server Error" })
            }
            console.log("Logged out successfully")
            return res.status(204).send({ message: "Logged out successfully" })
        } catch (error) {
            next(error)
        }
    }
}