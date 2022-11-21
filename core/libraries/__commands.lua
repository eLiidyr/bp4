local library = {}
function library:new(bp)
    local bp = bp
    local pm = {}

    -- Private Variables.

    -- Public Variables.

    -- Private Methods.
    pm['toggle'] = function()
        bp.enabled = bp.enabled ~= true and true or false
        bp.helpers.popchat.pop(string.format('BUDDYPAL AUTOMATION ENABLED: \\cs(%s)%s\\cr', bp.colors.setting, tostring(bp.enabled):upper()))

        if not bp.enabled then
            bp.libs.__queue.clear()
        end

    end

    pm['on'] = function()
        bp.enabled = true
        bp.helpers.popchat.pop(string.format('BUDDYPAL AUTOMATION ENABLED: \\cs(%s)%s\\cr', bp.colors.setting, tostring(bp.enabled):upper()))

    end

    pm['off'] = function()
        bp.enabled = false
        bp.libs.__queue.clear()
        bp.helpers.popchat.pop(string.format('BUDDYPAL AUTOMATION ENABLED: \\cs(%s)%s\\cr', bp.colors.setting, tostring(bp.enabled):upper()))

    end

    pm['follow'] = function()
        bp.libs.__orders.deliver('p*', ('bp follow %s'):format(bp.player.name))
    end

    pm['request_stop'] = function()
        orders.deliver('p*', 'bp stop')
    end

    pm['stop'] = function()
        bp.libs.__actions.stop()
    end

    pm['info'] = function()
        local target = windower.ffxi.get_mob_by_target('t') or false

        if target then
            print(string.format('ID: %s | Index: %s | Claim ID: %s | POS(x=%s, y=%s, z=%s) | Zone: %s [ %s ]', target.id, target.index, target.claim_id, target.x, target.y, target.z, self.info.zone, self.res.zones[self.info.zone].en))
            --table.vprint(target)
            --table.vprint(windower.ffxi.get_player())
            --table.vprint(self.me)
        end

    end

    -- Public Methods.

    -- Private Events.
    windower.register_event('addon command', function(...)
        local commands  = T{...}
        local command   = commands[1] and table.remove(commands, 1):lower()
        
        if bp and command then
            local popchat = bp.helpers.popchat
            local orders = bp.libs.__orders

            if pm[command] then
                pm[command](commands)

            elseif S{'r','rld','reload'}:contains(command) then
                windower.send_command('lua r bp4')

            end

        end

    end)

    return self

end
return library