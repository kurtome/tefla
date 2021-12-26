const colors = require('tailwindcss/colors')

module.exports = {
  mode: 'jit',
  content: [
    './js/**/*.js',
    '../lib/*_web/**/*.*ex'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    container: {
      center: true,
      padding: '2rem',
    },
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      black: colors.black,
      white: colors.white,
      blue: colors.blue,
      green: colors.green,
      gray: colors.neutral,
      indigo: colors.indigo,
      red: colors.rose,
      amber: colors.amber,
      yellow: colors.yellow,
    },
    extend: {
      aspectRatio: {
        cardwidth: '222.22',
        cardheight: '322.88',
      },
      brightness: {
        55: '.55',
        6: '.6',
        65: '.65',
        70: '.7',
        80: '.8',
        85: '.85',
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/aspect-ratio'),
  ],
}
