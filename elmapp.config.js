const path = require("path");
const merge = require("webpack-merge");
const PurgecssPlugin = require("purgecss-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const glob = require("glob");

module.exports = {
	configureWebpack: (config, env) => {
		const devMode = env !== "production";

		const STYLESHEET_REGEX = /\.(p|s)?css$/;

		const additionsAndOverrides = {
			module: {
				rules: [
					{
						test: STYLESHEET_REGEX,
						use: [
							devMode ? require.resolve("style-loader") : MiniCssExtractPlugin.loader,
							{
								loader: require.resolve("css-loader"),
								options: { importLoaders: 2 }
							},
							{ loader: require.resolve("postcss-loader"), ident: "postcss" }
						]
					}
				]
			},
			plugins: [
				!devMode &&
					new MiniCssExtractPlugin({
						filename: devMode ? "static/css/[name].css" : "static/css/[name].[contenthash:8].css",
						chunkFilename: devMode
							? "static/css/[name].chunk.css"
							: "static/css/[name].[contenthash:8].chunk.css"
					}),
				new PurgecssPlugin({
					paths: glob.sync(`${__dirname}/src/**/*`, { nodir: true })
				})
			].filter(Boolean)
		};

		const excludeStylesToo = configuration => {
			const rules = configuration.module.rules;
			rules.forEach(r => {
				if (r.exclude && r.exclude.length) {
					r.exclude.push(STYLESHEET_REGEX);
				}
			});
		};

		const merged = merge.strategy({
			"module.rules": "prepend"
		})(config, additionsAndOverrides);

		excludeStylesToo(merged);
		return merged;
	}
};