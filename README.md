# hubot-scrumvival
[![Build Status](https://img.shields.io/travis/tommywo/hubot-scrumvival/master.svg)](https://travis-ci.org/tommywo/hubot-scrumvival) [![Dependency Status](https://www.versioneye.com/user/projects/55f5557f3ed8940014000516/badge.svg?style=flat)](https://www.versioneye.com/user/projects/55f5557f3ed8940014000516) [![Codecov branch](https://img.shields.io/codecov/c/github/tommywo/hubot-scrumvival/master.svg)](http://codecov.io/github/tommywo/hubot-scrumvival?branch=master) [![npm](https://img.shields.io/npm/v/hubot-scrumvival.svg)](https://www.npmjs.com/package/hubot-scrumvival) [![npm](https://img.shields.io/npm/dt/hubot-scrumvival.svg)](https://www.npmjs.com/package/hubot-scrumvival)

display nudge from scrumvival.com

See [`src/scrumvival.coffee`](src/scrumvival.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-scrumvival --save`

Then add **hubot-scrumvival** to your `external-scripts.json`:

```json
[
  "hubot-scrumvival"
]
```

## Sample Interaction

```
user1>> hubot scrum
hubot>> So scrum doesn't work, huh?... It’s your f*cking fault.
```
