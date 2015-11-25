expressResponseError = require('../index')
express = require('express')
async = require('async')
assert = require('assert')

supertest = require('supertest')

app = new express()
app.use(expressResponseError())

app.get('*',(req,res,next)->
  res.throw(req.query.message or 'not message',req.query.statusCode)
)

test = supertest(app)


describe('middleware',()->
  it('should return status code',(done)->
    async.forEach([200,201,400],(status,cb)->
      test.get('/?message=status-' + status + '&statusCode=' + status)
      .expect(status)
      .expect((res)->
        assert.equal(res.body.error,'status-' + status)
      )
      .end(cb)
    ,done)
  )


)