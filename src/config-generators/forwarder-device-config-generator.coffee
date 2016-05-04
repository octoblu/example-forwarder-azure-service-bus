module.exports = ({authorizedUuid, deviceType, imageUrl, serviceUrl, name, options}) ->
  name: name
  type: deviceType
  imageUrl: imageUrl
  forwarder:
    version: '1.0.0'
  meshblu:
    version: '2.0.0'
    forwarders:
      message:
        received: [{
          type: 'webhook'
          url:  "#{serviceUrl}/messages"
          method: 'POST'
          generateAndForwardMeshbluCredentials: true
        }]
    whitelists:
      broadcast:
        as:       [{uuid: authorizedUuid}]
        received: [{uuid: authorizedUuid}]
        sent:     [{uuid: authorizedUuid}]
      configure:
        as:       [{uuid: authorizedUuid}]
        received: [{uuid: authorizedUuid}]
        sent:     [{uuid: authorizedUuid}]
        update:   [{uuid: authorizedUuid}]
      discover:
        view:     [{uuid: authorizedUuid}]
        as:       [{uuid: authorizedUuid}]
      message:
        as:       [{uuid: authorizedUuid}]
        received: [{uuid: authorizedUuid}]
        sent:     [{uuid: authorizedUuid}]
        from:     [{uuid: authorizedUuid}]
