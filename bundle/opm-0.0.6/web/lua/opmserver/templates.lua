--[[
   This Lua code was generated by Lemplate, the Lua
   Template Toolkit. Any changes made to this file will be lost the next
   time the templates are compiled.

   Copyright 2016 - Yichun Zhang (agentzh) - All rights reserved.

   Copyright 2006-2014 - Ingy döt Net - All rights reserved.
]]

local gsub = ngx.re.gsub
local concat = table.concat
local type = type
local math_floor = math.floor
local table_maxn = table.maxn

local _M = {
    version = '0.07'
}

local template_map = {}

local function tt2_true(v)
    return v and v ~= 0 and v ~= "" and v ~= '0'
end

local function tt2_not(v)
    return not v or v == 0 or v == "" or v == '0'
end

local context_meta = {}

function context_meta.plugin(context, name, args)
    if name == "iterator" then
        local list = args[1]
        local count = table_maxn(list)
        return { list = list, count = 1, max = count - 1, index = 0, size = count, first = true, last = false, prev = "" }
    else
        return error("unknown iterator: " .. name)
    end
end

function context_meta.process(context, file)
    local f = template_map[file]
    if not f then
        return error("file error - " .. file .. ": not found")
    end
    return f(context)
end

function context_meta.include(context, file)
    local f = template_map[file]
    if not f then
        return error("file error - " .. file .. ": not found")
    end
    return f(context)
end

context_meta = { __index = context_meta }

-- XXX debugging function:
-- local function xxx(data)
--     io.stderr:write("\n" .. require("cjson").encode(data) .. "\n")
-- end

local function stash_get(stash, expr)
    local result

    if type(expr) ~= "table" then
        result = stash[expr]
        if type(result) == "function" then
            return result()
        end
        return result or ''
    end

    result = stash
    for i = 1, #expr, 2 do
        local key = expr[i]
        if type(key) == "number" and key == math_floor(key) and key >= 0 then
            key = key + 1
        end
        local val = result[key]
        local args = expr[i + 1]
        if args == 0 then
            args = {}
        end

        if val == nil then
            if not _M.vmethods[key] then
                if type(expr[i + 1]) == "table" then
                    return error("virtual method " .. key .. " not supported")
                end
                return ''
            end
            val = _M.vmethods[key]
            args = {result, unpack(args)}
        end

        if type(val) == "function" then
            val = val(unpack(args))
        end

        result = val
    end

    return result
end

local function stash_set(stash, k, v, default)
    if default then
        local old = stash[k]
        if old == nil then
            stash[k] = v
        end
    else
        stash[k] = v
    end
end

_M.vmethods = {
    join = function (list, delim)
        delim = delim or ' '
        local out = {}
        local size = #list
        for i = 1, size, 1 do
            out[i * 2 - 1] = list[i]
            if i ~= size then
                out[i * 2] = delim
            end
        end
        return concat(out)
    end,

    first = function (list)
        return list[1]
    end,

    keys = function (list)
        local out = {}
        i = 1
        for key in pairs(list) do
            out[i] = key
            i = i + 1
        end
        return out
    end,

    last = function (list)
        return list[#list]
    end,

    push = function(list, ...)
        local n = select("#", ...)
        local m = #list
        for i = 1, n do
            list[m + i] = select(i, ...)
        end
        return ''
    end,

    size = function (list)
        if type(list) == "table" then
            return #list
        else
            return 1
        end
    end,

    sort = function (list)
        local out = { unpack(list) }
        table.sort(out)
        return out
    end,

    split = function (str, delim)
        delim = delim or ' '
        local out = {}
	local start = 1
	local sub = string.sub
	local find = string.find
	local sstart, send = find(str, delim, start)
        local i = 1
	while sstart do
	    out[i] = sub(str, start, sstart-1)
            i = i + 1
	    start = send + 1
	    sstart, send = find(str, delim, start)
	end
	out[i] = sub(str, start)
	return out
    end,
}

_M.filters = {
    html = function (s, args)
        s = gsub(s, "&", '&amp;', "jo")
        s = gsub(s, "<", '&lt;', "jo");
        s = gsub(s, ">", '&gt;', "jo");
        s = gsub(s, '"', '&quot;', "jo"); -- " end quote for emacs
        return s
    end,

    lower = function (s, args)
        return string.lower(s)
    end,

    upper = function (s, args)
        return string.upper(s)
    end,
}

function _M.process(file, params)
    local stash = params
    local context = {
        stash = stash,
        filter = function (bits, name, params)
            local s = concat(bits)
            local f = _M.filters[name]
            if f then
                return f(s, params)
            end
            return error("filter '" .. name .. "' not found")
        end
    }
    context = setmetatable(context, context_meta)
    local f = template_map[file]
    if not f then
        return error("file error - " .. file .. ": not found")
    end
    return f(context)
end
-- 404.tt2
template_map['404.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<h2>\n404 not found!\n</h2>\n'

    return output
end

-- analytics.tt2
template_map['analytics.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<script>\nvar ga_func = function () {\n    (function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\n        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\n    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\n    })(window,document,\'script\',\'https://www.google-analytics.com/analytics.js\',\'ga\');\n\n    ga(\'create\', \'UA-24724965-2\', \'auto\');\n    ga(\'send\', \'pageview\');\n}\nsetTimeout(ga_func, 0);\n</script>\n'

    return output
end

-- docs.tt2
template_map['docs.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<div class="main_col">\n<div class="split_header">\n    <h2>Docs</h2>\n</div>\n\n'
-- line 7 "docs.tt2"
i = i + 1 output[i] = stash_get(stash, 'doc_html')
i = i + 1 output[i] = '\n</div>\n'

    return output
end

-- error.tt2
template_map['error.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<div class="main_col">\n<div class="split_header">\n    <h2>Error</h2>\n</div>\n\n<div class="error_info">\n    '
-- line 8 "error.tt2"

-- FILTER
local value
do
    local output = {}
    local i = 0

i = i + 1 output[i] = stash_get(stash, 'error_info')

    value = context.filter(output, 'html', {})
end
i = i + 1 output[i] = value

i = i + 1 output[i] = '\n</div>\n\n</div>\n'

    return output
end

-- footer.tt2
template_map['footer.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<p>'
-- line 2 "footer.tt2"
i = i + 1 output[i] = 'Copyright © 2016-2020 Yichun Zhang (agentzh)'
i = i + 1 output[i] = '</p>\n<p>'
-- line 3 "footer.tt2"
i = i + 1 output[i] = '100% Powered by OpenResty and PostgreSQL'
i = i + 1 output[i] = '\n '
-- line 4 "footer.tt2"
i = i + 1 output[i] = '('
i = i + 1 output[i] = '<a href="https://github.com/openresty/opm/">'
-- line 4 "footer.tt2"
i = i + 1 output[i] = 'view the source code of this site'
i = i + 1 output[i] = '</a>'
-- line 4 "footer.tt2"
i = i + 1 output[i] = ')'
i = i + 1 output[i] = '</p>\n<p>京ICP备16021991号</p>\n'

    return output
end

-- index.tt2
template_map['index.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<div class="intro_banner">\n    <div class="intro_banner_inner">\n        <div class="intro_text">\n        <p><b>opm</b> is the official OpenResty package manager, similar to Perl\'s CPAN and NodeJS\'s npm in rationale.</p>\n        <p>We provide both the opm client-side command-line utility and the server-side application for the central package repository.</p>\n        <p>Please read the <a href="/docs">opm documentation</a> for more details.</p>\n        <p>We already have <b>'
-- line 8 "index.tt2"
i = i + 1 output[i] = stash_get(stash, 'total_uploads')
i = i + 1 output[i] = '</b> successful uploads across <b>'
-- line 8 "index.tt2"
i = i + 1 output[i] = stash_get(stash, 'package_count')
i = i + 1 output[i] = '</b> distinct package names from <b>'
-- line 8 "index.tt2"
i = i + 1 output[i] = stash_get(stash, 'uploader_count')
i = i + 1 output[i] = '</b> contributors. Come on, OPM authors!</p>\n        </div>\n    </div>\n</div>\n\n<div class="main_col">\n<div class="split_header">\n    <h2>Recent packages</h2>\n    <span class="header_sub">\n        (<a href="/packages">view all</a>)\n    </span>\n    <span class="right">\n        <a href="/uploads">Recent uploads</a>\n    </span>\n</div>\n\n<section>\n'
-- line 25 "index.tt2"
i = i + 1 output[i] = context.process(context, 'package_list.tt2')
i = i + 1 output[i] = '\n</section>\n</div>\n'

    return output
end

-- layout.tt2
template_map['layout.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '<!DOCTYPE html>\n<html lang="en">\n<head>\n    <meta charset="utf-8">\n    <title>OPM - OpenResty Package Manager</title>\n    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes">\n    <link rel="stylesheet" type="text/css" href="/css/main.css">\n</head>\n<body>\n    <div class="content">\n        <header class="header">\n        '
-- line 12 "layout.tt2"
i = i + 1 output[i] = context.process(context, 'nav.tt2')
i = i + 1 output[i] = '\n        </header>\n\n        <main class="main_page">\n            '
-- line 16 "layout.tt2"
i = i + 1 output[i] = stash_get(stash, 'main_html')
i = i + 1 output[i] = '\n        </main>\n    </div>\n\n    <div class="footer">\n    '
-- line 21 "layout.tt2"
i = i + 1 output[i] = context.process(context, 'footer.tt2')
i = i + 1 output[i] = '\n    </div>\n\n</body>\n\n'
-- line 26 "layout.tt2"
i = i + 1 output[i] = context.process(context, 'analytics.tt2')
i = i + 1 output[i] = '\n\n</html>\n'

    return output
end

-- nav.tt2
template_map['nav.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<div class="header_inner">\n<a href="https://openresty.org">\n    <img src="https://openresty.org/images/logo.png" width="64">\n</a>\n<nav class="logo_panel">\n<a href="/">\n    OPM\n</a>\n</nav>\n\n<form method="GET" action="/search" class="header_search">\n    <input type="text" placeholder="Search Packages ..." name="q" value="'
-- line 13 "nav.tt2"
i = i + 1 output[i] = stash_get(stash, 'query_words')
i = i + 1 output[i] = '">\n</form>\n<nav class="nav_panel">\n    <a href="/docs">Docs </a>\n\n</nav>\n</div>\n'

    return output
end

-- package_info.tt2
template_map['package_info.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<div class="main_col">\n<div class="split_header">\n    <h2>'
-- line 4 "package_info.tt2"

-- FILTER
local value
do
    local output = {}
    local i = 0

i = i + 1 output[i] = stash_get(stash, 'pkg_name')

    value = context.filter(output, 'html', {})
end
i = i + 1 output[i] = value

i = i + 1 output[i] = '\n    </h2>\n    <div class="description">\n        <p>\n        '
-- line 8 "package_info.tt2"

-- FILTER
local value
do
    local output = {}
    local i = 0

i = i + 1 output[i] = stash_get(stash, {'pkg_info', 0, 'abstract', 0})

    value = context.filter(output, 'html', {})
end
i = i + 1 output[i] = value

i = i + 1 output[i] = '\n        </p>\n    </div>\n</div>\n\n<div class="metadata_columns">\n    <div class="metadata_columns_inner">\n        <div class="column">\n            <h3>Account</h3>'
-- line 16 "package_info.tt2"
i = i + 1 output[i] = stash_get(stash, 'account')
i = i + 1 output[i] = '\n        </div>\n        <div class="column">\n            <h3>Repo</h3><a href="'
-- line 19 "package_info.tt2"
i = i + 1 output[i] = stash_get(stash, {'pkg_info', 0, 'repo_link', 0})
i = i + 1 output[i] = '" target="_blank">'
-- line 19 "package_info.tt2"
i = i + 1 output[i] = stash_get(stash, {'pkg_info', 0, 'repo_link', 0})
i = i + 1 output[i] = '</a>\n        </div>\n    </div>\n</div>\n\n<div>\n'
-- line 25 "package_info.tt2"
i = i + 1 output[i] = stash_get(stash, 'pkg_doc')
i = i + 1 output[i] = '\n</div>\n\n<h3>Authors</h3>\n<div class="description">\n    <p>\n    '
-- line 31 "package_info.tt2"

-- FILTER
local value
do
    local output = {}
    local i = 0

i = i + 1 output[i] = stash_get(stash, {'pkg_info', 0, 'authors', 0})

    value = context.filter(output, 'html', {})
end
i = i + 1 output[i] = value

i = i + 1 output[i] = '\n    </p>\n<div>\n\n<h3>License</h3>\n<div class="description">\n    <p>\n    '
-- line 38 "package_info.tt2"

-- FILTER
local value
do
    local output = {}
    local i = 0

i = i + 1 output[i] = stash_get(stash, {'pkg_info', 0, 'licenses', 0})

    value = context.filter(output, 'html', {})
end
i = i + 1 output[i] = value

i = i + 1 output[i] = '\n    </p>\n<div>\n'
-- line 49 "package_info.tt2"
if tt2_true(stash_get(stash, {'pkg_info', 0, 'dep_info', 0})) then
i = i + 1 output[i] = '\n<h3>Dependencies</h3>\n<div class="description">\n    <p>\n    '
-- line 46 "package_info.tt2"
i = i + 1 output[i] = stash_get(stash, {'pkg_info', 0, 'dep_info', 0})
i = i + 1 output[i] = '\n    </p>\n</div>'
end

i = i + 1 output[i] = '\n\n<h3>Versions</h3>\n\n<section>\n'
-- line 54 "package_info.tt2"
i = i + 1 output[i] = context.process(context, 'package_list.tt2')
i = i + 1 output[i] = '\n</section>\n</div>\n'

    return output
end

-- package_list.tt2
template_map['package_list.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<ul class="package_list">\n'
-- line 47 "package_list.tt2"

-- FOREACH
do
    local list = stash_get(stash, 'packages')
    local iterator
    if list.list then
        iterator = list
        list = list.list
    end
    local oldloop = stash_get(stash, 'loop')
    local count
    if not iterator then
        count = table_maxn(list)
        iterator = { count = 1, max = count - 1, index = 0, size = count, first = true, last = false, prev = "" }
    else
        count = iterator.size
    end
    stash.loop = iterator
    for idx, value in ipairs(list) do
        if idx == count then
            iterator.last = true
        end
        iterator.index = idx - 1
        iterator.count = idx
        iterator.next = list[idx + 1]
        stash['row'] = value
i = i + 1 output[i] = '\n<li class="package_row">\n\n    '
-- line 7 "package_list.tt2"
stash_set(stash, 'uploader', stash_get(stash, {'row', 0, 'uploader_name', 0}));
-- line 7 "package_list.tt2"
stash_set(stash, 'org', stash_get(stash, {'row', 0, 'org_name', 0}));
-- line 7 "package_list.tt2"
stash_set(stash, 'account', stash_get(stash, 'uploader'));
-- line 7 "package_list.tt2"
if tt2_true(stash_get(stash, 'org')) then
-- line 7 "package_list.tt2"
stash_set(stash, 'account', stash_get(stash, 'org'));
end

i = i + 1 output[i] = '\n\n    <div class="main">'
-- line 19 "package_list.tt2"
if tt2_true(stash_get(stash, {'row', 0, 'raw_package_name', 0})) then
i = i + 1 output[i] = '\n        <a href="/package/'
-- line 16 "package_list.tt2"
i = i + 1 output[i] = stash_get(stash, 'account') .. '/' .. stash_get(stash, {'row', 0, 'raw_package_name', 0})
i = i + 1 output[i] = '/" class="title">'
else
i = i + 1 output[i] = '\n        <a href="/package/'
-- line 18 "package_list.tt2"
i = i + 1 output[i] = stash_get(stash, 'account') .. '/' .. stash_get(stash, {'row', 0, 'package_name', 0})
i = i + 1 output[i] = '/" class="title">'
end

i = i + 1 output[i] = '\n\n            '
-- line 21 "package_list.tt2"
i = i + 1 output[i] = stash_get(stash, 'account') .. '/' .. stash_get(stash, {'row', 0, 'package_name', 0})
i = i + 1 output[i] = '\n        </a>\n        <span class="version_name">\n            '
-- line 24 "package_list.tt2"

-- FILTER
local value
do
    local output = {}
    local i = 0

i = i + 1 output[i] = stash_get(stash, {'row', 0, 'version_s', 0})

    value = context.filter(output, 'html', {})
end
i = i + 1 output[i] = value

i = i + 1 output[i] = '\n        </span>'
-- line 32 "package_list.tt2"
if tt2_true(stash_get(stash, {'row', 0, 'indexed', 0})) then
i = i + 1 output[i] = '\n'
elseif tt2_true(stash_get(stash, {'row', 0, 'failed', 0})) then
i = i + 1 output[i] = '\n        <span class="failed">Failed</span>'
else
i = i + 1 output[i] = '\n        <span class="pending">Pending</span>'
end

i = i + 1 output[i] = '\n        <span class="author">\n            by \n            <a href="/uploader/'
-- line 35 "package_list.tt2"
i = i + 1 output[i] = stash_get(stash, 'uploader')
i = i + 1 output[i] = '/">\n                '
-- line 36 "package_list.tt2"
i = i + 1 output[i] = stash_get(stash, 'uploader')
i = i + 1 output[i] = '\n            </a>\n        </span>\n    </div>\n    <div class="summary">\n        '
-- line 41 "package_list.tt2"
i = i + 1 output[i] = stash_get(stash, {'row', 0, 'abstract', 0})
i = i + 1 output[i] = '\n        <span class="updated_at">\n            '
-- line 43 "package_list.tt2"

-- FILTER
local value
do
    local output = {}
    local i = 0

i = i + 1 output[i] = stash_get(stash, {'row', 0, 'upload_updated_at', 0})

    value = context.filter(output, 'html', {})
end
i = i + 1 output[i] = value

i = i + 1 output[i] = '\n        </span>\n    </div>\n</li>'
        iterator.first = false
        iterator.prev = value
    end
    stash_set(stash, 'loop', oldloop)
end

i = i + 1 output[i] = '\n</ul>\n\n'
-- line 50 "package_list.tt2"
i = i + 1 output[i] = stash_get(stash, 'page_info')
i = i + 1 output[i] = '\n'

    return output
end

-- packages.tt2
template_map['packages.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<div class="main_col">\n<div class="split_header">\n    <h2>Recent packages\n    <span class="right">\n      <a href="/uploads">Recent uploads</a>\n    </span>\n    </h2>\n</div>\n\n'
-- line 11 "packages.tt2"
i = i + 1 output[i] = context.process(context, 'package_list.tt2')
i = i + 1 output[i] = '\n</div>\n'

    return output
end

-- search.tt2
template_map['search.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<div class="main_col">\n<div class="split_header">\n    <h2>Search results</h2>\n</div>\n\n'
-- line 7 "search.tt2"
i = i + 1 output[i] = context.process(context, 'package_list.tt2')
i = i + 1 output[i] = '\n</div>\n'

    return output
end

-- uploader.tt2
template_map['uploader.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<div class="main_col">\n<div class="split_header">\n    <h2>'
-- line 4 "uploader.tt2"

-- FILTER
local value
do
    local output = {}
    local i = 0

i = i + 1 output[i] = stash_get(stash, 'uploader_name')

    value = context.filter(output, 'html', {})
end
i = i + 1 output[i] = value

i = i + 1 output[i] = '\n    </h2>\n    <span class="user_github">\n      <a href="https://github.com/'
-- line 7 "uploader.tt2"

-- FILTER
local value
do
    local output = {}
    local i = 0

i = i + 1 output[i] = stash_get(stash, 'uploader_name')

    value = context.filter(output, 'html', {})
end
i = i + 1 output[i] = value

i = i + 1 output[i] = '/" target="_blank"><img src="/images/github.png" width="30" height="30" alt="GitHub"></a>\n    </span>\n</div>\n\n<div class="metadata_columns">\n    <div class="metadata_columns_inner">\n        <div class="column">\n            <h3>Packages</h3>'
-- line 14 "uploader.tt2"
i = i + 1 output[i] = stash_get(stash, 'packages_count')
i = i + 1 output[i] = '\n        </div>'
-- line 20 "uploader.tt2"
if tt2_true(stash_get(stash, {'uploader', 0, 'public_email', 0})) then
i = i + 1 output[i] = '\n        <div class="column">\n            <h3>Email</h3>'
-- line 18 "uploader.tt2"
i = i + 1 output[i] = stash_get(stash, {'uploader', 0, 'public_email', 0})
i = i + 1 output[i] = '\n        </div>'
end

-- line 25 "uploader.tt2"
if tt2_true(stash_get(stash, {'uploader', 0, 'blog', 0})) then
i = i + 1 output[i] = '\n        <div class="column">\n            <h3>Blog</h3><a href="'
-- line 23 "uploader.tt2"
i = i + 1 output[i] = stash_get(stash, {'uploader', 0, 'blog', 0})
i = i + 1 output[i] = '" target="_blank">'
-- line 23 "uploader.tt2"
i = i + 1 output[i] = stash_get(stash, {'uploader', 0, 'blog', 0})
i = i + 1 output[i] = '</a>\n        </div>'
end

i = i + 1 output[i] = '\n    </div>\n</div>\n\n<h3>Packages</h3>\n\n<section>\n'
-- line 32 "uploader.tt2"
i = i + 1 output[i] = context.process(context, 'package_list.tt2')
i = i + 1 output[i] = '\n</section>\n</div>\n'

    return output
end

-- uploads.tt2
template_map['uploads.tt2'] = function (context)
    if not context then
        return error("Lemplate function called without context\n")
    end
    local stash = context.stash
    local output = {}
    local i = 0

i = i + 1 output[i] = '\n<div class="main_col">\n<div class="split_header">\n    <h2>Recent uploads</h2>\n    <span class="right">\n      <a href="/packages">Recent packages</a>\n    </span>\n</div>\n\n'
-- line 10 "uploads.tt2"
i = i + 1 output[i] = context.process(context, 'package_list.tt2')
i = i + 1 output[i] = '\n</div>\n'

    return output
end

return _M