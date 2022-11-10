local buildManager = function(bp)
    local manager, meta = {}, {}
        
    -- Private Variables.
    local bp        = bp
    local hmt       = dofile(string.format("%score/metas.lua", windower.addon_path))
    local classes   = {}

    -- Public Variables.
    manager.helpers = {}

    -- Private Methods.
    local addClass = function(helper)
        local helper = helper(bp, hmt)

        if helper then
            return helper, helper.new()
        end
        
    end

    -- Public Methods.    
    function manager:add(helper, name)
        
        if bp and helper and name then
            classes[name], self.helpers[name] = addClass(helper)
        end

    end

    function manager:reload(name)

        if bp and name and classes[name] then
            self.helpers[name] = classes[name]:reload()
        end

    end

    -- Manager Metas.
    meta.__index = function(t, index)
        
        if t.helpers and t.helpers[index] then
            return t.helpers[index]

        else
            return false

        end

    end

    meta.__call = function(t, index)

        if index then
            -- Future needs.

        else
            return T(t.helpers):keyset()

        end

    end

    return setmetatable(manager, meta)

end
return buildManager