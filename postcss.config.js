module.exports = {
	ident: 'postcss',
  plugins: [
    require('postcss-mixins'),
    require('postcss-simple-vars'),
    require('postcss-custom-media'),
    require('postcss-grid-kiss')({
      fallback: false
    }),
    require('postcss-flexbugs-fixes'),
    require('postcss-import'),
    require('postcss-nested'),
    require('tailwindcss')('./tailwind.js'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009',
      },
      stage: 1
    })
  ],
}