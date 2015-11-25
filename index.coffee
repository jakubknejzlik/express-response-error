module.exports = (options = {})->
  return (req,res,next)->
    res.throw = (message,statusCode = 400)->
      res.status(statusCode).send({error:message})
    next()

    res.notFound = (message)->
      res.throw(message,404)