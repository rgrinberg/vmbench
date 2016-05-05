local uv = require('uv')

-- Create listener socket
local server = uv.new_tcp()
server:bind('127.0.0.1', 25000)

server:listen(128, function(err)
  -- Create socket handle for client
  local client = uv.new_tcp()

  -- Accept incoming connection
  server:accept(client)

  -- Relay data back to client
  client:read_start(function(err, data)
    if err then
      client:close()
      return
    end

    if data then
      client:write(data)
    else
      client:close()
    end
  end)
end)