import requests
import json
import win32api
import subprocess
import sys


variable = ""
i = len(sys.argv)
for i in range(len(sys.argv)):
    if i >= 1:
        variable = variable + " " + sys.argv[i]
variable = variable.strip()

r = requests.get("http://api.openweathermap.org/data/2.5/weather?zip=37777&units=imperial&APPID=a6008f16b466badb6d36aa4534abba03")
data = r.json()
check = data['name']
temps = str(data['main']['temp'])
doop = data['weather'][0]['description']
weatheris = 'The weather is '
degrees = ' degrees with '
weather = weatheris + temps + degrees + doop

ahkScript = str(variable.split("|")[0])
ahkScript = ahkScript.strip()

subprocess.Popen([r"C:\Program Files\AutoHotkey\AutoHotkey.exe", ahkScript,weather])
