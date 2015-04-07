module.exports = ->
  @loadNpmTasks "grunt-contrib-uglify"

  @config "uglify",
    dist:
      files:
        "public/main.dist.js": [ "public/main.js" ]
