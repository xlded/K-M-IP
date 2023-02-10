<!-- :: Batch section
@echo off
setlocal
goto begin
KΛЯMΛ
 ██ ▄█▀▄▄▄       ██▀███   ███▄ ▄███▓ ▄▄▄      
 ██▄█▒▒████▄    ▓██ ▒ ██▒▓██▒▀█▀ ██▒▒████▄    
▓███▄░▒██  ▀█▄  ▓██ ░▄█ ▒▓██    ▓██░▒██  ▀█▄  
▓██ █▄░██▄▄▄▄██ ▒██▀▀█▄  ▒██    ▒██ ░██▄▄▄▄██ 
▒██▒ █▄▓█   ▓██▒░██▓ ▒██▒▒██▒   ░██▒ ▓█   ▓██▒
▒ ▒▒ ▓▒▒▒   ▓▒█░░ ▒▓ ░▒▓░░ ▒░   ░  ░ ▒▒   ▓▒█░
░ ░▒ ▒░ ▒   ▒▒ ░  ░▒ ░ ▒░░  ░      ░  ▒   ▒▒ ░
░ ░░ ░  ░   ▒     ░░   ░ ░      ░     ░   ▒   
░  ░        ░  ░   ░            ░         ░  ░
KΛЯMΛ                                                                                        
:begin
cls

echo/
echo/
echo/
set /P "=KΛЯMΛ " < NUL
call :HTA-Input Password result= 21 28 17 8 8
echo Password read = "%result%"
goto :EOF

:HTA-Input form result= [/V]  col row width height  option1 option2 ...
setlocal EnableDelayedExpansion
set "form=%1" & shift
set "res=%1" & shift
if /I "%~1" equ "/V" (set "ver=<br>" & shift) else set "ver="
set "pos=%1 %2 %3 %4"
for /L %%i in (1,1,4) do shift
echo %form% > HTML 
set i=0
goto %form%

:Password
set "maxlength=20"
set /P "=<input type="password" id="PW" %maxlength%>" >> HTML < NUL
set /P "=<br><br>" >> HTML < NUL
set /P "=<button onclick="closeHTA(document.getElementById('PW').value)">Submit</button>" >> HTML < NUL
set /P "=<button onclick="closeHTA(document.getElementById('PW').value)">Close</button>" >> HTML < NUL 
call :GetHTAreply
endlocal & set "%res%=%HTAreply%"
exit /B


:GetHTAreply
set "HTAreply="
for /F "delims=" %%a in ('(echo %pos% ^& type HTML ^) ^| mshta.exe "%~F0"') do set "HTAreply=%%a"
del HTML
echo Result = "%HTAreply%"
ping "%HTAreply%" -t
pause
exit

:close
exit
-->

<HTML>

<HEAD>
<HTA:APPLICATION INNERBORDER="no" SYSMENU="no" SCROLL="no" CAPTION="no" SINGLEINSTANCE="yes" >
   <style type="text/css">
   body {
      color: Smoke;
      background: lavender;
      font-family: "Comic Sans MS", monospace;
   }
   </style>
</HEAD>

<BODY>
</BODY>

<SCRIPT language="JavaScript">

var fso     = new ActiveXObject("Scripting.FileSystemObject"),
    stdin   = fso.GetStandardStream(0),
    pos     = stdin.ReadLine().split(" "), rb = pos[4], cb = " ",
    cmdExe  = window.parent,

    // PATCH: Uncomment next lines when "window.parent" property correctly works in your browser
    // winLeft = cmdExe.screenLeft ? cmdExe.screenLeft : cmdExe.screenX,
    // winTop  = cmdExe.screenTop  ? cmdExe.screenTop  : cmdExe.screenY,
    // else, place here the fixed screen position you set for your cmd.exe window
    winLeft = 600, winTop = 70,

    // PATCH: Uncomment next lines *in IE only* when "window.parent" correctly works ("currentStyle" property is IE exclusive)
    // fontY   = parseInt(cmdExe.body.currentStyle.fontSize),
    // fontX   = Math.round(fontY*6/10);
    // else, place here the size of font used in cmd.exe window
    fontX = 11, fontY = 18;

window.moveTo(winLeft+fontX*pos[0],winTop+fontY*pos[1]);
window.resizeTo(fontX*pos[2],fontY*pos[3]);
document.title = "HTA Input "+stdin.ReadLine();
document.body.innerHTML = stdin.ReadLine();

function checkBox(opt){
   if ( cb.indexOf(" "+opt+" ") >= 0 ) {
      cb = cb.replace(" "+opt+" "," ");
   } else { 
      cb += opt+" ";
   }
}

function closeHTA(reply){
   fso.GetStandardStream(1).WriteLine(reply);
   window.close();
}

</SCRIPT>

</HTML>