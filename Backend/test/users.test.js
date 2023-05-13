const chai = require('chai');
const chaiHttp = require('chai-http');
const app = require('../app'); 
const expect = chai.expect;

chai.use(chaiHttp);

describe('Users Endpoint Test', function () {
  let access_token = '';

  before(function (done) {
    chai
      .request(app)
      .post('/auth/login')
      .send({ email: 'test@gmail.com', password: 'test1234' })
      .end(function (err, res) {
        access_token = res.body.access_token;
        done();
      });
  });

  it('should be able to get user details', function (done) {
    chai
      .request(app)
      .post('/users')
      .set('Authorization', `Bearer ${access_token}`)
      .end(function (err, res) {
        expect(res).to.have.status(200);
        done();
      });
  });

  it('should edit password', function (done) {
    chai
      .request(app)
      .post('/users/editpassword')
      .set('Authorization', `Bearer ${access_token}`)
      .send({old_password:"test1234", password:"test1234"})
      .end(function (err, res) {
        expect(res).to.have.status(200);
        done();
      });
  });

  it('should edit studio name', function (done) {
    chai
      .request(app)
      .post('/users/editStudioName')
      .set('Authorization', `Bearer ${access_token}`)
      .send({studio_name:"Test Studio"})
      .end(function (err, res) {
        expect(res).to.have.status(200);
        done();
      });
  });

});

