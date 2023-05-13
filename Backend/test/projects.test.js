const chai = require('chai');
const chaiHttp = require('chai-http');
const app = require('../app'); 
const expect = chai.expect;

chai.use(chaiHttp);

describe('Projects Endpoint Test', function () {
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

  it('should be able to get all projects', function (done) {
    chai
      .request(app)
      .get('/users/projects')
      .set('Authorization', `Bearer ${access_token}`)
      .end(function (err, res) {
        expect(res).to.have.status(200);
        done();
      });
  });

  it('should be able to get project by id', function (done) {
    chai
      .request(app)
      .get('/users/projects/2')
      .set('Authorization', `Bearer ${access_token}`)
      .end(function (err, res) {
        expect(res).to.have.status(200);
        done();
      });
  });
});

