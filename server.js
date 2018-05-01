var express  = require('express'),
    path     = require('path'),
    bodyParser = require('body-parser'),
    app = express(),
    expressValidator = require('express-validator');

/*Set EJS template Engine*/
app.set('view engine','ejs');

app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: true })); //support x-www-form-urlencoded
app.use(bodyParser.json());
app.use(expressValidator());

/*MySql connection*/
var connection  = require('express-myconnection'),
    mysql = require('mysql');

app.use(
    connection(mysql,{
        host     : 'localhost',
        user     : 'user_name',
        password : 'passwordGoesHere',
        database : 'test',
        debug    : false //set true if you wanna see debug logger
    },'request')
);

app.get('/',function(req,res){
    res.send('Welcome');
});

//RESTful route
var router = express.Router();

/*------------------------------------------------------
*  This is router middleware,invoked everytime
*  we hit url /api and anything after /api
--------------------------------------------------------*/
router.use(function(req, res, next) {
    console.log(req.method, req.url);
    next();
});

var curut = router.route('/v1');

//show the CRUD interface | GET
curut.get(function(req,res,next){


    req.getConnection(function(err,conn){

        if (err) return next("Cannot Connect to database.");

        var query = conn.query('SELECT * FROM Inventory, ProductList WHERE Inventory.pId = ProductList.pId AND Inventory.sellDate IS NULL;',function(err,rows){
            if(err){
                console.log(err);
                return next("Mysql error, please check your query");
            }
            res.status(200).json(rows);
        });
    });
});

//now we need to apply our router here
app.use('/api', router);

//start Server
var server = app.listen(8001,function(){

    console.log("Listening to port %s",server.address().port);

});
