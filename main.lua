
local url1 = "https://raw.githubusercontent.com/ahmedayman2005/Ahmed/refs/heads/main/script.lua"
local url2 = "https://raw.githubusercontent.com/ahmedayman2005/Ahmed/refs/heads/main/New%20Script.lua"


-- 📥 تحميل وتشغيل السكريبت
function RunScript(url, scriptName)
    gg.toast("⏳ جاري تحميل " .. scriptName .. "...")

    local response = gg.makeRequest(url)

    if not response then
        gg.alert("❌ فشل الاتصال بالإنترنت!\n\nتأكد من اتصالك بالإنترنت وحاول مرة أخرى.")
        return
    end

    if response.content == nil or response.content == "" then
        gg.alert(
            "❌ تعذر تحميل " .. scriptName .. "!\n\n" ..
            "🔗 تأكد من صحة الرابط أو اتصال الإنترنت."
        )
        return
    end

    local func, err = load(response.content)

    if not func then
        gg.alert(
            "⚠️ فشل في قراءة كود " .. scriptName .. "!\n\n" ..
            "📋 تفاصيل الخطأ:\n" .. tostring(err)
        )
        return
    end

    local success, executionError = pcall(func)

    if not success then
        gg.alert(
            "❌ حدث خطأ أثناء تشغيل " .. scriptName .. "!\n\n" ..
            "📋 تفاصيل الخطأ:\n" .. tostring(executionError)
        )
        return
    end

    gg.toast("✅ تم تشغيل " .. scriptName .. " بنجاح!")
end


-- 📋 القائمة الرئيسية
function MainMenu()
    local menu = gg.choice({
        "📜 تشغيل السكريبت القديم",
        "📜 تشغيل السكريبت الجديد",
        "🚪 خروج"
    }, nil, "╔════════════════════╗\n     📂 اختر السكريبت\n╚════════════════════╝")

    if menu == nil then
        return
    end

    if menu == 1 then
        RunScript(url1, "السكريبت القديم")

    elseif menu == 2 then
        RunScript(url2, "السكريبت الجديد")

    elseif menu == 3 then
        os.exit()
    end
end


-- 🔄 تشغيل القائمة باستمرار
while true do
    if gg.isVisible() then
        gg.setVisible(false)
        MainMenu()
    end

    gg.sleep(100)
end
