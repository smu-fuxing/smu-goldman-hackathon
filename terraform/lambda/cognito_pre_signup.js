'use strict';
exports.handler = (event, context, callback) => {
  event['response'] = {
    'autoConfirmUser': true,
    'autoVerifyEmail': false,
    'autoVerifyPhone': false
  }

  callback(null, event)
}
