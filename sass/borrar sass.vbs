' Script para eliminar archivos .css y .map en el directorio actual para cuando se crean indeseadamente

Option Explicit

Dim objFSO, objFolder, objFile
Dim currentDirectory

' Crear objeto FileSystemObject
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Obtener el directorio actual
currentDirectory = objFSO.GetParentFolderName(WScript.ScriptFullName)

' Obtener la carpeta del directorio actual
Set objFolder = objFSO.GetFolder(currentDirectory)

' Recorrer los archivos en el directorio actual
For Each objFile In objFolder.Files
    If LCase(objFSO.GetExtensionName(objFile.Name)) = "css" Or LCase(objFSO.GetExtensionName(objFile.Name)) = "map" Then
        On Error Resume Next ' Evitar que el script se detenga en caso de error
        objFile.Delete True ' Eliminar el archivo, usar True para forzar la eliminación si es necesario
        If Err.Number = 0 Then
            WScript.Echo "Eliminado: " & objFile.Name
        Else
            WScript.Echo "Error al eliminar: " & objFile.Name & " - " & Err.Description
            Err.Clear
        End If
        On Error GoTo 0 ' Restaurar manejo de errores
    End If
Next

' Liberar objetos
Set objFile = Nothing
Set objFolder = Nothing
Set objFSO = Nothing
