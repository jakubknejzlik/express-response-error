responses = {
  error:(message,statusCode = 400)->
    error = null
    if message instanceof Error
      error = message
    else
      try
        throw new Error(message)
      catch err
        error = err
    payload = {error:error.message}
    if process.env.NODE_ENV isnt 'production' or @req.query.debug
      payload.stack = error.stack
    @status(statusCode).send(payload)
  unauthorized:(message)->
    @error(message,401)
  paymentRequired:(message)->
    @error(message,402)
  forbidden:(message)->
    @error(message,403)
  notFound:(message)->
    @error(message,404)
  methodNotAllowed:(message)->
    @error(message,405)
  notAcceptable:(message)->
    @error(message,406)
  proxyAuthenticationRequired:(message)->
    @error(message,407)
  requestTimeout:(message)->
    @error(message,408)
  conflict:(message)->
    @error(message,409)
  gone:(message)->
    @error(message,410)
  lengthRequired:(message)->
    @error(message,411)
  preconditionFailed:(message)->
    @error(message,412)
  requestEntityTooLarge:(message)->
    @error(message,413)
  requestURITooLong:(message)->
    @error(message,414)
  unsuportedMediaType:(message)->
    @error(message,415)
  requestedRangeNotSatisfiable:(message)->
    @error(message,416)
  expectationFailed:(message)->
    @error(message,417)


  internalServerError:(message)->
    @error(message,500)
  notImplemented:(message)->
    @error(message,501)
  badGateway:(message)->
    @error(message,502)
  serviceUnavailable:(message)->
    @error(message,503)
  gatewayTimeout:(message)->
    @error(message,504)
  httpVersionNotSupported:(message)->
    @error(message,505)
}

module.exports = (options = {})->
  return (req,res,next)->

    for name,responseHandler of responses
      res[name] = responseHandler

    next()