#cs ----------------------------------------------------------------
Name ..........: Schoology Resources
Description ...: Import thin common cartridge (thin cc) files into Schoology resources
AutoIt Version : 3.3.14.5
Author(s) .....: Thomas E. Bennett, Anthony R. Perez
Date ..........: Tue Feb 23 16:18:45 CST 2021

Recommended Reading / Requirements
  * Information: https://www.autoitscript.com/forum/topic/191990-webdriver-udf-w3c-compliant-version-01162021/#comments
  * Information: https://www.autoitscript.com/wiki/WebDriver
  * Information: https://www.autoitscript.com/wiki/WebDriver#Installation
  * Information: https://www.autoitscript.com/wiki/Adding_UDFs_to_AutoIt_and_SciTE
#ce ----------------------------------------------------------------
#include "wd_core.au3"
#include "wd_helper.au3"

Local $sDesiredCapabilities, $sSession, $sPath, $sParams, $sCSV

; Update these values to match your environment.
$sPath = "C:\Users\Thomas\OneDrive - CEV Multimedia\Knowledge\LMS Sharing Resources\include\chromedriver.exe"
$sCSV = "C:\Users\Thomas\OneDrive - CEV Multimedia\Knowledge\LMS Sharing Resources\include\schoology.csv"

Func SetupChrome()
_WD_Option('Driver', $sPath)
_WD_Option('Port', 9515)
_WD_Option('DriverParams', '--verbose --log-path="' & @ScriptDir & '\chrome.log"')

$sDesiredCapabilities = '{"capabilities": {"alwaysMatch": {"goog:chromeOptions": {"w3c": true, "excludeSwitches": [ "enable-automation"], "useAutomationExtension": false }}}}'
EndFunc

SetupChrome()
_WD_Startup()
$sSession = _WD_CreateSession($sDesiredCapabilities)
_WD_Navigate($sSession, "https://www.schoology.com/")
$sElement = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, "//button[contains(text(),'Double-Click Me To See Alert')]")

If @error = $_WD_ERROR_Success Then
    _WD_ElementActionEx($sSession, $sElement, "doubleclick")
EndIf

Sleep(2000)
_WD_Alert($sSession, 'accept')

$sElement = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, "//span[@class='context-menu-one btn btn-neutral']")

If @error = $_WD_ERROR_Success Then
    _WD_ElementActionEx($sSession, $sElement, "rightclick")
EndIf

_WD_DeleteSession($sSession)
_WD_Shutdown()
