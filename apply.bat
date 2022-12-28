@echo off
title Mod Manager
echo Creating mod...

:: delete old mod
:: del "C:\Users\Kailen\AppData\Roaming\Factorio\mods\intermodal-containers-and-gantry_0.0.0.zip"
:: make zip
"C:\Program Files\7-Zip\7z.exe" a -tzip "C:\Users\Kailen\Documents\Factorio Mods\intermodal-containers-and-gantry_0.0.0.zip" "C:\Users\Kailen\Documents\Factorio Mods\Intermodal Containers and Gantry\intermodal-containers-and-gantry"

echo "Done!"