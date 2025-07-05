-------------------------------------------------------------------------------
--! json library
--! cryptography library
local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;
local lEncode, lDecode, lDigest = a3, aw, Z;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--! platoboost library

--! configuration
local service = 3152;  -- your service id, this is used to identify your service.
local secret = "e09e08b2-0a3e-4f6a-9f4-4fcfdcea14a4";  -- make sure to obfuscate this if you want to ensure security.
local useNonce = true;  -- use a nonce to prevent replay attacks and request tampering.

--! callbacks
local onMessage = function(message) end;

--! wait for game to load
repeat task.wait(1) until game:IsLoaded();

--! functions
local requestSending = false;
local fSetClipboard, fRequest, fStringChar, fToString, fStringSub, fOsTime, fMathRandom, fMathFloor, fGetHwid = setclipboard or toclipboard, request or http_request or syn_request, string.char, tostring, string.sub, os.time, math.random, math.floor, gethwid or function() return game:GetService("Players").LocalPlayer.UserId end
local cachedLink, cachedTime = "", 0;

--! pick host
local host = "https://api.platoboost.com";
local hostResponse = fRequest({
    Url = host .. "/public/connectivity",
    Method = "GET"
});
if hostResponse.StatusCode ~= 200 or hostResponse.StatusCode ~= 429 then
    host = "https://api.platoboost.net";
end

--!optimize 2
function cacheLink()
    if cachedTime + (10*60) < fOsTime() then
        local response = fRequest({
            Url = host .. "/public/start",
            Method = "POST",
            Body = lEncode({
                service = service,
                identifier = lDigest(fGetHwid())
            }),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        });

        if response.StatusCode == 200 then
            local decoded = lDecode(response.Body);

            if decoded.success == true then
                cachedLink = decoded.data.url;
                cachedTime = fOsTime();
                return true, cachedLink;
            else
                onMessage(decoded.message);
                return false, decoded.message;
            end
        elseif response.StatusCode == 429 then
            local msg = "you are being rate limited, please wait 20 seconds and try again.";
            onMessage(msg);
            return false, msg;
        end

        local msg = "Failed to cache link.";
        onMessage(msg);
        return false, msg;
    else
        return true, cachedLink;
    end
end

cacheLink();

--!optimize 2
local generateNonce = function()
    local str = ""
    for _ = 1, 16 do
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)
    end
    return str
end

--!optimize 1
for _ = 1, 5 do
    local oNonce = generateNonce();
    task.wait(0.2)
    if generateNonce() == oNonce then
        local msg = "platoboost nonce error.";
        onMessage(msg);
        error(msg);
    end
end

--!optimize 2
local copyLink = function()
    local success, link = cacheLink();
    
    if success then
        fSetClipboard(link);
    end
end

--!optimize 2
local redeemKey = function(key)
    local nonce = generateNonce();
    local endpoint = host .. "/public/redeem/" .. fToString(service);

    local body = {
        identifier = lDigest(fGetHwid()),
        key = key
    }

    if useNonce then
        body.nonce = nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "POST",
        Body = lEncode(body),
        Headers = {
            ["Content-Type"] = "application/json"
        }
    });

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("failed to verify integrity.");
                        return false;
                    end    
                else
                    return true;
                end
            else
                onMessage("key is invalid.");
                return false;
            end
        else
            if fStringSub(decoded.message, 1, 27) == "unique constraint violation" then
                onMessage("you already have an active key, please wait for it to expire before redeeming it.");
                return false;
            else
                onMessage(decoded.message);
                return false;
            end
        end
    elseif response.StatusCode == 429 then
        onMessage("you are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("server returned an invalid status code, please try again later.");
        return false; 
    end
end

--!optimize 2
local verifyKey = function(key)
    if requestSending == true then
        onMessage("a request is already being sent, please slow down.");
        return false;
    else
        requestSending = true;
    end

    local nonce = generateNonce();
    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key;

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    });

    requestSending = false;

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("failed to verify integrity.");
                        return false;
                    end
                else
                    return true;
                end
            else
                if fStringSub(key, 1, 4) == "KEY_" then
                    return redeemKey(key);
                else
                    onMessage("key is invalid.");
                    return false;
                end
            end
        else
            onMessage(decoded.message);
            return false;
        end
    elseif response.StatusCode == 429 then
        onMessage("you are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("server returned an invalid status code, please try again later.");
        return false;
    end
end

--!optimize 2
local getFlag = function(name)
    local nonce = generateNonce();
    local endpoint = host .. "/public/flag/" .. fToString(service) .. "?name=" .. name;

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    });

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if useNonce then
                if decoded.data.hash == lDigest(fToString(decoded.data.value) .. "-" .. nonce .. "-" .. secret) then
                    return decoded.data.value;
                else
                    onMessage("failed to verify integrity.");
                    return nil;
                end
            else
                return decoded.data.value;
            end
        else
            onMessage(decoded.message);
            return nil;
        end
    else
        return nil;
    end
end
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--! platoboost usage documentation
-- copyLink() -> string
-- verifyKey(key: string) -> boolean
-- getFlag(name: string) -> boolean, string | boolean | number

-- use copyLink() to copy a link to the clipboard, in which the user will paste it into their browser and complete the keysystem.
-- use verifyKey(key) to verify a key, this will return a boolean value, true means the key was valid, false means it is invalid.
-- use getFlag(name) to get a flag from the server, this will return nil if an error occurs, if no error occurs, the value configured in the platoboost dashboard will be returned.

-- IMPORTANT: onMessage is a callback, it will be called upon status update, use it to provide information to user.
-- EXAMPLE: 
--[[
onMessage = function(message)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Platoboost status",
        Text = message
    })
end
]]--

-- NOTE: PLACE THIS ENTIRE SCRIPT AT THE TOP OF YOUR SCRIPT, ADD THE LOGIC, THEN OBFUSCATE YOUR SCRIPT.

--! example usage
--[[
copyButton.MouseButton1Click:Connect(function()
    copyLink();
end)

verifyButton.MouseButton1Click:Connect(function()
    local key = keyBox.Text;
    local success = verifyKey(key);

    if success then
        print("key is valid.");
    else
        print("key is invalid.");
    end
end)

local flag = getFlag("example_flag");
if flag ~= nil then
    print("flag value: " .. flag);
else
    print("failed to get flag.");
end
]]--
-------------------------------------------------------------------------------
-- 使用Platoboost库创建自动保存卡密的系统
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- 创建UI界面
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlatoboostUI"
screenGui.Parent = PlayerGui

-- 主容器
local container = Instance.new("Frame")
container.Size = UDim2.new(0, 350, 0, 400)
container.Position = UDim2.new(0.5, -175, 0.5, -200)
container.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
container.BorderSizePixel = 0
container.Parent = screenGui

-- 圆角效果
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = container

-- 顶部装饰条
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 5)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
topBar.BorderSizePixel = 0
topBar.Parent = container

-- 标题
local title = Instance.new("TextLabel")
title.Text = "PLATOBOOST 验证系统"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = container

-- 副标题
local subtitle = Instance.new("TextLabel")
subtitle.Text = "安全访问高级功能"
subtitle.Size = UDim2.new(1, 0, 0, 30)
subtitle.Position = UDim2.new(0, 0, 0, 40)
subtitle.BackgroundTransparency = 1
subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 14
subtitle.Parent = container

-- 输入框容器
local inputFrame = Instance.new("Frame")
inputFrame.Size = UDim2.new(0.8, 0, 0, 50)
inputFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
inputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
inputFrame.BorderSizePixel = 0
inputFrame.Parent = container

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputFrame

-- 输入框
local keyBox = Instance.new("TextBox")
keyBox.PlaceholderText = "输入您的卡密..."
keyBox.Size = UDim2.new(0.9, 0, 0.8, 0)
keyBox.Position = UDim2.new(0.05, 0, 0.1, 0)
keyBox.BackgroundTransparency = 1
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 16
keyBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
keyBox.Parent = inputFrame

-- 输入框图标
local keyIcon = Instance.new("ImageLabel")
keyIcon.Size = UDim2.new(0, 20, 0, 20)
keyIcon.Position = UDim2.new(0.85, 0, 0.4, 0)
keyIcon.BackgroundTransparency = 1
keyIcon.Image = "rbxassetid://3926305904"
keyIcon.ImageRectOffset = Vector2.new(84, 204)
keyIcon.ImageRectSize = Vector2.new(36, 36)
keyIcon.Parent = inputFrame

-- 验证按钮
local verifyButton = Instance.new("TextButton")
verifyButton.Text = "验证卡密"
verifyButton.Size = UDim2.new(0.8, 0, 0, 45)
verifyButton.Position = UDim2.new(0.1, 0, 0.4, 0)
verifyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
verifyButton.TextColor3 = Color3.new(1, 1, 1)
verifyButton.Font = Enum.Font.GothamBold
verifyButton.TextSize = 16
verifyButton.Parent = container

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = verifyButton

-- 复制按钮
local copyButton = Instance.new("TextButton")
copyButton.Text = "获取验证链接"
copyButton.Size = UDim2.new(0.8, 0, 0, 45)
copyButton.Position = UDim2.new(0.1, 0, 0.55, 0)
copyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
copyButton.TextColor3 = Color3.new(1, 1, 1)
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 16
copyButton.Parent = container

local copyButtonCorner = Instance.new("UICorner")
copyButtonCorner.CornerRadius = UDim.new(0, 8)
copyButtonCorner.Parent = copyButton

-- 复制按钮图标
local copyIcon = Instance.new("ImageLabel")
copyIcon.Size = UDim2.new(0, 20, 0, 20)
copyIcon.Position = UDim2.new(0.15, 0, 0.5, -10)
copyIcon.BackgroundTransparency = 1
copyIcon.Image = "rbxassetid://3926305904"
copyIcon.ImageRectOffset = Vector2.new(324, 364)
copyIcon.ImageRectSize = Vector2.new(36, 36)
copyIcon.Parent = copyButton

-- 状态标签容器
local statusContainer = Instance.new("Frame")
statusContainer.Size = UDim2.new(0.8, 0, 0, 60)
statusContainer.Position = UDim2.new(0.1, 0, 0.7, 0)
statusContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
statusContainer.BorderSizePixel = 0
statusContainer.Parent = container

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusContainer

-- 状态图标
local statusIcon = Instance.new("ImageLabel")
statusIcon.Size = UDim2.new(0, 30, 0, 30)
statusIcon.Position = UDim2.new(0.1, 0, 0.5, -15)
statusIcon.BackgroundTransparency = 1
statusIcon.Image = "rbxassetid://3926305904"
statusIcon.ImageRectOffset = Vector2.new(84, 204)
statusIcon.ImageRectSize = Vector2.new(36, 36)
statusIcon.ImageColor3 = Color3.fromRGB(180, 180, 180)
statusIcon.Parent = statusContainer

-- 状态标签
local statusLabel = Instance.new("TextLabel")
statusLabel.Text = "等待验证..."
statusLabel.Size = UDim2.new(0.7, 0, 0.8, 0)
statusLabel.Position = UDim2.new(0.3, 0, 0.1, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 14
statusLabel.Parent = statusContainer

-- 底部信息
local footer = Instance.new("TextLabel")
footer.Text = "Platoboost安全系统 v1.2.0"
footer.Size = UDim2.new(1, 0, 0, 30)
footer.Position = UDim2.new(0, 0, 0.95, -30)
footer.BackgroundTransparency = 1
footer.TextColor3 = Color3.fromRGB(100, 100, 120)
footer.Font = Enum.Font.Gotham
footer.TextSize = 12
footer.Parent = container

-- 设置消息回调函数
onMessage = function(message)
    statusLabel.Text = message
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Platoboost",
        Text = message,
        Duration = 5
    })
    
    -- 更新状态图标
    if string.find(message:lower(), "成功") then
        statusIcon.ImageRectOffset = Vector2.new(84, 4)
        statusIcon.ImageColor3 = Color3.fromRGB(0, 200, 0)
    elseif string.find(message:lower(), "失败") or string.find(message:lower(), "无效") then
        statusIcon.ImageRectOffset = Vector2.new(324, 124)
        statusIcon.ImageColor3 = Color3.fromRGB(220, 0, 0)
    else
        statusIcon.ImageRectOffset = Vector2.new(84, 204)
        statusIcon.ImageColor3 = Color3.fromRGB(180, 180, 180)
    end
end

-- 自动保存卡密到本地
local function saveKeyToLocal(key)
    if writefile then
        writefile("platoboost_key.txt", key)
        return true
    end
    return false
end

-- 尝试加载本地保存的卡密
local function loadSavedKey()
    if readfile and isfile("platoboost_key.txt") then
        return readfile("platoboost_key.txt")
    end
    return nil
end

-- 按钮悬停效果
local function setupButtonHover(button, defaultColor, hoverColor)
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(
            button,
            TweenInfo.new(0.2),
            {BackgroundColor3 = hoverColor}
        ):Play()
    end)
    
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(
            button,
            TweenInfo.new(0.2),
            {BackgroundColor3 = defaultColor}
        ):Play()
    end)
end

-- 设置按钮悬停效果
setupButtonHover(verifyButton, Color3.fromRGB(0, 120, 215), Color3.fromRGB(0, 150, 255))
setupButtonHover(copyButton, Color3.fromRGB(40, 40, 50), Color3.fromRGB(60, 60, 70))

-- 检查并自动验证保存的卡密
local savedKey = loadSavedKey()
if savedKey then
    keyBox.Text = savedKey
    verifyButton.Text = "验证保存的卡密..."
    
    task.spawn(function()
        local success = verifyKey(savedKey)
        if success then
            verifyButton.Text = "验证成功!"
            container.Visible = false
            background.Visible = false
            
            local CoreGui = game:GetService("StarterGui")

CoreGui:SetCore("SendNotification", {
    Title = "黄某脚本中心",
    Text = "反挂机已开启",
    Duration = 5, 
})

local Sound = Instance.new("Sound")
        Sound.Parent = game.SoundService
        Sound.SoundId = "rbxassetid://4590662766"
        Sound.Volume = 3
        Sound.PlayOnRemove = true
        Sound:Destroy()

print("反挂机开启")
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/xiak27/637/refs/heads/main/xiao586.lua'))()
local Window = OrionLib:MakeWindow({Name ="黄某脚本中心", HidePremium = false, SaveConfig = true,IntroText = "黄某脚本中心", ConfigFolder = "黄某脚本中心"})

local Tab = Window:MakeTab({
    Name = "信息",
    Icon = "rbxassetid://7734068321",
    PremiumOnly = false
})

Tab:AddParagraph("黄某脚本中心正式版")
Tab:AddParagraph("阿尔宙斯注入器用不了")
Tab:AddParagraph("作者roblox id:CNHM88")
Tab:AddParagraph("作者QQ391108721")
Tab:AddParagraph("Q群1043327536")
Tab:AddParagraph("如果你是买来的那就说明你被圈了")
Tab:AddParagraph("倒卖者死全家并且螺旋飞天")
Tab:AddParagraph("倒卖狗快手:2899078088")
Tab:AddParagraph("倒卖狗QQ:3205768718")
local Tab = Window:MakeTab({
	Name = "设置",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddParagraph("用户名:"," "..game.Players.LocalPlayer.Name.."")
Tab:AddParagraph("注入器:"," "..identifyexecutor().."")
Tab:AddParagraph("服务器的ID"," "..game.GameId.."")

Tab:AddButton({
	Name = "开启玩家进出服务器提示",
	Callback = function()
      	loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
  	end
})

Tab:AddTextbox({
	Name = "跳跃高度设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end
})

Tab:AddTextbox({
	Name = "移动速度设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end
})

Tab:AddButton({
  Name = "穿墙",
  Callback = function()
  local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Noclip = Instance.new("ScreenGui")
local BG = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local StatusPF = Instance.new("TextLabel")
local Status = Instance.new("TextLabel")
local Plr = Players.LocalPlayer
local Clipon = false
 
Noclip.Name = "穿墙"
Noclip.Parent = game.CoreGui
 
BG.Name = "BG"
BG.Parent = Noclip
BG.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
BG.BorderColor3 = Color3.new(0.0588235, 0.0588235, 0.0588235)
BG.BorderSizePixel = 2
BG.Position = UDim2.new(0.149479166, 0, 0.82087779, 0)
BG.Size = UDim2.new(0, 210, 0, 127)
BG.Active = true
BG.Draggable = true
 
Title.Name = "Title"
Title.Parent = BG
Title.BackgroundColor3 = Color3.new(0.266667, 0.00392157, 0.627451)
Title.BorderColor3 = Color3.new(0.180392, 0, 0.431373)
Title.BorderSizePixel = 2
Title.Size = UDim2.new(0, 210, 0, 33)
Title.Font = Enum.Font.Highway
Title.Text = "穿墙"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.FontSize = Enum.FontSize.Size32
Title.TextSize = 30
Title.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
Title.TextStrokeTransparency = 0
 
Toggle.Parent = BG
Toggle.BackgroundColor3 = Color3.new(0.266667, 0.00392157, 0.627451)
Toggle.BorderColor3 = Color3.new(0.180392, 0, 0.431373)
Toggle.BorderSizePixel = 2
Toggle.Position = UDim2.new(0.152380958, 0, 0.374192119, 0)
Toggle.Size = UDim2.new(0, 146, 0, 36)
Toggle.Font = Enum.Font.Highway
Toggle.FontSize = Enum.FontSize.Size28
Toggle.Text = "打开/关闭"
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.TextSize = 25
Toggle.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
Toggle.TextStrokeTransparency = 0
 
StatusPF.Name = "StatusPF"
StatusPF.Parent = BG
StatusPF.BackgroundColor3 = Color3.new(1, 1, 1)
StatusPF.BackgroundTransparency = 1
StatusPF.Position = UDim2.new(0.314285725, 0, 0.708661377, 0)
StatusPF.Size = UDim2.new(0, 56, 0, 20)
StatusPF.Font = Enum.Font.Highway
StatusPF.FontSize = Enum.FontSize.Size24
StatusPF.Text = "状态:"
StatusPF.TextColor3 = Color3.new(1, 1, 1)
StatusPF.TextSize = 20
StatusPF.TextStrokeColor3 = Color3.new(0.333333, 0.333333, 0.333333)
StatusPF.TextStrokeTransparency = 0
StatusPF.TextWrapped = true
 
Status.Name = "状态"
Status.Parent = BG
Status.BackgroundColor3 = Color3.new(1, 1, 1)
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0.580952346, 0, 0.708661377, 0)
Status.Size = UDim2.new(0, 56, 0, 20)
Status.Font = Enum.Font.Highway
Status.FontSize = Enum.FontSize.Size14
Status.Text = "关"
Status.TextColor3 = Color3.new(0.666667, 0, 0)
Status.TextScaled = true
Status.TextSize = 14
Status.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
Status.TextWrapped = true
Status.TextXAlignment = Enum.TextXAlignment.Left
 
 
Toggle.MouseButton1Click:connect(function()
	if Status.Text == "关" then
		Clipon = true
		Status.Text = "开"
		Status.TextColor3 = Color3.new(0,185,0)
		Stepped = game:GetService("RunService").Stepped:Connect(function()
			if not Clipon == false then
				for a, b in pairs(Workspace:GetChildren()) do
                if b.Name == Plr.Name then
                for i, v in pairs(Workspace[Plr.Name]:GetChildren()) do
                if v:IsA("BasePart") then
                v.CanCollide = false
                end end end end
			else
				Stepped:Disconnect()
			end
		end)
	elseif Status.Text == "开" then
		Clipon = false
		Status.Text = "关"
		Status.TextColor3 = Color3.new(170,0,0)
	end
end)
  end
})

Tab:AddTextbox({
	Name = "自定义头部大小",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)		game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.Head.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.Head.Transparency = 1
v.Character.Head.BrickColor = BrickColor.new("Red")
v.Character.Head.Material = "Neon"
v.Character.Head.CanCollide = false
v.Character.Head.Massless = true
end)
end
end
end
end)    
	end
})

Tab:AddTextbox({
	Name = "重力设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		game.Workspace.Gravity = Value
	end
})

Tab:AddTextbox({
	Name = "超广角设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		Workspace.CurrentCamera.FieldOfView = Value
	end
})

Tab:AddTextbox({
	Name = "最大视野设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		Workspace.CurrentCamera.FieldOfView = Value
	end
})

Tab:AddTextbox({
	Name = "最小视野设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		game.Workspace.CurrentCamera.FieldOfView = v
	end
})

Tab:AddButton({
  Name = "重新加入服务器",
  Callback = function()
game:GetService("TeleportService"):TeleportToPlaceInstance(
            game.PlaceId,
            game.JobId,
            game:GetService("Players").LocalPlayer
        )
  end
})

Tab:AddButton({
  Name = "离开服务器",
  Callback = function()
     game:Shutdown()
  end
})

Tab:AddButton({
  Name = "帧率显示",
  Callback = function()
  
 local ScreenGui = Instance.new("ScreenGui") 
 local FpsLabel = Instance.new("TextLabel")
 
 
 ScreenGui.Name = "FPSGui" 
 ScreenGui.ResetOnSpawn = false 
 ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling 
 
 FpsLabel.Name = "FPSLabel" 
 FpsLabel.Size = UDim2.new(0, 100, 0, 50) 
 FpsLabel.Position = UDim2.new(0, 10, 0, 10) 
 FpsLabel.BackgroundTransparency = 1 
 FpsLabel.Font = Enum.Font.SourceSansBold 
 FpsLabel.Text = "帧率: 0" 
 FpsLabel.TextSize = 20 
 FpsLabel.TextColor3 = Color3.new(1, 1, 1) 
 FpsLabel.Parent = ScreenGui 
  
 function updateFpsLabel() 
     local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait()) 
     FpsLabel.Text = "帧率: " .. fps 
 end 
  
  game:GetService("RunService").RenderStepped:Connect(updateFpsLabel) 
  
 ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")


 animateCredits()
  end
})

Tab:AddButton({
  Name = "显示时间",
  Callback = function()
local LBLG = Instance.new("ScreenGui", getParent)
local LBL = Instance.new("TextLabel", getParent)
local player = game.Players.LocalPlayer

LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true
LBL.Name = "LBL"
LBL.Parent = LBLG
LBL.BackgroundColor3 = Color3.new(1, 1, 1)
LBL.BackgroundTransparency = 1
LBL.BorderColor3 = Color3.new(0, 0, 0)
LBL.Position = UDim2.new(0.75,0,0.010,0)
LBL.Size = UDim2.new(0, 133, 0, 30)
LBL.Font = Enum.Font.GothamSemibold
LBL.Text = "TextLabel"
LBL.TextColor3 = Color3.new(1, 1, 1)
LBL.TextScaled = true
LBL.TextSize = 14
LBL.TextWrapped = true
LBL.Visible = true

local FpsLabel = LBL
local Heartbeat = game:GetService("RunService").Heartbeat
local LastIteration, Start
local FrameUpdateTable = { }

local function HeartbeatUpdate()
	LastIteration = tick()
	for Index = #FrameUpdateTable, 1, -1 do
		FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
	end
	FrameUpdateTable[1] = LastIteration
	local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
	CurrentFPS = CurrentFPS - CurrentFPS % 1
	FpsLabel.Text = ("北京时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S")).."秒"
end
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)
  end
})


Tab:AddButton({
  Name = "重开",
  Callback = function()

game.Players.LocalPlayer.Character.Head:Remove()

  end
})

Tab:AddToggle({
	Name = "夜视",
	Default = false,
	Callback = function(Value)
		if Value then
		game:GetService("Lighting").Brightness = 2
game:GetService("Lighting").ClockTime = 14
game:GetService("Lighting").FogEnd = 100000
game:GetService("Lighting").GlobalShadows = false
game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
		end
	end
})

local Tab = Window:MakeTab({
	Name = "通用",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "查看游戏中的所有玩家（包括血量条）",
  Callback = function()
      assert(Drawing, "missing dependency: 'Drawing'") local Players = game:GetService("Players") local RunService = game:GetService("RunService") local localPlayer = Players.LocalPlayer local camera = workspace.CurrentCamera local cache = {} local BOX_OUTLINE_COLOR = Color3.new(0, 0, 0) local BOX_COLOR = Color3.new(1, 0, 0) local NAME_COLOR = Color3.new(1, 1, 1) local HEALTH_OUTLINE_COLOR = Color3.new(0, 0, 0) local HEALTH_HIGH_COLOR = Color3.new(0, 1, 0) local HEALTH_LOW_COLOR = Color3.new(1, 0, 0) local CHAR_SIZE = Vector2.new(4, 6) local function create(class, properties) local drawing = Drawing.new(class) for property, value in pairs(properties) do drawing[property] = value end return drawing end local function floor2(v) return Vector2.new(math.floor(v.X), math.floor(v.Y)) end local function createEsp(player) local esp = {} esp.boxOutline = create("Square", {Color = BOX_OUTLINE_COLOR, Thickness = 3, Filled = false}) esp.box = create("Square", {Color = BOX_COLOR, Thickness = 1, Filled = false}) esp.name = create("Text", {Color = NAME_COLOR, Font = (syn and not RectDynamic) and 2 or 1, Outline = true, Center = true, Size = 13}) esp.healthOutline = create("Line", {Thickness = 3, Color = HEALTH_OUTLINE_COLOR}) esp.health = create("Line", {Thickness = 1}) cache[player] = esp end local function removeEsp(player) local esp = cache[player] if not esp then return end for _, drawing in pairs(esp) do drawing:Remove() end cache[player] = nil end local function updateEsp() for player, esp in pairs(cache) do local character, team = player.Character, player.Team if character and (not team or team ~= localPlayer.Team) then local cframe = character:GetPivot() local screen, onScreen = camera:WorldToViewportPoint(cframe.Position) if onScreen then local frustumHeight = math.tan(math.rad(camera.FieldOfView * 0.5)) * 2 * screen.Z local size = camera.ViewportSize.Y / frustumHeight * CHAR_SIZE local position = Vector2.new(screen.X, screen.Y) esp.boxOutline.Size = floor2(size) esp.boxOutline.Position = floor2(position - size * 0.5) esp.box.Size = esp.boxOutline.Size esp.box.Position = esp.boxOutline.Position esp.name.Text = string.lower(player.Name) esp.name.Position = floor2(position - Vector2.yAxis * (size.Y * 0.5 + esp.name.TextBounds.Y + 2)) local humanoid = character:FindFirstChildOfClass("Humanoid") local health = (humanoid and humanoid.Health or 100) / 100 esp.healthOutline.From = floor2(position - size * 0.5) - Vector2.xAxis * 5 esp.healthOutline.To = floor2(position - size * Vector2.new(0.5, -0.5)) - Vector2.xAxis * 5 esp.health.From = esp.healthOutline.To esp.health.To = floor2(esp.healthOutline.To:Lerp(esp.healthOutline.From, health)) esp.health.Color = HEALTH_LOW_COLOR:Lerp(HEALTH_HIGH_COLOR, health) esp.healthOutline.From = Vector2.yAxis esp.healthOutline.To = Vector2.yAxis end for _, drawing in pairs(esp) do drawing.Visible = onScreen end else for _, drawing in pairs(esp) do drawing.Visible = false end end end end Players.PlayerAdded:Connect(createEsp) Players.PlayerRemoving:Connect(removeEsp) RunService.RenderStepped:Connect(updateEsp) for idx, player in ipairs(Players:GetPlayers()) do if idx ~= 1 then createEsp(player) end end
  end
})

Tab:AddButton({
  Name = "飞行V3",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/CNHM/asg/refs/heads/main/fly.lua"))()
  end
})

Tab:AddButton({
  Name = "爬墙走脚本",
  Callback = function()
  loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Wall-Walk-9153"))()
  end
})

Tab:AddButton({
  Name = "外国FE陆管",
  Callback = function()
  loadstring(game:HttpGet("https://pastebin.com/raw/FWwdST5Y"))()
  end
})

Tab:AddButton({
  Name = "画质提升(黄某制作)(无法关闭)",
  Callback = function()
  local light = game.Lighting
for i, v in pairs(light:GetChildren()) do
	v:Destroy()
end

local ter = workspace.Terrain
local color = Instance.new("ColorCorrectionEffect")
local bloom = Instance.new("BloomEffect")
local sun = Instance.new("SunRaysEffect")
local blur = Instance.new("BlurEffect")

color.Parent = light
bloom.Parent = light
sun.Parent = light
blur.Parent = light

-- enable or disable shit

local config = {

	Terrain = true;
	ColorCorrection = true;
	Sun = true;
	Lighting = true;
	BloomEffect = true;
	
}

-- settings {

color.Enabled = false
color.Contrast = 0.15
color.Brightness = 0.1
color.Saturation = 0.25
color.TintColor = Color3.fromRGB(255, 222, 211)

bloom.Enabled = false
bloom.Intensity = 0.1

sun.Enabled = false
sun.Intensity = 0.2
sun.Spread = 1

bloom.Enabled = false
bloom.Intensity = 0.05
bloom.Size = 32
bloom.Threshold = 1

blur.Enabled = false
blur.Size = 6

-- settings }


if config.ColorCorrection then
	color.Enabled = true
end


if config.Sun then
	sun.Enabled = true
end


if config.Terrain then
	-- settings {
	ter.WaterWaveSize = 0.1
	ter.WaterWaveSpeed = 22
	ter.WaterTransparency = 0.9
	ter.WaterReflectance = 0.05
	-- settings }
end
if config.Lighting then
	-- settings {
	light.Ambient = Color3.fromRGB(0, 0, 0)
	light.Brightness = 4
	light.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
	light.ColorShift_Top = Color3.fromRGB(0, 0, 0)
	light.ExposureCompensation = 0
	light.FogColor = Color3.fromRGB(132, 132, 132)
	light.GlobalShadows = true
	light.OutdoorAmbient = Color3.fromRGB(112, 117, 128)
	light.Outlines = false
	-- settings }
end
local a = game.Lighting
a.Ambient = Color3.fromRGB(33, 33, 33)
a.Brightness = 5.69
a.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
a.ColorShift_Top = Color3.fromRGB(255, 247, 237)
a.EnvironmentDiffuseScale = 0.105
a.EnvironmentSpecularScale = 0.522
a.GlobalShadows = true
a.OutdoorAmbient = Color3.fromRGB(51, 54, 67)
a.ShadowSoftness = 0.18
a.GeographicLatitude = -15.525
a.ExposureCompensation = 0.75
b.Enabled = true
b.Intensity = 0.99
b.Size = 9999 
b.Threshold = 0
local c = Instance.new("ColorCorrectionEffect", a)
c.Brightness = 0.015
c.Contrast = 0.25
c.Enabled = true
c.Saturation = 0.2
c.TintColor = Color3.fromRGB(217, 145, 57)
if getgenv().mode == "夏日" then
   c.TintColor = Color3.fromRGB(255, 220, 148)
elseif getgenv().mode == "秋季" then
   c.TintColor = Color3.fromRGB(217, 145, 57)
else
   warn("未选择模式")
   print("请选择一个模式")
   b:Destroy()
   c:Destroy()
end
local d = Instance.new("DepthOfFieldEffect", a)
d.Enabled = true
d.FarIntensity = 0.077
d.FocusDistance = 21.54
d.InFocusRadius = 20.77
d.NearIntensity = 0.277
local e = Instance.new("ColorCorrectionEffect", a)
e.Brightness = 0
e.Contrast = -0.07
e.Saturation = 0
e.Enabled = true
e.TintColor = Color3.fromRGB(255, 247, 239)
local e2 = Instance.new("ColorCorrectionEffect", a)
e2.Brightness = 0.2
e2.Contrast = 0.45
e2.Saturation = -0.1
e2.Enabled = true
e2.TintColor = Color3.fromRGB(255, 255, 255)
local s = Instance.new("SunRaysEffect", a)
s.Enabled = true
s.Intensity = 0.01
s.Spread = 0.146

print("最高画质已载入! 由黄某汉化")
  end
})

Tab:AddButton({
  Name = "画质提升(比上面的暗一点)(无法关闭)",
  Callback = function()
  local a = game.Lighting
a.Ambient = Color3.fromRGB(33, 33, 33)
a.Brightness = 5.69
a.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
a.ColorShift_Top = Color3.fromRGB(255, 247, 237)
a.EnvironmentDiffuseScale = 0.105
a.EnvironmentSpecularScale = 0.522
a.GlobalShadows = true
a.OutdoorAmbient = Color3.fromRGB(51, 54, 67)
a.ShadowSoftness = 0.18
a.GeographicLatitude = -15.525
a.ExposureCompensation = 0.75
b.Enabled = true
b.Intensity = 0.99
b.Size = 9999 
b.Threshold = 0
local c = Instance.new("ColorCorrectionEffect", a)
c.Brightness = 0.015
c.Contrast = 0.25
c.Enabled = true
c.Saturation = 0.2
c.TintColor = Color3.fromRGB(217, 145, 57)
if getgenv().mode == "Summer" then
   c.TintColor = Color3.fromRGB(255, 220, 148)
elseif getgenv().mode == "Autumn" then
   c.TintColor = Color3.fromRGB(217, 145, 57)
else
   warn("No mode selected!")
   print("Please select a mode")
   b:Destroy()
   c:Destroy()
end
local d = Instance.new("DepthOfFieldEffect", a)
d.Enabled = true
d.FarIntensity = 0.077
d.FocusDistance = 21.54
d.InFocusRadius = 20.77
d.NearIntensity = 0.277
local e = Instance.new("ColorCorrectionEffect", a)
e.Brightness = 0
e.Contrast = -0.07
e.Saturation = 0
e.Enabled = true
e.TintColor = Color3.fromRGB(255, 247, 239)
local e2 = Instance.new("ColorCorrectionEffect", a)
e2.Brightness = 0.2
e2.Contrast = 0.45
e2.Saturation = -0.1
e2.Enabled = true
e2.TintColor = Color3.fromRGB(255, 255, 255)
local s = Instance.new("SunRaysEffect", a)
s.Enabled = true
s.Intensity = 0.01
s.Spread = 0.146

print("RTX Graphics loaded! Created by BrickoIcko")

  end
})

Tab:AddButton({
  Name = "偷物品",
  Callback = function()
for i,v in pairs (game.Players:GetChildren()) do
wait()
for i,b in pairs (v.Backpack:GetChildren()) do
b.Parent = game.Players.LocalPlayer.Backpack
end
end
  end
})

Tab:AddButton({
  Name = "R15CB脚本",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/YE-R15CB-SCRIPT.lua"))()
  end
})

local Tab = Window:MakeTab({
	Name = "死铁轨",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

local Section = Tab:AddSection({
        Name = "----------债券区----------"
})

Tab:AddButton({
  Name = "红叶脚本",
  Callback = function()
  loadstring(game:HttpGet("https://getnative.cc/script/loader"))()
  end
})

Tab:AddButton({
  Name = "自动胜利",
  Callback = function()
  loadstring(game:HttpGet("https://rawscripts.net/raw/Dead-Rails-Alpha-Auto-Win-Script-for-Dead-Rails-Instant-win-AFK-farm-KEYLESS-39867"))()
  end
})

Tab:AddButton({
  Name = "刷债券(最好用)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Anoonymouss69/ScriptHUB/refs/heads/main/AutoBonds"))()
  end
})

Tab:AddButton({
  Name = "刷债券(中文)",
  Callback = function()
  loadstring(request({Url="https://raw.githubusercontent.com/ShenJiaoBen/Partial-Server-Ribbon/refs/heads/main/自动债券Linninew.lua"}).Body)()
  end
})

Tab:AddButton({
  Name = "刷债券(speed hub)(需解卡)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
  end
})

Tab:AddButton({
  Name = "Ringta刷债券",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/fjruie/newcopybonds.github.io/refs/heads/main/ringtadead.lua"))()
  end
})

local Section = Tab:AddSection({
        Name = "----------功能类----------"
})

Tab:AddButton({
  Name = "无拉回飞行(moondiely)",
  Callback = function()
  loadstring(game:HttpGet("https://rawscripts.net/raw/Dead-Rails-Alpha-FLY-in-Dead-Rails-One-Click-Script-KEYLESS-by-Moondiety-39179"))()
  end
})

Tab:AddButton({
  Name = "无拉回飞行第二版",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/selftilted/flighttosky/refs/heads/main/DeadRails"))()
  end
})

Tab:AddButton({
  Name = "近战武器攻速",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/HeadHarse/DeadRails/refs/heads/main/V4SWING"))()
  end
})

Tab:AddButton({
  Name = "近战武器攻速(第二类)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/HeadHarse/Dusty/refs/heads/main/NOTV4TRUST"))()
  end
})

Tab:AddButton({
  Name = "moondiely hub",
  Callback = function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/m00ndiety/Dead-rails/refs/heads/main/Full-GUI'))()
  end
})

Tab:AddButton({
  Name = "Sanshub(不知道有啥用还要卡密)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/iopjklbnmsss/SansHubScript/refs/heads/main/SansHub"))()
  end
})

Tab:AddButton({
  Name = "TX(破国人脚本刷债券还不免费)",
  Callback = function()
  loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\102\121\46\97\112\112\47\54\52\68\99\116\76\77\53\47\114\97\119"))()
  end
})

Tab:AddButton({
  Name = "拿物品(需解卡)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/thiennrb7/Script/refs/heads/main/Bringall"))()
  end
})

Tab:AddButton({
  Name = "无限制焊接",
  Callback = function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/hbjrev/airweld.github.io/refs/heads/main/RINGTA.lua'))()
  end
})

Tab:AddParagraph("卡密:ringta")

Tab:AddButton({
  Name = "铁拳(可以肘飞狼人)",
  Callback = function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
  end
})

local Section = Tab:AddSection({
        Name = "-----------任务类----------"
})

Tab:AddButton({
  Name = "僵尸马",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/wehjf/Pestilenceringta.github.io/refs/heads/main/horseringta.lua"))()
  end
})

local Section = Tab:AddSection({
        Name = "----------娱乐类----------"
})

Tab:AddButton({
  Name = "Zusume hub(需解卡)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/ZusumeHub/ZusumeHub/refs/heads/main/V3%20deadrails"))()
  end
})

local Section = Tab:AddSection({
        Name = "注意:复制的东西无法使用"
})

Tab:AddButton({
  Name = "Ringta(无需解卡超好用)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/ringtaa/NEWSPRINT.github.io/refs/heads/main/newsprint.lua"))()
  end
})

Tab:AddButton({
  Name = "快速交互(无冷却)",
  Callback = function()
  
for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
	if v:IsA("ProximityPrompt") then
		v["HoldDuration"] = 0
	end
end
 
Tab:AddButton({
  Name = "蜘蛛侠HUB",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/SpiderScriptRB/Dead-Rails-SpiderXHub-Script/refs/heads/main/SpiderXHub%202.0.txt"))()
  end
})
 
game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(v)
    v["HoldDuration"] = 0
end)
  end
})

local Tab = Window:MakeTab({
	Name = "最强战场",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "Fe美化防御",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/IdkRandomUsernameok/PublicAssets/refs/heads/main/Releases/MUI.lua"))()
  end
})

local Tab = Window:MakeTab({
	Name = "俄亥俄州",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "AL自动刷印钞机",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/pijiaobenMSJMleng/ehhdvdhd/refs/heads/main/good.lua"))()
  end
})

Tab:AddButton({
  Name = "Snow Hub(专治XA恶俗)(使用前必须退出XA群组)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/canxiaoxue666/SnowHubDemo/refs/heads/main/SnowHub"))() 
  end
})

Tab:AddButton({
  Name = "XA HUB 俄亥俄州(使用前请加入XA群组)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/Ohio"))()
  end
})

local Tab = Window:MakeTab({
	Name = "战争大亨",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "HubBloxy 菜单(卡密1318-9233)",
  Callback = function()
  loadstring(game:HttpGet("https://pastebin.com/raw/eFzmXhRE"))()
  end
})

local Section = Tab:AddSection({
        Name = "修了半天的东西干脆不修了"
})

Tab:AddButton({
  Name = "黄某制作高光显示",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/CNHM/asg/refs/heads/main/player%20lighting"))()
  end
})

local Tab = Window:MakeTab({
	Name = "GB(内脏与黑火药)",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "不知名脚本(需解卡)",
  Callback = function()
  loadstring(game:HttpGet('https://api.luarmor.net/files/v3/loaders/4f5c7bbe546251d81e9d3554b109008f.lua'))()
  end
})

local Tab = Window:MakeTab({
	Name = "压力",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "超强脚本(汉化by黄某)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/CNHM/asg/refs/heads/main/pressure"))()
  end
})
        else
            verifyButton.Text = "验证卡密"
            statusLabel.Text = "保存的卡密已失效"
        end
    end)
end

-- 按钮事件处理
copyButton.MouseButton1Click:Connect(function()
    copyLink()
    statusLabel.Text = "链接已复制到剪贴板!"
    
    -- 显示复制成功反馈
    copyButton.Text = "已复制!"
    task.wait(1)
    copyButton.Text = "获取验证链接"
end)

verifyButton.MouseButton1Click:Connect(function()
    local key = keyBox.Text
    if #key < 5 then
        statusLabel.Text = "请输入有效的卡密"
        return
    end
    
    verifyButton.Text = "验证中..."
    
    -- 按钮加载动画
    local spinner = Instance.new("ImageLabel")
    spinner.Size = UDim2.new(0, 20, 0, 20)
    spinner.Position = UDim2.new(0.8, 0, 0.5, -10)
    spinner.BackgroundTransparency = 1
    spinner.Image = "rbxassetid://3926305904"
    spinner.ImageRectOffset = Vector2.new(324, 4)
    spinner.ImageRectSize = Vector2.new(36, 36)
    spinner.Rotation = 0
    spinner.Parent = verifyButton
    
    local spinTween = game:GetService("TweenService"):Create(
        spinner,
        TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1),
        {Rotation = 360}
    )
    spinTween:Play()
    
    task.spawn(function()
        local success = verifyKey(key)
        spinTween:Cancel()
        spinner:Destroy()
        
        if success then
            saveKeyToLocal(key)  -- 保存验证成功的卡密
            statusLabel.Text = "卡密验证成功!"
            verifyButton.Text = "验证成功!"
            
            -- 添加成功动画
            local successIcon = Instance.new("ImageLabel")
            successIcon.Size = UDim2.new(0, 25, 0, 25)
            successIcon.Position = UDim2.new(0.5, -12.5, 0.5, -12.5)
            successIcon.BackgroundTransparency = 1
            successIcon.Image = "rbxassetid://3926305904"
            successIcon.ImageRectOffset = Vector2.new(84, 4)
            successIcon.ImageRectSize = Vector2.new(36, 36)
            successIcon.Parent = verifyButton
            successIcon.ZIndex = 2
            
            -- 等待2秒后关闭UI并执行脚本
            task.wait(2)
            container.Visible = false
            background.Visible = false
            
            local CoreGui = game:GetService("StarterGui")

CoreGui:SetCore("SendNotification", {
    Title = "黄某脚本中心",
    Text = "反挂机已开启",
    Duration = 5, 
})

local Sound = Instance.new("Sound")
        Sound.Parent = game.SoundService
        Sound.SoundId = "rbxassetid://4590662766"
        Sound.Volume = 3
        Sound.PlayOnRemove = true
        Sound:Destroy()

print("反挂机开启")
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/xiak27/637/refs/heads/main/xiao586.lua'))()
local Window = OrionLib:MakeWindow({Name ="黄某脚本中心", HidePremium = false, SaveConfig = true,IntroText = "黄某脚本中心", ConfigFolder = "黄某脚本中心"})

local Tab = Window:MakeTab({
    Name = "信息",
    Icon = "rbxassetid://7734068321",
    PremiumOnly = false
})

Tab:AddParagraph("黄某脚本中心正式版")
Tab:AddParagraph("阿尔宙斯注入器用不了")
Tab:AddParagraph("作者roblox id:CNHM88")
Tab:AddParagraph("作者QQ391108721")
Tab:AddParagraph("Q群1043327536")
Tab:AddParagraph("如果你是买来的那就说明你被圈了")
Tab:AddParagraph("倒卖者死全家并且螺旋飞天")
Tab:AddParagraph("倒卖狗快手:2899078088")
Tab:AddParagraph("倒卖狗QQ:3205768718")
local Tab = Window:MakeTab({
	Name = "设置",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddParagraph("用户名:"," "..game.Players.LocalPlayer.Name.."")
Tab:AddParagraph("注入器:"," "..identifyexecutor().."")
Tab:AddParagraph("服务器的ID"," "..game.GameId.."")

Tab:AddButton({
	Name = "开启玩家进出服务器提示",
	Callback = function()
      	loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
  	end
})

Tab:AddTextbox({
	Name = "跳跃高度设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end
})

Tab:AddTextbox({
	Name = "移动速度设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end
})

Tab:AddButton({
  Name = "穿墙",
  Callback = function()
  local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Noclip = Instance.new("ScreenGui")
local BG = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local StatusPF = Instance.new("TextLabel")
local Status = Instance.new("TextLabel")
local Plr = Players.LocalPlayer
local Clipon = false
 
Noclip.Name = "穿墙"
Noclip.Parent = game.CoreGui
 
BG.Name = "BG"
BG.Parent = Noclip
BG.BackgroundColor3 = Color3.new(0.0980392, 0.0980392, 0.0980392)
BG.BorderColor3 = Color3.new(0.0588235, 0.0588235, 0.0588235)
BG.BorderSizePixel = 2
BG.Position = UDim2.new(0.149479166, 0, 0.82087779, 0)
BG.Size = UDim2.new(0, 210, 0, 127)
BG.Active = true
BG.Draggable = true
 
Title.Name = "Title"
Title.Parent = BG
Title.BackgroundColor3 = Color3.new(0.266667, 0.00392157, 0.627451)
Title.BorderColor3 = Color3.new(0.180392, 0, 0.431373)
Title.BorderSizePixel = 2
Title.Size = UDim2.new(0, 210, 0, 33)
Title.Font = Enum.Font.Highway
Title.Text = "穿墙"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.FontSize = Enum.FontSize.Size32
Title.TextSize = 30
Title.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
Title.TextStrokeTransparency = 0
 
Toggle.Parent = BG
Toggle.BackgroundColor3 = Color3.new(0.266667, 0.00392157, 0.627451)
Toggle.BorderColor3 = Color3.new(0.180392, 0, 0.431373)
Toggle.BorderSizePixel = 2
Toggle.Position = UDim2.new(0.152380958, 0, 0.374192119, 0)
Toggle.Size = UDim2.new(0, 146, 0, 36)
Toggle.Font = Enum.Font.Highway
Toggle.FontSize = Enum.FontSize.Size28
Toggle.Text = "打开/关闭"
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.TextSize = 25
Toggle.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
Toggle.TextStrokeTransparency = 0
 
StatusPF.Name = "StatusPF"
StatusPF.Parent = BG
StatusPF.BackgroundColor3 = Color3.new(1, 1, 1)
StatusPF.BackgroundTransparency = 1
StatusPF.Position = UDim2.new(0.314285725, 0, 0.708661377, 0)
StatusPF.Size = UDim2.new(0, 56, 0, 20)
StatusPF.Font = Enum.Font.Highway
StatusPF.FontSize = Enum.FontSize.Size24
StatusPF.Text = "状态:"
StatusPF.TextColor3 = Color3.new(1, 1, 1)
StatusPF.TextSize = 20
StatusPF.TextStrokeColor3 = Color3.new(0.333333, 0.333333, 0.333333)
StatusPF.TextStrokeTransparency = 0
StatusPF.TextWrapped = true
 
Status.Name = "状态"
Status.Parent = BG
Status.BackgroundColor3 = Color3.new(1, 1, 1)
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0.580952346, 0, 0.708661377, 0)
Status.Size = UDim2.new(0, 56, 0, 20)
Status.Font = Enum.Font.Highway
Status.FontSize = Enum.FontSize.Size14
Status.Text = "关"
Status.TextColor3 = Color3.new(0.666667, 0, 0)
Status.TextScaled = true
Status.TextSize = 14
Status.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
Status.TextWrapped = true
Status.TextXAlignment = Enum.TextXAlignment.Left
 
 
Toggle.MouseButton1Click:connect(function()
	if Status.Text == "关" then
		Clipon = true
		Status.Text = "开"
		Status.TextColor3 = Color3.new(0,185,0)
		Stepped = game:GetService("RunService").Stepped:Connect(function()
			if not Clipon == false then
				for a, b in pairs(Workspace:GetChildren()) do
                if b.Name == Plr.Name then
                for i, v in pairs(Workspace[Plr.Name]:GetChildren()) do
                if v:IsA("BasePart") then
                v.CanCollide = false
                end end end end
			else
				Stepped:Disconnect()
			end
		end)
	elseif Status.Text == "开" then
		Clipon = false
		Status.Text = "关"
		Status.TextColor3 = Color3.new(170,0,0)
	end
end)
  end
})

Tab:AddTextbox({
	Name = "自定义头部大小",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)		game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.Head.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.Head.Transparency = 1
v.Character.Head.BrickColor = BrickColor.new("Red")
v.Character.Head.Material = "Neon"
v.Character.Head.CanCollide = false
v.Character.Head.Massless = true
end)
end
end
end
end)    
	end
})

Tab:AddTextbox({
	Name = "重力设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		game.Workspace.Gravity = Value
	end
})

Tab:AddTextbox({
	Name = "超广角设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		Workspace.CurrentCamera.FieldOfView = Value
	end
})

Tab:AddTextbox({
	Name = "最大视野设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		Workspace.CurrentCamera.FieldOfView = Value
	end
})

Tab:AddTextbox({
	Name = "最小视野设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		game.Workspace.CurrentCamera.FieldOfView = v
	end
})

Tab:AddButton({
  Name = "重新加入服务器",
  Callback = function()
game:GetService("TeleportService"):TeleportToPlaceInstance(
            game.PlaceId,
            game.JobId,
            game:GetService("Players").LocalPlayer
        )
  end
})

Tab:AddButton({
  Name = "离开服务器",
  Callback = function()
     game:Shutdown()
  end
})

Tab:AddButton({
  Name = "帧率显示",
  Callback = function()
  
 local ScreenGui = Instance.new("ScreenGui") 
 local FpsLabel = Instance.new("TextLabel")
 
 
 ScreenGui.Name = "FPSGui" 
 ScreenGui.ResetOnSpawn = false 
 ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling 
 
 FpsLabel.Name = "FPSLabel" 
 FpsLabel.Size = UDim2.new(0, 100, 0, 50) 
 FpsLabel.Position = UDim2.new(0, 10, 0, 10) 
 FpsLabel.BackgroundTransparency = 1 
 FpsLabel.Font = Enum.Font.SourceSansBold 
 FpsLabel.Text = "帧率: 0" 
 FpsLabel.TextSize = 20 
 FpsLabel.TextColor3 = Color3.new(1, 1, 1) 
 FpsLabel.Parent = ScreenGui 
  
 function updateFpsLabel() 
     local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait()) 
     FpsLabel.Text = "帧率: " .. fps 
 end 
  
  game:GetService("RunService").RenderStepped:Connect(updateFpsLabel) 
  
 ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")


 animateCredits()
  end
})

Tab:AddButton({
  Name = "显示时间",
  Callback = function()
local LBLG = Instance.new("ScreenGui", getParent)
local LBL = Instance.new("TextLabel", getParent)
local player = game.Players.LocalPlayer

LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true
LBL.Name = "LBL"
LBL.Parent = LBLG
LBL.BackgroundColor3 = Color3.new(1, 1, 1)
LBL.BackgroundTransparency = 1
LBL.BorderColor3 = Color3.new(0, 0, 0)
LBL.Position = UDim2.new(0.75,0,0.010,0)
LBL.Size = UDim2.new(0, 133, 0, 30)
LBL.Font = Enum.Font.GothamSemibold
LBL.Text = "TextLabel"
LBL.TextColor3 = Color3.new(1, 1, 1)
LBL.TextScaled = true
LBL.TextSize = 14
LBL.TextWrapped = true
LBL.Visible = true

local FpsLabel = LBL
local Heartbeat = game:GetService("RunService").Heartbeat
local LastIteration, Start
local FrameUpdateTable = { }

local function HeartbeatUpdate()
	LastIteration = tick()
	for Index = #FrameUpdateTable, 1, -1 do
		FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
	end
	FrameUpdateTable[1] = LastIteration
	local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
	CurrentFPS = CurrentFPS - CurrentFPS % 1
	FpsLabel.Text = ("北京时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S")).."秒"
end
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)
  end
})


Tab:AddButton({
  Name = "重开",
  Callback = function()

game.Players.LocalPlayer.Character.Head:Remove()

  end
})

Tab:AddToggle({
	Name = "夜视",
	Default = false,
	Callback = function(Value)
		if Value then
		game:GetService("Lighting").Brightness = 2
game:GetService("Lighting").ClockTime = 14
game:GetService("Lighting").FogEnd = 100000
game:GetService("Lighting").GlobalShadows = false
game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
		end
	end
})

local Tab = Window:MakeTab({
	Name = "通用",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "查看游戏中的所有玩家（包括血量条）",
  Callback = function()
      assert(Drawing, "missing dependency: 'Drawing'") local Players = game:GetService("Players") local RunService = game:GetService("RunService") local localPlayer = Players.LocalPlayer local camera = workspace.CurrentCamera local cache = {} local BOX_OUTLINE_COLOR = Color3.new(0, 0, 0) local BOX_COLOR = Color3.new(1, 0, 0) local NAME_COLOR = Color3.new(1, 1, 1) local HEALTH_OUTLINE_COLOR = Color3.new(0, 0, 0) local HEALTH_HIGH_COLOR = Color3.new(0, 1, 0) local HEALTH_LOW_COLOR = Color3.new(1, 0, 0) local CHAR_SIZE = Vector2.new(4, 6) local function create(class, properties) local drawing = Drawing.new(class) for property, value in pairs(properties) do drawing[property] = value end return drawing end local function floor2(v) return Vector2.new(math.floor(v.X), math.floor(v.Y)) end local function createEsp(player) local esp = {} esp.boxOutline = create("Square", {Color = BOX_OUTLINE_COLOR, Thickness = 3, Filled = false}) esp.box = create("Square", {Color = BOX_COLOR, Thickness = 1, Filled = false}) esp.name = create("Text", {Color = NAME_COLOR, Font = (syn and not RectDynamic) and 2 or 1, Outline = true, Center = true, Size = 13}) esp.healthOutline = create("Line", {Thickness = 3, Color = HEALTH_OUTLINE_COLOR}) esp.health = create("Line", {Thickness = 1}) cache[player] = esp end local function removeEsp(player) local esp = cache[player] if not esp then return end for _, drawing in pairs(esp) do drawing:Remove() end cache[player] = nil end local function updateEsp() for player, esp in pairs(cache) do local character, team = player.Character, player.Team if character and (not team or team ~= localPlayer.Team) then local cframe = character:GetPivot() local screen, onScreen = camera:WorldToViewportPoint(cframe.Position) if onScreen then local frustumHeight = math.tan(math.rad(camera.FieldOfView * 0.5)) * 2 * screen.Z local size = camera.ViewportSize.Y / frustumHeight * CHAR_SIZE local position = Vector2.new(screen.X, screen.Y) esp.boxOutline.Size = floor2(size) esp.boxOutline.Position = floor2(position - size * 0.5) esp.box.Size = esp.boxOutline.Size esp.box.Position = esp.boxOutline.Position esp.name.Text = string.lower(player.Name) esp.name.Position = floor2(position - Vector2.yAxis * (size.Y * 0.5 + esp.name.TextBounds.Y + 2)) local humanoid = character:FindFirstChildOfClass("Humanoid") local health = (humanoid and humanoid.Health or 100) / 100 esp.healthOutline.From = floor2(position - size * 0.5) - Vector2.xAxis * 5 esp.healthOutline.To = floor2(position - size * Vector2.new(0.5, -0.5)) - Vector2.xAxis * 5 esp.health.From = esp.healthOutline.To esp.health.To = floor2(esp.healthOutline.To:Lerp(esp.healthOutline.From, health)) esp.health.Color = HEALTH_LOW_COLOR:Lerp(HEALTH_HIGH_COLOR, health) esp.healthOutline.From = Vector2.yAxis esp.healthOutline.To = Vector2.yAxis end for _, drawing in pairs(esp) do drawing.Visible = onScreen end else for _, drawing in pairs(esp) do drawing.Visible = false end end end end Players.PlayerAdded:Connect(createEsp) Players.PlayerRemoving:Connect(removeEsp) RunService.RenderStepped:Connect(updateEsp) for idx, player in ipairs(Players:GetPlayers()) do if idx ~= 1 then createEsp(player) end end
  end
})

Tab:AddButton({
  Name = "飞行V3",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/CNHM/asg/refs/heads/main/fly.lua"))()
  end
})

Tab:AddButton({
  Name = "爬墙走脚本",
  Callback = function()
  loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Wall-Walk-9153"))()
  end
})

Tab:AddButton({
  Name = "外国FE陆管",
  Callback = function()
  loadstring(game:HttpGet("https://pastebin.com/raw/FWwdST5Y"))()
  end
})

Tab:AddButton({
  Name = "画质提升(黄某制作)(无法关闭)",
  Callback = function()
  local light = game.Lighting
for i, v in pairs(light:GetChildren()) do
	v:Destroy()
end

local ter = workspace.Terrain
local color = Instance.new("ColorCorrectionEffect")
local bloom = Instance.new("BloomEffect")
local sun = Instance.new("SunRaysEffect")
local blur = Instance.new("BlurEffect")

color.Parent = light
bloom.Parent = light
sun.Parent = light
blur.Parent = light

-- enable or disable shit

local config = {

	Terrain = true;
	ColorCorrection = true;
	Sun = true;
	Lighting = true;
	BloomEffect = true;
	
}

-- settings {

color.Enabled = false
color.Contrast = 0.15
color.Brightness = 0.1
color.Saturation = 0.25
color.TintColor = Color3.fromRGB(255, 222, 211)

bloom.Enabled = false
bloom.Intensity = 0.1

sun.Enabled = false
sun.Intensity = 0.2
sun.Spread = 1

bloom.Enabled = false
bloom.Intensity = 0.05
bloom.Size = 32
bloom.Threshold = 1

blur.Enabled = false
blur.Size = 6

-- settings }


if config.ColorCorrection then
	color.Enabled = true
end


if config.Sun then
	sun.Enabled = true
end


if config.Terrain then
	-- settings {
	ter.WaterWaveSize = 0.1
	ter.WaterWaveSpeed = 22
	ter.WaterTransparency = 0.9
	ter.WaterReflectance = 0.05
	-- settings }
end
if config.Lighting then
	-- settings {
	light.Ambient = Color3.fromRGB(0, 0, 0)
	light.Brightness = 4
	light.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
	light.ColorShift_Top = Color3.fromRGB(0, 0, 0)
	light.ExposureCompensation = 0
	light.FogColor = Color3.fromRGB(132, 132, 132)
	light.GlobalShadows = true
	light.OutdoorAmbient = Color3.fromRGB(112, 117, 128)
	light.Outlines = false
	-- settings }
end
local a = game.Lighting
a.Ambient = Color3.fromRGB(33, 33, 33)
a.Brightness = 5.69
a.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
a.ColorShift_Top = Color3.fromRGB(255, 247, 237)
a.EnvironmentDiffuseScale = 0.105
a.EnvironmentSpecularScale = 0.522
a.GlobalShadows = true
a.OutdoorAmbient = Color3.fromRGB(51, 54, 67)
a.ShadowSoftness = 0.18
a.GeographicLatitude = -15.525
a.ExposureCompensation = 0.75
b.Enabled = true
b.Intensity = 0.99
b.Size = 9999 
b.Threshold = 0
local c = Instance.new("ColorCorrectionEffect", a)
c.Brightness = 0.015
c.Contrast = 0.25
c.Enabled = true
c.Saturation = 0.2
c.TintColor = Color3.fromRGB(217, 145, 57)
if getgenv().mode == "夏日" then
   c.TintColor = Color3.fromRGB(255, 220, 148)
elseif getgenv().mode == "秋季" then
   c.TintColor = Color3.fromRGB(217, 145, 57)
else
   warn("未选择模式")
   print("请选择一个模式")
   b:Destroy()
   c:Destroy()
end
local d = Instance.new("DepthOfFieldEffect", a)
d.Enabled = true
d.FarIntensity = 0.077
d.FocusDistance = 21.54
d.InFocusRadius = 20.77
d.NearIntensity = 0.277
local e = Instance.new("ColorCorrectionEffect", a)
e.Brightness = 0
e.Contrast = -0.07
e.Saturation = 0
e.Enabled = true
e.TintColor = Color3.fromRGB(255, 247, 239)
local e2 = Instance.new("ColorCorrectionEffect", a)
e2.Brightness = 0.2
e2.Contrast = 0.45
e2.Saturation = -0.1
e2.Enabled = true
e2.TintColor = Color3.fromRGB(255, 255, 255)
local s = Instance.new("SunRaysEffect", a)
s.Enabled = true
s.Intensity = 0.01
s.Spread = 0.146

print("最高画质已载入! 由黄某汉化")
  end
})

Tab:AddButton({
  Name = "画质提升(比上面的暗一点)(无法关闭)",
  Callback = function()
  local a = game.Lighting
a.Ambient = Color3.fromRGB(33, 33, 33)
a.Brightness = 5.69
a.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
a.ColorShift_Top = Color3.fromRGB(255, 247, 237)
a.EnvironmentDiffuseScale = 0.105
a.EnvironmentSpecularScale = 0.522
a.GlobalShadows = true
a.OutdoorAmbient = Color3.fromRGB(51, 54, 67)
a.ShadowSoftness = 0.18
a.GeographicLatitude = -15.525
a.ExposureCompensation = 0.75
b.Enabled = true
b.Intensity = 0.99
b.Size = 9999 
b.Threshold = 0
local c = Instance.new("ColorCorrectionEffect", a)
c.Brightness = 0.015
c.Contrast = 0.25
c.Enabled = true
c.Saturation = 0.2
c.TintColor = Color3.fromRGB(217, 145, 57)
if getgenv().mode == "Summer" then
   c.TintColor = Color3.fromRGB(255, 220, 148)
elseif getgenv().mode == "Autumn" then
   c.TintColor = Color3.fromRGB(217, 145, 57)
else
   warn("No mode selected!")
   print("Please select a mode")
   b:Destroy()
   c:Destroy()
end
local d = Instance.new("DepthOfFieldEffect", a)
d.Enabled = true
d.FarIntensity = 0.077
d.FocusDistance = 21.54
d.InFocusRadius = 20.77
d.NearIntensity = 0.277
local e = Instance.new("ColorCorrectionEffect", a)
e.Brightness = 0
e.Contrast = -0.07
e.Saturation = 0
e.Enabled = true
e.TintColor = Color3.fromRGB(255, 247, 239)
local e2 = Instance.new("ColorCorrectionEffect", a)
e2.Brightness = 0.2
e2.Contrast = 0.45
e2.Saturation = -0.1
e2.Enabled = true
e2.TintColor = Color3.fromRGB(255, 255, 255)
local s = Instance.new("SunRaysEffect", a)
s.Enabled = true
s.Intensity = 0.01
s.Spread = 0.146

print("RTX Graphics loaded! Created by BrickoIcko")

  end
})

Tab:AddButton({
  Name = "偷物品",
  Callback = function()
for i,v in pairs (game.Players:GetChildren()) do
wait()
for i,b in pairs (v.Backpack:GetChildren()) do
b.Parent = game.Players.LocalPlayer.Backpack
end
end
  end
})

Tab:AddButton({
  Name = "R15CB脚本",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/YE-R15CB-SCRIPT.lua"))()
  end
})

local Tab = Window:MakeTab({
	Name = "死铁轨",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

local Section = Tab:AddSection({
        Name = "----------债券区----------"
})

Tab:AddButton({
  Name = "红叶脚本",
  Callback = function()
  loadstring(game:HttpGet("https://getnative.cc/script/loader"))()
  end
})

Tab:AddButton({
  Name = "自动胜利",
  Callback = function()
  loadstring(game:HttpGet("https://rawscripts.net/raw/Dead-Rails-Alpha-Auto-Win-Script-for-Dead-Rails-Instant-win-AFK-farm-KEYLESS-39867"))()
  end
})

Tab:AddButton({
  Name = "刷债券(最好用)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Anoonymouss69/ScriptHUB/refs/heads/main/AutoBonds"))()
  end
})

Tab:AddButton({
  Name = "刷债券(中文)",
  Callback = function()
  loadstring(request({Url="https://raw.githubusercontent.com/ShenJiaoBen/Partial-Server-Ribbon/refs/heads/main/自动债券Linninew.lua"}).Body)()
  end
})

Tab:AddButton({
  Name = "刷债券(speed hub)(需解卡)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
  end
})

Tab:AddButton({
  Name = "Ringta刷债券",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/fjruie/newcopybonds.github.io/refs/heads/main/ringtadead.lua"))()
  end
})

local Section = Tab:AddSection({
        Name = "----------功能类----------"
})

Tab:AddButton({
  Name = "无拉回飞行(moondiely)",
  Callback = function()
  loadstring(game:HttpGet("https://rawscripts.net/raw/Dead-Rails-Alpha-FLY-in-Dead-Rails-One-Click-Script-KEYLESS-by-Moondiety-39179"))()
  end
})

Tab:AddButton({
  Name = "无拉回飞行第二版",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/selftilted/flighttosky/refs/heads/main/DeadRails"))()
  end
})

Tab:AddButton({
  Name = "近战武器攻速",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/HeadHarse/DeadRails/refs/heads/main/V4SWING"))()
  end
})

Tab:AddButton({
  Name = "近战武器攻速(第二类)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/HeadHarse/Dusty/refs/heads/main/NOTV4TRUST"))()
  end
})

Tab:AddButton({
  Name = "moondiely hub",
  Callback = function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/m00ndiety/Dead-rails/refs/heads/main/Full-GUI'))()
  end
})

Tab:AddButton({
  Name = "Sanshub(不知道有啥用还要卡密)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/iopjklbnmsss/SansHubScript/refs/heads/main/SansHub"))()
  end
})

Tab:AddButton({
  Name = "TX(破国人脚本刷债券还不免费)",
  Callback = function()
  loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\102\121\46\97\112\112\47\54\52\68\99\116\76\77\53\47\114\97\119"))()
  end
})

Tab:AddButton({
  Name = "拿物品(需解卡)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/thiennrb7/Script/refs/heads/main/Bringall"))()
  end
})

Tab:AddButton({
  Name = "无限制焊接",
  Callback = function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/hbjrev/airweld.github.io/refs/heads/main/RINGTA.lua'))()
  end
})

Tab:AddParagraph("卡密:ringta")

Tab:AddButton({
  Name = "铁拳(可以肘飞狼人)",
  Callback = function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
  end
})

local Section = Tab:AddSection({
        Name = "-----------任务类----------"
})

Tab:AddButton({
  Name = "僵尸马",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/wehjf/Pestilenceringta.github.io/refs/heads/main/horseringta.lua"))()
  end
})

local Section = Tab:AddSection({
        Name = "----------娱乐类----------"
})

Tab:AddButton({
  Name = "Zusume hub(需解卡)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/ZusumeHub/ZusumeHub/refs/heads/main/V3%20deadrails"))()
  end
})

local Section = Tab:AddSection({
        Name = "注意:复制的东西无法使用"
})

Tab:AddButton({
  Name = "Ringta(无需解卡超好用)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/ringtaa/NEWSPRINT.github.io/refs/heads/main/newsprint.lua"))()
  end
})

Tab:AddButton({
  Name = "快速交互(无冷却)",
  Callback = function()
  
for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
	if v:IsA("ProximityPrompt") then
		v["HoldDuration"] = 0
	end
end
 
Tab:AddButton({
  Name = "蜘蛛侠HUB",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/SpiderScriptRB/Dead-Rails-SpiderXHub-Script/refs/heads/main/SpiderXHub%202.0.txt"))()
  end
})
 
game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(v)
    v["HoldDuration"] = 0
end)
  end
})

local Tab = Window:MakeTab({
	Name = "最强战场",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "Fe美化防御",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/IdkRandomUsernameok/PublicAssets/refs/heads/main/Releases/MUI.lua"))()
  end
})

local Tab = Window:MakeTab({
	Name = "俄亥俄州",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "AL自动刷印钞机",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/pijiaobenMSJMleng/ehhdvdhd/refs/heads/main/good.lua"))()
  end
})

Tab:AddButton({
  Name = "Snow Hub(专治XA恶俗)(使用前必须退出XA群组)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/canxiaoxue666/SnowHubDemo/refs/heads/main/SnowHub"))() 
  end
})

Tab:AddButton({
  Name = "XA HUB 俄亥俄州(使用前请加入XA群组)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/Ohio"))()
  end
})

local Tab = Window:MakeTab({
	Name = "战争大亨",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "HubBloxy 菜单(卡密1318-9233)",
  Callback = function()
  loadstring(game:HttpGet("https://pastebin.com/raw/eFzmXhRE"))()
  end
})

local Section = Tab:AddSection({
        Name = "修了半天的东西干脆不修了"
})

Tab:AddButton({
  Name = "黄某制作高光显示",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/CNHM/asg/refs/heads/main/player%20lighting"))()
  end
})

local Tab = Window:MakeTab({
	Name = "GB(内脏与黑火药)",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "不知名脚本(需解卡)",
  Callback = function()
  loadstring(game:HttpGet('https://api.luarmor.net/files/v3/loaders/4f5c7bbe546251d81e9d3554b109008f.lua'))()
  end
})

local Tab = Window:MakeTab({
	Name = "压力",
	Icon = "rbxassetid://7734068321",
	PremiumOnly = false
})

Tab:AddButton({
  Name = "超强脚本(汉化by黄某)",
  Callback = function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/CNHM/asg/refs/heads/main/pressure"))()
  end
})
        else
            verifyButton.Text = "验证卡密"
            statusLabel.Text = "卡密验证失败"
            
            -- 添加失败动画
            local shakeTween = game:GetService("TweenService"):Create(
                verifyButton,
                TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 3),
                {Position = UDim2.new(0.1, -5, 0.4, 0)}
            )
            shakeTween:Play()
            task.wait(0.3)
            shakeTween:Cancel()
            verifyButton.Position = UDim2.new(0.1, 0, 0.4, 0)
        end
    end)
end)