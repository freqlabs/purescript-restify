"use strict";

// module Node.Restify.Response

exports._cache = function(res, type, options) {
    return function() {
        res.cache(type, options);
    };
};

exports._cache1 = function(res, type) {
    return function() {
        res.cache(type);
    };
};

exports._defaultCache = function(res) {
    return function() {
        res.cache();
    };
};

exports._noCache = function(res) {
    return function() {
        res.noCache();
    };
};

exports._charSet = function(res, type) {
    return function() {
        res.charSet(type);
    };
};

exports._setHeader = function(res, key, value) {
    return function() {
        res.header(key, value);
    };
};

exports._getHeader = function(res, key) {
    return function() {
        return res.header(key);
    };
};

exports._statusJsonHeaders = function(res, code, body, headers) {
    return function() {
        res.json(code, body, headers);
    };
};

exports._statusJson = function(res, code, body) {
    return function() {
        res.json(code, body);
    };
};

exports._json = function(res, body) {
    return function() {
        res.json(body);
    };
};

exports._link = function(res, key, value) {
    return function() {
        res.link(key, value);
    };
};

exports._statusSendHeaders = function(res, code, body, headers) {
    return function() {
        res.send(code, body, headers);
    };
};

exports._statusSend = function(res, code, body) {
    return function() {
        res.send(code, body);
    };
};

exports._send = function(res, body) {
    return function() {
        res.send(body);
    };
};

exports._statusSendRawHeaders = function(res, code, body, headers) {
    return function() {
        res.sendRaw(code, body, headers);
    };
};

exports._statusSendRaw = function(res, code, body) {
    return function() {
        res.sendRaw(code, body);
    };
};

exports._sendRaw = function(res, body) {
    return function() {
        res.sendRaw(body);
    };
};

exports._set = function(res, name, val) {
    return function() {
        res.set(name, val);
    };
};

exports._setHeaders = function(res, headers) {
    return function() {
        res.set(headers);
    };
};

exports._status = function(res, code) {
    return function() {
        res.status(code);
    };
};

exports._redirect = function(res, opts, next) {
    return function() {
        res.redirect(opts, next);
    };
};

exports._statusRedirect = function(res, code, url, next) {
    return function() {
        res.redirect(code, url, next);
    };
};
