let mysql = require('mysql');
let express = require('express');
let session = require('express-session');
let bodyParser = require('body-parser');
let path = require('path');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'accounts'
});

let app = express();

app.use(session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
}));

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.get('/', function(req, res) {
    res.send('Connected to API');
});

app.post('/auth', function(req, res) {
    console.log(req.body);
   let email = req.body.email;
   let password = req.body.password;
   if (email && password) {
       connection.query('SELECT * FROM accounts WHERE email = ? AND password = ?', [email, password], function(error, result, field) {
        if (result.length > 0) {
            req.session.loggedIn = true;
            req.session.userName = email;
            req.session.userId = result[0].id;
            let respondJSON = {
                status: "Login success",
                userInfo: result[0]
            }
            res.send(respondJSON);
        }
        else {
            res.status(500).send('Inccorect Username and Password!')
        }
        res.end();
       });
   }
   else {
    res.status(500).send('Inccorect Username and Password!')
    res.end();
   } 
});

app.post('/register', function(req, res) {
    console.log(req.body);
    let email = req.body.email;
   let username = req.body.username;
   let password = req.body.password;
   if (username && password && email) {
    connection.query('INSERT INTO accounts (username, password, email) VALUES (?, ?, ?)', [username, password, email], function(error, result, field) {
        if (error) throw error;
    });
    connection.query('SELECT * FROM accounts WHERE email = ? AND password = ?', [email, password], function(error, result, field) {
        if (result.length > 0) {
            req.session.loggedIn = true;
            req.session.userName = email;
            req.session.userId = result[0].id;
            let respondJSON = {
                status: "Login success",
                userInfo: result[0]
            }
            res.send(respondJSON);
        }
        else {
            res.status(500).send('Inccorect Username and Password!')
        }
        res.end();
       });    

   }
   else {
    res.status(500).send('Inccorect Username and Password!')
    res.end();
   } 
});

app.post('/update', function(req, res) {
    console.log(req.body);
    let email = req.body.email;
   let username = req.body.username;
   let password = req.body.password;
   let id = req.body.id;
   if (username && password && email) {
    connection.query('UPDATE accounts SET username = ?, password = ?, email = ? WHERE id = ?', [username, password, email, id], function(error, result, field) {
        if (error) throw error;
    });
    connection.query('SELECT * FROM accounts WHERE email = ? AND password = ?', [email, password], function(error, result, field) {
        if (result.length > 0) {
            req.session.loggedIn = true;
            req.session.userName = email;
            req.session.userId = result[0].id;
            let respondJSON = {
                status: "Login success",
                userInfo: result[0]
            }
            res.send(respondJSON);
        }
        else {
            // res.send('Inccorect Username and Password');
            res.status(500).send('Inccorect Username and Password!')
        }
        res.end();
       });    

   }
   else {
    res.status(500).send('Inccorect Username and Password!')
    res.end();
   } 
});

app.get('/home', function(req, res) {
    if(req.session.loggedIn) {
        let queryStr = `SELECT tasks.id, tasks.title, tasks.description, tasks.isConfirmed, tasks.owner_email, COUNT(approvement.id) as isApprovedByUser
        FROM tasks
        LEFT JOIN (SELECT * FROM approvement WHERE approver_id=${req.session.userId}) approvement ON tasks.id=approvement.task_id
        GROUP BY tasks.id
        ORDER BY tasks.id DESC`;
        connection.query(queryStr, function(error, result, field) {
            if (result.length > 0) {
                let html = TasksView.display(result);
                res.send(html);
            }
            else {
                res.send('<h1>Empty task list</h1>');
            }
            res.end();
           });
    }
    else {
        res.send('<h1>Please login first!</h1>');

    }
});

app.post('/approve', function(req, res) {
    let taskId = req.body.taskId;
    connection.query('INSERT INTO approvement (task_id, approver_id) VALUES (?, ?)', [taskId, req.session.userId], function(error, result, field) {
        if (error) throw error;
    });
    connection.query('SELECT * FROM approvement WHERE task_id=?', [taskId], function(error, result, field) {
        if (result.length >= 3) {
            connection.query('UPDATE tasks SET isConfirmed = 1 WHERE id=?', [taskId], function(error, result, field) {
                if (error) throw error;
            });
            connection.query('SELECT * FROM tasks WHERE id=?', [taskId], function(error, result, field) {
                if (error) throw error;
                email.sendMail(result[0]);
            });
        }
    });
    res.redirect('/home');
    });

app.listen(3000, () => console.log(`server is running on ${process.env.PORT}`));