const { environment } = require('@rails/webpacker')

// 無効な Node.js プロパティを無効化
environment.config.delete('node.dgram')
environment.config.delete('node.fs')
environment.config.delete('node.net')
environment.config.delete('node.tls')
environment.config.delete('node.child_process')

module.exports = environment
