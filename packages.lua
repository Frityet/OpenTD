-- Copyright (C) 2023 Amrit Bhogal
--
-- This file is part of pogn.
--
-- pogn is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- pogn is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with pogn.  If not, see <http://www.gnu.org/licenses/>.

package("ObjFW")
    set_homepage("https://objfw.nil.im")
    set_description("Portable, lightweight framework for the Objective-C language")
    set_urls("https://github.com/ObjFW/ObjFW.git")

    add_deps {
        "libtool", "autoconf", "automake"
    }

    on_install(function (package)
        import("package.tools.autoconf").install(package)
    end)

    on_load(function (package)
        import("lib.detect.find_tool")
        local objfw_config = find_tool("objfw-config")
        if not objfw_config then raise("Objfw-config not found, installation failed!") end

        package:add("mflags", os.iorunv(objfw_config.program, { "--objcflags" }))
        package:add("ldflags", os.iorunv(objfw_config.program,  { "--libs", "--ldflags", "--rpath" }))
    end)
package_end()
