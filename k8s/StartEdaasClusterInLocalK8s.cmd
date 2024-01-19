@echo off

kubectl apply -k .

kubectl apply -f ingress-examdesigner.yaml

REM iis and nginx has port confict on 443 (https port)
iisreset /stop

cd nginx 

if not exist logs mkdir logs

if not exist temp mkdir temp

tasklist /FI "IMAGENAME eq nginx.exe" 2>NUL | find /I /N "nginx.exe">NUL
if "%ERRORLEVEL%"=="0" taskkill /f /t /im nginx.exe

start nginx.exe

cd ..

@echo Edaas cluster in local k8s is started!

@echo on