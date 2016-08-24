expressResponseError = require('../index')
express = require('express')
async = require('async')
assert = require('assert')
i18n = require('i18n')

i18n.configure({
  locales:['en']
  directory: __dirname + '/locales'
})


supertest = require('supertest')

app = new express()
app.use(i18n.init)

app.get('*',expressResponseError({translate:'i18n'}),(req,res)->
  res.error(req.query.message or 'no message',req.query.statusCode)
)

app.use((err,req,res,next)->
  res.status(err.code).send({error: err.message})
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

  it('should return test response',(done)->
    async.forEach([200,201,400],(status,cb)->
      test.get('/?message=TEST_RESPONSE&statusCode=' + status)
      .expect(status)
      .expect((res)->
        assert.equal(res.body.error,'this is test response')
      )
      .end(cb)
    ,done)
  )
)