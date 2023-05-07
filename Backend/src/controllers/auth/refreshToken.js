const { signAccessToken, signRefreshToken, verifyRefreshToken } = require("../../helpers/jwt_token");
const createError = require('http-errors')

module.exports = {
    refreshToken: async(req,res,next)=> {
        try {
            const { refresh_token } = req.body;
            if (!refresh_token) {
                console.log("Bad request")
                res.status(400).send({ message: "Bad request" })
            }
            const user_id = await verifyRefreshToken(refresh_token)

            const access_token = await signAccessToken(user_id)
            const refreshToken = await signRefreshToken(user_id)
            res.status(200).send({ access_token: access_token, refresh_token: refreshToken })
        } catch (error) {
            next(error)
        }
    }
}   