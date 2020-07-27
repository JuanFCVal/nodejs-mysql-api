const express = require("express");
const router = express.Router();

const mysqlConnection = require("../database"); //Trae la conexion de mysql, y usaremos la conexion para hacer consultas.

router.get("/reportes/", (req, res) => {
  mysqlConnection.query("SELECT * FROM falsabandera", (err, rows, fields) => {
    //Sentencia y lo que podemos obtener
    if (!err) {
      res.json(rows);
    } else {
      console.log("No se pudo obtener los falsabanderas " + err);
    }
  });
});

//Busqueda de falsabandera recibiendo como parametro id de la falsabandera
router.get("/reportes/:id", (req, res) => {
  const { id } = req.params; //Parametro que recibire
  mysqlConnection.query("SELECT * FROM falsabandera WHERE idFalsaBandera = ?", [id], (err, rows, fields) => {
    ////Sentencia y que puede devolver
    if (!err) {
      res.json(rows[0]);
    } else {
      console.log("No se pudo obtener las falsabanderas " + err);
    }
  });
});


//Ver evidencias de los reportes
router.get("/reportes/:id/evidencias", (req, res) => {
  const { id } = req.params;
  const { id1 } = req.params;
  mysqlConnection.query("SELECT * FROM falsabandera fb , evidencias e WHERE e.idEvidencias = fb.Evidencias_idEvidencias and idFalsaBandera= ? ",[id], (err, rows, fields) => {//Sentencia y lo que podemos obtener
    if (!err) {
      res.json(rows);
    } else {
      console.log("No se pudo obtener las banderas " + err);
    }
  }); 
});

//Insertar un dato dentro de nuestra tabla
router.post("/reportes/", (req, res) => {
  const { idFalsaBandera, estado, Usuario_cedula, Evidencias_idEvidencias, Bandera_idBandera } = req.body; //Obtenemos el falsabandera desde la aplicacion
  const query = ` 
    CALL AgregarEditarReportes(?,?,?,?,?);
    `;
  mysqlConnection.query(
    query,
    [idFalsaBandera, estado, Usuario_cedula, Evidencias_idEvidencias, Bandera_idBandera],
    (err, rows, fields) => {
      if (!err) {
        res.json({ Status: "falsabandera registrada" });
      } else {
        console.log("No se ha registrado  falsabandera " + err);
      }
    }
  );
});
//Metodo de actualizacion
router.put("/reportes/:id", (req, res) => {
  const { idFalsaBandera, estado, Usuario_cedula, Evidencias_idEvidencias, Bandera_idBandera } = req.body;
  const { id } = req.params;
  const query = `
  CALL AgregarEditarReportes(?,?,?,?,?);
    `;
  mysqlConnection.query(query, [id, estado, Usuario_cedula, Evidencias_idEvidencias, Bandera_idBandera], (err, rows, fields) => {
    if (!err) {
      res.json({ status: "Se ha actualizado la falsabandera de id" + id });
    } else {
      console.log("No se ha actualizado la falsabandera " + err);
    }
  });
});

router.delete("/reportes/:id", (req, res) => {
  const { id } = req.params;
  mysqlConnection.query("DELETE FROM falsabandera WHERE idFalsaBandera = ?", [id], (err, rows, fields) => {
    if (!err) {
      res.json({ status: "Se ha eliminado la falsabandera de id" + id });
    } else {
      console.log("No se ha eliminado la falsabandera " + err);
    }
  });
});
module.exports = router;
