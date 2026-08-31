--- @sync entry
local function entry()
	local h = cx.active.current.hovered
	if h and not h.cha.is_dir then
		local url = tostring(h.url)
		if url:match("%.md$") or url:match("%.markdown$") then
			ya.emit("shell", { "open " .. ya.quote(url), orphan = true })
			return
		end
	end
	ya.emit("open", {})
end

return { entry = entry }
