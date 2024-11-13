package("engine-squared")
    set_kind("library")
    set_description("Open-source game engine written in C++.")
    set_license("GPL-3.0")

    add_urls("https://github.com/EngineSquared/EngineSquared.git")

    local plugins = {
        "EngineSquaredCore",
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

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end

        import("package.tools.xmake").install(package, configs)

        for _, plugin in ipairs(plugins) do
            local plugin_package = package:dep(plugin)
            import("package.tools.xmake").install(plugin_package, configs)
        end
    end)