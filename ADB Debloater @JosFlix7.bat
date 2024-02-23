@echo off
SET Ver=v5.8 [5.8: ROG Phone 7 Initial Integration]
SET CatCut=echo ####################################################################################################
SET LineCut=echo ----------------------------------------------------------------------------------------------------
SET LineSep=echo ____________________
SET .=echo .
SET QYN=choice /C YN
SET Q12=choice /C 12
SET Q13=choice /C 123
SET Q15=choice /C 12345

:Start
cls
COLOR 0B
echo ATENCION:
echo Necesitas meter este bat en tu carpeta de platform-tools o tener adb en el sistema.
%.%
%.%
%.%
%CatCut%
echo Moto G7 Power (Ocean), Moto G60 (Hanoip) and Asus ROG Phone 7 ADB App Debloater.
echo Para Stock y Custom ROMS que he probado.
echo Testeado y hecho por @JosFlix7.
%LineCut%
echo NO ME HAGO RESPONSABLE si tienes Bootloop o algo male sal, ya que hice esta lista
echo para mi uso personal y deshabilita cosas que yo no uso.
%LineCut%
echo (i) - Se te preguntara en algunas partes si quieres continuar o no con un conjunto de Apps.
%LineCut%
echo Compartido para el grupo @MotoG7PowerES y @MotoG60ES en Telegram.
%LineCut%
echo %ver%
%CatCut%
%.%
%.%
%.%
echo Desea ver los problemas conocidos/changelog antes de continuar?
echo (1) Continuar con la ejecucion
echo (2) Ver problemas conocidos
echo (3) Ver changelog
%Q13%
	if ERRORLEVEL 3 goto Changelog
	if ERRORLEVEL 2 goto Problems
	if ERRORLEVEL 1 goto Continue

::-------------------------------------------------- LISTADO DE PROBLEMAS
:Problems
cls
COLOR 0E
%CatCut%
echo Desafortunadamente no todas las ROMs se salvan de tener problemas. Estos son algunos
echo problemas conocidos:
echo  - DESACTIVA todas las opciones de la pantalla ambiente de HavocOS 4.X antes de
echo 	continuar con el bat o de lo contrario esta quedara siempre activada.
%.%
echo  - Bootloop en HavocOS 4.X SOLO VERSION GAPPS.
echo    * La version vanilla no tiene este problema.
%.%
echo  - Desactivar Android System Intelligence en ROMs Android 13 QPR1 provocara crash al
echo 	querer entrar a "Ajustes/Notificaciones." Solo pasa en ROMs con Gapps incluidas.
%.%
echo  - Desactivar Moto LiveWallpaper3, Moto Gallery y todos los fondos animados causa crash
echo  al querer cambiar el fondo en MYUI 5 China.
echo   * Restaurar estas apps soluciona el problema.
%CatCut%
echo Presiona cualquier tecla para regresar a la pregunta anterior...
pause >nul
goto Start

::-------------------------------------------------- PREGUNTA INICIAL
:Continue
SET GB=echo OK! vuelve a ejecutar este bat si cambias de opinion.
cls
echo Que desea hacer?
echo 1) Quiero desinstalar Apps.
echo 2) Quiero deshabilitar Apps.
echo 3) Quiero restaurar Apps. (Deshacer opcion 1)
echo 4) Quiero habilitar Apps. (Deshacer opcion 2)
echo 5) Cambie de opinion, deseo salir.
%LineSep%
echo (i) A veces es mejor deshabilitar apps en vez de desinstalar ademas de no haber riesgo de bootloop.
%Q15%
	if ERRORLEVEL 5 goto Exit
	if ERRORLEVEL 4 goto Restore2
	if ERRORLEVEL 3 goto Restore1
	if ERRORLEVEL 2 goto Disable
	if ERRORLEVEL 1 goto Uninstall

::-------------------------------------------------- DECLARACION DE VARIABLES
:Uninstall
SET T.U=Desinstalando
SET Q.U=Desinstalar
SET T.D=Deshabilitando
SET C.U=adb wait-for-device uninstall --user 0
SET C.D=adb wait-for-device shell cmd package disable-user --user 0
SET C.DK=adb wait-for-device shell cmd package disable-user -k
SET C.FS=adb wait-for-device shell am force-stop
SET C.CP=adb wait-for-device shell pm clear --user 0
goto ADB

:Disable
SET T.U=Deshabilitando
SET Q.U=Deshabilitar
SET T.D=Deshabilitando
SET C.U=adb wait-for-device shell cmd package disable-user --user 0
SET C.D=adb wait-for-device shell cmd package disable-user --user 0
SET C.DK=adb wait-for-device shell cmd package disable-user -k
SET C.FS=adb wait-for-device shell am force-stop
SET C.CP=adb wait-for-device shell pm clear --user 0
goto ADB

:Restore1
SET T.U=Restaurando
SET Q.U=Restaurar
SET T.D=Habilitando
SET C.U=adb wait-for-device shell cmd package install-existing
SET C.D=adb wait-for-device shell cmd package enable
SET C.DK=adb wait-for-device shell cmd package enable
SET C.FS=::
SET C.CP=::
goto ADB

:Restore2
SET T.U=Habilitando
SET Q.U=Habilitar
SET T.D=Habilitando
SET C.U=adb wait-for-device shell cmd package enable
SET C.D=adb wait-for-device shell cmd package enable
SET C.DK=adb wait-for-device shell cmd package enable
SET C.FS=::
SET C.CP=::
goto ADB

::-------------------------------------------------- DETECCION DE ADB
:ADB
cls
echo Iniciando ADB 
adb devices 2>nul
	if ERRORLEVEL == 9009 (
	goto NoADB
	) else (
	goto Wizard
	)

::-------------------------------------------------- NO HAY ADB GUE
:NoADB
SET GB=echo OK! Ejecuta este bat cuando hayas solucionado los problemas.
cls
COLOR 0C
echo NO SE ENCONTRO ADB EN EL SISTEMA!
%.%
echo Revisa si tienes instalado "platform-tools" y haz lo siguiente:
echo 1. Revisa que este bat este dentro de la carpeta "platform-tools" que descargaste y descomprimiste.
echo 2. Si colocaste "platform-tools" en las variables de entorno del sistema para usarlo globalmente,
echo    revisa que este correctamente configurado.
%.%
echo Dirigete a este link si no haz descargado platform-tools:
%.%
echo https://dl.google.com/android/repository/platform-tools-latest-windows.zip
%.%
echo Luego revisa que tu telefono tenga la depuracion USB activada y que este sea detectado usando el
echo comando "adb devices"
%.%
echo Si ya funciona ADB pero tu dispositivo no es detectado, busca los drivers de tu dispositivo,
echo normalmente son universales de la marca, por ejemplo, busca en google "Drivers Motorola" para
echo encontrar la pagina de motorola y descargar los drivers universales de sus dispositivos.
%.%
echo Que desea hacer?
echo 1) Reiniciar Bat.
echo 2) Salir.
%Q12%
	if ERRORLEVEL 2 goto Exit
	if ERRORLEVEL 1 goto Start

::-------------------------------------------------- SETUP WIZARD APPS
:Wizard
%CatCut%
echo SetupWizard.
%CatCut%
echo %Q.U% Setup Wizard?
echo (i) Puedes omitirlo o hacerlo y despues eliminarlo.
%QYN%
	if ERRORLEVEL 2 goto Gapps
	if ERRORLEVEL 1 goto Wizard1

:Wizard1
echo %T.D% Lineage SetupWizard
SET app=org.lineageos.setupwizard
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

echo %T.U% Restauracion de Pixel
SET app=com.google.android.apps.pixelmigrate
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% La Herramienta de Restauracion de Google
SET app=com.google.android.apps.restore
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Google Setup Wizard
SET app=com.google.android.setupwizard
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% One Time Initializer
SET app=com.android.onetimeinitializer
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Google One Time Initializer
SET app=com.google.android.onetimeinitializer
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Pixel Setup Wizard
SET app=com.google.android.pixel.setupwizard
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::-------------------------------------------------- GOOGLE APPS
:Gapps
%.%
%.%
%.%
%.%
%.%
%CatCut%
echo Google Apps.
%CatCut%
echo %Q.U% Apps Google?
%QYN%
	if ERRORLEVEL 2 goto Core
	if ERRORLEVEL 1 goto GappsCore

:GappsCore
%.%
%LineCut%
echo %Q.U% Google Apps Core? (Telefono, Contactos, Mensajes, Reloj, Calculadora y Calendario.)
%QYN%
	if ERRORLEVEL 2 goto GappsIntelligence
	if ERRORLEVEL 1 goto GappsCore1

:GappsCore1
echo %T.U% Telefono de Google
SET app=com.google.android.dialer
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Contactos de Google
SET app=com.google.android.contacts
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Mensajes de Google
SET app=com.google.android.apps.messaging
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Reloj de Google
SET app=com.google.android.deskclock
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Calculadora de Google
SET app=com.google.android.calculator
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Calendario de Google
SET app=com.google.android.calendar
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:GappsIntelligence
%.%
%LineCut%
echo %Q.U% Android System Intelligence?
%QYN%
	if ERRORLEVEL 2 goto GappsGoogle
	if ERRORLEVEL 1 goto GappsIntelligence1

:GappsIntelligence1
echo %T.U% Android System Intelligence
SET app=com.google.android.as
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Private Compute Services
SET app=com.google.android.as.oss
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:GappsGoogle
%.%
%LineCut%
echo %Q.U% Google App?
%QYN%
	if ERRORLEVEL 2 goto GappsMaps
	if ERRORLEVEL 1 goto GappsGoogle1

:GappsGoogle1
echo %T.U% Google App
SET app=com.google.android.googlequicksearchbox
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:GappsMaps
%.%
%LineCut%
echo %Q.U% Google Maps?
%QYN%
	if ERRORLEVEL 2 goto GappsSoundPicker
	if ERRORLEVEL 1 goto GappsMaps1

:GappsMaps1
echo %T.U% Maps
SET app=com.google.android.apps.maps
%C.FS% com.google.android.apps.maps >nul 2>nul
%C.U% com.google.android.apps.maps >nul 2>nul

:GappsSoundPicker
%.%
%LineCut%
echo %Q.U% Google Sound Picker?
echo (i) A veces las ROMs con Gapps incluidas lo usan por defecto.
%QYN%
	if ERRORLEVEL 2 goto GappsWell
	if ERRORLEVEL 1 goto GappsSoundPicker1

:GappsSoundPicker1
echo %T.U% Google Sound Picker
SET app=com.google.android.soundpicker
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:GappsWell
%.%
%LineCut%
echo %Q.U% Bienestar Digital?
%QYN%
	if ERRORLEVEL 2 goto GappsBasic
	if ERRORLEVEL 1 goto GappsWell1

:GappsWell1
echo %T.U% Bienestar Digital
SET app=com.google.android.apps.wellbeing
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:GappsBasic
%.%
%LineCut%
echo %Q.U% Apps basicas de Google? (Fotos, Fotos Go, Files, Talkback, Lens, Servicios de Voz.)
%QYN%
	if ERRORLEVEL 2 goto GappsYouTube
	if ERRORLEVEL 1 goto GappsBasic1

:GappsBasic1
echo %T.U% Google Gallery Go
SET app=com.google.android.apps.photosgo
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Google Files
SET app=com.google.android.apps.nbu.files
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.settings.overlay.filesgoogle
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Google Fotos
SET app=com.google.android.apps.photos
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Google TalkBack
SET app=com.google.android.marvin.talkback
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Lens
SET app=com.google.ar.lens
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Servicios de voz de Google
SET app=com.google.android.tts
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:GappsYouTube
%.%
%LineCut%
echo %Q.U% YouTube y YouTube Music?
%QYN%
	if ERRORLEVEL 2 goto GappsPixel
	if ERRORLEVEL 1 goto GappsYouTube1

:GappsYouTube1
echo %T.U% YouTube
SET app=com.google.android.youtube
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% YouTube Music
SET app=com.google.android.apps.youtube.music
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.apps.youtube.music.setupwizard
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:GappsPixel
%.%
%LineCut%
echo %Q.U% Stock Pixel Core Apps?
%QYN%
	if ERRORLEVEL 2 goto GappsStuff
	if ERRORLEVEL 1 goto GappsPixel1

:GappsPixel1
echo %T.U% Android Auto
SET app=com.google.android.projection.gearhead
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Device Health Services
SET app=com.google.android.apps.turbo
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Historial de ubicaciones de Google
SET app=com.google.android.gms.location.history
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Seguridad y Emergencia
SET app=com.google.android.apps.safetyhub
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:GappsStuff
%.%
%LineCut%
echo %T.U% Google Carrier Services
SET app=com.google.android.ims
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Google Carrier Settings
SET app=com.google.android.carrier
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Google Partner Setup
SET app=com.google.android.partnersetup
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Servicio de recomendacion de impresora
SET app=com.google.android.printservice.recommendation
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Google Exchange Services
SET app=com.google.android.gm.exchange
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Google Markup
SET app=com.google.android.markup
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Google Meet
SET app=com.google.android.apps.tachyon
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Google Feedback
SET app=com.google.android.feedback
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Play Music
SET app=com.google.android.music
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Peliculas y TV
SET app=com.google.android.videos
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Servicios de AR de Google
SET app=com.google.ar.core
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Apps y paquetes restantes...
SET app=com.google.android.configupdater
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.ext.shared
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.gms.policy_sidecar_aps
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.wfcactivation
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.apps.googleassistant
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.apps.subscriptions.red
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.apps.carrier.carrierwifi
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.cellbroadcastreceiver
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.cellbroadcastservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::-------------------------------------------------- AOSP CORE APPS
:Core
%.%
%.%
%.%
%.%
%.%
%CatCut%
echo AOSP Core Apps.
%CatCut%
echo %Q.U% Apps AOSP Core?
%QYN%
	if ERRORLEVEL 2 goto AOSP
	if ERRORLEVEL 1 goto CoreBasic

:CoreBasic
%.%
%LineCut%
echo %Q.U% Apps AOSP basicas? (Telefono, Mensajes, Contactos.)
%QYN%
	if ERRORLEVEL 2 goto CoreKeyboard
	if ERRORLEVEL 1 goto CoreBasic1

:CoreBasic1
echo %T.U% Centro de Mensajes
SET app=com.android.messaging
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Contactos
SET app=com.android.contacts
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Telefono
SET app=com.android.dialer
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:CoreKeyboard
%.%
%LineCut%
echo %Q.U% Teclado AOSP?
%QYN%
	if ERRORLEVEL 2 goto CoreClock
	if ERRORLEVEL 1 goto CoreKeyboard1

:CoreKeyboard1
echo %T.U% Teclado de Android (AOSP)
SET app=com.android.inputmethod.latin
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:CoreClock
%.%
%LineCut%
echo %Q.U% Reloj?
%QYN%
	if ERRORLEVEL 2 goto CoreCalculator
	if ERRORLEVEL 1 goto CoreClock1

:CoreClock1
echo %T.U% Reloj
SET app=com.android.deskclock
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:CoreCalculator
%.%
%LineCut%
echo %Q.U% Calculadora?
%QYN%
	if ERRORLEVEL 2 goto CoreFM
	if ERRORLEVEL 1 goto CoreCalculator1

:CoreCalculator1
echo %T.U% Calculadora
SET app=com.android.calculator2
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul 
 
:CoreFM
%.%
%LineCut%
echo %Q.U% RadioFM?
%QYN%
	if ERRORLEVEL 2 goto CoreNFC
	if ERRORLEVEL 1 goto CoreFM1

:CoreFM1
echo %T.D% y %T.U% RadioFM
SET app=com.android.fmradio
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.caf.fmradio
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.fmradio.recordings
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:CoreNFC
%.%
%LineCut%
echo %Q.U% NFC?
%QYN%
	if ERRORLEVEL 2 goto CoreGallery
	if ERRORLEVEL 1 goto CoreNFC1

:CoreNFC1
echo %T.U% Servicio NFC
SET app=com.android.nfc
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Servicios NFC de Motorola
SET app=com.motorola.nfc
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Chad Etiquetas NFC
SET app=com.android.apps.tag
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Virgin Etiquetas NFC
SET app=com.google.android.tag
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:CoreGallery
%.%
%LineCut%
echo %T.U% Galeria
SET app=com.android.gallery3d
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Calendario
SET app=com.android.calendar
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::-------------------------------------------------- AOSP APPS
:AOSP
%.%
%.%
%.%
%.%
%.%
%CatCut%
echo AOSP COMMON FULL DEBLOAT.
%CatCut%
echo %Q.U% Apps AOSP?
%QYN%
	if ERRORLEVEL 2 goto Lineage
	if ERRORLEVEL 1 goto AOSPIMS

:AOSPIMS
%.%
%LineCut%
echo %Q.U% CodeAurora IMS?
echo (i) Permite el uso de 4G LTE durante una llamada telefonica.
%QYN%
	if ERRORLEVEL 2 goto AOSPVPN
	if ERRORLEVEL 1 goto AOSPIMS1

:AOSPIMS1
echo %T.D% CodeAurora IMS
SET app=org.codeaurora.ims
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

:AOSPVPN
%.%
%LineCut%
echo %Q.U% VPN Dialogs?
echo (i) Se usa para confirmar el uso de VPN, seguro de quitar si no usas VPNs.
%QYN%
	if ERRORLEVEL 2 goto AOSPLiveWall
	if ERRORLEVEL 1 goto AOSPVPN1

:AOSPVPN1
echo %T.U% VPN Dialogs
SET app=com.android.vpndialogs
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:AOSPLiveWall
%.%
%LineCut%
echo %Q.U% Selector de fondo de pantalla animado?
echo (i) Se pueden romper algunos widgets de clima, no afecta a Moto Widget ni Google App.
echo      No podras escoger un fondo de pantalla animado.
%QYN%
	if ERRORLEVEL 2 goto AOSPSett
	if ERRORLEVEL 1 goto AOSPLiveWall1

:AOSPLiveWall1
echo %T.U% Selector de fondo de pantalla animado
SET app=com.android.wallpaper.livepicker
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:AOSPSett
%.%
%LineCut%
echo %Q.U% Sugerencias de configuracion?
echo (i) Barra de busqueda de los Ajustes, quitarlo dara crash al tocar la barra o puede no aparecer.
%QYN%
	if ERRORLEVEL 2 goto AOSPGeneral
	if ERRORLEVEL 1 goto AOSPSett1

:AOSPSett1
echo %T.U% Sugerencias de configuracion
SET app=com.android.settings.intelligence
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:AOSPGeneral
%.%
%LineCut%
echo %T.D% Kit de Herramientas de SIM
SET app=com.android.stk
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

echo %T.U% BT MIDI Service
SET app=com.android.bluetoothmidiservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.D% Copia de seguridad del historial de llamadas
SET app=com.android.calllogbackup
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

echo %T.U% Android Easter Egg
SET app=com.android.egg
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Servicio para configurar un perfil de trabajo o usar apps como Island
SET app=com.android.managedprovisioning
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Efectos de sonido AOSP
SET app=com.android.musicfx
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Servicio de impresion recomendado
SET app=com.android.printservice.recommendation
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Selector de tarjetas en controles de dispositivos
SET app=com.android.systemui.plugin.globalactions.wallet
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.D% Almacenamiento de numeros bloqueados
SET app=com.android.providers.blockednumber
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

echo %T.D% Diccionario del usuario
SET app=com.android.providers.userdictionary
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

echo %T.U% Backup Confirm (Para adb backup, obsoleto)
SET app=com.android.backupconfirm
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Visor de HTML
SET app=com.android.htmlviewer
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% y %T.D% Alertas de Emergencia
SET app=com.android.cellbroadcastreceiver
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.cellbroadcastreceiver.module
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.cellbroadcastservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

echo %T.U% Protector de pantalla de Fotos
SET app=com.android.dreams.phototable
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Protector de pantalla basico
SET app=com.android.dreams.basic
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Perfil de emergencia
SET app=com.android.emergency
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Reproductor de Musica AOSP
SET app=com.android.music
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Apps y paquetes restantes...
SET app=android.ext.shared
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.providers.partnerbookmarks
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.traceur
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.bips
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.companiondevicemanager
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.pacprocessor
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.proxyhandler
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.sharedstoragebackup
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.simappdialog
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.smspush
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qti.qualcomm.datastatusnotification
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.android.omadm.service
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.cts.ctsshim
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.cts.priv.ctsshim
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.imsserviceentitlement
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.carrierdefaultapp
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.bookmarkprovider
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.wallpaperbackup
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.android.wallpapercropper
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.launcher3.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.android.cellbroadcast.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.cellbroadcastservice.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::-------------------------------------------------- LINEAGE AND EXTRA ROM APPS
:Lineage
%.%
%.%
%.%
%.%
%.%
%CatCut%
echo Lineage and Extra ROMs Apps.
%CatCut%
echo %Q.U% Apps de ROMs?
%QYN%
	if ERRORLEVEL 2 goto G7Stock
	if ERRORLEVEL 1 goto LineageMotoGestures

:LineageMotoGestures
%.%
%LineCut%
echo %Q.U% Gestos Moto? (Lineage Settings Device, usado por ROMs con Gestos Moto)
%QYN%
	if ERRORLEVEL 2 goto LineageSeedvault
	if ERRORLEVEL 1 goto LineageMotoGestures1

:LineageMotoGestures1
echo %T.D% Gestos Moto
SET app=org.lineageos.settings.device
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

:LineageSeedvault
%.%
%LineCut%
echo %Q.U% Seedvault? (Copias de Seguridad Local de LineageOS)
%QYN%
	if ERRORLEVEL 2 goto LineageAperture
	if ERRORLEVEL 1 goto LineageSeedvault1

:LineageSeedvault1
echo %T.U% Seedvault
SET app=com.stevesoltys.seedvault
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:LineageAperture
%.%
%LineCut%
echo %Q.U% Aperture?
%QYN%
	if ERRORLEVEL 2 goto GrapheneCam
	if ERRORLEVEL 1 goto LineageAperture1

:LineageAperture1
echo %T.U% Aperture Camera
SET app=org.lineageos.aperture
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.apps.googlecamera.fishfood
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:GrapheneCam
%.%
%LineCut%
echo %Q.U% Camara de GrapheneOS?
%QYN%
	if ERRORLEVEL 2 goto LineageEtar
	if ERRORLEVEL 1 goto GrapheneCam1

:GrapheneCam1
echo %T.U% Camara de GrapheneOS
SET app=app.grapheneos.camera
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:LineageEtar
%.%
%LineCut%
echo %Q.U% Calendario (Etar)?
%QYN%
	if ERRORLEVEL 2 goto SimpleGallery
	if ERRORLEVEL 1 goto LineageEtar1

:LineageEtar1
echo %T.U% Calendario
SET app=org.lineageos.etar
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:SimpleGallery
%.%
%LineCut%
echo %Q.U% Simple Gallery?
%QYN%
	if ERRORLEVEL 2 goto GameMode
	if ERRORLEVEL 1 goto SimpleGallery1

:SimpleGallery1
echo %T.U% Simple Gallery Pro
SET app=com.simplemobiletools.gallery.pro
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:GameMode
%.%
%LineCut%
echo %Q.U% HavocOS Game Mode?
%QYN%
	if ERRORLEVEL 2 goto ParallelSpace
	if ERRORLEVEL 1 goto GameMode1

:GameMode1
echo %T.U% HavocOS Game Mode
SET app=com.android.game.mode
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.game.mode.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:ParallelSpace
%.%
%LineCut%
echo %Q.U% Parallel Space? (Opcion de clonacion de Apps en algunas ROMs Android 13)
%QYN%
	if ERRORLEVEL 2 goto GameSpace
	if ERRORLEVEL 1 goto ParallelSpace1

:ParallelSpace1
echo %T.U% Parallel Space
SET app=ink.kscope.parallelspace
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=ink.kscope.parallelspace.auto_generated_rro_product__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:GameSpace
%.%
%LineCut%
echo %Q.U% Chaldeaprjkt GameSpace? (Incluido en varias ROMs Android 13)
%QYN%
	if ERRORLEVEL 2 goto LineageUpdater
	if ERRORLEVEL 1 goto GameSpace1

:GameSpace1
echo %T.U% GameSpace
SET app=io.chaldeaprjkt.gamespace
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=io.chaldeaprjkt.gamespace.auto_generated_rro_product__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:LineageUpdater
%.%
%LineCut%
echo %Q.U% Updater de ROMs?
%QYN%
	if ERRORLEVEL 2 goto LineageStuff
	if ERRORLEVEL 1 goto LineageUpdater1

:LineageUpdater1
echo %T.U% LineageOS Updater
SET app=org.lineageos.updater
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Updater de HavocOS 4.X
SET app=com.havoc.updater
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.havoc.updater.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:LineageStuff
%.%
%LineCut%
echo %T.U% AudioFX de LOS
SET app=org.lineageos.audiofx
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Grabadora de LOS
SET app=org.lineageos.recorder
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Musica de LOS
SET app=org.lineageos.eleven
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Musica de CrDroid
SET app=com.crdroid.music
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Navegador de LOS
SET app=org.lineageos.jelly
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.D% Administrador de clientes concetados en Hotspot en HavocOS
SET app=com.android.softap
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

echo %T.U% DuckDuckGo
SET app=com.duckduckgo.mobile.android
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Simple Calendar
SET app=com.simplemobiletools.calendar.pro
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Dolby DAXService
SET app=com.dolby.daxservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Dolby
SET app=com.motorola.dolby.dolbyui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% MatLog
SET app=org.omnirom.logcat
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Opcion ANGLE de Game Space de Cr, Derp y otras ROMs
SET app=com.android.angle
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% DerpFest Wallpapers
SET app=org.derpfest.walls
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Copia de seguridad local de contactos de CalyxOS
SET app=org.calyxos.backup.contacts
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Lineage Wallpapers
SET app=org.lineageos.backgrounds
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Komodo Wallpapers
SET app=org.komodo.wallpaper
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Widget del clima OmniJaws y sus paquetes de iconos
SET app=org.omnirom.omnijaws
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.benzo.weathericons
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Desbloqueo Facial de CrDroid
SET app=com.crdroid.faceunlock
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Desbloqueo Facial de Pixel Experience
SET app=org.pixelexperience.faceunlock
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Desbloqueo Facial de AOSP
SET app=com.android.faceunlock
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.D% Touch Gestures de HavocOS 4.X
SET app=com.android.touch.gestures
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

echo %T.D% Pantalla Ambiente de HavocOS 4.X
SET app=com.custom.ambient.display
%C.FS% %app% >nul 2>nul
%C.DK% %app% >nul 2>nul

::-------------------------------------------------- MOTO STOCK G7 POWER & HANOIP APPS
:G7Stock
%.%
%.%
%.%
%.%
%.%
%CatCut%
echo MOTO APPS - Para Stock ROM Moto G7 Power (Android 10), Stock ROM Moto G60 (Android 12) Y ROMS Con Moto Apps.
%CatCut%
echo %Q.U% Apps Moto?
%QYN%
	if ERRORLEVEL 2 goto ExtremeDebloat
	if ERRORLEVEL 1 goto G7StockMotoCam

:G7StockMotoCam
%.%
%LineCut%
echo %Q.U% Moto Camera 2?
echo (i) Algunas ROMs la incluyen, como LineageOS desde 19.1+
%QYN%
	if ERRORLEVEL 2 goto G60MotoCam
	if ERRORLEVEL 1 goto G7StockMotoCam1

:G7StockMotoCam1
echo %T.U% Moto Camera 2
SET app=com.motorola.camera2
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Optimizador de la camara Moto 2
SET app=com.motorola.imagertuning_lake
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.camera2.tunner
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:G60MotoCam
%.%
%LineCut%
echo %Q.U% Moto Camera 3?
%QYN%
	if ERRORLEVEL 2 goto G7StockWallPicker
	if ERRORLEVEL 1 goto G60MotoCam1

:G60MotoCam1
echo %T.U% Moto Camera 3
SET app=com.motorola.camera2
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Optimizador de la camara
SET app=com.motorola.imagertuning_V2
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% IA de la camara
SET app=com.motorola.camera3.content.ai
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:G7StockWallPicker
%.%
%LineCut%
echo %Q.U% Fondos de pantalla y Estilos?
echo ADVERTENCIA: Escoga "Y" si estas en Stock Ocean. Escoga "N" si estas en una custom ROM o Stock Hanoip.
%QYN%
	if ERRORLEVEL 2 goto G7StockActions
	if ERRORLEVEL 1 goto G7StockWallPicker1

:G7StockWallPicker1
echo %T.U% Fondos de pantalla y Estilos
SET app=com.android.wallpaper
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Estilos y fondos de pantalla
SET app=com.google.android.apps.wallpaper
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:G7StockActions
%.%
%LineCut%
echo %Q.U% Acciones Moto?
%QYN%
	if ERRORLEVEL 2 goto G60GameTime
	if ERRORLEVEL 1 goto G7StockActions1

:G7StockActions1
echo %T.U% Moto App
SET app=com.motorola.moto
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Acciones Moto
SET app=com.motorola.actions
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Servidor del sistema Moto
SET app=com.motorola.systemserver
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Ajustes de Motorola
SET app=com.motorola.coresettingsext
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:G60GameTime
%.%
%LineCut%
echo %Q.U% Moto Game Time?
echo (i) No funcionara sin las acciones moto
%QYN%
	if ERRORLEVEL 2 goto G7StockMotoDisplay
	if ERRORLEVEL 1 goto G60GameTime1

:G60GameTime1
echo %T.U% Moto GameTime
SET app=com.motorola.gamemode
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:G7StockMotoDisplay
%.%
%LineCut%
echo %Q.U% Pantalla Moto?
echo (i) No funcionara correctamente sin las acciones moto
%QYN%
	if ERRORLEVEL 2 goto G60Vol
	if ERRORLEVEL 1 goto G7StockMotoDisplay1

:G7StockMotoDisplay1
echo %T.U% Pantalla Moto
SET app=com.motorola.motodisplay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:G60Vol
%.%
%LineCut%
echo %Q.U% Volumen Multitarea?
echo (i) No funcionara correctamente sin las acciones moto
%QYN%
	if ERRORLEVEL 2 goto G60ForeCast
	if ERRORLEVEL 1 goto G60Vol1

:G60Vol1
echo %T.U% Volumen Multitarea
SET app=com.motorola.dynamicvolume
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:G60ForeCast
%.%
%LineCut%
echo %Q.U% Desempeno Moto?
echo (i) Funcion para precargar apps freecuentes en cache
%QYN%
	if ERRORLEVEL 2 goto G7StockTrash
	if ERRORLEVEL 1 goto G60ForeCast1

:G60ForeCast1
echo %T.U% Desempeno Moto (Funcion para precargar en cache apps que se usan con frecuencia)
SET app=com.motorola.appforecast
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:G7StockTrash
%.%
%LineCut%
echo %T.U% Moto signature (Paquetes de motorola que permite instalar apps de moto, aun puedes
echo hacerlo con el paquete eliminado)
SET app=com.motorola.motosignature.app
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.motosignature2.app
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Acceso para el operador Moto
SET app=com.motorola.nfwlocationattribution
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Servicios preinstalados de Facebook
SET app=com.facebook.appmanager
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.facebook.services
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.facebook.system
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Lenovo ID
SET app=com.lenovo.lsf.user
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% y %T.D% Modo Demostracion
SET app=com.motorola.demo
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Efectos de audio
SET app=com.motorola.audiofx
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.demo.env
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

echo %T.U% Prefijo Facil
SET app=com.motorola.easyprefix
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Moto Email
SET app=com.motorola.email
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Moto Live Wallpaper 3
SET app=com.motorola.livewallpaper3
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% RadioFM UI
SET app=com.motorola.fmplayer
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Ayuda del dispositivo
SET app=com.motorola.genie
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.help
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Moto Setup Wizard (Creo)
SET app=com.motorola.setup
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Moto RadioFM
SET app=com.motorola.android.fmradio
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

echo %T.U% Tutorial de navegacion por gestos
SET app=com.motorola.gesture
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Desbloqueo Facial
SET app=com.motorola.faceunlock
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Actualizaciones del sistema
SET app=com.motorola.ccc.ota
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Editor de capturas de pantalla (Sigue funcionando aun eliminado)
SET app=com.motorola.screenshoteditor
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Navegacion con un boton de Motorola
SET app=com.android.internal.systemui.navbar.softonenav
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Configuracion de escritorio de la camara
SET app=com.motorola.motcameradesktop
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Editor de fotos Moto
SET app=com.motorola.photoeditor
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Moto Intelligence
SET app=com.motorola.motointelligence
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.motointelligence.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Tutorial Motorola
SET app=com.motorola.mototour
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Moto Ready For
SET app=com.motorola.mobiledesktop
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- MYUi GLobal
echo %T.U% Apps y paquetes restantes...
SET app=android.autoinstalls.config.motorola.layout
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=cci.usage
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.amazon.appmanager
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.providers.chromehomepage
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.att.phone.extensions
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.attvowifi
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.brapps
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.ccc.devicemanagement
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.ccc.notification
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.comcast.settings.extensions
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.comcastext
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.contacts.preloadcontacts
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.hiddenmenuapp
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.motocit
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.omadm.vzw
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.programmenu
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.orange.update
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.verizon.loginengine.unbranded
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.vzw.apnlib
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=de.telekom.tsc
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.provisioning
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.vzw.apnservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.lmi.motorola.rescuesecurity
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.jvtcmd
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.android.nativedropboxagent
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.appdirectedsmsproxy
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.bach.modemstats
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.bug2go
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.callredirectionservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.carriersettingsext
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.ccc.mainplm
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.config.wifi
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.lifetimedata
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.motocare
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.motocare.internal
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.omadm.service
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.paks
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.pgmsystem2
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.slpc_sys
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.vzw.pco.extensions.pcoreceiver
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.qualcomm.atfwd
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qualcomm.embms
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qualcomm.qti.uim
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.VirtualUiccPayment
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=vendor.qti.iwlan
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.invisiblenet
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.entitlement
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qualcomm.wfd.service
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.wifi.motowifimetrics
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.launcherconfig
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

SET app=com.motorola.telprov
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.revoker.services
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.hotwordenrollment.okgoogle
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.hotwordenrollment.xgoogle
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.help.extlog
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.motolights
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.leanbacklauncher
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.smart5g
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.securevault
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.securityhub
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.spaces
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.aura.oobe.motorola
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.audiorecorder
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.overlay.crystaltalkai
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.discovery
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.overlay.googleasi
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.setup.auto_generated_rro_vendor__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.setup.overlay.gabuttonrighttop
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qualcomm.qti.remoteSimlockAuth
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qualcomm.qti.xrvd.service
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.overlay.gmsconfig.personalsafety
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.safetycenter.resources
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.safetycenter.resources.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.launcherconfig.overlay.tundra
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.coresettingsext.overlay.tundra
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.actions.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- MYUi China
echo %T.U% Apps y paquetes restantes de MYUi China...
SET app=com.qualcomm.simcontacts
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.tencent.soter.soterserver
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.wapi.wapicertmanage
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.ifaa.aidl.manager
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qualcomm.qti.dynamicddsservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qualcomm.qti.uimGbaApp
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.providers.settings.resources.overlay.NfcPrcWalletOverlayProduct
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.traceur.auto_generated_rro_product__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.wifi.resources.overlay.WifiResOnlyForPrc
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:: SET app=com.baidu.map.location
:: %C.FS% %app% >nul 2>nul
:: %C.CP% %app% >nul 2>nul
:: %C.U% %app% >nul 2>nul

SET app=com.cmcc.csserver
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.cmcc.csu
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.cmcc.gbaserver
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.carrier.prc.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.overlay.gmsconfig.china
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.lenovo.leos.cloud.sync
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.lenovo.leos.cloud.sync.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.lenovo.lsf
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.lenovo.lsf.device
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.actions.overlayprc
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.adaptivebrightness
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.airgesture
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.airgesture.incall
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.coresettingsext.overlay.doubletap
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.launcher.overlay.china
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.networkstack.overlay.retcn
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.overlay.china
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.overlay.livewallpapers.alloy_drift
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.providers.settings.overlay.china
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.settings.overlay.prc.wallet
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.systemui.overlay.cmcc
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.systemui.overlay.ctcn
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.systemui.overlay.cucn
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.systemui.overlay.retcn
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.deskclock
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.devicemigration
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.emergency
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.emergency.auto_generated_rro_product__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.gallery
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.nfcagent
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.prcactivation
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.prcactivation.auto_generated_rro_product__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.prcsettingsext
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.searchintelligence
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.setupwizard
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.smartservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.cn.trip
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.dciservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.enterprise.service
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.hce
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.launcher.iconpack.moto
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.livewallpaper3.prebuilt.chroma_plume
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.livewallpaper3.prebuilt.sunlit_smile
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.livewallpaper3.prebuilt.titan
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.myscreen
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.overlay.voicetranslation
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qualcomm.qti.xrcb
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qualcomm.qtil.btdsda
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.ted.number
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.zui.antitheft
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.zui.deviceidservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.zui.filemanager
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.zui.sdac
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.zui.xlog
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.coresettingsext.overlay.prc
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.coresettingsext.overlay.rtwo
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.launcher.overlay.animation.scale
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.settings.overlay.fps.display
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.android.settings.overlay.prc
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.gesture.overlay.prc
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.moto.overlay.personalizelauncher
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.setup.auto_generated_rro_product__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.setup.auto_generated_rro_vendor__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=vendor.qti.qesdk.sysservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.motorola.deviceshield.engine
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::-------------------------------------------------- EXPERIMENTAL APPS
:ExtremeDebloat
%.%
%.%
%.%
%.%
%.%
%CatCut%
echo EXTREME DEBLOAT, RECOMENDADO SALTAR
%CatCut%
echo (i) Deshabilita y elimina Apps AOSP, LOS y de otras ROMs como la navegacion por 3 botones,
echo     overlays de personalizacion, entre otros.
echo ESCOGA "Y" PARA CONTINUAR, O "N" PARA SALTAR ESTA SECCION.
%QYN%
	if ERRORLEVEL 2 goto ROG7
	if ERRORLEVEL 1 goto ExtremeDebloat3Button

:ExtremeDebloat3Button
%.%
%LineCut%
echo %Q.U% Navegacion de 3 botones?
echo (i) Asegurate de tener habilitado al menos 1 modo de navegacion.
%QYN%
	if ERRORLEVEL 2 goto ExtremeDebloatGestural
	if ERRORLEVEL 1 goto ExtremeDebloat3Button1

:ExtremeDebloat3Button1
echo %T.U% Navegacion de 3 botones.
SET app=com.android.internal.systemui.navbar.threebutton
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:ExtremeDebloatGestural
%.%
%LineCut%
echo %Q.U% Navegacion por gestos?
echo (i) Asegurate de tener habilitado al menos 1 modo de navegacion.
%QYN%
	if ERRORLEVEL 2 goto ExtremeDebloatOverlays
	if ERRORLEVEL 1 goto ExtremeDebloatGestural1

:ExtremeDebloatGestural1
echo 1) %Q.U% Completamente
echo 2) %Q.U% Manteniendo Sensibilidad Minima
%LineSep%
echo (i) Antes de escoger "%Q.U% Manteniendo Sensibilidad Minima" revisa que la sensibilidad de los
echo bordes izquierdo y derecho esten al minimo.
%Q12%
	if ERRORLEVEL 2 goto ExtremeDebloatGesturalMinimal
	if ERRORLEVEL 1 goto ExtremeDebloatGesturalAll

:ExtremeDebloatGesturalAll
SET app=com.android.internal.systemui.navbar.gestural
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:ExtremeDebloatGesturalMinimal
SET app=com.android.internal.systemui.navbar.gestural_extra_wide_back
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.internal.systemui.navbar.gestural_narrow_back
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.internal.systemui.navbar.gestural_wide_back
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::-------------------------------------------------- OVERLAYS VARIOS
:ExtremeDebloatOverlays
%.%
%LineCut%
echo %Q.U% Overlays varios?
echo (i) Overlays de personalizacion como el tema oscuro amoled, formas de iconos, fuentes y emulaciones
echo     de cortes de pantalla. Los paquetes fueron recopilados de Stock A10, LineageOS 20, HavocOS 4.X
echo     y CrDroid 9.5.
%QYN%
	if ERRORLEVEL 2 goto ExtremeDebloatStuff
	if ERRORLEVEL 1 goto ExtremeDebloatOverlays1

:ExtremeDebloatOverlays1
::----- ICON SHAPES
echo %T.U% Fomas de iconos
SET app=com.android.theme.icon.pebble
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.roundedrect
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.square
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.squircle
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.taperedrect
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.teardrop
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.vessel
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.heart
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=id.vern.shape.sammy
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.cloudy
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.cylinder
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.flower
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.hexagon
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.leaf
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.meow
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.roundedhexagon
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.stretched
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon.round
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- ICON PACKS
echo %T.U% Paquetes de iconos
SET app=com.android.theme.icon_pack.circular.android
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.circular.launcher
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.circular.settings
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.circular.systemui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.circular.themepicker
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.filled.android
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.filled.launcher
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.filled.settings
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.filled.systemui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.filled.themepicker
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.kai.android
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.kai.launcher
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.kai.settings
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.kai.systemui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.kai.themepicker
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.rounded.android
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.rounded.launcher
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.rounded.settings
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.rounded.systemui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.rounded.themepicker
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.sam.android
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.sam.launcher
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.sam.settings
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.sam.systemui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.sam.themepicker
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.victor.android
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.victor.launcher
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.victor.settings
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.victor.systemui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.victor.themepicker
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.acherus.android
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.acherus.systemui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.oos.android
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.oos.launcher
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.oos.settings
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.oos.systemui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.oos.themepicker
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.outline.android
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.outline.settings
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.outline.systemui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.pui.android
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.pui.launcher
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.pui.settings
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.pui.systemui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.icon_pack.pui.themepicker
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% MYUi Moto Adaptive Icons
SET app=com.motorola.launcher.iconpack.motoadaptive
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- TEMAS DE NAVBAR
echo %T.U% Temas para la navegacion de 3 botones
SET app=com.android.system.navbar.android
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.system.navbar.asus
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.system.navbar.dora
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul
SET app=com.android.system.navbar.moto
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.system.navbar.nexus
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.system.navbar.old
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.system.navbar.oneplus
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.system.navbar.oneui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.system.navbar.sammy
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.system.navbar.tecno
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.system.navbar.black
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- COLORES DE ACENTO
echo %T.U% Colores de acento (Android 10 y 11)
SET app=com.android.theme.color.amber
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.amethyst
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.aquamarine
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.black
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.bluegray
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.candyred
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.carbon
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.cinnamon
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.cyan
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.ddaygreen
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.flatpink
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.frenchbleu
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.green
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.heirloombleu
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.holillusion
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.illusionspurple
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.indigo
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.lightpurple
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.mint
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.obfusbleu
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.ocean
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.oneplusred
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.orchid
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.palette
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.pink
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.purple
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.qgreen
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.red
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.sand
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.seasidemint
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.space
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.tangerine
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.teal
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.violet
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.warmthorange
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.yellow
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.cherry
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.darklake
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.magentahaze
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.parasailing
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.saffron
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.overlay.accent.black
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.overlay.accent.blue
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.overlay.accent.brown
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.overlay.accent.cyan
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.overlay.accent.green
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.overlay.accent.orange
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.overlay.accent.pink
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.overlay.accent.purple
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.overlay.accent.red
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.overlay.accent.yellow
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.color.pixelblue
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- ICONOS DE SENAL
echo %T.U% Iconos de Senal Movil
SET app=com.android.systemui.signalbar_a
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.signalbar_b
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.signalbar_c
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.signalbar_d
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.crdroid.systemui.signalbar_e
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.signalbar_f
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.signalbar_g
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.signalbar_h
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.signalbar_j
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- ICONOS DE WIFI
echo %T.U% Iconos de WiFi
SET app=com.android.systemui.wifibar_a
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.wifibar_b
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.wifibar_c
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.wifibar_d
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.wifibar_e
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.wifibar_f
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.wifibar_g
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.wifibar_h
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.wifibar_i
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.systemui.wifibar_j
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- FUENTES
echo %T.U% Fuentes adicionales
SET app=org.lineageos.overlay.font.lato
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.notoserifsource
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.overlay.font.rubik
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.arbutussource
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.arvolato
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.kai
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.rubikrubik
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.sam
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.victor
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.accuratist
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.aclonica
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.amarante
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.bariol
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.cagliostro
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.cocon
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.comfortaa
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.comicsans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.cookierun
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.coolstory
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.exotwo
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.fifa2018
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.googlesans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.grandhotel
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.harmonysans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.lato
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.lgsmartgothic
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.linotte
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.nokiapure
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.nothingdot
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.nothingdotheadline
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.nunito
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.oneplussans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.oneplusslate
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.oswald
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.quando
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.redressed
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.reemkufi
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.robotocondensed
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.rosemary
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.rubik
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.samsungone
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.sonysketch
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.storopia
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.surfer
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.ubuntu
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.ralewaysource
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.googlesanslato
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.slateforoneplus
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.ArchivoSemiBold
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.RobotoSlabRegular
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.RookeryRegular
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.antipastopro
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.cooljazz
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.customizesource
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.evolvesans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.Exo2Regular
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.fluidsans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.fucek
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.hanyiqiheisource
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.inter
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.jtleonor
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.lemonmilk
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.manrope
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.misans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.oduda
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.oneuisans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.opposans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.pangyaersource
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.productsansvh
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.roboto
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.sanfrancisco
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.simpleday
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.font.zhongsongsource
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- FUENTES DE LA PANTALLA DE BLOQUEO
echo %T.U% Fuentes de la pantalla de bloqueo de Android 13+
SET app=com.android.theme.lockscreen_clock_font.accuratist
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.aclonica
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.amarante
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.bariol
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.cagliostro
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.cocon
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.comfortaa
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.comicsans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.cookierun
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.coolstory
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.exotwo
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.fifa2018
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.googlesans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.grandhotel
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.harmonysans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.lato
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.lgsmartgothic
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.linotte
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.nokiapure
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.nothingdotheadline
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.nunito
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.oneplussans
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.oneplusslate
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.oswald
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.quando
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.redressed
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.reemkufi
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.robotocondensed
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.rosemary
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.rubik
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.samsungone
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.sonysketch
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.storopia
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.surfer
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.theme.lockscreen_clock_font.ubuntu
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- INMERSIVE GESTURES
echo %T.U% opcion para ocultar la pildora de navegacion en LineageOS
SET app=org.lineageos.overlay.customization.navbar.nohint
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% opcion para ocultar la pildora de navegacion en ROMs
SET app=com.android.internal.systemui.navbar.nohint
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% opcion para ocultar la pildora de navegacion en Motorola Stock
SET app=com.android.internal.systemui.navbar.hidegestural
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- CUTOUTS
echo %T.U% Emulaciones de cortes de pantalla
SET app=com.android.internal.display.cutout.emulation.tall
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.internal.display.cutout.emulation.waterfall
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.internal.display.cutout.emulation.corner
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.internal.display.cutout.emulation.hole
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.internal.display.cutout.emulation.double
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.internal.display.cutout.emulation.noCutout
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.internal.display.cutout.emulation.avoidAppsInCutout
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.arrow.overlay.hidecutout
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- DARK THEME OVERLAYS
echo %T.U% Temas del Modo Oscuro
SET app=com.android.dark.bakedgreen
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.bakedgreenExt
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.chocox
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.chocoxExt
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.clearspring
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.clearspringExt
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.darkaubergine
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.darkaubergineExt
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.darkgray
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.darkgrayExt
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.materialocean
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.materialoceanExt
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.night
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.nightExt
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.ravenblack
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.ravenblackExt
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.solarizeddark
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.solarizeddarkExt
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.style
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.dark.styleExt
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::----- OTHER OVERLAYS
echo %T.U% Tema Oscuro Amoled de LOS
SET app=org.lineageos.overlay.customization.blacktheme
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Tema Oscuro Amoled de CrDroid
SET app=com.android.system.theme.black
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Menu de personalizacion de HavocOS 4.X
SET app=com.android.customization.stub
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Menu de personalizacion de ArrowOS
SET app=org.arrowos.customisation
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Tamanos de la Pildora de navegacion
SET app=com.android.internal.systemui.navbar.gestural.long
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.internal.systemui.navbar.gestural.medium
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.custom.overlay.systemui.gestural.hidden
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.custom.overlay.systemui.gestural.long
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.custom.overlay.systemui.gestural.medium
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:ExtremeDebloatStuff
%.%
%LineCut%
echo %T.U% Navegacion de 2 botones.
SET app=com.android.internal.systemui.navbar.twobutton
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.D% Lineage Themes Legacy (A13 QPR1-)
SET app=org.lineageos.customization
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

echo %T.D% AOSP Themes
SET app=com.android.customization.themes
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.D% %app% >nul 2>nul

echo %T.U% LineageOS Profiles
SET app=org.lineageos.profiles
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Proton AOSP Device Config
SET app=org.protonaosp.deviceconfig
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.protonaosp.deviceconfig.auto_generated_rro_product__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

echo %T.U% Apps y paquetes restantes de ROMs...
SET app=com.android.emergency.auto_generated_rro_product__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.imsserviceentitlement.auto_generated_rro_product__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.inputmethod.latin.auto_generated_rro_product__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.android.camera2.auto_generated_rro_product__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.setupwizard.auto_generated_rro_product__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=org.lineageos.snap.auto_generated_rro_vendor__
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.arrow.overlay.statusbarstock
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::-------------------------------------------------- ROG Apps
:ROG7
%.%
%LineCut%
echo %Q.U% Apps de Asus ROG Phone 7?
echo (i) Esto es una version incial sin preguntas, debloteara por completo tu ROG Phone 7.
echo     Proximamente se iran añadiendo apartados para poder escoger que eliminar.
%QYN%
	if ERRORLEVEL 2 goto Fin
	if ERRORLEVEL 1 goto ROG7_Updater

:ROG7_Updater
%.%
%LineCut%
echo %Q.U% Actualizador del sistema?
echo (i) No podras actualizar ni por OTA ni de forma manual.
%QYN%
	if ERRORLEVEL 2 goto ROG7_1
	if ERRORLEVEL 1 goto ROG7_Updater1

:ROG7_Updater1
echo %T.U% Actualizador del sistema.
SET app=com.asus.appupdater
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.dm
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

:ROG7_1
echo %T.U% Apps de Asus, esto puede tomar tiempo.
SET app=com.asus.ia.asusapp
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.soundrecorder
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.dsi.ant.server
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qti.snapdragon.qdcm_ff
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qualcomm.qti.devicestatisticsservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.alwayson
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ar.welcome
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.asusbacktap
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.asusoptiflex
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.asussettingsbackuphelper
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.audiowizard
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.auraaoaclient
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.cellbroadcastreceiver.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.cellbroadcastservice.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.configupdater
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ephotoburst
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.faceunlockservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.filemanager
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.gallery
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.gmotion
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.hbm
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.imagesearch
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.benchmarkblocker
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.brightnessservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.evtlog
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.extdispctrl
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.misc
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.observer
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.packageinstallerproxy
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.pointerproxy
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.rogafkservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.rogproxy
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.smartread
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.twinapps
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.watermark
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.inadvertentTouch
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.key_status
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.launcher.twinviewmode
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.livedemo
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.livedemoservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.livewallpaper.customizelivewallpaper
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.livewallpaper.rog7.bionicconsciousness
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.livewallpaper.rog7.darkmatterflow
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.loguploader
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.loguploaderproxy
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.nextapp
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.nextappcore
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.openbeta2
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.sarprotection
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.seconddisplayeditor
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.setupwizard
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.smartreading
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.splendid
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.stitchimage.service
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.sysmonitor
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.taskwidget
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.theme.color.asusui
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.theme.color.rog
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.themeapp
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.themepromotion
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.tips
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.twinapps
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.twinappsservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.visualmaster
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.zenmotion
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.dirac.acs
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.futuredial.asusdatatransfer
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.futuredial.asuslocalbackup
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.overlay.gmsconfig.asi
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.overlay.gmsconfig.geotz
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.tetheringentitlement
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.monotype.android.font.felbridge
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.monotype.android.font.manroperegular
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.monotype.android.font.rajdhanimedium
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.monotype.android.font.syndor
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qti.qcc
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=android.autoinstalls.config.asus.pai
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.alwayson.res.overlay
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.wifiperfservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.qti.slaservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.asus.ims.asusoptiflexservice
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.overlay.gmsconfig.nosafetycenter
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

SET app=com.google.android.overlay.gmsconfig.searchselector
%C.FS% %app% >nul 2>nul
%C.CP% %app% >nul 2>nul
%C.U% %app% >nul 2>nul

::-------------------------------------------------- FIN
:Fin
%.%
%.%
%.%
%.%
%.%
%CatCut%
echo Hemos terminado, reiniciar tu dispositivo es opcional.
echo Recuerda que puedes reinstalar una app desde Play Store, con su APK o usando la opcion "restaurar".
%CatCut%

::----- Force Stop Moto Desktop SystemUI
SET app=com.motorola.systemui.desk
%C.FS% %app% >nul 2>nul

echo Desea reiniciar su dispositivo?
%QYN%
	if ERRORLEVEL 2 goto No
	if ERRORLEVEL 1 goto Yes

:Yes
echo Reiniciando dispositivo...
adb wait-for-device reboot

:No
SET GB=::
cls
%LineCut%
echo Que desea hacer?
echo 1) Reiniciar el bat.
echo 2) Salir.
echo 3) Salir y detener ADB.
%Q13%
	if ERRORLEVEL 3 goto Exit2
	if ERRORLEVEL 2 goto Exit
	if ERRORLEVEL 1 goto Start

:Exit
cls
COLOR 0A
%GB%
echo Listo. Presiona cualquier tecla para cerrar esta ventana.
pause >nul
exit

:Exit2
cls
COLOR 0A
%GB%
echo Deteniendo ADB Server.
adb kill-server
echo Listo. Presiona cualquier tecla para cerrar esta ventana.
pause >nul
exit

:Changelog
cls
COLOR 09
%CatCut%
echo 	 	 	 	 	CHANGELOG
echo [v1-v4]
echo 	- Archivo de texto normal, se fueron anadiendo los comandos de las apps a eliminar
echo 	usando de referencia la aplicacion UAD (Universal Android Debloater) y eliminando de a
echo 	poco las apps incluidas en varias ROMs.
%.%
echo [v5]
echo 	- Migracion a formato .bat.
%.%
echo [v5.1]
echo 	- Adicion de Seedvault.
echo 	- Habilitacion de eliminacion de apps AOSP basicas.
%.%
echo [v5.2]
echo 	- Adicion de este changelog.
echo 	- Adicion de selector de opciones (Y/N) para preguntarle al usuario si quiere eliminar
echo 	determinados conjuntos de apps (Por ejemplo las AOSP basicas por si se van a instalar
echo 	las apps de Google).
%.%
echo [5.2.1]
echo 	- Adicion de MatLog.
echo 	- Adicion de Lineage SetupWizard.
echo 	- Adicion opcional de Moto Camera 2.
echo 	- Correccion de errores (se me olvido descomentar comandos de algunas apps xd).
%.%
echo [5.2.2]
echo 	- Adicion de comentarios en los comandos.
echo 	- Adicion de Exchange Services y Google Markup.
echo 	- Adicion opcional de Selector de fondos de pantalla animados.
echo 	- Eliminacion opcional de VPN Dialogs.
%.%
echo [5.2.3]
echo 	- Adicion de ManagedProvisioning.
echo 	- Adicion de MusicFX.
echo 	- Adicion de advertencias para ciertas ROMs.
%.%
echo [5.3]
echo 	- Cambios en la info sobre VPN Dialogs.
echo 	- Ahora el bat detiene las apps antes de eliminarlas.
echo 	- Ahora no se muestra la salida de los comandos.
echo 	- Adicion de la leyendas "Eliminando", "listo" u otras en ciertos puntos.
echo 	- Eliminacion opcional del SetupWizard AOSP, LineageOS y de Google.
%.%
echo [5.3.1]
echo 	- Ahora se deshabilitan en vez de desinstalar ciertos paquetes (Sospecho que las apps
echo 	que generan datos persistentes aun despues de borrarlos lagean el dispositivo al
echo 	querer generarlos una vez desinstaladas pero sin tener exito, deshabilitadas generan
echo 	los datos y ahi se mantienen).
echo 	- Adicion de eliminacion de personalizacion de LineageOS.
echo 	- Adicion de AOSP Experimental.
%.%
echo [5.3.2]
echo 	- Correcciones menores en el bat.
%.%
echo [5.4]
echo 	- Cambios masivos en el codigo del bat.
echo 	- Ahora el bat borra los datos de la aplicaion antes de desinstalar/deshabiblitar.
echo 	- Nuevas variables para Desinstalar/Deshabilitar/Reinstalar paquetes (El usuario
echo 	ahora puede escoger al comienzo del bat lo que quiere hacer).
echo 	- Este changelog ahora es visible durante la ejecucion del bat.
%.%
echo [5.4.1]
echo 	- Adicion de Calendario AOSP y Google Gallery Go.
%.%
echo [5.4.2]
echo 	- Eliminacion opcional para Reloj AOSP.
%.%
echo [5.4.3]
echo 	- Eliminacion opcional para Calendario Etar y Calculadora AOSP.
echo 	- Adicion de eliminacion de paquetes extras de LineageOS en seccion Experimental.
%.%
echo [5.4.4]
echo 	- Adicion de Camara de LineageOS 20 (Aperture).
%.%
echo [5.5] - THE NEW ORDER UPDATE
echo 	- Eliminacion opcional de navegacion por 3 botones y por gestos en seccion experimental.
echo 	- Ahora se limpia la consola en puntos especificos.
echo 	- Mejor orden en los comandos y secciones.
echo 	- Seccion "Experimental" ahora se llama "Extreme Debloat".
echo 	- Fusion de las secciones "Lineage Apps" y "Extra ROMs Apps".
echo 	- Adicion de Apps y Overlays de HavocOS 4.X.
echo 	- Ahora las actualizaciones grandes tendran nombre.
%.%
echo [5.5.1]
echo 	- Adicion de CrDroid Music
echo 	- Adicion de eliminacion de overlays extras de CrDroid 9.5 en ExtremeDebloat.
%.%
echo [5.5.2]
echo 	- Adicion opcional de Chaldeaprjkt GameSpace.
%.%
echo [5.5.3]
echo 	- Adicion de paquetes faltantes de ROM Stock Ocean.
%.%
echo [5.5.4]
echo 	- Adicion opcional de Game Mode de HavocOS.
echo 	- Adicion opcional de Sugerencias de configuracion.
echo 	- Adicion de Android AOSP Shared Library.
echo 	- Adicion de paquetes faltantes de AOSP.
echo 	- Adicion de Camera Moto Tunner.
echo 	- Detener ADB al finalizar ahora es opcional.
echo 	- Mejor separacion entre preguntas.
%.%
echo [5.6] - THE BETTER SCRIPT UPDATE
echo 	- Cambios menores en el codigo del bat.
echo 	- Uso de variables para divisores, preguntas y otras cosas.
echo 	- Finalmente ya no se muestran los errores de ADB cuando una app no se encuentra o
echo 	esta protegida.
echo 	- Ya no se limpia la consola tan seguido debido al cambio de arriba :D
echo 	- Ahora la fuente se muestra de color celeste, un gran cambio.jpg
%.%
echo [5.6.1] - THE BETTER SCRIPT UPDATE - PART 2 -
echo 	- Ya no se borran los datos de la pantalla ambiente de HavocOS 4.X para evitar que se
echo 	vuelva a activar.
echo 	- Adicion de informacion de la pantalla ambiente de HavocOS 4.X en problemas conocidos.
echo 	- Se renombraron las variables importantes por algo mas entendible.
echo 	(Porque luego se me olvidaba que variable hacia que jajajaja)
echo 	- Ahora el bat te muestra un aviso y no te permite continuar con la ejecucion si:
echo 	ADB no se encuentra en el sistema/el bat no esta en la misma carpeta que platform-tools.
echo 	- Ahora la fuente cambia a color verde claro cuando el bat finalizo.
echo 	- Ahora la fuente cambia a color rojo claro cuando no se encuentra ADB.
echo 	- Ahora la fuente cambia a color amarillo claro en la ventana de problemas conocidos.
echo 	- Ahora la fuente cambia a color azul claro en este changelog.
echo 	- Se cambio el color de la fuente general de celeste a celeste claro.
echo 	- Adicion de una opcion para mostrar la ventana de error cuando no se encuentra ADB.
echo 	- Adicion de otra variable de linea divisora mas pequena.
echo 	- Cambios menores en el apartado de despedida cuando el usuario desea salir/no hay ADB.
echo 	- Cambios menores en el apartado de problemas conocidos.
echo 	- Adicion de separacion extra entre versiones del changelog.
%.%
echo [5.6.2]
echo 	- Corregido bug que no permitia desinstalar algunos Overlays en ExtremeDebloat.
echo 	- Eliminada la opcion test para mostrar la ventana de error cuando no se encuentra ADB.
%.%
echo [5.6.3]
echo 	- Adicion de colores de acento de LineageOS 18.1.
echo 	- Adicion de LineageOS Profiles en ExtremeDebloat.
echo 	- Adicion opcional de LineageOS Updater (y ROMs que usen el mismo nombre de paquete).
echo 	- Adicion opcional de los Gestos Moto (LineageOS Settings Device).
echo 	- Adicion de Proton Device Config en ExtremeDebloat (La mayoria de ROMs lo tienen).
echo 	- Adicion de paquetes extras de ArrowOS 11.
echo 	- Adicion de paquetes extras de LineageOS 20 QPR3 (12 Agosto 2023).
echo 	- Adicion de Qualcomm WFD Service.
echo 	- Correcciones menores en el bat.
%.%
echo [5.6.4]
echo 	- Ahora se deshabilitan RadioFM, WallpaperBackup y LOS Gestos moto en vez de
echo 	desinstalar para evitar problemas (Siempre intentan generar datos, vease el primer
echo 	cambio de la version 5.3.1).
%.%
echo [5.6.5]
echo 	- Ahora se deshabilitan algunas apps de HavocOS 4.13 y Ocean Stock para evitar el
echo 	problema mencionado en la version anterior.
echo 	- Correcciones menores en el bat.
%.%
echo [5.7] - #HanoipSupremacy
echo 	- Adicion de RadioFM CAF de Hanoip en LOS 20.
echo 	- Eliminacion opcional de NFC.
echo 	- Eliminacion opcional de Updaters de ROMs.
%.%
echo [5.7.1]
echo 	- Adicion de paquetes extra de Google incluidos en Stock ROM de Hanoip.
echo 	- Adicion de paquetes extra de Motorola incluidos en Stock ROM de Hanoip.
echo 	- Eliminacion opcional de Acciones Moto y Pantalla Moto.
echo 	- Adicion opcional de Moto GameTime.
%.%
echo [5.7.2]
echo 	- Adicion de mas paquetes extra de Motorola y Google incluidos en Stock ROM de Hanoip.
echo 	- Adiciom opcional de Volumen Multitarea de Moto.
echo 	- Adicion opcional de Desempeno Moto (Funcion que precarga apps frecuentes en cache).
echo 	- Adicion opcional de Camara Moto 3.
echo 	- Eliminacion opcional de algunas apps de Google.
%.%
echo [5.7.3]
echo 	- Eliminado Moto Desktop SystemUI debido a problemas con el QS en modo horizontal.
%.%
echo [5.7.4]
echo 	- Eliminacion opcional de CodeAurora IMS.
%.%
echo [5.7.5]
echo 	- Adicion de paquetes extra de Motorola incluidos en MYUi 5 (Android 13).
echo 	- Eliminacion opcional de Ajustes de Motorola (Ahora incluido en seccion de gestos Moto).
echo 	- Cambios menores en bat.
echo 	- Adicion de paquetes extra de Motorola incluidos en MYUi 5 China (Android 13).
echo 	- Ahora se fuerza detencion a Moto Desktop SystemUI para solucionar un bug con el QS en
echo 	modo horizontal.
%.%
echo [5.7.6]
echo 	- Adicion de mas paquetes extras de Motorola Hanoip Stock ROM, MYUi 5 Global y China.
%.%
echo [5.8] - ROG Phone 7 Initial Integration
echo	- Adicion de paquetes de Asus ROG Phone 7. Fase inicial, sin opciones de eliminacion.
%CatCut%
echo Presiona cualquier tecla para regresar a la pregunta anterior...
pause >nul
goto Start