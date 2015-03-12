module.exports = ->

  @loadNpmTasks "grunt-contrib-compass"

  @config "compass",
    dist:
      options:
        config: "config.rb"
        sassDir: "app/style/"
        cssDir: "public/"
