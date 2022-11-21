script_author ("Exfil_Chidori")
script_description ("Monser helper for MONSER DM")
script_version ("0.1")

require 'lib.moonloader'
local imgui = require('imgui')
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local vkeys = require 'vkeys'
local fa = require 'fAwesome5'

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
        font_config.MergeMode = true

        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
    end
end

local show_main_window = imgui.ImBool(false)
healx = imgui.ImBool(false)
maskc = imgui.ImBool(false)
vehgw = imgui.ImBool(false)
animsbiv = imgui.ImBool(false)


local tag = "{8E52F9}[MONSER-HELPER]:" -- tag перед сообщениями в чате

function theme_white() -- theme style.
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

	colors[clr.Text]                   = ImVec4(0.00, 0.00, 0.00, 1.00);
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00);
	colors[clr.WindowBg]               = ImVec4(0.86, 0.86, 0.86, 1.00);
	colors[clr.ChildWindowBg]          = ImVec4(0.71, 0.71, 0.71, 1.00);
	colors[clr.PopupBg]                = ImVec4(0.79, 0.79, 0.79, 1.00);
	colors[clr.Border]                 = ImVec4(0.00, 0.00, 0.00, 0.36);
	colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.10);
	colors[clr.FrameBg]                = ImVec4(1.00, 1.00, 1.00, 1.00);
	colors[clr.FrameBgHovered]         = ImVec4(1.00, 1.00, 1.00, 1.00);
	colors[clr.FrameBgActive]          = ImVec4(1.00, 1.00, 1.00, 1.00);
	colors[clr.TitleBg]                = ImVec4(1.00, 1.00, 1.00, 0.81);
	colors[clr.TitleBgActive]          = ImVec4(1.00, 1.00, 1.00, 1.00);
	colors[clr.TitleBgCollapsed]       = ImVec4(1.00, 1.00, 1.00, 0.51);
	colors[clr.MenuBarBg]              = ImVec4(1.00, 1.00, 1.00, 1.00);
	colors[clr.ScrollbarBg]            = ImVec4(1.00, 1.00, 1.00, 0.86);
	colors[clr.ScrollbarGrab]          = ImVec4(0.37, 0.37, 0.37, 1.00);
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.60, 0.60, 0.60, 1.00);
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.21, 0.21, 0.21, 1.00);
	colors[clr.ComboBg]                = ImVec4(0.61, 0.61, 0.61, 1.00);
	colors[clr.CheckMark]              = ImVec4(0.42, 0.42, 0.42, 1.00);
	colors[clr.SliderGrab]             = ImVec4(0.51, 0.51, 0.51, 1.00);
	colors[clr.SliderGrabActive]       = ImVec4(0.65, 0.65, 0.65, 1.00);
	colors[clr.Button]                 = ImVec4(0.52, 0.52, 0.52, 0.83);
	colors[clr.ButtonHovered]          = ImVec4(0.58, 0.58, 0.58, 0.83);
	colors[clr.ButtonActive]           = ImVec4(0.44, 0.44, 0.44, 0.83);
	colors[clr.Header]                 = ImVec4(0.65, 0.65, 0.65, 1.00);
	colors[clr.HeaderHovered]          = ImVec4(0.73, 0.73, 0.73, 1.00);
	colors[clr.HeaderActive]           = ImVec4(0.53, 0.53, 0.53, 1.00);
	colors[clr.Separator]              = ImVec4(0.46, 0.46, 0.46, 1.00);
	colors[clr.SeparatorHovered]       = ImVec4(0.45, 0.45, 0.45, 1.00);
	colors[clr.SeparatorActive]        = ImVec4(0.45, 0.45, 0.45, 1.00);
	colors[clr.ResizeGrip]             = ImVec4(0.23, 0.23, 0.23, 1.00);
	colors[clr.ResizeGripHovered]      = ImVec4(0.32, 0.32, 0.32, 1.00);
	colors[clr.ResizeGripActive]       = ImVec4(0.14, 0.14, 0.14, 1.00);
	colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
	colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
	colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 1.00, 1.00, 1.00);
	colors[clr.PlotHistogram]          = ImVec4(0.70, 0.70, 0.70, 1.00);
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 1.00, 1.00, 1.00);
	colors[clr.TextSelectedBg]         = ImVec4(0.62, 0.62, 0.62, 1.00);
	colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end
theme_white()

local sw, sh = getScreenResolution()
imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
imgui.SetNextWindowSize(imgui.ImVec2(400, 200), imgui.Cond.FirstUseEver)

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	sampAddChatMessage(tag..  '{FFFFFF} Hello, script was loaded.', -1)
    while true do
				if healx.v and isKeyDown(49) then
					sampSendChat('/healme')
				end
				if maskc.v and isKeyDown(50) then
					sampSendChat('/mask')
				end
				if vehgw.v and isKeyDown(51) then
					sampSendChat('/veh 411 1 1')
				end
				if animsbiv.v and isKeyDown(90) then
					sampSendChat('/anim 8')
				end
        wait(0)

        -- if wasKeyPressed(vkeys.VK_B) then
        --     show_main_window.v = not show_main_window.v
        -- end

				sampRegisterChatCommand("mh", cmd_mh) -- активация imgui по команде.

        imgui.Process = show_main_window.v
        wait(0)


    end
end

function cmd_mh(arg)
	show_main_window.v = not show_main_window.v
	imgui.Process = show_main_window.v
end

function imgui.TextQuestion(label, description)
    imgui.TextDisabled(label)

    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
            imgui.PushTextWrapPos(600)
                imgui.TextUnformatted(description)
            imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function imgui.OnDrawFrame()
	if show_main_window.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(500, 300), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(fa.ICON_FA_HOME.. ' Monser Helper', show_main_window)

		if imgui.Button(fa.ICON_FA_INFO_CIRCLE .. ' FAQ') then
			sampAddChatMessage("{FFFFFF}Привет! Спасибо что используете наш хелпер для игроков {8E52F9}Monser DM!", -1)
			sampAddChatMessage("{FFFFFF}Цель нашего {8E52F9}скрипта {FFFFFF}заключается в облегчении во время игры на наших серверах! ", -1)
			sampAddChatMessage("С помощью нашего {8E52F9}хелпера {ffffff}любой из игроков может быстро использовать аптечку/маску, автопринятите лидерки и многое другое!", -1)
		end

		imgui.Separator()
--
		imgui.Text(u8"Аптечка на кнопку ")
		imgui.SameLine()
		imgui.Checkbox(' ', healx)
		imgui.SameLine()
		imgui.TextQuestion("( ? )", u8"Использование аптечки на клавишу 1 ")
--
		imgui.Text(u8"Маска на кнопку ")
		imgui.SameLine()
		imgui.Checkbox('  ', maskc)
		imgui.SameLine()
		imgui.TextQuestion("( ? )", u8"Использование маски на клавишу 2" )
--
		-- imgui.Text(u8"Автолидерка ")
		-- imgui.SameLine()
		-- imgui.Checkbox('   ')
		-- imgui.SameLine()
		-- imgui.TextQuestion("( ? )", u8"Функционал в разработке...")
--
		imgui.Text(u8"Быстрый спавн Т/С на GW ")
		imgui.SameLine()
		imgui.Checkbox('   ', vehgw)
		imgui.SameLine()
		imgui.TextQuestion("( ? )", u8'Быстрый спавн транспортного средства в режиме GangWar на клавишу 3 ')
--
		imgui.Text(u8"Активация анимации на клавишу ")
		imgui.SameLine()
		imgui.Checkbox('   ', animsbiv)
		imgui.SameLine()
		imgui.TextQuestion("( ? )", u8'Активация анимации на клавишу Z ')

    imgui.End()
    end
end
