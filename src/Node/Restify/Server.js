"use strict";

// module Node.Restify.Server

var restify = require('restify');

exports.createServer = function(opts) {
    return function() {
        return restify.createServer(opts);
    };
};

exports.createServer_ = function() {
    return restify.createServer();
};

exports._http = function(server, method, opts, handler) {
    return function() {
        server[method](opts, function(req, res, next) {
            return handler(req)(res)(next)();
        });
    };
};

exports.listen = function(server) {
    return function(port) {
        return function() {
            server.listen(port);
        };
    };
};
