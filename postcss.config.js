module.exports = {
  ident: "postcss",
  plugins: [
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: "no-2009"
      },
      stage: 0
    }),
    require("postcss-bem-fix")({
      // style: "bem", // suit or bem, suit by default,
      separators: {
        modifier: "--",
        descendent: "__" // overwrite any default separator for chosen style
      },
      shortcuts: {
        descendent: "element"
      }
    }),
    require("postcss-inline-media")({ shorthand: "min-width" }),
    require("postcss-at-rules-variables"),
    require("postcss-mixins"),
    require("postcss-simple-vars"),
    require("postcss-custom-media"),
    require("postcss-color-alpha"),
    require("postcss-grid-kiss")({
      fallback: false
    }),
    require("postcss-flexbugs-fixes"),
    require("postcss-import"),
    require("postcss-light-text"),
    require("postcss-nested"),
    require("postcss-custom-properties"),
    require("postcss-custom-selectors"),
    require("postcss-momentum-scrolling"),
    require("postcss-responsive-type"),
    require("postcss-color-function"),
    // require("postcss-encode-background-svgs"),
    // require('postcss-magic-animations'),
    require("postcss-utilities")
  ]
};

// separators: {
//   element: '__',
//   descendent: '__' // overwrite any default separator for chosen style
// }
