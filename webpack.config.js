var path = require("path");

module.exports = {
    entry: {
        app: ['./src/index.js']
    },
    output: {
        path: path.resolve(__dirname + '/dist'),
        filename: '[name].js'
    },
    module: {
        rules: [
            {
                test: /\.(css|scss)$/,
                use: [
                    'style-loader',
                    'css-loader',
                    'resolve-url-loader',
                ]
            },
            {
                test: /\.html$/,
                exclude: /node_modules/,
                loader: 'file-loader?name=[name].[ext]',
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader: 'elm-webpack-loader?verbose=true&warn=true',
            },
            {
                test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: 'url-loader?limit=10000&mimetype=application/font-woff&publicPath=/',
                query: {
                    useRelativePath: false
                }
            },
            {
                test: /\.(png|jpg|gif)$/,
                loader: 'file-loader',
            },
            {
                test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: 'file-loader',
            }
        ],

        noParse: /\.elm$/,
    },

    devServer: {
        inline: true,
        stats: {color: true },
        historyApiFallback: true
    },
};