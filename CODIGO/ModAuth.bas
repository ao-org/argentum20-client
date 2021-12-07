Attribute VB_Name = "ModAuth"
Option Explicit

Public Enum e_state
    Idle = 0
    RequestAccountLogin
    AccountLogged
    RequestCharList
    RequestLogout
End Enum

Public SessionOpened As Boolean

Public Auth_state As e_state
Public public_key() As Byte
Public encrypted_session_token As String


Public Sub AuthSocket_DataArrival(ByVal bytesTotal As Long)

    If Not SessionOpened Then
        Call HandleOpenSession(bytesTotal)
        If SessionOpened And Auth_state = e_state.RequestAccountLogin Then
            Call SendAccountLoginRequest
        End If
        Exit Sub
    End If
    
    Select Case Auth_state
        Case e_state.RequestAccountLogin
            Call HandleAccountLogin(bytesTotal)
        Case e_state.RequestCharList
            Call HandlePCList(bytesTotal)
        Case e_state.RequestLogout
            Call HandleLogOutRequest(bytesTotal)
    End Select
    
End Sub

Public Sub OpenSessionRequest()
    
    SessionOpened = False
    
    Dim arr(0 To 3) As Byte
    arr(0) = &H0
    arr(1) = &HAA
    arr(2) = &H0
    arr(3) = &H4
    Call frmConnect.AuthSocket.SendData(arr)
    
End Sub
Public Sub DebugPrint(ByVal str As String, Optional ByVal int1 As Integer = 0, Optional ByVal int2 As Integer = 0, Optional ByVal int3 As Integer = 0, Optional ByVal asd As Boolean = False)

    Debug.Print (str)
    
End Sub

Public Sub SendAccountLoginRequest()
    Dim username As String
    Dim password As String
    Dim len_encrypted_username As Integer
    Dim len_encrypted_password As Integer
    
    Dim login_request() As Byte
    Dim packet_size As Integer
    Dim offset_login_request As Long
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    Call DebugPrint("SendAccountLoginRequest", 255, 255, 255, True)
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    username = CuentaEmail
    password = CuentaPassword
    
    Dim encrypted_username() As Byte
    Dim encrypted_username_b64 As String
    
    Dim encrypted_password() As Byte
    Dim encrypted_password_b64 As String
    
    
    encrypted_username_b64 = AO20CryptoSysWrapper.Encrypt(cnvHexStrFromBytes(public_key), username)
    encrypted_password_b64 = AO20CryptoSysWrapper.Encrypt(cnvHexStrFromBytes(public_key), password)
    
    'Call DebugPrint("Username: " & encrypted_username_b64, 255, 255, 255)
    'Call DebugPrint("Password: " & encrypted_password_b64, 255, 255, 255)
    
    Call Str2ByteArr(encrypted_username_b64, encrypted_username)
    Call Str2ByteArr(encrypted_password_b64, encrypted_password)
    
    
    Dim len_username As Integer
    Dim len_password As Integer
    
    len_username = Len(encrypted_username_b64)
    len_password = Len(encrypted_password_b64)
    
    ReDim login_request(1 To (2 + 2 + 2 + len_username + 2 + len_password))
    
    packet_size = UBound(login_request)
    
    login_request(1) = &HDE
    login_request(2) = &HAD
    
    'Siguientes 2 bytes indican tamaño total del paquete
    login_request(3) = hiByte(packet_size)
    login_request(4) = LoByte(packet_size)
    
    'Los siguientes 2 bytes son el SIZE_ENCRYPTED_USER
    login_request(5) = hiByte(len_username)
    login_request(6) = LoByte(len_username)
    Call AO20CryptoSysWrapper.CopyBytes(encrypted_username, login_request, len_username, 7)
    
    offset_login_request = 7 + UBound(encrypted_username)
        
    login_request(offset_login_request + 1) = hiByte(len_password)
    login_request(offset_login_request + 2) = LoByte(len_password)
    
    Call AO20CryptoSysWrapper.CopyBytes(encrypted_password, login_request, len_password, offset_login_request + 3)
    
    Call frmConnect.AuthSocket.SendData(login_request)
    
    Auth_state = e_state.RequestAccountLogin
    
End Sub

Public Sub LogOutRequest()
    
    Dim logout_request() As Byte
    Dim packet_size As Integer
    
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    Call DebugPrint("LogOutRequest", 255, 255, 255, True)
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    
    ReDim logout_request(1 To (4 + Len(encrypted_session_token)))
    
    packet_size = UBound(logout_request)
    
    logout_request(1) = &H1
    logout_request(2) = &H1
    
    'Siguientes 2 bytes indican tamaño total del paquete
    logout_request(3) = hiByte(packet_size)
    logout_request(4) = LoByte(packet_size)
    Dim encrypted_session_token_byte() As Byte
    Call Str2ByteArr(encrypted_session_token, encrypted_session_token_byte)
    Call AO20CryptoSysWrapper.CopyBytes(encrypted_session_token_byte, logout_request, Len(encrypted_session_token), 5)
    
    Call frmConnect.AuthSocket.SendData(logout_request)
    
    Auth_state = e_state.RequestLogout
    
End Sub
Public Sub HandleLogOutRequest(ByVal bytesTotal As Long)
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    Call DebugPrint("HandleLogOutRequest", 255, 255, 255, True)
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    
    Dim data() As Byte
    
    frmConnect.AuthSocket.PeekData data, vbByte, bytesTotal
    
    frmConnect.AuthSocket.GetData data, vbByte, 2
    
    If data(0) = &H20 And data(1) = &H22 Then
        Call DebugPrint("LOGOUT_OKAY", 0, 255, 0, True)
        
        frmConnect.AuthSocket.GetData data, vbByte, 2
        
        Auth_state = e_state.Idle
    Else
       Call DebugPrint("ERROR", 255, 0, 0, True)
        frmConnect.AuthSocket.GetData data, vbByte, 4
        Select Case MakeInt(data(3), data(2))
            Case 41
                Call DebugPrint("Not logged yet.", 255, 255, 0)
        End Select
    End If
    Auth_state = e_state.Idle
End Sub

Public Sub PCListRequest()
    Dim username As String
    Dim len_encrypted_username As Integer
    
    Dim packet_request() As Byte
    Dim charList_request() As Byte
    Dim offset_login_request As Long
    Dim packet_size As Integer
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    Call DebugPrint("PCListRequest", 255, 255, 255, True)
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    username = CuentaEmail
    
    Dim encrypted_username() As Byte
    Dim encrypted_username_b64 As String
    
    
    encrypted_username_b64 = AO20CryptoSysWrapper.Encrypt(cnvHexStrFromBytes(public_key), username)
    
    Call Str2ByteArr(encrypted_username_b64, encrypted_username)
    
    
    Dim len_username As Integer
    
    len_username = Len(encrypted_username_b64)
    
    ReDim charList_request(1 To (2 + 2 + len_username))
    
    packet_size = UBound(charList_request)
    
    charList_request(1) = &H1
    charList_request(2) = &H2
    
    'Siguientes 2 bytes indican tamaño total del paquete
    charList_request(3) = hiByte(packet_size)
    charList_request(4) = LoByte(packet_size)
    
    Call AO20CryptoSysWrapper.CopyBytes(encrypted_username, charList_request, len_username, 5)
        
    Call frmConnect.AuthSocket.SendData(charList_request)
    
    Auth_state = e_state.RequestCharList
    
End Sub
Public Sub connectToLoginServer(Optional ByVal state As e_state)

    frmConnect.AuthSocket.Close
    frmConnect.AuthSocket.RemoteHost = IPdelServidorLogin
    frmConnect.AuthSocket.RemotePort = PuertoDelServidorLogin
    frmConnect.AuthSocket.Connect
    SessionOpened = False
    Auth_state = e_state.Idle
End Sub



Public Sub HandleOpenSession(ByVal bytesTotal As Long)
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    Call DebugPrint("HandleOpenSession", 255, 255, 255, True)
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    Dim strData As String
    frmConnect.AuthSocket.PeekData strData, vbString, bytesTotal
    Call DebugPrint("Bytes total: " & strData, 255, 255, 255, False)
    
    frmConnect.AuthSocket.GetData strData, vbString, 2
    Call DebugPrint("Id: " & strData, 255, 255, 255, False)
    
    frmConnect.AuthSocket.GetData strData, vbString, 2
    
    Dim encrypted_token() As Byte
    Dim secret_key_byte() As Byte
    
    frmConnect.AuthSocket.GetData encrypted_token, 64
            
    Call Str2ByteArr("pablomarquezARG1", secret_key_byte)
    Dim decrypted_session_token As String
     
    decrypted_session_token = AO20CryptoSysWrapper.Decrypt("7061626C6F6D61727175657A41524731", cnvStringFromHexStr(cnvToHex(encrypted_token)))
    Call DebugPrint("Decripted_session_token: " & decrypted_session_token, 255, 255, 255, False)
        
    public_key = mid(decrypted_session_token, 1, 16)
    
    Call DebugPrint("Public key:" & CStr(public_key), 255, 255, 255, False)
    
    Str2ByteArr decrypted_session_token, public_key, 16
    
    SessionOpened = True
    encrypted_session_token = cnvStringFromHexStr(cnvToHex(encrypted_token))
End Sub

Public Sub HandlePCList(ByVal bytesTotal As Long)

    If bytesTotal < 4 Then
        Call DebugPrint("Paquete incorrecto", 255, 255, 255, True)
        Exit Sub
    End If
    
    Dim packet_size_byte() As Byte
    Dim PacketId() As Byte
    
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    Call DebugPrint("HandlePCList", 255, 255, 255, True)
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    Dim strData As String
    frmConnect.AuthSocket.PeekData strData, vbString, bytesTotal
    Call DebugPrint("Bytes total: " & strData, 255, 255, 255, False)
    
    frmConnect.AuthSocket.GetData PacketId, vbByte, 2
    Call DebugPrint("Id: " & ByteArrayToHex(PacketId), 255, 255, 255, False)
    
    frmConnect.AuthSocket.GetData packet_size_byte, vbByte, 2
    
    Dim encrypted_list() As Byte
    Dim packet_size As Integer
    
    packet_size = MakeInt(packet_size_byte(1), packet_size_byte(0))
    frmConnect.AuthSocket.GetData encrypted_list, packet_size - 4
        
    'Call Str2ByteArr("pablomarquezARG1", secret_key_byte)
    Dim decrypted_list As String
     
    decrypted_list = AO20CryptoSysWrapper.Decrypt(ByteArrayToHex(public_key), cnvStringFromHexStr(cnvToHex(encrypted_list)))
    Call FillAccountData(decrypted_list)
    Call DebugPrint("Decrypted_list: " & decrypted_list, 255, 255, 255, False)
            
    Auth_state = e_state.AccountLogged
End Sub
Public Sub HandleAccountLogin(ByVal bytesTotal As Long)

    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    Call DebugPrint("HandleRequestAccountLogin", 255, 255, 255, True)
    Call DebugPrint("------------------------------------", 0, 255, 0, True)
    Dim data() As Byte
    
    frmConnect.AuthSocket.PeekData data, vbByte, bytesTotal
    
    frmConnect.AuthSocket.GetData data, vbByte, 2
    
    If data(0) = &HAF And data(1) = &HA1 Then
        Call DebugPrint("LOGIN-OK", 0, 255, 0, True)
        Call DebugPrint(AO20CryptoSysWrapper.ByteArrayToHex(data), 255, 255, 255)
        frmConnect.AuthSocket.GetData data, vbByte, 2
        
        Auth_state = e_state.AccountLogged
        Call PCListRequest
    Else
       Call DebugPrint("ERROR", 255, 0, 0, True)
        frmConnect.AuthSocket.GetData data, vbByte, 4
        Select Case MakeInt(data(3), data(2))
            Case 1
                Call DebugPrint("Invalid Username", 255, 0, 0)
            Case 4
                Call DebugPrint("Username is already logged.", 255, 255, 0)
                If Not FullLogout Then
                    Call SendAccountLoginRequest
                Else
                    Call LogOutRequest
                End If
            Case 5
                Call DebugPrint("Password is incorrect.", 255, 255, 0)
            Case 6
                Call DebugPrint("Username has been banned.", 255, 0, 0)
            Case 7
                Call DebugPrint("Ther server has reached the max. number of users.", 255, 0, 0)
            Case 9
                Call DebugPrint("The account has not been activated.", 255, 255, 0)
            Case Else
                Call DebugPrint("Unknown error: " & AO20CryptoSysWrapper.ByteArrayToHex(data), 255, 255, 0)
        End Select
    End If
        
End Sub


Function FileToString(strFileName As String) As String
  Open strFileName For Input As #1
    FileToString = StrConv(InputB(LOF(1), 1), vbUnicode)
  Close #1
End Function

Private Sub FillAccountData(ByVal data As String)
  
    Dim i As Long
    Dim cantidadPersonajes As Long
    cantidadPersonajes = 0
    For i = 1 To Len(data)
        If mid(data, i, 1) = "(" Then
            cantidadPersonajes = cantidadPersonajes + 1
        End If
    Next i

    Dim ii As Byte
     'name, head_id, class_id, body_id, pos_map, pos_x, pos_y, level, status, helmet_id, shield_id, weapon_id, guild_index, is_dead, is_sailing
    For ii = 1 To cantidadPersonajes
        Pjs(ii).nombre = ""
        Pjs(ii).Head = 0 ' si is_sailing o muerto, cabeza en 0
        Pjs(ii).Clase = 0
        Pjs(ii).Body = 0
        Pjs(ii).Mapa = 0
        Pjs(ii).posX = 0
        Pjs(ii).posY = 0
        Pjs(ii).nivel = 0
        Pjs(ii).Criminal = 0
        Pjs(ii).Casco = 0
        Pjs(ii).Escudo = 0
        Pjs(ii).Arma = 0
        Pjs(ii).ClanName = ""
        Pjs(ii).NameMapa = ""
    Next ii

    For ii = 1 To cantidadPersonajes
        Dim character As String
        character = ReadField(ii, data, Asc(")"))
        character = Replace(character, "(", "")
        character = Replace(character, "[", "")
        character = Replace(character, "]", "")
        character = Replace(character, "'", "")
        If mid(character, 1, 1) = "," Then
            character = mid(character, 2)
        End If
        
         Pjs(ii).nombre = ReadField(1, character, Asc(","))
        Pjs(ii).Head = Val(ReadField(2, character, Asc(",")))
        Pjs(ii).Clase = Val(ReadField(3, character, Asc(",")))
        Pjs(ii).Body = Val(ReadField(4, character, Asc(",")))
        Pjs(ii).Mapa = Val(ReadField(5, character, Asc(",")))
        Pjs(ii).posX = Val(ReadField(6, character, Asc(",")))
        Pjs(ii).posY = Val(ReadField(7, character, Asc(",")))
        Pjs(ii).nivel = Val(ReadField(8, character, Asc(",")))
        Pjs(ii).Criminal = Val(ReadField(9, character, Asc(",")))
        Pjs(ii).Casco = Val(ReadField(10, character, Asc(",")))
        Pjs(ii).Escudo = Val(ReadField(11, character, Asc(",")))
        Pjs(ii).Arma = Val(ReadField(12, character, Asc(",")))
        Pjs(ii).ClanName = "<" & "pepito" & ">"
       
        ' Pjs(ii).NameMapa = Pjs(ii).mapa
       ' Pjs(ii).NameMapa = NameMaps(Pjs(ii).Mapa).Name

    Next ii


    For i = 1 To cantidadPersonajes

        Select Case Pjs(i).Criminal

            Case 0 'Criminal
                Call SetRGBA(Pjs(i).LetraColor, ColoresPJ(50).r, ColoresPJ(50).G, ColoresPJ(50).B)
                Pjs(i).priv = 0

            Case 1 'Ciudadano
                Call SetRGBA(Pjs(i).LetraColor, ColoresPJ(49).r, ColoresPJ(49).G, ColoresPJ(49).B)
                Pjs(i).priv = 0

            Case 2 'Caos
                Call SetRGBA(Pjs(i).LetraColor, ColoresPJ(6).r, ColoresPJ(6).G, ColoresPJ(6).B)
                Pjs(i).priv = 0

            Case 3 'Armada
                Call SetRGBA(Pjs(i).LetraColor, ColoresPJ(8).r, ColoresPJ(8).G, ColoresPJ(8).B)
                Pjs(i).priv = 0

            Case 4 'EsConsejero
                Call SetRGBA(Pjs(i).LetraColor, ColoresPJ(1).r, ColoresPJ(1).G, ColoresPJ(1).B)
                Pjs(i).ClanName = "<Game Master>"
                Pjs(i).priv = 1
                EsGM = True

            Case 5 ' EsSemiDios
                Call SetRGBA(Pjs(i).LetraColor, ColoresPJ(2).r, ColoresPJ(2).G, ColoresPJ(2).B)
                Pjs(i).ClanName = "<Game Master>"
                Pjs(i).priv = 2
                EsGM = True

            Case 6 ' EsDios
                Call SetRGBA(Pjs(i).LetraColor, ColoresPJ(3).r, ColoresPJ(3).G, ColoresPJ(3).B)
                Pjs(i).ClanName = "<Game Master>"
                Pjs(i).priv = 3
                EsGM = True

            Case 7 ' EsAdmin
                Call SetRGBA(Pjs(i).LetraColor, ColoresPJ(4).r, ColoresPJ(4).G, ColoresPJ(4).B)
                Pjs(i).ClanName = "<Game Master>"
                Pjs(i).priv = 4
                EsGM = True

            Case Else

        End Select

    Next i
    
    AlphaRenderCuenta = MAX_ALPHA_RENDER_CUENTA
   
    If cantidadPersonajes > 0 Then
        PJSeleccionado = 1
        LastPJSeleccionado = 1
        
        If Pjs(1).Mapa <> 0 Then
            Call SwitchMap(Pjs(1).Mapa)
            RenderCuenta_PosX = Pjs(1).posX
            RenderCuenta_PosY = Pjs(1).posY
        End If
    End If
    
    Call mostrarcuenta
    

End Sub

Public Sub mostrarcuenta()
     
    ' FrmCuenta.Show
    AlphaNiebla = 30
    frmConnect.Visible = True
    QueRender = 2
    
    'UserMap = 323
    
    'Call SwitchMap(UserMap)
    
    SugerenciaAMostrar = RandomNumber(1, NumSug)
        
    ' LogeoAlgunaVez = True
    Call Sound.Sound_Play(192)
    
    Call Sound.Sound_Stop(SND_LLUVIAIN)
    '  Sound.NextMusic = 2
    '  Sound.Fading = 350
      
    Call Graficos_Particulas.Particle_Group_Remove_All
    Call Graficos_Particulas.Engine_Select_Particle_Set(203)
    ParticleLluviaDorada = Graficos_Particulas.General_Particle_Create(208, -1, -1)
    
    frmConnect.relampago.Enabled = False
            
    If FrmLogear.Visible Then
        Unload FrmLogear

        'Unload frmConnect
    End If
    
    If frmMain.Visible Then
        '  frmMain.Visible = False
        
        UserParalizado = False
        UserInmovilizado = False
        UserStopped = False
        
        InvasionActual = 0
        frmMain.Evento.Enabled = False
     
        'BUG CLONES
        Dim i As Integer

        For i = 1 To LastChar
            Call EraseChar(i)
        Next i
        
        frmMain.personaje(1).Visible = False
        frmMain.personaje(2).Visible = False
        frmMain.personaje(3).Visible = False
        frmMain.personaje(4).Visible = False
        frmMain.personaje(5).Visible = False

    End If
End Sub



