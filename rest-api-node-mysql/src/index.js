const express = require('express');
const  app = express();
var cors = require('cors');
const wakeDyno = require("woke-dyno");
//Settings
//Solo para pushear xd
const port = process.env.PORT;
app.set('port', port || 3000); //Acepta el puerto que nos da el servidor en caso que no te de uda el 3000

//Middlewares
app.use(express.json());  //Acepta el formato Json como dato
app.use(cors());
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
        startNap: [10, 0, 0, 0], // the time to start nap in UTC, as [h, m, s, ms] (05:00 UTC in this example)
        endNap: [9, 00, 00, 000] // time to wake up again, in UTC (09:59:59.999 in this example)
    }).start(); 
});
