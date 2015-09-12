### istanbul ignore next ###
fs = require 'fs'
### istanbul ignore next ###
path = require 'path'

### istanbul ignore next ###
module.exports = (robot, scripts) ->
  scriptsPath = path.resolve(__dirname, 'src')
  if fs.existsSync scriptsPath
    for script in fs.readdirSync(scriptsPath).sort()
      if scripts? and '*' not in scripts
        robot.loadFile(scriptsPath, script) if script in scripts
      else
        robot.loadFile(scriptsPath, script)
