var express = require('express');
var router = express.Router();
var jwt = require('jsonwebtoken');
var fs = require('fs');
const mariadb = require('mariadb');
var db = mariadb.createConnection({
    host: 'localhost',
    user: 'root',
    password: '3266jpa',
    database: 'clinica'
})

router.post('/insertar', async function(req, res, next) {
    var cliente = req.body;
    db.then(conn=>{
        conn.query("insert into clientes(vorname,name,seguro,allergien)values(?,?,?,?)",[cliente.vorname,cliente.name,cliente.seguro,cliente.allergien])
        .then(x=>{
            console.log(x)
           console.log(cliente)
          return res.send(x)
        })
    })
})
router.post('/prueba', async function(req, res, next) {
    var cliente = req.body;

    db.then(conn=>{
        conn.query("select * from gerichte where id=1")
        .then(x=>{
            console.log('gerichtes ' , x[0].name)
           console.log(cliente);
           plato=x[0].bestandteil
          //return res.send(plato)
        })
    })
    db.then(conn=>{
        conn.query("select * from clientes where id=1")
        .then(x=>{
            miarray=x[0].allergien;
            console.log('alergias '+ x[0].vorname)
            for (var i = 0; i < miarray.length; i++) {
                   for(var p=0; p < plato.length; p++){
                       if (miarray[i]==plato[p]){
                           return res.end('cliente allergico');
                       }
                   }
                console.log(miarray[i])
                }
            console.log(x)
           console.log(cliente)
          return res.send(x)
        })
    })
})
router.post('/login', async function(req, res, next) {
    var user = req.body;
console.log(user);
    //Verifica el usuario
    if (!user)
        return res.status(500).send({ message: 'Los datos del usuario son incorrectos.' });
        
        db.then(conn => {
            conn.query("select * from users where email=?",[user.Usuario] )
                .then(rows => {
                    usuario=rows[0].email;
                    clave=rows[0].password;
                    console.log('mi usuario'+ usuario);+
                    console.log('mi otro usuario' + user.Usuario)
    
                    if(user.Password!==clave){
                        return res.send('usuario o clave erroneos');
                    }
                    try {
                        console.log('__dirname: ', __dirname);
                        //var cert_priv = fs.readFileSync(__dirname + '/../certs/clave_privada.pem');
                        var signOptions = {
                            issuer: process.env.Issuer,
                            audience: process.env.Audience,
                            expiresIn: "52000", // 1 dia (Formato https://github.com/zeit/ms)
                            //algorithm: "RS256" // https://github.com/auth0/node-jsonwebtoken#algorithms-supported
                        };
                
                        // https://github.com/auth0/node-jsonwebtoken#jwtsignpayload-secretorprivatekey-options-callback
                        jwt.sign({ cusu: user.Usuario }, '123456', signOptions,
                            function(err, token) {
                
                                if (err) {
                                    console.log('Error al generar el token: ', err);
                                    res.status(500).send({ error: "Error interno" });
                                }
                                console.log('token: ', token);
                                res.send({ response: token });
                            });
                
                    } catch (error) {
                        console.log('error: ', error);
                        res.status(500).send({ error: "Error interno" });
                    }
                            
                }).catch(error =>{console.log('error');
               return res.send('No logueado');
            });
        }).catch(error =>console.log(error));



   
});

module.exports = router;            