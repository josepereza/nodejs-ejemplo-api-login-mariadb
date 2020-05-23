var express=require('express');
var logger=require('morgan');
var helmet=require('helmet');
var cors=require('cors');
var dotenv=require('dotenv');

dotenv.config();
var app=express();
//Archivos de apis
var indentidadRouter=require('./routes/identidad');
var clientesRouter=require('./routes/clientes');



//parser de datos recibidos

app.use(express.json());
app.use(express.urlencoded({extended:false}));

app.use(logger('dev'));
app.use(cors());
app.use(helmet());

app.use('/api/identidad', indentidadRouter);
app.use('/api/clientes', clientesRouter);
app.listen(3000, function(){
    console.log('el puerto 3000 inicio correctamente');
})