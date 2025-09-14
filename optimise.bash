# Minify JavaScript files
terser script.js -o script.min.js

# Format all JavaScript files
prettier --write "**/*.js"

# Optimize CSS files  
csso styles.css -o styles.min.css

# Lint JavaScript for code quality
eslint src/