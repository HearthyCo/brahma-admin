module.exports = ->
  @loadNpmTasks "grunt-env"

  @config "env",
    mobile:
      HEARTHY_PLATFORM: "mobile"

    development:
      BRAHMA_API_PORT: "tcp://brahma-api.byglue.me:80"
      BRAHMA_CHAT_PORT: "tcp://brahma-chat.byglue.me:80"

    preproduction:
      BRAHMA_API_PORT: "tcp://api.demo.hearthy.co:80"
      BRAHMA_CHAT_PORT: "tcp://chat.demo.hearthy.co:80"

    production:
      BRAHMA_API_PORT: "tcp://api.demo.hearthy.co:80"
      BRAHMA_CHAT_PORT: "tcp://chat.demo.hearthy.co:80"
