includes("packages.lua")

--Config:
local packages = {
    "ObjFW",
    "libsdl",
    "libsdl_image",
}

local sanitizers = { "address", "leak", "undefined" }

local mflags = {
    release = {},
    debug = {
        "-Wno-unused-function", "-Wno-unused-parameter", "-Wno-unused-variable"
    },
    regular = {
        "-Wall", "-Wextra", "-Werror",
        "-fexceptions", "-fobjc-exceptions", "-funwind-tables", "-fconstant-string-class=OFConstantString", "-Xclang", "-fno-constant-cfstrings", "-Xclang", "-fblocks", "-fobjc-arc", "-fobjc-arc-exceptions",
        "-Wno-unused-variable", "-Wno-unused-parameter",
    }
}

local ldflags = {
    release = {},
    debug = {},
    regular = {
        "-fexceptions", "-Wl,-U,_NSFoundationVersionNumber", "-Wl,-rpath,/usr/local/lib"
    }
}

set_languages {
    "gnulatest"
}

add_rules("mode.debug", "mode.release")

add_requires(packages)

target("Tower Defence Game")
do
    set_kind("binary")
    add_packages(packages)

    add_files("source/**.c", "source/**.m")
    add_headerfiles("include/**.h")

    add_includedirs("source/", "include/")
    add_includedirs("/usr/local/include/")

    add_cflags(mflags.regular)
    add_mflags(mflags.regular)
    add_ldflags(ldflags.regular)

    add_links("objc", "m", "dl", "pthread")
    add_linkdirs("/usr/local/lib")
    add_links("objfw")

    if is_mode("debug") then
        add_cflags(mflags.debug)
        add_mflags(mflags.debug)
        add_ldflags(ldflags.debug)

        for _, v in ipairs(sanitizers) do
            add_cxflags("-fsanitize=" .. v)
            add_mflags("-fsanitize=" .. v)
            add_ldflags("-fsanitize=" .. v)
        end

        add_defines("PROJECT_DEBUG")
    elseif is_mode("release") then
        add_cflags(mflags.release)
        add_mflags(mflags.release)
        add_ldflags(ldflags.release)
    end
end
target_end()
