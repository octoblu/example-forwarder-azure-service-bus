azure       = require 'azure'
debug       = require('debug')('forwarder-azure-service-bus')
_           = require 'lodash'
MeshbluHttp = require 'meshblu-http'
generateConfig = require '../config-generators/forwarder-device-config-generator'

class DeviceController
  constructor: ({@serviceUrl, @deviceType, @imageUrl})->
    throw new Error('serviceUrl is required') unless @serviceUrl?
    throw new Error('deviceType is required') unless @deviceType?
    throw new Error('imageUrl is required') unless @imageUrl?

  create: (req, res) =>
    {name, options} = req.body
    console.log req.body
    {meshbluAuth}   = req
    authorizedUuid  = meshbluAuth.uuid
    return res.sendError @_userError 422, 'options are required for this device' unless options?

    deviceConfig   = generateConfig {@deviceType, @imageUrl, @serviceUrl, authorizedUuid, name, options}
    meshbluHttp    = new MeshbluHttp meshbluAuth
    meshbluHttp.register deviceConfig, (error, device) =>
      return res.sendError error if error?
      res.status(201).send device

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    error

module.exports = DeviceController
