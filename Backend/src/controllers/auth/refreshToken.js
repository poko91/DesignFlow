const { signAccessToken, signRefreshToken, validateRefreshToken } = require("../../helpers/jwt_token");
const createError = require('http-errors')

module.exports = {
    refreshToken: async(req,res,next)=> {
        const { refresh_token } = req.body;
        try {
            if (!refresh_token) throw createError.BadRequest()
            const user_id = await validateRefreshToken(refresh_token)

            const access_token = await signAccessToken(user_id)
            const refreshToken = await signRefreshToken(user_id)
            res.status(200).send({ access_token: access_token, refreshToken: refresh_token })
        } catch (error) {
            next(error)
        }
    }
}