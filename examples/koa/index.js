const Koa = require('koa');
const Router = require('koa-router');
const _ = require('lodash')
const log = require('./log');
const metrics = require('./metrics');

const app = new Koa();
const router = new Router();

let willToLive = true;

router.get('/', async ctx => {
  if (willToLive) {
    metrics.increment('healthy');
    ctx.body = 'ok\n';
  } else {
    metrics.increment('error');
    ctx.status = 500;
    ctx.body = 'meh\n';
  }
});

router.get('/die', async ctx => {
  willToLive = false;
  metrics.increment('die');
  ctx.body = 'nice knowing you\n';
});

app.use(router.routes());

const server = app.listen(3000, () => {
  log.info('Listening on port 3000');
});

process.on('SIGTERM', function () {
  server.close(function () {
    log.info('Shut down gracefully');
    process.exit(0);
  });
});
