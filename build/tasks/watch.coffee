module.exports = ->

  @loadNpmTasks "grunt-contrib-watch"

  @config "watch",
    options:
      spawn: false
    grunt:
      files: "Gruntfile.coffee"
      tasks: ["development"]
    coffee:
      files: "app/**/*.coffee"
      tasks: ["js"]
    components:
      files: "brahma_modules/brahma-components/dist/**/*.js"
      tasks: ["js"]
    sass:
      files: "app/style/**/*"
      tasks: ["css"]
    css:
      files: "brahma_modules/brahma-css/dist/*.scss"
      tasks: ["css"]
    html:
      files: "app/index.html"
      tasks: ["html"]

