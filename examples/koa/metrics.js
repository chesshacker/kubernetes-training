const StatsD = require('hot-shots');

const { STATSD_HOST, STATSD_PREFIX, DATADOG_ENV } = process.env;

module.exports = new StatsD({
  host: STATSD_HOST || 'localhost',
  prefix: STATSD_PREFIX || 'example.',
  globalTags: {env: DATADOG_ENV || 'unknown'},
});
