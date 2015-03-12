module.exports = ->

  @loadNpmTasks "grunt-contrib-cssmin"

  @config "cssmin",
    options:
      keepSpecialComments: 0
    dist:
      files: [{
        expand: true
        cwd: "public/"
        src: ["*.css", "!*.min.css"]
        dest: "public/"
        ext: ".css"
      }]
