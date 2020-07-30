const express = require("express");
const router = express.Router();

const mysqlConnection = require("../database"); //Trae la conexion de mysql, y usaremos la conexion para hacer consultas.

router.get("/donacion", (req, res) => {
  mysqlConnection.query("SELECT * FROM donacion", (err, rows, fields) => {//Sentencia y lo que podemos obtener
    if (!err) {
      res.json(rows);
    } else {
      console.log("No se pudo obtener la lista donaciones " + err);
    }
  }); 
});

//Ver los tipos de donaciones de una donacion
router.get("/donacion/:id/donaciones", (req, res) => {
  const { id } = req.params;
  const { id1 } = req.params;
  mysqlConnection.query("SELECT Tipo,idDonacion FROM donacion d INNER JOIN donacion_has_tipodonacion dd ON d.idDonacion =  dd.donacion_idDonacion INNER JOIN  tipodonacion td ON dd.tipodonacion_idTipoDonacion = td.idTipoDonacion WHERE idDonacion = ?",[id], (err, rows, fields) => {//Sentencia y lo que podemos obtener
    if (!err) {
      res.json(rows);

    } else {
      console.log("No se pudo obtener las banderas " + err);
    }
  }); 
});
//Ver evidencias de las donaciones
router.get("/donacion/:id/evidencias", (req, res) => {
  const { id } = req.params;
  const { id1 } = req.params;
  mysqlConnection.query("SELECT * FROM donacion d , evidencias e WHERE e.idEvidencias = d.Evidencias_idEvidencias and idDonacion= ?; ",[id], (err, rows, fields) => {//Sentencia y lo que podemos obtener
    if (!err) {
      res.json(rows);
    } else {
      console.log("No se pudo obtener las banderas " + err);
    }
  });
});

router.get("/donacion/evidencias", (req, res) => {
  mysqlConnection.query("SELECT * FROM donacion,evidencias", (err, rows, fields) => {//Sentencia y lo que podemos obtener
    if (!err) {
      res.json(rows);
    } else {
      console.log("No se pudo obtener la lista donaciones " + err);
    }
  }); 
});

//Busqueda de donacion recibiendo como parametro id de la donacion
router.get("/donacion/:id", (req, res) => {
  const { id } = req.params;  //Parametro que recibire
  mysqlConnection.query('SELECT * FROM donacion WHERE idDonacion = ?', [id], (err, rows, fields) => { ////Sentencia y que puede devolver
    if (!err) {
      res.json(rows[0]);
    } else {
      console.log("No se pudo obtener las donacion " + err);
    }
  });
});

//Insertar un dato dentro de nuestra tabla 
router.post('/donacion/', (req, res)=>{
    const {idDonacion, estado, fecha, Usuario_cedula, Evidencias_idEvidencias } = req.body //Obtenemos el usuario desde la aplicacion 
    const query = ` 

    CALL AgregaroEditarDonacion(?,?,?,?,?);
    `;
    mysqlConnection.query(query, [idDonacion, estado, fecha, Usuario_cedula, Evidencias_idEvidencias], (err, rows, fields)=>{
            if (!err) {
                res.json({Status: 'donacion registrada'});
              } else {
                console.log("No se ha registrado la donacion " + err);
              }
        })
});
//Metodo de actualizacion
router.put('/donacion/:id', (req, res ) =>{
    const {  estado, fecha, Usuario_cedula, Evidencias_idEvidencias } = req.body;
    const{ id } = req.params;
    const query = "CALL AgregaroEditarDonacion(?,?,?,?,?);"
    mysqlConnection.query(query, [id, estado, fecha, Usuario_cedula, Evidencias_idEvidencias], (err, rows, fields)=>{
            if (!err) {
                res.json({status: 'Se ha actualizado la donacion de id'+id});
              } else {
                console.log("No se ha actualizado la donacion " + err);
              }
        })

});

router.delete('/donacion/:id',(req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM donacion WHERE idDonacion = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.json({status: 'Se ha eliminado la donacion de id'+id});
          } else {
            console.log("No se ha eliminado la donacion " + err);
          }
    })

});
module.exports = router;
