const express = require("express");
const router = express.Router();

const mysqlConnection = require("../database"); //Trae la conexion de mysql, y usaremos la conexion para hacer consultas.

router.get("/bandera/", (req, res) => {
  mysqlConnection.query("SELECT * FROM bandera", (err, rows, fields) => {
    //Sentencia y lo que podemos obtener
    if (!err) {
      res.json(rows);
    } else {
      console.log("No se pudo obtener las banderas " + err);
    }
  });
});
router.get("/bandera/pendiente", (req, res) => {
  mysqlConnection.query("SELECT * FROM bandera WHERE estado = 0", (err, rows, fields) => {
    //Sentencia y lo que podemos obtener
    if (!err) {
      res.json(rows);
    } else {
      console.log("No se pudo obtener las banderas " + err);
    }
  });
});

router.get("/bandera/validado", (req, res) => {
  mysqlConnection.query("SELECT * FROM bandera WHERE estado = 1", (err, rows, fields) => {
    //Sentencia y lo que podemos obtener
    if (!err) {
      res.json(rows);
    } else {
      console.log("No se pudo obtener las banderas " + err);
    }
  });
});

//Ver los tipos de donaciones de una bandera
router.get("/banderas/:id/donaciones", (req, res) => {
  const { id } = req.params;
  mysqlConnection.query(
    "SELECT Tipo,idBandera FROM bandera b INNER JOIN bandera_has_tipodonacion bd ON b.idBandera =  bd.bandera_idBandera INNER JOIN  tipodonacion td ON bd.tipodonacion_idTipoDonacion = td.idTipoDonacion WHERE idBandera = ?",
    [id],
    (err, rows, fields) => {
      //Sentencia y lo que podemos obtener
      if (!err) {
        res.json(rows);
      } else {
        console.log("No se pudo obtener las banderas " + err);
      }
    }
  );
});

router.get("/banderas/donaciones", (req, res) => {
  mysqlConnection.query(
    "SELECT Tipo,idBandera FROM bandera b INNER JOIN bandera_has_tipodonacion bd ON b.idBandera =  bd.bandera_idBandera INNER JOIN  tipodonacion td ON bd.tipodonacion_idTipoDonacion = td.idTipoDonacion",
    (err, rows, fields) => {
      //Sentencia y lo que podemos obtener
      if (!err) {
        res.json(rows);
      } else {
        console.log("No se pudo obtener las banderas " + err);
      }
    }
  );
});

//Ver evidencias de las banderas
router.get("/banderas/:id/evidencias", (req, res) => {
  const { id } = req.params;
  mysqlConnection.query(
    "SELECT Descripcion, Imagen1, Imagen2, Imagen3, idBandera FROM bandera b , evidencias e WHERE e.idEvidencias = b.Evidencias_idEvidencias and idBandera=? ",
    [id],
    (err, rows, fields) => {
      //Sentencia y lo que podemos obtener
      if (!err) {
        res.json(rows);
      } else {
        console.log("No se pudo obtener las banderas " + err);
      }
    }
  );
});

router.get("/bandera/evidencia", (req, res) => {
  mysqlConnection.query("SELECT Imagen1,Imagen2,Imagen3,idBandera FROM bandera b INNER JOIN evidencias e ON b.Evidencias_idEvidencias = e.idEvidencias", (err, rows, fields) => {
    //Sentencia y lo que podemos obtener
    if (!err) {
      res.json(rows);
    } else {
      console.log("No se pudo obtener las banderas " + err);
    }
  });
});

//Busqueda de bandera recibiendo como parametro id de la bandera
router.get("/bandera/:id", (req, res) => {
  const { id } = req.params; //Parametro que recibire
  mysqlConnection.query("SELECT * FROM bandera WHERE idBandera = ?", [id], (err, rows, fields) => {
    ////Sentencia y que puede devolver
    if (!err) {
      res.json(rows[0]);
    } else {
      console.log("No se pudo obtener las banderas " + err);
    }
  });

});

//Insertar un dato dentro de nuestra tabla
router.post("/bandera/", (req, res) => {
  const {
    idBandera,
    latitud,
    referencia,
    calleP,
    calleS,
    nroCasa,
    nIntegrantes,
    nombreBeneficiario,
    cedulaBeneficiario,
    apellidoBeneficiario,
    Usuario_cedula,
    longitud,
    fechaRegistro,
    estado,
    tipo1,
    tipo2,
    tipo3,
    imagen1,
    imagen2,
    imagen3
  } = req.body; //Obtenemos el usuario desde la aplicacion
  const query = ` 

    CALL AgregaroEditarBandera(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);
    `;
  mysqlConnection.query(
    query,
    [
      idBandera,
      latitud,
      referencia,
      calleP,
      calleS,
      nroCasa,
      nIntegrantes,
      nombreBeneficiario,
      cedulaBeneficiario,
      apellidoBeneficiario,
      Usuario_cedula,
      longitud,
      fechaRegistro,
      estado,
      tipo1,
      tipo2,
      tipo3,
      imagen1,
      imagen2,
      imagen3
    ],
    (err, rows, fields) => {
      if (!err) {
        res.json({ Status: "Bandera registrada" });
      } else {
        console.log("No se ha registrado la bandera " + err);
      }
    }
  );

});
//Metodo de actualizacion
router.put("/bandera/:id", (req, res) => {
  const {
    latitud,
    referencia,
    calleP,
    calleS,
    nroCasa,
    nIntegrantes,
    nombreBeneficiario,
    cedulaBeneficiario,
    apellidoBeneficiario,
    Usuario_cedula,
    Evidencias_idEvidencias,
    longitud,
    fechaRegistro,
    estado,
  } = req.body;
  const { id } = req.params;
  const query = "CALL AgregaroEditarBandera(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
  mysqlConnection.query(
    query,
    [
      id,
      latitud,
      referencia,
      calleP,
      calleS,
      nroCasa,
      nIntegrantes,
      nombreBeneficiario,
      cedulaBeneficiario,
      apellidoBeneficiario,
      Usuario_cedula,
      Evidencias_idEvidencias,
      longitud,
      fechaRegistro,
      estado,
    ],
    (err, rows, fields) => {
      if (!err) {
        res.json({ status: "Se ha actualizado la bandera de id" + id });
      } else {
        console.log("No se ha actualizado la bandera " + err);
      }
    }
  );

});

router.delete("/bandera/:id", (req, res) => {
  const { id } = req.params;
  mysqlConnection.query("DELETE FROM bandera WHERE idBandera = ?", [id], (err, rows, fields) => {
    if (!err) {
      res.json({ status: "Se ha eliminado la bandera de id" + id });
    } else {
      console.log("No se ha eliminado la bandera " + err);
    }
  });

});
module.exports = router;
