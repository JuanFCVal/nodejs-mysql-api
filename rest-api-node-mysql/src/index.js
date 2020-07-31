const express = require('express');
const  app = express();
const morgan = require('morgan');
var cors = require('cors');
//const wakeDyno = require("woke-dyno");
const http = require('http');


//Settings
const port = process.env.PORT;
app.set('port', port || 3000); //Acepta el puerto que nos da el servidor en caso que no te de uda el 3000

//Middlewares witohout corse
app.use(express.json());  //Acepta el formato Json como dato
app.use(morgan('dev'));
app.use(cors());
app.use(express.urlencoded({extended: false}));
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", '*'); // update to match the domain you will make the request from
    res.header("Access-Control-Allow-Headers", 'Origin, X-Requested-With, Content-Type, Accept');
    res.header("Access-Control-Allow-Headers", 'GET,PUT,POST,DELETE,OPTIONES');
    res.header("Access-Control-Allow-Headers", 'Content-Type, Authorization, Content-Lengt');
    next();
  });
//Route
app.get('/', (req,res) => {
    res.send('Welcome to my Api');
})
//Routes
app.use(require('./routes/banderas'));
app.use(require('./routes/donacion'));
app.use(require('./routes/usuario'));
app.use(require('./routes/reportes'));

//Starting server/*
//app.listen(app.get('port'), () => {
    
//} );

app.listen(port, () => {
    console.log('Server on port', app.get('port'));
    
    wakeDyno({
        url: "https://redflag-api.herokuapp.com/usuario/1",  // url string
        interval: 20000, // interval in milliseconds (1 minute in this example)
        startNap: [12, 0, 0, 0], // the time to start nap in UTC, as [h, m, s, ms] (05:00 UTC in this example)
        endNap: [13, 00, 10, 000] // time to wake up again, in UTC (09:59:59.999 in this example)
    }).start(); 
});
