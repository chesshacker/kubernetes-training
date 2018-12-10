const winston = require('winston');

const LOG_LEVEL_MAP = {
  test: 'error',
  production: 'info',
  development: 'debug',
};
const level = LOG_LEVEL_MAP[process.env.NODE_ENV] || 'debug';

module.exports = winston.createLogger({
  transports: [
    new winston.transports.Console({
      handleExceptions: true,
      json: true,
      stringify: obj => JSON.stringify(obj),
      stderrLevels: [],
      level,
    }),
  ],
  exitOnError: false,
});
