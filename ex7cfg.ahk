#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

;@Ahk2Exe-SetName explorer7 Config
;@Ahk2Exe-SetDescription explorer7 Config
;@Ahk2Exe-SetFileVersion 1.0.1
;@Ahk2Exe-SetCompanyName valkalyne
;@Ahk2Exe-SetCopyright valkalyne
;@Ahk2Exe-SetMainIcon icon.ico

reg := "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

DetectHiddenWindows(1)

;absolutely horrible section please ignore

Conf := Gui()
Conf.Title := "explorer7 Config"
Conf.BackColor := "FFFFFF"
Conf.Opt("-MinimizeBox +OwnDialogs")

try{
    Theme := RegRead(reg, "Theme")
} catch {
    Theme :="aero"
}

try{
    OrbDirectory := RegRead(reg, "OrbDirectory")
} catch {
    OrbDirectory :="default"
}

try{
    DisableComposition := RegRead(reg, "DisableComposition")
} catch {
    DisableComposition :=0
}

try{
    ClassicTheme := RegRead(reg, "ClassicTheme")
} catch {
    ClassicTheme :=0
}

try{
    EnableImmersive := RegRead(reg, "EnableImmersive")
} catch {
    EnableImmersive :=0
}

try{
    StoreAppsInStart := RegRead(reg, "StoreAppsInStart")
} catch {
    StoreAppsInStart :=1
}

try{
    StoreAppsOnTaskbar := RegRead(reg, "StoreAppsOnTaskbar")
} catch {
    StoreAppsOnTaskbar :=0
}

try{
    ColorizationOptions := RegRead(reg, "ColorizationOptions")
} catch {
    ColorizationOptions :=1
}

try{
    AcrylicColorization := RegRead(reg, "AcrylicColorization")
} catch {
    AcrylicColorization :=0
}

try{
    OverrideAlpha := RegRead(reg, "OverrideAlpha")
} catch {
    OverrideAlpha :=0
}

try{
    AlphaValue := RegRead(reg, "AlphaValue")
} catch {
    AlphaValue :=107
}

try{
    UseTaskbarPinning := RegRead(reg, "UseTaskbarPinning")
} catch {
    UseTaskbarPinning :=1
}

Conf.MarginX :=0
Conf.MarginY :=0

Conf.Add("Text","Y+519 h1 w510 BackgroundDFDFDF", "")
Conf.Add("Text","y+ h40 w510 BackgroundF0F0F0", "")
Conf.Add("Text","y+ h40 w510 Backgroundff0000", "")

Conf.MarginX :=11.25
Conf.MarginY :=6

Conf.SetFont("s12","Segoe UI",)
Conf.Add("Text","y11.25 x11.25 c003399", "Configure explorer7 Settings")
Conf.SetFont("s9","Segoe UI",)
Conf.Add("Link",,'For a list of what these options do, you can visit the <a href="https://github.com/explorer7-team/source">explorer7 Github repository</a>.`nThese options are located under `nHKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced')

Conf.Add("Text",,"Theme:")
Conf.Add("Edit","vTheme w477.5",Theme)
Conf.Add("Text",,"Custom Orb Directory:")
Conf.Add("Edit","vOrbDirectory w477.5",OrbDirectory)
Conf.Add("Checkbox","vDisableComposition Checked" DisableComposition,"Disable Composition")
Conf.Add("Checkbox","vClassicTheme Checked" ClassicTheme,"Use Classic theme")
Conf.Add("Checkbox","vEnableImmersive Checked" EnableImmersive,"Enable Immersive shell")
Conf.Add("Checkbox","vStoreAppsInStart Checked" StoreAppsInStart,"Show UWP Apps in Start")
Conf.Add("Checkbox","vStoreAppsOnTaskbar Checked" StoreAppsOnTaskbar,"Show UWP Apps on the Taskbar")
Conf.Add("Text",,"Colorization Options:")
Conf.Add("DropDownList", "vColorizationOptions Choose" ColorizationOptions+1, [0, 1, 2, 3, 4])
Conf.Add("Text","","Acrylic Options:")
Conf.Add("DropDownList", "vAcrylicColorization Choose" AcrylicColorization+1, [0, 1, 2, 3])
Conf.Add("Checkbox"," vOverrideAlpha Checked" OverrideAlpha,"Override Alpha")
Conf.Add("Text",,"Alpha Value:")
Conf.Add("Edit")
Conf.Add("UpDown", "vAlphaValue Range0-255", AlphaValue)
Conf.Add("Checkbox","vUseTaskbarPinning Checked" UseTaskbarPinning,"Use Taskbar Pinning")

Okbtn := Conf.Add("Button", "w105 h23 y528 x310 Default BackgroundF0F0F0", "Save Changes")
Okbtn.OnEvent("Click", apply)
Cancelbtn := Conf.Add("Button", "w73 h23 yp BackgroundF0F0F0", "Cancel")
Cancelbtn.OnEvent("Click", cancel)
Restartbtn :=Conf.Add("Button","xm w118 h23 yp BackgroundF0F0F0", "Restart Explorer")
Restartbtn.OnEvent("Click", restart)

Conf.Show("w510 h560")

restart(btn, info){
    RunWait("taskkill /f /im explorer.exe")
    Run RegRead("HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "Shell")
}

cancel(btn, info){ 
    ExitApp()
}

apply(btn, info){ 
    writeconfig()
    Conf.Opt("+OwnDialogs")
    MsgBox("Restart explorer7 to see the changes.","Settings applied","OK Iconi")
}

writeconfig(){
    RegWrite(Conf["Theme"].value, "REG_SZ", reg, "Theme")
    RegWrite(Conf["OrbDirectory"].value, "REG_SZ", reg, "OrbDirectory")
    RegWrite(Conf["DisableComposition"].value, "REG_DWORD", reg, "DisableComposition")
    RegWrite(Conf["ClassicTheme"].value, "REG_DWORD", reg, "ClassicTheme")
    RegWrite(Conf["EnableImmersive"].value, "REG_DWORD", reg, "EnableImmersive")
    RegWrite(Conf["StoreAppsInStart"].value, "REG_DWORD", reg, "StoreAppsInStart")
    RegWrite(Conf["StoreAppsOnTaskbar"].value, "REG_DWORD", reg, "StoreAppsOnTaskbar")
    RegWrite(Conf["ColorizationOptions"].text, "REG_DWORD", reg, "ColorizationOptions")
    RegWrite(Conf["AcrylicColorization"].text, "REG_DWORD", reg, "AcrylicColorization")
    RegWrite(Conf["OverrideAlpha"].value, "REG_DWORD", reg, "OverrideAlpha")
    RegWrite(Conf["AlphaValue"].value, "REG_DWORD", reg, "AlphaValue")
    RegWrite(Conf["UseTaskbarPinning"].value, "REG_DWORD", reg, "UseTaskbarPinning")
}