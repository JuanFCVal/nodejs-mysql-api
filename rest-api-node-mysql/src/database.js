const mysql = require('mysql');

//Parametros de conexión a la base de datos
const mysqlConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'redflag',
    multipleStatments: true
});

mysqlConnection.connect(function (err) {
    if(err){
        console.log(err);
        return;
    }else{
        console.log("Db is connected");
    }
});

module.exports = mysqlConnection;