const { validateRefreshToken } = require('../../helpers/jwt_token')
const client = require('../../helpers/init_redis')

module.exports = {
    logout: async(req, res, next)=> {
        try {
            const { refresh_token } = req.body
            if (!refresh_token){
                console.log(error)
                return res.status(400).send({ message: "Bad request" })
            }
            const user_id = await validateRefreshToken(refresh_token)
            client.DEL(user_id, (err,val)=> {
                if (err){
                    console.log(err.message)
                    return res.status(500).send({ message: "Internal Server Error" })
                }
                console.log(val, "Logged out successfully")
                return res.status(204).send()
            })
        } catch (error) {
            next(error)
        }
    }
}