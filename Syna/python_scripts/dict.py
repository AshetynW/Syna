import requests
import time
from xml.etree import ElementTree
import win32api
import subprocess
import sys

variable = ""
i = len(sys.argv)
for i in range(len(sys.argv)):
    if i >= 1:
        variable = variable + " " + sys.argv[i]
variable = variable.strip()

wordSearch = str(variable.split("|")[1])
ahkScript = str(variable.split("|")[0])
ahkScript = ahkScript.strip()
wordSearch = wordSearch.strip() 


url = r'http://www.dictionaryapi.com/api/v1/references/collegiate/xml/' + wordSearch + r"?key=b18a248a-0f24-4074-b099-ecbc3395eb7e"

response = requests.get(url)
root = ElementTree.fromstring(response.content)

for ds in root.findall('entry'):
    for dd in ds.findall('def'):
       yourResponseVariable = dd.find('dt').text
       print(dd.find('dt').text)

wordSearch = str(variable.split("|")[1])
ahkScript = str(variable.split("|")[0])
ahkScript = ahkScript.strip()
wordSearch = wordSearch.strip()

subprocess.Popen([r"C:\Program Files\AutoHotkey\AutoHotkey.exe", ahkScript,yourResponseVariable])

quit()

