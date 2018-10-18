var path = require('path');

module.exports = {
  entry: path.resolve('app/javascript/packs/application.js'),
  output: {
    filename: `[name].[hash].js`,
    path: path.resolve('public/bundles')
  },
  module: {
    rules: [
      {
        test: /\.erb$/,
        enforce: 'pre',
        loader: 'rails-erb-loader'
      },
    ]
  }
}
