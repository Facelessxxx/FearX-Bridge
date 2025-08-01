function FearX.AddBoxZone(name, coords, length, width, options, targetOptions)
    if FearX.Target == 'ox' then
        exports.ox_target:addBoxZone({
            coords = coords,
            size = vec3(length, width, options.minZ and (options.maxZ - options.minZ) or 2.0),
            rotation = options.heading or 0,
            debug = options.debugPoly,
            options = targetOptions
        })
    elseif FearX.Target == 'qb' then
        exports['qb-target']:AddBoxZone(name, coords, length, width, {
            name = name,
            heading = options.heading or 0,
            debugPoly = options.debugPoly,
            minZ = options.minZ,
            maxZ = options.maxZ
        }, {
            options = targetOptions,
            distance = options.distance or 2.0
        })
    elseif FearX.Target == 'bt' then
        exports['bt-target']:AddBoxZone(name, coords, length, width, {
            name = name,
            heading = options.heading or 0,
            debugPoly = options.debugPoly,
            minZ = options.minZ,
            maxZ = options.maxZ
        }, {
            options = targetOptions,
            distance = options.distance or 2.0
        })
    end
end

function FearX.AddCircleZone(name, coords, radius, options, targetOptions)
    if FearX.Target == 'ox' then
        exports.ox_target:addSphereZone({
            coords = coords,
            radius = radius,
            debug = options.debugPoly,
            options = targetOptions
        })
    elseif FearX.Target == 'qb' then
        exports['qb-target']:AddCircleZone(name, coords, radius, {
            name = name,
            debugPoly = options.debugPoly,
            useZ = options.useZ
        }, {
            options = targetOptions,
            distance = radius
        })
    elseif FearX.Target == 'bt' then
        exports['bt-target']:AddCircleZone(name, coords, radius, {
            name = name,
            debugPoly = options.debugPoly,
            useZ = options.useZ
        }, {
            options = targetOptions,
            distance = radius
        })
    end
end

function FearX.AddTargetEntity(entity, options)
    if FearX.Target == 'ox' then
        exports.ox_target:addLocalEntity(entity, options)
    elseif FearX.Target == 'qb' then
        exports['qb-target']:AddTargetEntity(entity, {
            options = options,
            distance = 2.0
        })
    elseif FearX.Target == 'bt' then
        exports['bt-target']:AddTargetEntity(entity, {
            options = options,
            distance = 2.0
        })
    end
end

function FearX.AddTargetModel(models, options)
    if FearX.Target == 'ox' then
        exports.ox_target:addModel(models, options)
    elseif FearX.Target == 'qb' then
        exports['qb-target']:AddTargetModel(models, {
            options = options,
            distance = 2.0
        })
    elseif FearX.Target == 'bt' then
        exports['bt-target']:AddTargetModel(models, {
            options = options,
            distance = 2.0
        })
    end
end

function FearX.RemoveZone(name)
    if FearX.Target == 'ox' then
        exports.ox_target:removeZone(name)
    elseif FearX.Target == 'qb' then
        exports['qb-target']:RemoveZone(name)
    elseif FearX.Target == 'bt' then
        exports['bt-target']:RemoveZone(name)
    end
end

function FearX.RemoveTargetEntity(entity, labels)
    if FearX.Target == 'ox' then
        exports.ox_target:removeLocalEntity(entity, labels)
    elseif FearX.Target == 'qb' then
        exports['qb-target']:RemoveTargetEntity(entity, labels)
    elseif FearX.Target == 'bt' then
        exports['bt-target']:RemoveTargetEntity(entity, labels)
    end
end

function FearX.RemoveTargetModel(models, labels)
    if FearX.Target == 'ox' then
        exports.ox_target:removeModel(models, labels)
    elseif FearX.Target == 'qb' then
        exports['qb-target']:RemoveTargetModel(models, labels)
    elseif FearX.Target == 'bt' then
        exports['bt-target']:RemoveTargetModel(models, labels)
    end
end