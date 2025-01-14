#include ./lib/findText.ahk
#Persistent ; Keep the script running
SetTitleMatchMode, 2 ; Allows partial matching of window titles
SetWorkingDir %A_ScriptDir%

global StopScript := false

colorHex := "./color.txt"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

f::
    hwnd := WinExist("ahk_exe RobloxPlayerBeta.exe")
    if !hwnd {
        MsgBox, RobloxPlayerBeta.exe not found
        return
    }
    WinActivate, ahk_exe RobloxPlayerBeta.exe

    WinWaitActive, ahk_exe RobloxPlayerBeta.exe, , 5

    coordX := 0
    coordY := 0
    
    Text:="|<>*118$51.zzzzzzzzzhsXDnwzrxiNUM61xy0U5vSrjDk60D/mwnzNn9sS7anvSNj/mwaQ0nBvSrc1vSNaNaNyTPnC7VsTnzzzzzzzzw"

    if (ok:=FindText(coordX, coordY, 1275-150000, 289-150000, 1275+150000, 289+150000, 0, 0, Text))
    {
        FindText().Click(process_imageX, process_imageY, "L")
    }

    ; if color picker input not found, set it manually here comment line 20 to 24
    

    FileRead, fileContent, %colorHex%
    if (ErrorLevel) {
        MsgBox, Could not read the file.
        ExitApp
    }

    totalLines := 0
    Loop, Parse, fileContent, `n, `r
    {
        if (A_LoopField != "")
            totalLines++ ; Count total non-empty lines, such a dumbideas
    }

    lineCount := 0
    Loop, Parse, fileContent, `n, `r
    {
        line := A_LoopField
        if (line == "")
            continue

        lineCount++
        StringTrimRight, line, line, 4
        Clipboard := line

        ShowNotification("Processing line " . lineCount . " of " . totalLines . ": " . line, 5000)

        ProcessLine(line, coordX, coordY)
        Sleep, 1000
    }
    ShowNotification("All lines processed. Exiting.", 5000)
    ExitApp ; Exit after all lines are processed
Return

ProcessLine(line, coordX, coordY) {
    WinActivate, ahk_exe autodraw.exe
    Sleep, 200
    WinWaitActive, ahk_exe autodraw.exe

    ; FIXME: Edit coordinate to ur Open file button ffrom auto draw, that one with image logo
    Click, 445, 437
    Sleep, 1000
    WinWaitActive, Open Image
    Sleep, 1000
    ; FIXME: Edit coordinate to ur File name: input bar
    input_bar:="|<>*152$64.00000000001zzzzzzzzzzrzzzzzzzzzzTzzzzzzzzzxzzzzzzzzzzrTzzzzzzzzzRzzzzzzzzzxrzzzzzzzzzrTzzzzzzzzzRzzzzzzzzzxrzzzzzzzzzrTzzzzzzzzzRzzzzzzzzzxrzzzzzzzzzrTzzzzzzzzzRzzzzzzzzzxrzzzzzzzzzrTzzzzzzzzzRzzzzzzzzzxrzzzzzzzzzrzzzzzzzzzzTzzzzzzzzzxzzzzzzzzzzk0000000000U"

    if (ok:=FindText(inputX, inputY, 545-150000, 566-150000, 545+150000, 566+150000, 0, 0, input_bar))
    {
        FindText().Click(inputX, inputY, "L")
    }
    Sleep, 1000

    Send ^v
    Sleep, 1000
    Send, {Down}
    Sleep, 1000
    Send, {Enter} ; dont merge down and enter, it might break the flow
    Sleep, 1000

    WinActivate, ahk_exe RobloxPlayerBeta.exe
    Sleep, 1000
    MouseClick, left, coordX, coordY
    MouseClick, left, coordX, coordY
    Sleep, 1000
    Send ^v

    Sleep, 1000
    WinActivate, ahk_exe autodraw.exe
    WinWaitActive, ahk_exe autodraw.exe

    ; Processing the Image & drawing
    process_image:="|<>*163$49.zzzzzzzzs7zzzzzzwtzzzzzzyQzzzzzzzCEEsQAC7b8m9YYmPkAtYwsDDtyNmS0UkwzCNDDyTCTb8aH39bDnksQA67zzzzzzzzU"
    ; FIX ME: Change to coordinate for Process Image button
    if (ok:=FindText(process_imageX, process_imageY, 825-150000, 588-150000, 825+150000, 588+150000, 0, 0, process_image))
    {
        Sleep, 1000
        FindText().Click(process_imageX, process_imageY, "L")
    }
    Sleep, 1000

    begin_drawing:="|<>*164$50.zzzzzzzzw3zzzwzzzCTzzzDzznnzzzzzzwwV1AoUsDD9aG99YnnmTYWGNAwwb1egaHDC9aMX9YnnaNa8mNAw3b1WQaMDzzzzzzznzzzzzzzAzzzzzzzsTzzzzzzzzU"
    ; FIX ME: Change to coordinate for Start Drawing button
    if (ok:=FindText(beginX, beginY, 997-150000, 589-150000, 997+150000, 589+150000, 0, 0, begin_drawing))
    {
        Sleep, 1000
        FindText().Click(beginX, beginY, "L")
    }
    Sleep, 1000

    
    WinActive("Preview")
    Sleep, 1000
    Send, {Shift}
    Sleep, 1000
    ; finished:="|<>*144$69.zzzzzzzzzzzy0nzszwzzzwtnyTz7zbzzzbCTzzzzwzzzwtnyM3C3UT1s7CTn2NWAFkC8tnyNtAtbAwbbC0nD9XwtbYwtnyNtC3bA0bbCTnD9yAtbwwznyNtAtbAxbbyTnD9WAtl68tnyNtC3bD1s7DzzzzzzzzzzzU"

    ; if (ok:=FindText(finishedX, finishedY, 685-150000, 343-150000, 685+150000, 343+150000, 0, 0, finished))
    ; {
    ;     Send, {LAlt}
    ; }
    WinActive("Preview")
    Sleep, 1000
    WinClose, Message
    Sleep, 1000
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ShowNotification(message, duration := 3000) {
    Gui, Notification:Destroy
    Gui, Notification:+AlwaysOnTop -Caption +ToolWindow
    Gui, Notification:Color, Black  ; Set background color
    Gui, Notification:Font, s10 Bold, Arial
    Gui, Notification:Add, Text, cWhite Center, %message%

    ; Position notification at the top-right corner
    ScreenWidth := A_ScreenWidth
    GuiWidth := 250  ; Adjust width
    GuiHeight := 50  ; Adjust height
    XPos := ScreenWidth - GuiWidth - 10
    YPos := 10

    Gui, Notification:Show, x%XPos% y%YPos% w%GuiWidth% h%GuiHeight% NoActivate, Notification
    SetTimer, CloseNotification, %duration%
}

CloseNotification:
    Gui, Notification:Destroy
    SetTimer, CloseNotification, Off
Return

;;;;;;;;;;;;;;;;;;

^f:: ; Ctrl + F to stop the script
    StopScript := true
    GuiControl,, StatusText, Script stopping...
    Sleep, 1000
ExitApp
Return
