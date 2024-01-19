# VERSION 5.7.5
Fecha: 18/01/24

# ADB OCEAN & HANOIP DEBLOATER
Este es un bat script para eliminar apps del sistema sin necesidad de tener root o el bootloader desbloqueado.
* Se te preguntará en algunos casos si deseas eliminar una app.

## ¿Qué hace?
Es como deshabilitar apps de forma más agresiva. En Android tu tienes un usuario, entonces la app se "desinstala" para ese usuario.
La app sigue estando en el sistema, puesto que no se pueden borrar sin root o con bootloader bloqueado, pero no se puede ejecutar, ayudando a reducir el uso de recursos y tampoco se puede reinstalar por si sola, solamente puede ser reinstalada desde Play Store o con la opción "Restaurar" incluida en el bat.
* Esto es muy útil si no quieres usar root o si estás en stock con el bootloader cerrado.

## PUEDES VER LOS PROBLEMAS CONOCIDOS Y CAMBIOS EN EL BAT
Por @JosFlix7 para los grupos https://t.me/MotoG7PowerES y https://t.me/MotoG60ES

## MODOS DISPONIBLES
1) Desinstalar Apps
* Sin riesgo de bootloop en Stock A10 de Ocean, Stock A12 de Hanoip, LineageOS 20 y otras ROMs probadas.
2) Deshabilitar Apps
* Menor riesgo de bootloop en otros dispositivos o ROMs.
3) Restaurar Apps
* Deshacer opción 1.
4) Habilitar Apps
* Deshacer opción 2.

## NECESITAS PLATFORM-TOOLS O SIMILARES (TINY FASTBOOT, MINIMAL ADB, ETC.)
Descarga el zip para ADB desde aquí: https://dl.google.com/android/repository/platform-tools-latest-windows.zip
* Mueve el bat dentro de tu carpeta fastboot-tools en caso de no haber configurado platform-tools en las variables de entorno de Windows.