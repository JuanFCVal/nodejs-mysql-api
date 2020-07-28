const mysql = require('mysql');

//Parametros de conexión a la base de datos
var dbconfig ={
    host: 'us-cdbr-east-02.cleardb.com',
    user: 'b8747b60318c94',
    password: 'cfb48514',
    database: 'heroku_165707ab10392f8',
    multipleStatments: true,
    connect_timeout:1000000
};
const mysqlConnection = mysql.createConnection(dbconfig);

mysqlConnection.connect(function (err) {
    if(err){
        console.log(err);
        return;
    }else{

        console.log("Db is connected");
    }
});

module.exports = mysqlConnection;