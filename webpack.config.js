const path = require('path');

module.exports = {
  context: __dirname,
  entry: [
    './app/assets/javascript/main.js',
    './app/assets/stylesheets/main.scss'
  ],
  output: {
    path: path.resolve(__dirname, 'public'),
    filename: 'js/main.min.js'
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: 'babel-loader'
      },
      {
        test: /\.scss$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'file-loader',
            options: { name: 'css/main.min.css'}
          },
          'sass-loader'
        ]
      }
    ]
  }
};
