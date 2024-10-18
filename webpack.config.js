const path = require('path');

module.exports = {
    entry: './app/javascript/packs/application.js', // 正しいパスに設定
    output: {
      filename: 'bundle.js',
      path: path.resolve(__dirname, 'public/packs')
    },

  };