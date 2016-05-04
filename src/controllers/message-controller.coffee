azure       = require 'azure'
debug       = require('debug')('forwarder-azure-service-bus')
_           = require 'lodash'
MeshbluHttp = require 'meshblu-http'

class MessageController

  message: (req, res) =>
    message = req.body
    meshblu = new MeshbluHttp req.meshbluAuth
    @getDeviceConfig meshblu, (error, {connectionString, queueName}={}) =>
      return res.sendError(error) if error?

      serviceBusService = azure.createServiceBusService connectionString
      serviceBusService.receiveQueueMessage queueName, body: JSON.stringify(message), (error) =>
        return res.sendError(error) if error?
        res.sendStatus 201

  getDeviceConfig: (meshblu, callback) =>
    meshblu.whoami (error, device) =>
      return callback error if error?
      callback null, device

module.exports = MessageController
