rmdir "C:\Program Files (x86)\National Instruments\LabVIEW 2019\resource\Framework\Providers\LVAPT"
REM mklink /J "C:\Program Files (x86)\National Instruments\LabVIEW 2019\resource\Framework\Providers\SecondaryProviderExample2" "%~dp0SecondaryProviderExample2"
REM mklink /J "C:\Program Files (x86)\National Instruments\LabVIEW 2019\resource\Framework\Providers\PrimaryProviderExample2" "%~dp0PrimaryProviderExample2"
REM mklink /J "C:\Program Files (x86)\National Instruments\LabVIEW 2019\resource\Framework\Providers\DummyPrimaryProvider" "%~dp0DummyPrimaryProvider"

del "C:\Program Files (x86)\National Instruments\LabVIEW 2019\resource\Framework\Providers\GProviders\LVAPT_System.ini"
del "C:\Program Files (x86)\National Instruments\LabVIEW 2019\resource\Framework\Providers\GProviders\LVAPT_Document.ini" 
del "C:\Program Files (x86)\National Instruments\LabVIEW 2019\resource\Framework\Providers\GProviders\LVAPT_VirtualFolder.ini"
del "C:\Program Files (x86)\National Instruments\LabVIEW 2019\resource\Framework\Providers\GProviders\LVAPT_Project.ini"
del "C:\Program Files (x86)\National Instruments\LabVIEW 2019\resource\Framework\Providers\GProviders\LVAPT_Class.ini"
del "C:\Program Files (x86)\National Instruments\LabVIEW 2019\resource\Framework\Providers\GProviders\LVAPT_Git.ini"

rmdir "C:\Program Files (x86)\National Instruments\LabVIEW 2019\resource\Framework\Providers\Icons\fatcow-hosting"
pause