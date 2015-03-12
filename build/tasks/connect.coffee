module.exports = ->

  @loadNpmTasks "grunt-contrib-connect"

  @config "connect",
    server:
      options:
        port: 3002
        base: "public"
