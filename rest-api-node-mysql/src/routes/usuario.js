const express = require("express");
const router = express.Router();

const mysqlConnection = require("../database"); //Trae la conexion de mysql, y usaremos la conexion para hacer consultas.

router.get("/usuario/", (req, res) => {
  mysqlConnection.query("SELECT * FROM usuario", (err, rows, fields) => {
    //Sentencia y lo que podemos obtener
    if (!err) {
      res.json(rows);
    } else {
      console.log("No se pudo obtener los usuarios " + err);
    }
  });
  mysqlConnection.end();
});

//Busqueda de usuario recibiendo como parametro id de la usuario
router.get("/usuario/:id", (req, res) => {
  const { id } = req.params; //Parametro que recibire
  mysqlConnection.query("SELECT * FROM usuario WHERE cedula = ?", [id], (err, rows, fields) => {
    ////Sentencia y que puede devolver
    if (!err) {
      res.json(rows[0]);
    } else {
      console.log("No se pudo obtener las usuarios " + err);
    }
  });
  mysqlConnection.end();
});

//Insertar un dato dentro de nuestra tabla
router.post("/usuario/", (req, res) => {
  const { nombre, apellido, cedula, correo, usuario, password, fotoPerfil, tipoUser } = req.body; //Obtenemos el usuario desde la aplicacion
  const query = ` 
    CALL AgregarUsuario(?,?,?,?,?,?,?,?);
    `;
  mysqlConnection.query(query, [nombre, apellido, cedula, correo, usuario, password, fotoPerfil, tipoUser], (err, rows, fields) => {
    if (!err) {
      res.json({ Status: "usuario registrada" });
    } else {
      console.log("No se ha registrado  usuario " + err);
    }
  });
  mysqlConnection.end();
});
//Metodo de actualizacion
router.put("/usuario/:cedula", (req, res) => {
  const { nombre, apellido, correo, usuario, password, fotoPerfil, tipoUser } = req.body;
  const { cedula } = req.params;
  const query = `
    CALL EditarUsuario(?,?,?,?,?,?,?,?);
    `;
  mysqlConnection.query(query, [nombre, apellido, cedula, correo, usuario, password, fotoPerfil, tipoUser], (err, rows, fields) => {
    if (!err) {
      res.json({ status: "Se ha actualizado la usuario de id" + cedula });
    } else {
      console.log("No se ha actualizado la usuario " + err);
    }
  });
  mysqlConnection.end();
});

router.delete("/usuario/:cedula", (req, res) => {
  const { cedula } = req.params;
  mysqlConnection.query("DELETE FROM usuario WHERE cedula = ?", [cedula], (err, rows, fields) => {
    if (!err) {
      res.json({ status: "Se ha eliminado la usuario de id" + cedula });
    } else {
      console.log("No se ha eliminado la usuario " + err);
    }
  });
  mysqlConnection.end();
});
module.exports = router;
