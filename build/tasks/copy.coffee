module.exports = ->

  @loadNpmTasks "grunt-contrib-copy"

  @config "copy",
    html:
      files: [
        {
          src: "app/index.html"
          dest: "public/index.html"
        },
        {
          expand: true
          src: "app/intl/*.json"
          dest: "public/locales/"
          flatten: true
          filter: 'isFile'
        },
        {
          expand: true
          cwd: "app/res/"
          src: "**/*"
          dest: "public/res/"
        }
      ]
    components:
      files: [
        {
          expand: true
          cwd: "brahma_modules/brahma-components/dist/"
          src: "**/*"
          dest: "node_modules/brahma-components/dist/"
        }
      ]
