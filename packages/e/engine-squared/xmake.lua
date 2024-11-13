package("engine-squared")
    set_kind("library")
    set_description("Open-source game engine written in C++.")
    set_license("GPL-3.0")

    add_deps("entt")

    add_urls("https://github.com/EngineSquared/EngineSquared.git")

    local core_engine = "EngineSquaredCore"

    local plugins = {
        "PluginCamera",
        "PluginCollision",
        "PluginColors",
        "PluginInput",
        "PluginMath",
        "PluginObject",
        "PluginPhysics",
        "PluginScene",
        "PluginTime",
        "PluginUI",
        "PluginUtils",
        "PluginVkWrapper",
        "PluginWindow"
    }

    local components = {}

    for _, plugin in ipairs(plugins) do
        add_configs(plugin, {description = "Enable the " .. plugin .. " plugin.", default = false, type = "boolean"})
    end

    on_component("PluginCamera", function (package, config)
        local e = package:config("shared") and "" or "-s"
        if package:debug() then
            e = e .. "-d"
        end

        component:add("deps", "glm")
    end)

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end

        import("package.tools.xmake").install(package, configs)
    end)