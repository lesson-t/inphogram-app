const path = require('path');

module.exports = {
    entry: './app/javascript/packs/application.js', // 正しいパスに設定
    output: {
      filename: 'bundle.js',
      path: path.resolve(__dirname, 'public/packs')
    },
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: 'babel-loader',
          },
        },
      ],
    },
    resolve: {
      extensions: ['.js'],
    },
  };