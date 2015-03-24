module.exports = ->

  @loadNpmTasks "grunt-run"

  @config "run",
    start:
      cmd: "npm"
      args: ["start"]
      options:
        wait: false
