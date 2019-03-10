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
    require('postcss-rpxtorem'),
    require('postcss-insert'),
    require('postcss-bem-fix')({
      style: 'bem', // suit or bem, suit by default,
      separators: {
        descendent: '__' // overwrite any default separator for chosen style
      }
    }),
    require('postcss-nested'),
    require('tailwindcss')('./tailwind.js'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009',
      },
      stage: 1
    }),
    require('postcss-custom-properties'),
    require('postcss-momentum-scrolling'),
    require('postcss-color-palette')({
      palette: 'mrmrs',
    }),
    require('postcss-responsive-type'),
    require('postcss-inline-media'),
    require('postcss-magic-animations'),
    require('postcss-utilities'),
    require('postcss-console'),
  ],
}