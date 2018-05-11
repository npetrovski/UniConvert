!define PRODUCT_NAME "UniConvert"
!define PRODUCT_VERSION "1.0.0"
!define PRODUCT_PUBLISHER "Nikolay Petrovski"
!define RELEASE_BIN "..\bin\Release"
!define ARGS_STACK_END "."


Name "${PRODUCT_NAME}"
Caption "${PRODUCT_NAME} ${PRODUCT_VERSION} Setup"
OutFile "${PRODUCT_NAME}-${PRODUCT_VERSION}-setup.exe"
BrandingText " "

InstallDir $PROGRAMFILES32\UniConvert

RequestExecutionLevel admin

!include nsDialogs.nsh
!include LogicLib.nsh
!include "MUI2.nsh"

#!include "PageFileExtensions.nsh"

!define MUI_ICON "..\icon2.ico"
!define MUI_HEADERIMAGE 0
!define MUI_HEADERIMAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Header\orange.bmp" ; optional
!define MUI_ABORTWARNING

; Install pages
#!define MUI_COMPONENTSPAGE_NODESC 1
#!define MUI_COMPONENTSPAGE_TEXT_TOP "Select the embroidery file extensions you want to add in the context menu"
#!define MUI_COMPONENTSPAGE_TEXT_COMPLIST "Select file types"
#!define MUI_COMPONENTSPAGE_TEXT_INSTTYPE ""
#!define MUI_COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Desciption"
#!define MUI_COMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "${PRODUCT_NAME} will add a short-cut to explorer context menu"
#
#!insertmacro MUI_PAGE_COMPONENTS

!insertmacro MUI_PAGE_WELCOME 
!insertmacro MUI_PAGE_LICENSE "..\license.txt"
#!insertmacro CUSTOM_PAGE_FILEEXTENSIONS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

  
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"


Function RegisterContextMenu

	SetRegView 64

	begin:
		ClearErrors
		Exch $R0
		Pop $0
		StrCmp $R0 `${ARGS_STACK_END}` end do
		IfErrors end
	do:
		DetailPrint $R0
		#WriteRegExpandStr HKCR "SystemFileAssociations\.$R0\shell\${PRODUCT_NAME}" "" "Convert to Unicode"
		#WriteRegExpandStr HKCR "SystemFileAssociations\.$R0\shell\${PRODUCT_NAME}" "Position" "Top"
		#WriteRegExpandStr HKCR "SystemFileAssociations\.$R0\shell\${PRODUCT_NAME}" "Icon" '"$INSTDIR\UniConvert.exe"'
		#WriteRegExpandStr HKCR "SystemFileAssociations\.$R0\shell\${PRODUCT_NAME}\command" "" '"$INSTDIR\UniConvert.exe" "%1"'
		
		WriteRegExpandStr HKCR "SystemFileAssociations\.$R0\shell\${PRODUCT_NAME}.SubCommands" "MUIVerb" "Convert to"
		WriteRegExpandStr HKCR "SystemFileAssociations\.$R0\shell\${PRODUCT_NAME}.SubCommands" "Position" "Top"
		WriteRegExpandStr HKCR "SystemFileAssociations\.$R0\shell\${PRODUCT_NAME}.SubCommands" "Icon" '"$INSTDIR\UniConvert.exe"'
		WriteRegExpandStr HKCR "SystemFileAssociations\.$R0\shell\${PRODUCT_NAME}.SubCommands" "SubCommands" "${PRODUCT_NAME}.UNICODE;|;${PRODUCT_NAME}.UTF8;${PRODUCT_NAME}.UTF16;${PRODUCT_NAME}.UTF32;${PRODUCT_NAME}.Windows1250;${PRODUCT_NAME}.Windows1251;${PRODUCT_NAME}.Windows1252;${PRODUCT_NAME}.ISO8859.1;${PRODUCT_NAME}.ASCII;${PRODUCT_NAME}.KOI8U;${PRODUCT_NAME}.KOI8R;${PRODUCT_NAME}.MORE"
		Goto begin
	end:
	
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.UNICODE" "" "Unicode"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.UNICODE\command" "" '"$INSTDIR\UniConvert.exe" "%1"'	
	
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.UTF8" "" "UTF-8"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.UTF8\command" "" '"$INSTDIR\UniConvert.exe" "utf-8" "%1"'		
	
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.UTF16" "" "UTF-16"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.UTF16\command" "" '"$INSTDIR\UniConvert.exe" "utf-16" "%1"'		
	
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.UTF32" "" "UTF-32"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.UTF32\command" "" '"$INSTDIR\UniConvert.exe" "utf-32" "%1"'
	
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.Windows1250" "" "Windows-1250"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.Windows1250\command" "" '"$INSTDIR\UniConvert.exe" "windows-1250" "%1"'
		
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.Windows1251" "" "Windows-1251"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.Windows1251\command" "" '"$INSTDIR\UniConvert.exe" "windows-1251" "%1"'
		
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.Windows1252" "" "Windows-1252"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.Windows1252\command" "" '"$INSTDIR\UniConvert.exe" "windows-1252" "%1"'
	
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.ISO8859.1" "" "ISO-8859-1"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.ISO8859.1\command" "" '"$INSTDIR\UniConvert.exe" "iso-8859-1" "%1"'
	
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.ASCII" "" "US-ASCII"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.ASCII\command" "" '"$INSTDIR\UniConvert.exe" "us-ascii" "%1"'
	
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.KOI8U" "" "KOI8-U"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.KOI8U\command" "" '"$INSTDIR\UniConvert.exe" "koi8-u" "%1"'
	
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.KOI8R" "" "KOI8-R"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.KOI8R\command" "" '"$INSTDIR\UniConvert.exe" "koi8-r" "%1"'
	
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.MORE" "" "More..."
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.MORE\command" "" '"$INSTDIR\UniConvert.exe" "unknown" "%1"'

FunctionEnd


Function un.RegisterContextMenu

	SetRegView 64
	
	DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.UTF8"
	DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.UTF16"
	DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.UTF32"
	DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.Windows1251"
	DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.ISO8859.1"
	DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\${PRODUCT_NAME}.ASCII"
		
	begin:
		ClearErrors
		Exch $R0
		Pop $0
		StrCmp $R0 `${ARGS_STACK_END}` end do
		IfErrors end
	do:
		#DeleteRegKey HKCR "SystemFileAssociations\.$R0\shell\${PRODUCT_NAME}"
		DeleteRegKey HKCR "SystemFileAssociations\.$R0\shell\${PRODUCT_NAME}.SubCommands"
		Goto begin
	end:
FunctionEnd


Function RegisterWindowsUninstaller

	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayName" "${PRODUCT_NAME}"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayVersion" "${PRODUCT_VERSION}"
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "UninstallString" '"$INSTDIR\uninstall.exe"'
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayIcon" '"$INSTDIR\UniConvert.exe"'
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "InstallLocation" '"$INSTDIR"'
	WriteRegExpandStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "Publisher" "${PRODUCT_PUBLISHER}"
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "EstimatedSize" 0x00000212
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "NoModify" 0x00000001
	WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "NoRepair" 0x00000001

FunctionEnd


Function un.RegisterWindowsUninstaller

	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
	
FunctionEnd


Section

	SetOutPath $INSTDIR
	SetOverwrite try

	File ${RELEASE_BIN}\UdeDll.dll
	File ${RELEASE_BIN}\UniConvert.exe

	WriteUninstaller $INSTDIR\uninstall.exe
		
	
SectionEnd


Section -Post

	Call RegisterWindowsUninstaller
	
	Push `${ARGS_STACK_END}`
	Push "txt"
	Push "sub"
	Push "srt"
	Call RegisterContextMenu
	
SectionEnd



# Uninstaller
 
#Function un.onInit
#	SetShellVarContext all
# 
#	#Verify the uninstaller - last chance to back out
#	MessageBox MB_OKCANCEL "Permanantly remove ${PRODUCT_NAME} ${PRODUCT_VERSION}?" IDOK next
#		Abort
#	next:
#	
#FunctionEnd

Section "uninstall"
 
	Delete $INSTDIR\uninstall.exe
	Delete $INSTDIR\UdeDll.dll
	Delete $INSTDIR\UniConvert.exe
	
	rmDir $INSTDIR
	
	Call un.RegisterWindowsUninstaller
	
	Push `${ARGS_STACK_END}`
	Push "txt"
	Push "sub"
	Push "srt"
	Call un.RegisterContextMenu
 
SectionEnd