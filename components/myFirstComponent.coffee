noflo = require "noflo"

class Forwarder extends noflo.Component
  description: "This component receives data on a single input 
  port and sends the same data out to the output port"

  constructor: ->
    # Register ports
    @inPorts =
      in: new noflo.Port 'all'
    @outPorts =
      out: new noflo.Port 'all'

    @inPorts.in.on "data", (data) =>
      # Forward data when we receive it.
      # Note: send() will connect automatically if needed
      @outPorts.out.send data

    @inPorts.in.on "disconnect", =>
      # Disconnect output port when input port disconnects
      @outPorts.out.disconnect()

exports.getComponent = -> new Forwarder()