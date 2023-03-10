const { getUserById } = require('../../services/users')

module.exports = {
  getUserById: async (req, res) => {
    try {
      const { user_id } = req.params
      const user = await getUserById(user_id)
      const loggedInUser = {
        user_id: user.user_id,
        email: user.email,
        studio_name: user.studio_name,
        business_add: user.business_add
      };
      console.log('user:', loggedInUser)
      res.status(200).send(loggedInUser)
    }
    catch (error) {
      console.log(error)
      res.status(500).send({ message: "Internal Server Error "})
    }
}, 
};
