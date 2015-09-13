# Description
#   display nudge from scrumvival.com
#
# Dependencies:
#   "htmlparser": "1.7.6"
#   "soupselect: "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot scrum - display nudge from scrumvival.com
#
# Author:
#   tomasz@wojtun.pl

Select     = require("soupselect").select
HtmlParser = require "htmlparser"

module.exports = (robot) ->
  robot.respond /scrum/i, (msg) ->
    msg.http("http://scrumvival.com")
      .get() (err, res, body) ->
        msg.http(res.headers.location)
          .get() (err2, res2, body2) ->
            handler = new HtmlParser.DefaultHandler()
            parser  = new HtmlParser.Parser handler
            parser.parseComplete body2
            quote = 'So scrum doesn\'t work, huh?... ' 
            article = (Select handler.dom, "h1")[0]
            for d, i in article.children
              if d.type == 'text'
                quote = quote + d.raw
              else
                if d.type=='tag'
                  quote = quote + d.children[0].raw
            msg.send quote