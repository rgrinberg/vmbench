local http = require('http')
local url = require('url')

responses = {}

http.createServer(function (req, res)
  req.uri = url.parse(req.url)
  local msize = 1024
  local path = req.uri.pathname
  if string.len(path) > 1 then
    msize = tonumber(string.sub(path, 2))
  end

  if not responses[msize] then
    responses[msize] = string.rep("X", msize)
  end

  res:setHeader("Content-Type", "text/plain")
  res:setHeader("Content-Length", msize)
  res:finish(responses[msize])
end):listen(25000, '0.0.0.0')

print('Server running at http://127.0.0.1:25000/')