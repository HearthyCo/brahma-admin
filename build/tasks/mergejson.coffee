module.exports = ->

  @loadNpmTasks "grunt-merge-json"

  files = {}
  for lang in [ "es-ES", "en-US" ]
    files["app/locales/#{lang}.json"] = [
      "brahma_modules/brahma-components/src/intl/#{lang}.json"
      "app/intl/#{lang}.json"
    ]

  @config "merge-json",
    options:
      space: "  "
    dist:
      files: files
