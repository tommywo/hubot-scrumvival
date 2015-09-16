# Hubot classes
Robot = require("hubot/src/robot")
TextMessage = require("hubot/src/message").TextMessage
# Load assertion methods to this scope
chai = require 'chai'
nock = require 'nock'
{ expect } = chai
path = require 'path'

nock = require 'nock'
process.env.HUBOT_LOG_LEVEL = 'debug'
chai.use require 'chai-spies'
{ expect, spy } = chai

describe 'hubot-scrumvival', ->
  robot = null
  user = null
  adapter = null
  nockScope = null
  beforeEach (done)->
    nock.disableNetConnect()
    nockScope = nock('http://scrumvival.com').post('/wp-admin/admin-ajax.php')
    robot = new Robot null, 'mock-adapter', yes, 'TestHubot'
    robot.adapter.on 'connected', ->
      robot.loadFile path.resolve('.'), 'index.coffee'
      hubotScripts = path.resolve 'node_modules', 'hubot-help', 'src'
      robot.loadFile hubotScripts, 'help.coffee'
      user = robot.brain.userForId '1', {
        name: 'user'
        room: '#mocha'
      }
      adapter = robot.adapter
      waitForHelp = ->
        if robot.helpCommands().length > 0
          do done
        else
          setTimeout waitForHelp, 100
      do waitForHelp
    do robot.run

  afterEach ->
    robot.server.close()
    robot.shutdown()

  describe 'help', ->
    it 'should have 3', (done)->
      expect(robot.helpCommands()).to.have.length 3
      do done

    it 'should parse help', (done)->
      adapter.on 'send', (envelope, strings)->
        try
          expect(strings[0]).to.equal """
          TestHubot help - Displays all of the help commands that TestHubot knows about.
          TestHubot help <query> - Displays all help commands that match <query>.
          TestHubot scrum - display nudge from scrumvival.com
          """
          do done
        catch e
          done e
      adapter.receive new TextMessage user, 'TestHubot help'

  describe 'success',(done) ->

    it 'should send', (done)->

      data = {"ID":696314,"post_title":"Introduce a little anarchy. | Scrumvival","post_content":"Introduce a little anarchy.","post_content_main":"Introduce a little anarchy.","link":"http:\/\/scrumvival.com\/20150329\/","twitter_message":"Introduce+a+little+anarchy.+%23scrumvival+%23scrum.+Via+%40scrumvival+%28http%3A%2F%2Fscrumvival.com%2F20150329%2F%29","votes_plus":"0","votes_minus":"0","vote_button_flag":"","trails":null,"fuck":"1"}
      nockScope.reply 200, data

      adapter.on 'send', (envelope, strings)->
        try
          expect(envelope.user.id).to.equal '1'
          expect(envelope.user.name).to.equal 'user'
          expect(envelope.user.room).to.equal '#mocha'
          expect(strings).to.have.length(1)
          expect(strings[0]).to.have.length.greaterThan 35
          expect(strings[0]).to.have.string 'So scrum doesn\'t work, huh?... '

          do done
        catch e
          done e
      adapter.receive new TextMessage user, 'testhubot scrum'

    it 'should send when no connection', (done)->

      adapter.on 'send', (envelope, strings)->
        try
          expect(envelope.user.id).to.equal '1'
          expect(envelope.user.name).to.equal 'user'
          expect(envelope.user.room).to.equal '#mocha'
          expect(strings).to.have.length(1)
          expect(strings[0]).to.have.length.greaterThan 35
          expect(strings[0]).to.have.string 'So scrum doesn\'t work, huh?... '
          do done
        catch e
          done e
      adapter.receive new TextMessage user, 'testhubot scrum'

    it 'should send when parsing error', (done)->

      data = '{test:'
      nockScope.reply 200, data

      adapter.on 'send', (envelope, strings)->
        try
          expect(envelope.user.id).to.equal '1'
          expect(envelope.user.name).to.equal 'user'
          expect(envelope.user.room).to.equal '#mocha'
          expect(strings).to.have.length(1)
          expect(strings[0]).to.have.length.greaterThan 35
          expect(strings[0]).to.have.string 'So scrum doesn\'t work, huh?... '
          do done
        catch e
          done e
      adapter.receive new TextMessage user, 'testhubot scrum'