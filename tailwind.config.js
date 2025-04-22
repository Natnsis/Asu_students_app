/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./app/**/*.{js,jsx,ts,tsx}"],
  presets: [require("nativewind/preset")],
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#4318D1',
          light: '#8a63f2',   
        },
        green: {
          hard: '#14532D',   
          light: '#86EFAC',   
        },
        red: {
          hard: '#B91C1C',    
          light: '#FCA5A5',    
        },
        yellow: {
          hard: '#FACC15',   
          light: '#FEF3C7',  
        },
        ash: '#F1F5F9',       
        back: '#FFFFFF',  
        second:"#bab7b6",
        backlight: "#F8FAFC"    
      },
    },
  },
  plugins: [],
};