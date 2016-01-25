# express-response-error

Send errors easily right from response object (eg. res.notFound('not found') -> 404 {"error":"not found"}).

[![Build Status](https://travis-ci.org/jakubknejzlik/express-response-error.svg?branch=master)](https://travis-ci.org/jakubknejzlik/express-response-error)

# Example

```
 var express = require('express');
 var expressResponseError = require('express-response-error');

 app = new express();
 
 var options = {};
 app.use(expressResponseError(options));

 app.get('/test/forbidden',(req,res,next)->
  res.forbidden('this resource is forbidden');
 )
 
 app.get('/test/custom',(req,res,next)->
  res.error('something bad has happened',444);
 )

 app.listen(process.env.PORT)

```

# Options

 * `curlify` - return *curl* for request
 * `logging` - log every error payload with *console.error*
 * `stackLogging` - include error stack in payload
 * `translation` - translate error message (default `null`)
    - specify translate function accepting one argument
    - string `i18n` to use translation for [i18n](https://www.npmjs.com/package/i18n))

# Translations with i18n

```
 var express = require('express');
 var expressResponseError = require('express-response-error');
 var i18n = require('i18n');

 i18n.configure({
    locales:['en','de']
 })

 app = new express();
 
 var options = {
    translate:'i18n'
 };
 app.use(expressResponseError(options));
 app.use(i18n.init)
 
 app.get('*',(req,res,next)->
  res.error('SOME_ERROR'); // this message gets translated with dictionary 
 )

 app.listen(process.env.PORT)

```

# Debug

If you app is not running in `production` (process.env.NODE_ENV == 'production') or if you specify `?debug=1` in request stack is returned in response.