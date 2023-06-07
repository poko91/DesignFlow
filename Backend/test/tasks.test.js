const chai = require('chai');
const chaiHttp = require('chai-http');
const app = require('../app'); 
const expect = chai.expect;

chai.use(chaiHttp);

describe('Tasks Endpoint Test', function () {
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

  it('should be able to get all tasks', function (done) {
    chai
      .request(app)
      .get('/users/tasks')
      .set('Authorization', `Bearer ${access_token}`)
      .end(function (err, res) {
        expect(res).to.have.status(200);
        done();
      });
  });

  it('should be able to get task by id', function (done) {
    chai
      .request(app)
      .get('/users/tasks/1')
      .set('Authorization', `Bearer ${access_token}`)
      .end(function (err, res) {
        expect(res).to.have.status(200);
        done();
      });
  });

  it('should be able to get tasks by project name', function (done) {
    chai
      .request(app)
      .get('/users/projects/1/tasks')
      .set('Authorization', `Bearer ${access_token}`)
      .send({project_id: 1})
      .end(function (err, res) {
        expect(res).to.have.status(200);
        done();
      });
  });

  it('should be able to get task by due date', function (done) {
    chai
      .request(app)
      .post('/users/tasksByDate')
      .set('Authorization', `Bearer ${access_token}`)
      .send({due_date: "2023-01-01"})
      .end(function (err, res) {
        expect(res).to.have.status(200);
        done();
      });
  });

  it('should be able to update project', function (done) {
    chai
      .request(app)
      .put('/users/tasks/1')
      .set('Authorization', `Bearer ${access_token}`)
      .send({task_title: "Test task",
      task_description: "Test",
      due_date: "2023-01-01",
      priority: "Medium",
      project_id: 1})
      .end(function (err, res) {
        expect(res).to.have.status(200);
        done();
      });
  });
});

