const mysql = require("mysql");
const dotenv = require("dotenv");
let instance = null;
dotenv.config();

const connection = mysql.createConnection({
    host: process.env.HOST,
    user: 'root',
    password: '',
    database: process.env.DATABASE,
    port: process.env.DB_PORT,
});

connection.connect((err) => {
    if (err) console.log(err.message);
    console.log("db " + connection.state);
});

class DbService {
    static getDbServiceInstance() {
        return instance ? instance : new DbService();
    }

    async getAllUser() {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "SELECT * FROM users;";
                connection.query(query, (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            return response;
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    async loginUser(info) {
        console.log(info);
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "SELECT * FROM users WHERE info_id = ? AND password = ?;";
                connection.query(query, [info.info_id, info.password], (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            if (response.length === 0) return { success: false, message: "invalid username or password" }
            else return { success: true, message: "login success", username: response[0].username, usertype: response[0].usertype, id: response[0].info_id };
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    async getAllCourse() {
        try {
            let response = await new Promise((resolve, reject) => {
                const query = "SELECT * FROM courses;";
                connection.query(query, (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            return response;
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    async getEnrolledCourses(info_id) {
        try {
            let response = await new Promise((resolve, reject) => {
                const query = "SELECT a.* FROM courses a INNER JOIN record b ON a.coursecode = b.coursecode WHERE b.info_id = ? AND b.status = 'enrolled';";
                connection.query(query, [info_id], (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            return response;
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    async dropCourse(coursecode, info_id) {
        try {
            let response = await new Promise((resolve, reject) => {
                const query = "UPDATE record SET status = 'dropped' WHERE coursecode = ? AND info_id = ?";
                connection.query(query, [coursecode, info_id], (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            return response;
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    async getCourseByCourseID(coursecode) {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "SELECT * FROM courses WHERE coursecode = ?;";
                connection.query(query, [coursecode], (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            return response;
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    async getCourseByFilter(filter) {
        console.log(filter)
        filter = '%' + filter + '%';
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "SELECT * FROM courses WHERE coursecode LIKE ? OR coursename LIKE ? OR instructor LIKE ? OR assessment_method LIKE ?;";
                connection.query(query, [filter, filter, filter, filter], (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            if (response === 0) return { success: false, message: "no result" }
            return response;
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    async addCourse(coursecode, coursename, time_period, place, department, instructor, capacity, assessment_method) {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "INSERT INTO courses (coursecode, coursename, time_period, place, department, instructor, capacity, assessment_method) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
                connection.query(query, [coursecode, coursename, time_period, place, department, instructor, capacity, assessment_method], (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            if (response.affectRows === 0) return { success: false, message: "add course failed" }
            else return { success: true, message: "add course success" };
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    async addUser(info_id, username, password, usertype, department, email) {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "INSERT INTO users (info_id, username, password, usertype, department, email) VALUES (?, ?, ?, ?, ?, ?);";
                connection.query(query, [info_id, username, password, usertype, department, email], (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            if (response.affectRows === 0) return { success: false, message: "add user failed" }
            else return { success: true, message: "add user success", id: info_id, usertype: usertype };
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    async resetPassword(password, info_id, username) {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "UPDATE users SET password = ? WHERE info_id = ? AND username = ?;";
                connection.query(query, [password, info_id, username], (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            if (response.affectRows === 0) return { success: false, message: "reset password failed" }
            else return { success: true, message: "reset password success" };
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    async editProfile(info_id, email) {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "UPDATE users SET email = ? WHERE info_id = ?;";
                connection.query(query, [info_id, email], (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            if (response.affectRows === 0) return { success: false, message: "edit profile failed" }
            else return { success: true, message: "edit profile success" };
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    async selectCourse(coursecode, info_id) {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "SELECT courses FROM users WHERE info_id = ?;";
                connection.query(query, [info_id], (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            // add selected course to courses
            // select students from courses where coursecode=coursecode
            // add info_id to students
            return { success: true, message: "success" };
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    //sample code for retreveing data from students table
    async getUserInfo(info_id) {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "SELECT * FROM users WHERE info_id = ?;";
                connection.query(query, [info_id], (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            if (response.length === 0) return { success: false, message: "invalid studentID" }
            else delete response[0].password; return { success: true, message: "login success", data: response[0] };

        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    //Get all user info
    async getAllUser(info_id, username, password, usertype, department, email) {
        const response = await new Promise((resolve, reject) => {
            const query = "SELECT * FROM users;"
            connection.query(query, (err, result) => {
                if (err) reject(new Error(err.message));
                resolve(result);
            });
        });
        return response;
    } catch(error) {
        console.log(error.message);
        return { success: false, message: "error occur" };
    }

    // Delete selected user    
    async deleteUser(info_id) {
        const response = await new Promise((resolve, reject) => {
            const query = "DELETE FROM users WHERE info_id = ?;"
            connection.query(query, [info_id], (err, result) => {
                if (err) reject(new Error(err.message));
                resolve(result);
            });
        });
        return response;
    } catch(error) {
        console.log(error.message);
        return { success: false, message: "error occur" };
    }

    // Delete selected course    
    async deleteCourse(coursecode) {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "DELETE FROM courses WHERE coursecode = ?;"
                connection.query(query, [coursecode], (err, result) => {
                    if (err) reject(new Error(err.message));
                    resolve(result);
                });
            });
            return response;
        } catch (error) {
            console.log(error.message);
            return { success: false, message: "error occur" };
        }
    }

    async getCourses(userType, searchItem) {
        const response = await new Promise((resolve, reject) => {
            const query = "SELECT * FROM courses WHERE " + userType + " = '" + searchItem + "';";
            console.log(query);
            connection.query(query, (err, result) => {
                if (err) reject(new Error(err.message));
                resolve(result);
            });
        });
        console.log(response);
        return response;
    } catch(error) {
        console.log(error.message);
        return { success: false, message: "error occur" };
    }
}

module.exports = DbService;
