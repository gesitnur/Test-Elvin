module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        powderBlue: '#C3E1E5',
        carribeanGreen: '#3AD6B3',
        pacifixBlue: '#50B0C0',
        africanViolet: '#BA7AC8',
        fuchsiaCrayola: '#C747C9',
      },
      screens: {
        'tablet': '769px',
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography')
  ],
}
