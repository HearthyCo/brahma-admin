module.exports = ->

  @loadNpmTasks "grunt-contrib-csslint"

  @config "csslint",
    options:
      csslintrc: ".csslintrc"
    dist:
      src: "public/*.css"
