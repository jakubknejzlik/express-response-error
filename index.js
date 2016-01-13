// Generated by CoffeeScript 1.10.0
(function() {
  var curlify, responses;

  curlify = require('request-as-curl');

  responses = {
    error: function(message, statusCode) {
      var error, options, payload;
      if (statusCode == null) {
        statusCode = 400;
      }
      options = this.req._responseErrorOptions || {};
      error = null;
      if (message instanceof Error) {
        error = message;
      } else {
        error = new Error(message);
      }
      payload = {
        error: error.message
      };
      if (process.env.NODE_ENV !== 'production' || this.req.query.debug) {
        payload.stack = error.stack;
      }
      if (process.env.RESPONSE_ERROR_LOGGING) {
        console.error(error);
      }
      if (options.curlify) {
        payload.curl = curlify(this.req);
      }
      return this.status(statusCode).send(payload);
    },
    unauthorized: function(message) {
      return this.error(message, 401);
    },
    paymentRequired: function(message) {
      return this.error(message, 402);
    },
    forbidden: function(message) {
      return this.error(message, 403);
    },
    notFound: function(message) {
      return this.error(message, 404);
    },
    methodNotAllowed: function(message) {
      return this.error(message, 405);
    },
    notAcceptable: function(message) {
      return this.error(message, 406);
    },
    proxyAuthenticationRequired: function(message) {
      return this.error(message, 407);
    },
    requestTimeout: function(message) {
      return this.error(message, 408);
    },
    conflict: function(message) {
      return this.error(message, 409);
    },
    gone: function(message) {
      return this.error(message, 410);
    },
    lengthRequired: function(message) {
      return this.error(message, 411);
    },
    preconditionFailed: function(message) {
      return this.error(message, 412);
    },
    requestEntityTooLarge: function(message) {
      return this.error(message, 413);
    },
    requestURITooLong: function(message) {
      return this.error(message, 414);
    },
    unsuportedMediaType: function(message) {
      return this.error(message, 415);
    },
    requestedRangeNotSatisfiable: function(message) {
      return this.error(message, 416);
    },
    expectationFailed: function(message) {
      return this.error(message, 417);
    },
    internalServerError: function(message) {
      return this.error(message, 500);
    },
    notImplemented: function(message) {
      return this.error(message, 501);
    },
    badGateway: function(message) {
      return this.error(message, 502);
    },
    serviceUnavailable: function(message) {
      return this.error(message, 503);
    },
    gatewayTimeout: function(message) {
      return this.error(message, 504);
    },
    httpVersionNotSupported: function(message) {
      return this.error(message, 505);
    }
  };

  module.exports = function(options) {
    if (options == null) {
      options = {};
    }
    return function(req, res, next) {
      var name, responseHandler;
      req._responseErrorOptions = options;
      for (name in responses) {
        responseHandler = responses[name];
        res[name] = responseHandler;
      }
      return next();
    };
  };

}).call(this);
