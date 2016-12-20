// Generated by LiveScript 1.4.0
(function(){
  var VERSION, parseType, parsedTypeCheck, typeCheck;
  VERSION = '0.3.2';
  parseType = require('./parse-type');
  parsedTypeCheck = require('./check');
  typeCheck = function(type, input, options){
    return parsedTypeCheck(parseType(type), input, options);
  };
  module.exports = {
    VERSION: VERSION,
    typeCheck: typeCheck,
    parsedTypeCheck: parsedTypeCheck,
    parseType: parseType
  };
}).call(this);
