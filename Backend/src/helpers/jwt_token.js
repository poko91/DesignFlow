const JWT = require('jsonwebtoken')
const createError = require('http-errors')
const client = require('./init_redis')

module.exports = {
    signAccessToken: (user_id) => {
        return new  Promise((resolve, reject) => {
            const payload = {
                aud: user_id
            }
            const secret = process.env.ACCESS_TOKEN_SECRET
            const options = { 
                expiresIn: "1h"
            }
            JWT.sign(payload, secret, options, (err,token)=> {
                if (err) {
                    console.log(error.message)
                    reject(createError.InternalServerError())
                }
                resolve(token)
            })
        })
    },

    verifyAccessToken: (req, res, next) => {
        if (!req.headers['authorization']) return next(createError.Unauthorized())
        const authHeader = req.headers['authorization']
        const bearer_token = authHeader.split(' ')
        const token = bearer_token[1]
        JWT.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, payload)=> {
            if (err) {
                if (err.name === "JsonWebTokenError"){
                    return next(createError.Unauthorized())
                } else {
                    return next(createError.Unauthorized(err.message))    
                }
            } 
            req.payload = payload
            next()
        })
    },

    signRefreshToken: (user_id) => {
        return new  Promise((resolve, reject) => {
            const payload = {
                aud: user_id
            }
            const secret = process.env.REFRESH_TOKEN_SECRET
            const options = { 
                expiresIn: "1y"
            }
            JWT.sign(payload, secret, options, (err,token)=> {
                if (err) {
                    console.log(error.message)
                    reject(createError.InternalServerError())
                }

                // Store refresh token in redis cache for 1 year = 31535993 secs
                client.SET(user_id, token, 'EX', 365 * 24 * 60 * 60, (err, reply)=> {
                    if (err) {
                        console.log(err.message)
                        reject(createError.InternalServerError())
                        return
                    }
                    resolve(token)
                })
            })
        })
    },

    validateRefreshToken: (refresh_token)=> {
        return new Promise((resolve, reject) => {
            JWT.verify(refresh_token, process.env.REFRESH_TOKEN_SECRET, (err, payload)=> {
                if (err) return reject(createError.Unauthorized()) 
                const user_id = payload.aud
                client.GET(user_id, (err,result)=> {
                    if (err){
                        console.log(err.message)
                        reject(createError.InternalServerError())
                        return
                    }
                    if (refresh_token === result) return resolve(user_id)
                    reject(createError.Unauthorized())
                })
            })
        })
    }
}