
/*!
 * Connect - limit
 * Copyright(c) 2011 TJ Holowaychuk
 * MIT Licensed
 */

/**
 * Module dependencies.
 */

var createError = require('http-errors');
var deprecate = require('depd')('connect');
var parseBytes = require('bytes');
var utils = require('../utils');
var brokenPause = utils.brokenPause;

/**
 * Limit:
 *
 *   Status: Deprecated. This middleware will be removed in Connect 3.0.
 *   If you still wish to use some type of limit middleware,
 *   you may be interested in:
 *
 *     - [raw-body](https://github.com/stream-utils/raw-body)
 *
 *   Limit request bodies to the given size in `bytes`.
 *
 *   A string representation of the bytesize may also be passed,
 *   for example "5mb", "200kb", "1gb", etc.
 *
 *     connect()
 *       .use(connect.limit('5.5mb'))
 *       .use(handleImageUpload)
 *
 * @param {Number|String} bytes
 * @return {Function}
 * @api public
 */

module.exports = function limit(bytes){
  if ('string' == typeof bytes) bytes = parseBytes(bytes);
  if ('number' != typeof bytes) throw new Error('limit() bytes required');

  return function limit(req, res, next){
    var received = 0
      , len = req.headers['content-length']
        ? parseInt(req.headers['content-length'], 10)
        : null;

    // self-awareness
    if (req._limit) return next();
    req._limit = true;

    // limit by content-length
    if (len && len > bytes) return next(createError(413));

    // limit
    if (brokenPause) {
      listen();
    } else {
      req.on('newListener', function handler(event) {
        if (event !== 'data') return;

        req.removeListener('newListener', handler);
        // Start listening at the end of the current loop
        // otherwise the request will be consumed too early.
        // Sideaffect is `limit` will miss the first chunk,
        // but that's not a big deal.
        // Unfortunately, the tests don't have large enough
        // request bodies to test this.
        process.nextTick(listen);
      });
    };

    next();

    function listen() {
      req.on('data', function(chunk) {
        received += Buffer.isBuffer(chunk)
          ? chunk.length :
          Buffer.byteLength(chunk);

        if (received > bytes) req.destroy();
      });
    };
  };
};

module.exports = deprecate.function(module.exports,
  'limit: Restrict request size at location of read');
