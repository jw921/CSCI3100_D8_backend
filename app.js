const express = require("express");
const app = express();
const cors = require("cors");
const dotenv = require("dotenv");
dotenv.config();

const DbService = require("./dbService");
const { response, request } = require("express");

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

//getUser
app.get("/getUsers", (request, response) => {
    const db = DbService.getDbServiceInstance();
    const result = db.getAllUser();
    result.then((data) => response.json(data)).catch((err) => console.log(err));
});

app.post('/login', (request, response) => {
    const info = ({ info_id, password } = request.body);
    console.log(info);
    const db = DbService.getDbServiceInstance();
    const result = db.loginUser(info);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
});

//sample api
app.get('/getUserInfo', (request, response) => {
    const { info_id } = request.query;
    const db = DbService.getDbServiceInstance();
    const result = db.getUserInfo(info_id);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
});

app.get("/getAllCourse", (request, response) => {
    const db = DbService.getDbServiceInstance();
    const result = db.getAllCourse();
    result.then((data) => response.json(data)).catch((err) => console.log(err));
});

app.get("/getEnrolledCourses", (request, response) => {
    const { info_id } = request.query;
    const db = DbService.getDbServiceInstance();
    const result = db.getEnrolledCourses(info_id);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
});

app.delete("/dropCourse", (request, response) => {
    const { info_id } = request.query;
    const { coursecode } = request.body;
    const db = DbService.getDbServiceInstance();
    const result = db.dropCourse(coursecode, info_id);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
});

app.get("/getCourseByCoursecode", (request, response) => {
    const { coursecode } = request.query;
    const db = DbService.getDbServiceInstance();
    const result = db.getCourseByCourseID(coursecode);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
});


app.get("/getCourseByFilter", (request, response) => {
    const { filter } = request.query;
    const db = DbService.getDbServiceInstance();
    const result = db.getCourseByFilter(filter);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
})

app.post("/addCourse", (request, response) => {
    const { coursecode, coursename, time_period, place, department, instructor, capacity, assessment_method } = request.body;
    const db = DbService.getDbServiceInstance();
    const result = db.addCourse(coursecode, coursename, time_period, place, department, instructor, capacity, assessment_method);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
});

app.post("/addUser", (request, response) => {
    const { info_id, username, password, usertype, department, email } = request.body;
    const db = DbService.getDbServiceInstance();
    const result = db.addUser(info_id, username, password, usertype, department, email);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
});

app.post("/resetPassword", (request, response) => {
    const { info_id, username, password } = request.body;
    const db = DbService.getDbServiceInstance();
    const result = resetPassword(password, info_id, username);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
});

app.put("/editProfile", (request, response) => {
    const { info_id, email} = request.body;
    const db = DbService.getDbServiceInstance();
    const result = db.editProfile(info_id, email);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
});

app.post("/selectCourse", (request, response) => {
    const { coursecode, info_id } = request.body;
    const db = DbService.getDbServiceInstance();
    const result = db.selectCourse(coursecode, info_id);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
});


app.get("/getAllUser", (request, response) => {
    const { info_id, username, password, usertype, department, email } = request.body;
    const db = DbService.getDbServiceInstance();
    const result = db.getAllUser(info_id, username, password, usertype, department, email);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
})

app.delete("/deleteUser", (request, response) => {
    const { info_id } = request.body;
    const db = DbService.getDbServiceInstance();
    const result = db.deleteUser(info_id);
    result.then((data) => response.json(data)).catch((err) => console.log(err));
})

app.delete("/deleteCourse", (request, response) => {
    const { coursecode } = request.body;
    const db = DbService.getDbServiceInstance();
    const result = db.deleteCourse(coursecode);
    result.then((data) => response.json(data)).catch((err) => console.log(err));

});

app.get("/getCourses", (request, response) => {
    const { userType, searchItem } = request.query;
    const db = DbService.getDbServiceInstance();
    const result = db.getCourses(userType, searchItem);
    result.then((data) => response.json(data)).catch((err) => console.log(err));

});

app.listen(process.env.PORT, () => console.log("app os running"));
