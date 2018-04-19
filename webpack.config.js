const path = require("path")
const CopyWebpackPlugin = require("copy-webpack-plugin")

module.exports = {
  entry: path.resolve(__dirname, "src/app.js"),
  output: {
    path: path.resolve(__dirname, "build"),
    filename: "bundle.js"
  },
  plugins: [
    new CopyWebpackPlugin([
      {from: "./src/index.html", to: "index.html"}
    ])
  ],
  module: {
    rules: [
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader"]
      },
      {
        test: /\/json$/, use: 'json-loader'
      },
      {
        test: /\.js$/,
        exclude: /(node_modules|bower_components)/,
        loader: "babel-loader",
        query: {
          presets: ["es2015"],
          plugins: ["transform-runtime"]
        }
      }
    ]
  },
  mode: "development"
}
