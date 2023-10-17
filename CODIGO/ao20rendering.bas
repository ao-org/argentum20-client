Attribute VB_Name = "ao20rendering"
'    Argentum 20 - Game Client Program
'    Copyright (C) 2022 - Noland Studios
'
'    This program is free software: you can redistribute it and/or modify
'    it under the terms of the GNU Affero General Public License as published by
'    the Free Software Foundation, either version 3 of the License, or
'    (at your option) any later version.
'
'    This program is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'    GNU Affero General Public License for more details.
'    You should have received a copy of the GNU Affero General Public License
'    along with this program.  If not, see <https://www.gnu.org/licenses/>.
'
'
Option Explicit

Public renderer                         As clsRenderer

Public Function GetWavFilesPath() As String
    GetWavFilesPath = App.path & "\..\Recursos"
End Function

Public Function GetMp3FilesPath() As String
    GetMp3FilesPath = App.path & "\MP3\"
End Function

Public Function GetMidiFilesPath() As String
    GetMidiFilesPath = GetWavFilesPath
End Function


