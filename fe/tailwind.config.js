export default {
  content: ['./index.html', './src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        cust: {
          blue: '#244563',
          orange: '#d8b049',
          black: '#212121',
          gray: '#ededed',
          silver: '#f8f8f8',
        },
        gold: '#e3b131',
        flash: '#fec01f',
        ink: '#26295d',
        night: '#132432',
      },
      fontFamily: {
        ubuntu: ['Ubuntu', 'sans-serif'],
        koho: ['KoHo', 'sans-serif'],
      },
      boxShadow: {
        card: '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
      },
    },
  },
  plugins: [],
};
