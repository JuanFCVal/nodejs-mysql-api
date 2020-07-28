const mysql = require('mysql');

//Parametros de conexión a la base de datos
var dbconfig ={
    host: 'us-cdbr-east-02.cleardb.com',
    user: 'b8747b60318c94',
    password: 'cfb48514',
    database: 'heroku_165707ab10392f8',
    multipleStatments: true
};
const mysqlConnection = mysql.createConnection(dbconfig);

var connection;
function handleDisconnect() {
    connection = mysql.createConnection(dbconfig);  // Recreate the connection, since the old one cannot be reused.
    connection.connect( function onConnect(err) {   // The server is either down
        if (err) {                                  // or restarting (takes a while sometimes).
            console.log('error when connecting to db:', err);
            setTimeout(handleDisconnect, 10000);    // We introduce a delay before attempting to reconnect,
        }                                           // to avoid a hot loop, and to allow our node script to
    });                                             // process asynchronous requests in the meantime.
                                                    // If you're also serving http, display a 503 error.
    connection.on('error', function onError(err) {
        console.log('db error', err);
        if (err.code == 'PROTOCOL_CONNECTION_LOST') {   // Connection to the MySQL server is usually
            handleDisconnect();                         // lost due to either server restart, or a
        } else {                                        // connnection idle timeout (the wait_timeout
            throw err;                                  // server variable configures this)
        }
    });
}
mysqlConnection.connect(function (err) {
    if(err){
        console.log(err);
        return;
    }else{
        handleDisconnect()
        console.log("Db is connected");
    }
});

module.exports = mysqlConnection;