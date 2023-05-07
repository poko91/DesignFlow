const { getUserById } = require('../../services/users')

module.exports = {
  getUserById: async (req, res) => {
    try {
      const user_id = req.payload.aud
      const user = await getUserById(user_id)
      if (user.length == 0){
        console.log("User not found")
        return res.status(400).send({ message: "User not found" })
      }
      res.status(200).send(user[0])
    }
    catch (error) {
      console.log(error)
      res.status(500).send({ message: "Internal Server Error "})
    }
}, 
};
