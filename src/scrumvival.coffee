# Description
#   display nudge from scrumvival.com
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot scrum - display nudge from scrumvival.com
#
# Author:
#   tomasz@wojtun.pl

offline = ['Don’t f*cking confuse urgent with important.',
          'Write rock-f*cking-solid code.',
          'F*cking call a turd a turd.',
          'One f*cking bit at a time.',
          'If all’s ok, something’s wrong.',
          'Looking for invisible gorillas may blind you to the obvious.',
          'It will get you anyway.',
          'You may compensate for money loss. Time’s gone for good.',
          'Quantify f*cking everything.',
          'Exploration f*cking builds value.',
          'Keep your build f*cking clean.',
          'Everything is f*cking progress.',
          'Make more f*cking mistakes.',
          'Visualize f*cking everything.',
          'Do the f*cking opposite.',
          'Look until you f*cking see.',
          'Always mean what you f*cking say.',
          'Take a deep f*cking breath.']

module.exports = (robot) ->
  params = 'action=navigation&flag=random&post_url=http%3A%2F%2Fscrumvival.com%2Fnudge%2F'

  robot.respond /scrum/i, (msg) ->
    robot.http("http://scrumvival.com")
      .path('/wp-admin/admin-ajax.php')
      .header('X-Requested-With','XMLHttpRequest')
      .header('Content-Type','application/x-www-form-urlencoded; charset=UTF-8')
      .post(params) (err, res, body) ->
        if err
          text = msg.random offline
          text = 'So scrum doesn\'t work, huh?... ' + text
          msg.send text
          console.log 'error getting random nudge from scrumvival.com'
          return

        data = null
        text = null
        try
          data = JSON.parse body
          text = "#{data.post_title}"
          text = text.split(' |')[0]
        catch error
          text = msg.random offline
          console.log 'error parsing reply from scrumvival.com'
        text = 'So scrum doesn\'t work, huh?... ' + text
        msg.send text


