const chai = require("chai");
const expect = chai.expect;
const chaiHttp = require("chai-http");
const app = require("../app");
require("dotenv").config();
chai.use(chaiHttp);

let access_token;
let refresh_token;

describe('Authentication', async()=> {
    it('should login succesffully', (done)=> {
        chai.request(app)
           .post('/auth/login')
           .set('Content-Type', 'application/json')
           .send({"email": "test@gmail.com", "password": "test1234"})
           .end((err, res)=> {
              expect(res.status).to.be.equal(200)
              access_token = res.body.access_token;
              refresh_token = res.body.refresh_token;
              done();
           })
    });

    it('Should succeed token refresh is successful', (done)=> {
        chai.request(app)
           .post('/auth/refresh-token')
           .set({ Authorization: `Bearer ${access_token}`})
           .set('Content-Type', 'application/json')
           .send({"refresh_token": `${refresh_token}`})
           .end((err, res)=> {
              expect(res.status).to.be.equal(200)
              refresh_token = res.body.refresh_token;
              done();
           })
    });

    it('Should succeed if logout is successful', (done)=> {
        chai.request(app)
           .post('/auth/logout')
           .set({ Authorization: `Bearer ${access_token}`})
           .set('Content-Type', 'application/json')
           .send({"refresh_token": `${refresh_token}`})
           .end((err, res)=> {
              expect(res.status).to.be.equal(204)
              done();
           })
    });

});

