'use strict';

module.exports = function (grunt) {

  grunt.initConfig({
    mocha_istanbul: {
      coverage: {
        src: 'test', // a folder works nicely 
        options: {
          reporter: 'spec',
          require: 'coffee-coverage/register-istanbul',
          recursive: true,
          mochaOptions: ['--compilers','coffee:coffee-script/register']
        }
      }
    },
    mochaTest: {
      test: {
        options: {
          reporter: 'spec',
          require: 'coffee-script'
        },
        src: ['test/**/*.coffee']
      }
    },
    release: {
      options: {
        tagName: 'v<%= version %>',
        commitMessage: 'Prepared to release <%= version %>.',
        npm: false
      }
    },
    watch: {
      files: ['Gruntfile.js', 'src/**/*.coffee', 'test/**/*.coffee'],
      tasks: ['test']
    }
  });

  // load all grunt tasks
  require('matchdep').filterDev(['grunt-*', '!grunt-cli']).forEach(grunt.loadNpmTasks);
  
  grunt.loadNpmTasks('grunt-mocha-istanbul');

  //grunt.registerTask('test', ['mochaTest']);
  grunt.registerTask('test:watch', ['watch']);
  grunt.registerTask('default', ['test']);        
  grunt.registerTask('test', ['mocha_istanbul:coverage']);
};
