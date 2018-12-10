FROM node:8-alpine
WORKDIR /app
RUN \
  npm install reveal.js && \
  rm -f package-lock.json && \
  cp -r node_modules/reveal.js/. ./ && \
  rm -rf node_modules && \
  npm install && \
  npm cache clean --force && \
  sed -i 's/open: true/open: false/' Gruntfile.js && \
  rm -f .travis.yml CONTRIBUTING.md README.md demo.html index.html
COPY . .
EXPOSE 8000
EXPOSE 35729
CMD npm start
