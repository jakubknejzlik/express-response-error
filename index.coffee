module.exports = (options = {})->
  return (req,res,next)->
    res.error = (message,statusCode = 400)->
      res.status(statusCode).send({error:message})
    next()

    res.notFound = (message)->
      res.error(message,404)