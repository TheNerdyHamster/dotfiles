local utils = require('utils')

local startup = require('startup')
local keys  = require('keys')
local ui = require('ui')

return utils.merge({startup, keys, ui})
