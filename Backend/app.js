// Required modules
require('dotenv').config()
const express = require('express')
const app = express()
const createError = require('http-errors')
const auth_router = require('./src/routes/auth')
const users_router = require('./src/routes/user')
const projects_router = require('./src/routes/project')
const tasks_router = require('./src/routes/tasks')
const morgan = require('morgan')
const { verifyAccessToken } = require('./src/helpers/jwt_token')

app.use(express.json())
app.use(morgan('dev'))
app.use('/auth', auth_router)
app.use('/users',verifyAccessToken, users_router)
app.use('/users',verifyAccessToken, projects_router)
app.use('/users',verifyAccessToken, tasks_router)


// handle errors
app.use(async (req,res,next)=> {
  next(createError.NotFound())
})

app.use((err,req,res,next)=> {
  res.status(err.status || 500)
  res.send({
      error: {
          status: err.status || 500,
          message: err.message
      }
  })
})

// Start server
const PORT = process.env.APP_PORT;
app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});
// Shutdown server
process.on('SIGINT', function() {
  console.log( "\nGracefully shutting down" );
  process.exit(0);
});

