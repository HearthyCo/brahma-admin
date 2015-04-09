module.exports = ->
  @loadNpmTasks "grunt-contrib-clean"

  @config "clean",
    options:
      pwd: "public/"
    public: [ "public/*" ]
    jsdist: [ "public/main.dist.js" ]
