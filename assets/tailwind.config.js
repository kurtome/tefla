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
      boxShadow: {
        'glow': '0 0 3px 0 rgba(0, 0, 0 / 0.1), 0 0 2px -1px rgb(0 0 0 / 0.1)',
        'glow-md': '0 0 6px -1px rgba(0, 0, 0 / 0.1), 0 0 4px -2px rgb(0 0 0 / 0.1)',
        'glow-lg': '0 0 15px -3px rgba(0, 0, 0 / 0.1), 0 0 6px -4px rgb(0 0 0 / 0.1)',
        'glow-xl': '0 0 25px -5px rgba(0, 0, 0 / 0.1), 0 0 10px -6px rgb(0 0 0 / 0.1)',
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
