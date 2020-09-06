const plugin = require('tailwindcss/plugin')

/*
** TailwindCSS Configuration File
**
** Docs: https://tailwindcss.com/docs/configuration
** Default: https://github.com/tailwindcss/tailwindcss/blob/master/stubs/defaultConfig.stub.js
*/
module.exports = {
  theme: {
    fontFamily: {
      display: ['-apple-system', 'system-ui', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'Helvetica Neue', 'Arial', 'sans-serif'],
      goldman: ['Goldman', 'sans-serif'],
    },
    extend: {
      colors: {
        blue: {
          '100': '#f0f4fa',
          '200': '#D4E4FA',
          '300': '#ADCCF7',
          '400': '#75B1FF',
          '500': '#3D8DF5',
          '600': '#186ADE',
          '700': '#0D4EA6',
          '800': '#103A75',
          '900': '#11294D',
        },
        goldman: {
          'darkBlue': '#112D63',
          'accent': '#7F99BF',
          'lightGrey': '#9ea2c0',
          'grey': '#F3F4F5',
          'gold': '#CAA060'
        }
      }
    },
  },
  variants: {},
  plugins: [
    plugin(function ({addBase, config}) {
      addBase({
        'h1': {
          fontSize: config('theme.fontSize.3xl'),
          fontWeight: 700,
        },
        'h2': {
          fontSize: config('theme.fontSize.2xl'),
          fontWeight: 700,
        },
        'h3': {
          fontSize: config('theme.fontSize.xl'),
          fontWeight: 700,
        },
        'h4': {
          fontSize: config('theme.fontSize.lg'),
          fontWeight: 600,
        },
      })
    }),
  ],
  purge: {
    // Learn more on https://tailwindcss.com/docs/controlling-file-size/#removing-unused-css
    enabled: process.env.NODE_ENV === 'production',
    content: [
      'components/**/*.vue',
      'layouts/**/*.vue',
      'pages/**/*.vue',
      'plugins/**/*.js',
      'nuxt.config.js'
    ]
  }
}
