# express-response-error

[![Build Status](https://travis-ci.org/jakubknejzlik/express-response-error.svg?branch=master)](https://travis-ci.org/jakubknejzlik/express-response-error)

# Example

```
 express = require('express')
 expressResponseError = require('express-response-error')

 app = new express()
 app.use(expressResponseError())

 app.get('/test/forbidden',(req,res,next)->
   res.forbidden('this resource is forbidden')
 )

 app.listen(process.env.PORT)

```