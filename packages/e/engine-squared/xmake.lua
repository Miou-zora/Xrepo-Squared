package("engine-squared")
    set_kind("library")
    set_description("Open-source game engine written in C++.")
    set_license("GPL-3.0")

    add_deps("entt", "vulkan-headers", "vulkansdk", "vulkan-hpp", "glfw", "glm", "gtest")

    add_urls("https://github.com/EngineSquared/EngineSquared.git")

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end

        os.run("xmake build")

        import("package.tools.xmake").install(package, configs)
    end)