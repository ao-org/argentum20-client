Attribute VB_Name = "ModLadder"
'RevolucionAo 1.0
'Pablo Mercavides



Public StopCreandoCuenta As Boolean
Public Const DegreeToRadian As Single = 0.01745329251994 'Pi / 180
Public Const RadianToDegree As Single = 57.2958279087977 '180 / Pi

'Nueva seguridad
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (destination As Any, source As Any, ByVal length As Long)
Private Declare Function GetAdaptersInfo Lib "iphlpapi" (lpAdapterInfo As Any, lpSize As Long) As Long



Private Declare Function GetAsyncKeyState Lib "user32" (ByVal vKey As Long) As Integer
'get mac adress

Public Type Tclan
    nombre As String
    Alineacion As Byte
    indice As Integer
End Type

Public ListaClanes As Boolean
Public ClanesList() As Tclan


Public MacAdress As String
Public HDserial As Long

Public intro As Byte



Public InviCounter As Integer
Public ScrollExpCounter As Long
Public ScrollOroCounter As Long
Public OxigenoCounter As Long
Public DrogaCounter As Integer


'Sistema de mapas
Public PosREAL As Byte
Public Dungeon As Boolean
Public idmap As Integer


Type Effect_Type
     FX_Grh     As grh      '< FxGrh.
     Fx_Index   As Integer  '< Indice del fx.
     ViajeChar  As Integer  '< CharIndex al que viaja.
     DestinoChar As Integer
     Viaje_X    As Integer   '< X hacia donde se dirije.
     End_Effect As Integer  '< Particula De la explosi�n.
     FxEnd_Effect As Integer  '< Particula De la explosi�n.
     End_Loops  As Integer  '< Loops del fx de la explosi�n.
     Viaje_Y    As Integer   '< Y hacia donde se dirije.
     ViajeSpeed As Single   '< Velocidad de viaje.
     Now_Moved  As Long     '< Tiempo del movimiento actual.
     Last_Move  As Long     '< Tiempo del �ltimo movimiento.
     Now_X      As Integer  '< Posici�n X actual
     Now_Y      As Integer  '< Posici�n Y actual
     Slot_Used  As Boolean  '< Si est� usandose este slot.
     wav        As Integer
     DestX As Byte
     DesyY As Byte
End Type
 
Public Const NO_INDEX = -1         '< �ndice no v�lido.
 
Public Effect() As Effect_Type


'Destruccion de items
Public DestItemSlot As Byte
Public DestItemCant As Integer

Public HoraFantasia As Integer

Public Enum FXSound
    Lobo_Sound = 124
    Gallo_Sound = 137
    Dropeo_Sound = 132
    Casamiento_sound = 161
    BARCA_SOUND = 202
    MP_SOUND = 150
End Enum


Public ColorCiego(0 To 3) As Long

Option Explicit


Public Const MAX_CORREOS_SLOTS = 60


Public LastIndex2 As Integer


Public CorreoMsj(1 To MAX_CORREOS_SLOTS) As CorreoMsj


Public ItemLista(1 To 10) As Obj
Public ItemCount As Byte

Public Type CorreoMsj
    Remitente As String
    mensaje As String
    ItemCount As Byte
    ItemArray As String
    Leido As Byte
    Fecha As String
    
End Type
Public TieneFamiliar As Long

Public PetPercExp As Long

Public HayLayer2 As Boolean
Public HayLayer4 As Boolean



'Logros
Public NPcLogros As TLogros
Public UserLogros As TLogros
Public LevelLogros As TLogros

Public MostrarTrofeo As Boolean

Type TLogros
    nombre As String
    desc As String
    cant As Long
    TipoRecompensa As Byte
    ObjRecompensa As String
    OroRecompensa As Long
    ExpRecompensa As Long
    HechizoRecompensa As Byte
    NpcsMatados As Integer
    NivelUser As Byte
    UserMatados As Integer
    Finalizada As Boolean
End Type


Public CantPartLLuvia As Integer
Public MeteoIndex As Integer
'Servidores
Public ChequeandoServidor As Byte
Public CantServer As Byte



'Dropeo
Public CantdPaquetes As Long
Public PingRender As Integer
Public InBytes As Long
Public OutBytes As Long

Public NumOBJs As Integer
Public NumNpcs As Integer
Public NumHechizos As Integer
Public NumLocaleMsg As Integer
Public NumQuest As Integer


Public NumSug As Integer


Public Sugerencia() As String

Public Quest_Name() As String
Public Quest_Desc() As String

Public DESCFINAL() As String
Public NEXTQUEST() As String


Public RequiredLevel() As Integer
Public PosMap() As Integer

Public ObjData() As ObjDatas
Public NpcData() As NpcDatas
Public Locale_SMG() As String
Public WordMapa(1 To 252) As String
Public DungeonData(1 To 252) As String
Public HechizoData() As HechizoDatas
Public NameMaps(1 To 400) As NameMapas



Public ShowMacros As Byte
Public OcultarMacro As Boolean
Public ModoCaminata As Boolean
Public MacrosBloqeados As Boolean


Public Type ObjDatas
    GrhIndex As Long ' Indice del grafico que representa el obj
    name As String
    MinDef As Integer
    MaxDef As Integer
    MinHit As Integer
    MaxHit As Integer
    ObjType As Byte
    Texto As String
    info As String
    CreaGRH As String
    CreaLuz As String
    CreaParticulaPiso As Integer
    proyectil As Byte
    Raices As Integer
    Madera As Integer
    PielLobo As Integer
    PielOsoPardo As Integer
    PielOsoPolar As Integer
    LingH As Integer
    LingP As Integer
    LingO As Integer
    Destruye As Byte
    SkHerreria As Byte
    SkPociones As Byte
    Sksastreria As Byte
    Valor As Long
End Type

Public Type NpcDatas
    name As String
    desc As String
    Body As Integer
    Hp As Long
    exp As Long
    oro As Long
    MinHit As Integer
    MaxHit As Integer
    Head As Integer
    NumQuiza As Byte
    QuizaDropea() As Integer
    ExpClan As Long
    
End Type

Public Type HechizoDatas
    nombre As String ' Indice del grafico que representa el obj
    desc As String
    PalabrasMagicas As String
    HechizeroMsg As String
    TargetMsg As String
    PropioMsg As String
    ManaRequerido As Integer
    MinSkill As Byte
    StaRequerido As Integer
    IconoIndex As Long
End Type

Public Type NameMapas
    name As String ' Indice del grafico que representa el obj
    desc As String
End Type


Public Type SvMsg
    nombre As String ' Indice del grafico que representa el obj
End Type

Public Enum Accion_Barra
    Runa = 1
    Resucitar = 2
    Intermundia = 3
    BattleModo = 4
    GoToPareja = 5
    CancelarAccion = 99
End Enum

Public UserMacro As Macro

Type Macro
    Activado As Boolean
    Intervalo As Integer
    TIPO As Byte
    cantidad As Integer
    Index As Integer
    tX As Byte
    tY As Byte
    Skill As Byte
End Type


Public MouseS As Long
Private Declare Function SystemParametersInfo Lib "user32" Alias _
    "SystemParametersInfoA" (ByVal uAction As Long, ByVal uParam As Long, _
    ByRef lpvParam As Any, ByVal fuWinIni As Long) As Long
 
Private Const SPI_SETMOUSESPEED = 113
Private Const SPI_GETMOUSESPEED = 112
Public Declare Function SwapMouseButton Lib "user32" ( _
    ByVal bSwap As Long) As Long
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Public Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long

Public Type COPYDATASTRUCT
  dwData As Long
  cbData As Long
  lpData As Long
End Type

Public Const WM_COPYDATA = &H4A

Private Declare Function SetTimer Lib "user32" (ByVal hwnd As Long, ByVal nIDEvent As Long, ByVal uElapse As Long, ByVal lpTimerFunc As Long) As Long
Private Declare Function KillTimer Lib "user32" (ByVal hwnd As Long, ByVal nIDEvent As Long) As Long

Private hBuffersTimer As Long


'Compresion
Private Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
Private Const MAX_LENGTH = 512




'Despreciar siempre un poco esto, hacer el intervalo m�s corto
Private Const CONST_INTERVALO_CASTEOMACRO As Long = 1200
Private Const CONST_INTERVALO_CASTEO As Long = 950
Private Const CONST_INTERVALO_ATAQUE As Long = 1200
Private Const CONST_INTERVALO_USAR As Long = 300
Private Const CONST_INTERVALO_USARDESPUESDEATACAR As Long = 350
Private Const CONST_INTERVALO_ANIM As Long = 150
Private Const CONST_INTERVALO_TIRAR As Long = 1200
Private Const CONST_INTERVALO_Conectar As Long = 100
Private Const CONST_INTERVALO_TRABAJAR As Long = 1200
Private Const CONST_INTERVALO_LLAMADACLAN As Long = 5000

Private Const CONST_INTERVALO_COMBO As Long = 450
Private Const CONST_INTERVALO_HEADING As Long = 120


Private Const CONST_INTERVALO_CLICK As Long = 200


Public Intervalos As tIntervalos
Public Type tIntervalos
    Anim As Long
    Ataque As Long
    Uso As Long
    Trabajo As Long
    Hechizo As Long
    tirar As Long
    Conectar As Long
    Subir As Long
    Presentacion As Long
    ComboGolpeMagia As Long
    ComboMagiaGolpe As Long
    Heading As Long
    Click As Long
    LLamadaClan As Long
    HechizoMacro As Long
    UsarDespuesDeAtacar As Long
End Type



Public LogeoAlgunaVez As Boolean
Public Pjs(1 To 10) As UserCuentaPJS
Public RecordarCuenta As Boolean
Public CuentaRecordada As CuentasGuardadas
Public CantidadDePersonajesEnCuenta As Byte

Type UserCuentaPJS
    nombre As String
    nivel As Byte
    mapa As Integer
    Body As Integer
    Head As Integer
    Criminal As Byte
    Clase As Byte
    NameMapa As String
    LetraColor As Long
    Arma As Integer
    Escudo As Integer
    Casco As Integer
    ClanName As String
    priv As Byte
End Type

Type CuentasGuardadas
    nombre As String
    Password As String
End Type

 
Public Type POINTAPI
    X As Long
    Y As Long
End Type
 
Private Type SAFEARRAYBOUND
    cElements As Long
    lLbound As Long
End Type
 
Private Type SAFEARRAY2D
    cDims As Integer
    fFeatures As Integer
    cbElements As Long
    cLocks As Long
    pvData As Long
    Bounds(0 To 1) As SAFEARRAYBOUND
End Type
 
Private Type BITMAP
    bmType As Long
    bmWidth As Long
    bmHeight As Long
    bmWidthBytes As Long
    bmPlanes As Integer
    bmBitsPixel As Integer
    bmBits As Long
End Type
 
Const HTCAPTION = 2
Const WM_NCLBUTTONDOWN = &HA1
Const RGN_OR = 2
 
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function CreateRectRgn Lib "gdi32" (ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long) As Long
Private Declare Function CombineRgn Lib "gdi32" (ByVal hDestRgn As Long, ByVal hSrcRgn1 As Long, ByVal hSrcRgn2 As Long, ByVal nCombineMode As Long) As Long
Private Declare Function GetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long
Private Declare Function SetWindowRgn Lib "user32" (ByVal hwnd As Long, ByVal hRgn As Long, ByVal bRedraw As Long) As Long
Private Declare Function CreatePolygonRgn Lib "gdi32" (lpPoint As POINTAPI, ByVal nCount As Long, ByVal nPolyFillMode As Long) As Long
Private Declare Function CreateEllipticRgn Lib "gdi32" (ByVal x1 As Long, ByVal y1 As Long, ByVal x2 As Long, ByVal y2 As Long) As Long
Private Declare Function GetObjectAPI Lib "gdi32" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, lpObject As Any) As Long
Private Declare Function VarPtrArray Lib "msvbvm50.dll" Alias "VarPtr" (Ptr() As Any) As Long

 
 
Public lRegion As Long
Public Render_Connect_Rect As RECT
Public Render_Main_Rect As RECT



      Public Const SWP_NOMOVE = 2
      Public Const SWP_NOSIZE = 1
      Public Const FLAGSz = SWP_NOMOVE Or SWP_NOSIZE
      Public Const HWND_TOPMOST = -1
      Public Const HWND_NOTOPMOST = -2

      Declare Function SetWindowPos Lib "user32" _
            (ByVal hwnd As Long, _
            ByVal hWndInsertAfter As Long, _
            ByVal X As Long, _
            ByVal Y As Long, _
            ByVal cx As Long, _
            ByVal cy As Long, _
            ByVal wFlags As Long) As Long
            Private Declare Function CreateIconFromResourceEx Lib "user32.dll" (ByRef presbits As Any, ByVal dwResSize As Long, ByVal fIcon As Long, ByVal dwVer As Long, ByVal cxDesired As Long, ByVal cyDesired As Long, ByVal flags As Long) As Long
Private Declare Function OleCreatePictureIndirect Lib "oleaut32.dll" (lpPictDesc As Any, riid As Any, ByVal fPictureOwnsHandle As Long, ipic As IPicture) As Long
Private Declare Function DestroyIcon Lib "user32.dll" (ByVal hIcon As Long) As Long
Public Declare Function DrawIconEx Lib "user32.dll" (ByVal hdc As Long, ByVal xLeft As Long, ByVal yTop As Long, ByVal hIcon As Long, ByVal cxWidth As Long, ByVal cyWidth As Long, ByVal istepIfAniCur As Long, ByVal hbrFlickerFreeDraw As Long, ByVal diFlags As Long) As Long

  
Private Declare Function SendMessageLongRef Lib "user32" _
        Alias "SendMessageA" ( _
        ByVal hwnd As Long, _
        ByVal wMsg As Long, _
        ByVal wParam As Long, _
        ByRef lParam As Long) As Long
  

                           

                           

                           
                           
Private m_ASC As Long
Sub inputbox_Password(El_Form As Form, Caracter As String)
      
    m_ASC = Asc(Caracter)
      
    Call SetTimer(El_Form.hwnd, &H5000&, 100, AddressOf TimerProc)
  
End Sub
  
  
Private Sub TimerProc(ByVal hwnd As Long, ByVal uMsg As Long, ByVal idEvent As Long, _
                                                                ByVal dwTime As Long)
           
    Dim Handle_InputBox As Long
      
    'Captura el handle del textBox del InputBox
    Handle_InputBox = FindWindowEx(FindWindow("#32770", App.title), 0, "Edit", "")
                  
    'Le establece el PasswordChar
    Call SendMessageLongRef(Handle_InputBox, &HCC&, m_ASC, 0)
    'Finaliza el Timer
    Call KillTimer(hwnd, idEvent)
  
End Sub
Public Function LoadPNGtoICO(pngData() As Byte) As IPicture
    
    Dim hIcon As Long
    Dim lpPictDesc(0 To 3) As Long, aGUID(0 To 3) As Long
    
    hIcon = CreateIconFromResourceEx(pngData(0), UBound(pngData) + 1&, 1&, &H30000, 0&, 0&, 0&)
    If hIcon Then
        lpPictDesc(0) = 16&
        lpPictDesc(1) = vbPicTypeIcon
        lpPictDesc(2) = hIcon
        ' IPicture GUID {7BF80980-BF32-101A-8BBB-00AA00300CAB}
        aGUID(0) = &H7BF80980
        aGUID(1) = &H101ABF32
        aGUID(2) = &HAA00BB8B
        aGUID(3) = &HAB0C3000
        ' create stdPicture
        If OleCreatePictureIndirect(lpPictDesc(0), aGUID(0), True, LoadPNGtoICO) Then
            DestroyIcon hIcon
        End If
        
    End If
    
End Function

      Public Function SetTopMostWindow(hwnd As Long, Topmost As Boolean) _
         As Long

         If Topmost = True Then 'Make the window topmost
            SetTopMostWindow = SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, 0, _
               0, FLAGSz)
         Else
            SetTopMostWindow = SetWindowPos(hwnd, HWND_NOTOPMOST, 0, 0, _
               0, 0, FLAGSz)
            SetTopMostWindow = False
         End If
      End Function

Public Sub LogError(desc As String)
On Error GoTo errhandler

Dim nfile As Integer
nfile = FreeFile ' obtenemos un canal
Open App.Path & "\errores.log" For Append Shared As #nfile
Print #nfile, Date & "-" & time & ":" & desc
Close #nfile

Exit Sub


errhandler:

End Sub
Sub IniciarCrearPj()
StopCreandoCuenta = False



frmCrearPersonaje.lbFuerza.Caption = 18
frmCrearPersonaje.lbAgilidad.Caption = 18
frmCrearPersonaje.lbInteligencia.Caption = 18
frmCrearPersonaje.lbConstitucion.Caption = 18
frmCrearPersonaje.lbLagaRulzz.Caption = 0

Dim i As Integer
frmCrearPersonaje.lstProfesion.Clear
For i = LBound(ListaClases) To UBound(ListaClases)
    frmCrearPersonaje.lstProfesion.AddItem ListaClases(i)
Next i




frmCrearPersonaje.lstRaza.Clear

For i = LBound(ListaRazas()) To UBound(ListaRazas())
    frmCrearPersonaje.lstRaza.AddItem ListaRazas(i)
Next i


frmCrearPersonaje.lstProfesion.Clear

For i = LBound(ListaClases()) To UBound(ListaClases())
    frmCrearPersonaje.lstProfesion.AddItem ListaClases(i)
Next i
End Sub
Sub General_Set_Connect()

    UserMap = 1
    AlphaNiebla = 75
    EntradaY = 10
    EntradaX = 10
    If UserMap <> 1 Then
        Call SwitchMapIAO(UserMap)
    End If

            If QueRender <> 1 Then
            frmConnect.Show
           FrmLogear.Show , frmConnect
            FrmLogear.Top = FrmLogear.Top + 3500
            End If
            
            
            intro = 1
    frmmain.Picture = LoadInterface("main.bmp")
    frmmain.panel.Picture = LoadInterface("centroinventario.bmp")
    frmmain.ExpBar.Picture = LoadInterface("barraexperiencia.bmp")
    frmmain.COMIDAsp.Picture = LoadInterface("barradehambre.bmp")
    frmmain.AGUAsp.Picture = LoadInterface("barradesed.bmp")
    frmmain.MANShp.Picture = LoadInterface("barrademana.bmp")
    frmmain.STAShp.Picture = LoadInterface("barradeenergia.bmp")
    frmmain.Hpshp.Picture = LoadInterface("barradevida.bmp")
            
            
            
Sound.Sound_Play CStr(SND_LLUVIAIN), True, 0, 0
AlphaNiebla = 10
engine.Engine_spell_Particle_Set (41)
If intro = 1 Then
engine.Engine_Meteo_Particle_Set (207)
End If

engine.Engine_Select_Particle_Set (203)

Sound.Music_Load 1, Sound.VolumenActualMusicMax
Sound.Music_Play
'Sound.Fading = 600

mFadingMusicMod = 0
CurMp3 = 1


QueRender = 1
'Sound.Sound_Play 650, False, 0, 0

    'frmConnect.Timer1.Enabled = True


 frmConnect.relampago.Enabled = True
'Sound.Sound_Play 404, False, 0, 0   LADDER REVISAR SAQUE TRUENO
 ClickEnAsistente = 0
 If CuentaRecordada.nombre <> "" Then
 
 Call TextoAlAsistente("�Bienvenido de nuevo " & CuentaRecordada.nombre & "! �Disfruta tu viaje por Ao20!") ' hay que poner 20 aniversario
 Else
 Call TextoAlAsistente("�Bienvenido a Ao20! �Ya tenes tu cuenta? Logea! sino, toca sobre Cuenta para crearte una.") ' hay que poner 20 aniversario
 End If
End Sub

 
Public Sub InitializeSurfaceCapture(frm As Form)
    lRegion = CreateRectRgn(0, 0, 0, 0)
    frm.Visible = False
End Sub
 Public Sub Obtener_RGB( _
    ByVal color As Long, _
    Rojo As Byte, _
    Verde As Byte, _
    Azul As Byte)
    
  Azul = (color And 16711680) / 65536
  Verde = (color And 65280) / 256
  Rojo = color And 255
  
End Sub
Public Sub ReleaseSurfaceCapture(frm As Form)
    ApplySurfaceTo frm
    frm.Visible = True
    Call DeleteObject(lRegion)
End Sub
 
Public Sub ApplySurfaceTo(frm As Form)
    Call SetWindowRgn(frm.hwnd, lRegion, True)
End Sub
 
' Create a polygonal region - has to be more than 2 pts (or 4 input values)
Public Sub CreateSurfacefromPoints(ParamArray XY())
    Dim lRegionTemp As Long
    Dim XY2() As POINTAPI
    Dim nIndex As Integer
    Dim nTemp As Integer
    Dim nSize As Integer
    nSize = CInt(UBound(XY) / 2) - 1
    ReDim XY2(nSize + 2)
    nIndex = 0
    For nTemp = 0 To nSize
        XY2(nTemp).X = XY(nIndex)
        nIndex = nIndex + 1
        XY2(nTemp).Y = XY(nIndex)
        nIndex = nIndex + 1
    Next nTemp
    lRegionTemp = CreatePolygonRgn(XY2(0), (UBound(XY2) + 1), 2)
    Call CombineRgn(lRegion, lRegion, lRegionTemp, RGN_OR)
    Call DeleteObject(lRegionTemp)
End Sub
 
' Create a ciruclar/elliptical region
Public Sub CreateSurfacefromEllipse(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer)
    Dim lRegionTemp As Long
    lRegionTemp = CreateEllipticRgn(x1, y1, x2, y2)
    Call CombineRgn(lRegion, lRegion, lRegionTemp, RGN_OR)
    Call DeleteObject(lRegionTemp)
End Sub
 
' Create a rectangular region
Public Sub CreateSurfacefromRect(x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer)
    Dim lRegionTemp As Long
    lRegionTemp = CreateRectRgn(x1, y1, x2, y2)
    Call CombineRgn(lRegion, lRegion, lRegionTemp, RGN_OR)
    Call DeleteObject(lRegionTemp)
End Sub
 
' My best creation (more like tweak) yet! Super fast routines qown j00!
Public Sub CreateSurfacefromMask(Obj As Object, Optional lBackColor As Long)
    ' Insight: Down with getpixel!!
    Dim lReturn   As Long
    Dim lRgnTmp   As Long
    Dim lSkinRgn  As Long
    Dim lStart    As Long
    Dim lRow      As Long
    Dim lCol      As Long
    Dim glHeight  As Integer
    Dim glWidth   As Integer
    Dim pict() As Byte
    Dim pict2() As Byte
    Dim sa As SAFEARRAY2D
    Dim bmp As BITMAP
    GetObjectAPI Obj.Picture, Len(bmp), bmp
    ' Load the bmp into a safearray ptr
    With sa
        .cbElements = 1
        .cDims = 2
        .Bounds(0).lLbound = 0
        .Bounds(0).cElements = bmp.bmHeight
        .Bounds(1).lLbound = 0
        .Bounds(1).cElements = bmp.bmWidthBytes
        .pvData = bmp.bmBits
    End With
    ' Unfortunately this only supports 256 color bmps (damn high bit graphics!!)
    If bmp.bmBitsPixel <> 8 Then
        CreateSurfacefromMask_GetPixel Obj
        Exit Sub
    End If
    CopyMemory ByVal VarPtrArray(pict), VarPtr(sa), 4
    ' Get the dimensions for future reference
    glHeight = UBound(pict, 2)
    glWidth = UBound(pict, 1)
    ' Create an identity array to flip the damn inversed regions
    ReDim pict2(glWidth, glHeight)
    ' Flip em!
    Dim nTempX As Integer
    Dim nTempY As Integer
    For nTempX = glWidth To 0 Step -1
        For nTempY = glHeight To 0 Step -1
            pict2(nTempX, nTempY) = pict(nTempX, glHeight - nTempY)
        Next nTempY
    Next nTempX
    ' Clear the original array
    CopyMemory ByVal VarPtrArray(pict), 0&, 4
    ' Let's make our regions!
    lSkinRgn = CreateRectRgn(0, 0, 0, 0)
    With Obj
        If lBackColor < 1 Then lBackColor = pict2(0, 0)
        For lRow = 0 To glHeight
            lCol = 0
            Do While lCol < glWidth
                Do While lCol < glWidth
                    If pict2(lCol, lRow) = lBackColor Then
                        lCol = lCol + 1
                    Else
                        Exit Do
                    End If
                Loop
                If lCol < glWidth Then
                    lStart = lCol
                    Do While lCol < glWidth
                        If pict2(lCol, lRow) <> lBackColor Then
                            lCol = lCol + 1
                        Else
                            Exit Do
                        End If
                    Loop
                    If lCol > glWidth Then lCol = glWidth
                    lRgnTmp = CreateRectRgn(lStart, lRow, lCol, (lRow + 1))
                    lReturn = CombineRgn(lSkinRgn, lSkinRgn, lRgnTmp, RGN_OR)
                    Call DeleteObject(lRgnTmp)
                End If
            Loop
        Next
    End With
    ' Clear the identity array
    CopyMemory ByVal VarPtrArray(pict2), 0&, 4
    ' Return the f****** fast generated region!
    lReturn = CombineRgn(lRegion, lRegion, lSkinRgn, RGN_OR)
End Sub
 
' XCopied from The Scarms! Felt like my obligation to leave this code intact w/o
' any changes to variables, etc (cept for the sub's name). Thanks d00d!
Public Sub CreateSurfacefromMask_GetPixel(Obj As Object, Optional lBackColor As Long)
    Dim lReturn   As Long
    Dim lRgnTmp   As Long
    Dim lSkinRgn  As Long
    Dim lStart    As Long
    Dim lRow      As Long
    Dim lCol      As Long
    Dim glHeight  As Integer
    Dim glWidth   As Integer
    lSkinRgn = CreateRectRgn(0, 0, 0, 0)
    With Obj
        glHeight = .Height / Screen.TwipsPerPixelY
        glWidth = .Width / Screen.TwipsPerPixelX
        If lBackColor < 1 Then lBackColor = GetPixel(.hdc, 0, 0)
        For lRow = 0 To glHeight - 1
            lCol = 0
            Do While lCol < glWidth
                Do While lCol < glWidth And GetPixel(.hdc, lCol, lRow) = lBackColor
                    lCol = lCol + 1
                Loop
                If lCol < glWidth Then
                    lStart = lCol
                    Do While lCol < glWidth And GetPixel(.hdc, lCol, lRow) <> lBackColor
                        lCol = lCol + 1
                    Loop
                    If lCol > glWidth Then lCol = glWidth
                    lRgnTmp = CreateRectRgn(lStart, lRow, lCol, lRow + 1)
                    lReturn = CombineRgn(lSkinRgn, lSkinRgn, lRgnTmp, RGN_OR)
                    Call DeleteObject(lRgnTmp)
                End If
            Loop
        Next
    End With
    lReturn = CombineRgn(lRegion, lRegion, lSkinRgn, RGN_OR)
End Sub
Public Sub General_Var_Write(ByVal file As String, ByVal Main As String, ByVal Var As String, ByVal value As String)
'*****************************************************************
'Author: Aaron Perkins
'Last Modify Date: 10/07/2002
'Writes a var to a text file
'*****************************************************************
    writeprivateprofilestring Main, Var, value, file
End Sub
Public Sub MensajeAdvertencia(ByVal mensaje As String)
Call MsgBox(mensaje, vbInformation + vbOKOnly, "Advertencia")
End Sub
Public Sub ReproducirMp3(ByVal mp3 As Byte)
If mp3 <> CurMp3 Then
    If mp3 <> 0 Then
        NextMP3 = mp3
        mFadingMusicMod = 0
       ' frmMain.TimerMusica.Enabled = True
    End If
End If
End Sub

Public Sub ForzarMp3(ByVal mp3 As Byte)
If mp3 = 0 Then Exit Sub


mFadingMusicMod = 0
CurMp3 = mp3


End Sub
Public Sub CargarCuentasGuardadas()
    Dim Arch As String
    Arch = App.Path & "\..\Recursos\OUTPUT\" & "raoinit.ini"
    CuentaRecordada.nombre = GetVar(Arch, "CUENTA", "Nombre")
    CuentaRecordada.Password = UnEncryptStr(GetVar(Arch, "CUENTA", "Password"), 9256)
    FrmLogear.Image4.Tag = "0"
 
 If CuentaRecordada.nombre <> "" Then
 FrmLogear.NameTxt = CuentaRecordada.nombre
  FrmLogear.PasswordTxt = CuentaRecordada.Password
         FrmLogear.Image4.Picture = LoadInterface("check-amarillo.bmp")
         FrmLogear.Image4.Tag = "1"
         'FrmLogear.Check1.value = 1
         
        FrmLogear.PasswordTxt.TabIndex = 0
        
        FrmLogear.PasswordTxt.SelStart = Len(FrmLogear.PasswordTxt)
        'FrmLogear.lstServers.TabIndex = 1
        'FrmLogear.cmdConnect.TabIndex = 2
End If
Rem FrmLogear.PasswordTxt = CuentaRecordada(1).Password
End Sub
Public Sub GrabarNuevaCuenta(ByVal name As String, ByVal Password As String)

    Dim Arch As String
    Arch = App.Path & "\..\Recursos\OUTPUT\" & "raoinit.ini"
    Call WriteVar(Arch, "CUENTA", "Nombre", name)
    Call WriteVar(Arch, "CUENTA", "Password", EncryptStr(Password, 9256))
    Call CargarCuentasGuardadas
End Sub
Public Sub ResetearCuentas()
    Dim Arch As String
    Arch = App.Path & "\..\Recursos\OUTPUT\" & "raoinit.ini"
    Call WriteVar(Arch, "CUENTA", "Nombre", "")
    Call WriteVar(Arch, "CUENTA", "Password", "")
    Call CargarCuentasGuardadas
End Sub

Public Sub LoadImpAoInit()

Windows_Temp_Dir = General_Get_Temp_Dir
Dim file As String
file = App.Path & "\..\Recursos\OUTPUT\" & "raoinit.ini"
Dim lC As Integer, tmpStr As String
ServerIndex = Val(GetVar(file, "INIT", "ServerIndex"))

NUMBINDS = Val(GetVar(file, "INIT", "NUMBINDS"))

ACCION1 = Val(GetVar(file, "INIT", "ACCION1"))
ACCION2 = Val(GetVar(file, "INIT", "ACCION2"))
ACCION3 = Val(GetVar(file, "INIT", "ACCION3"))

ReDim Preserve BindKeys(1 To NUMBINDS) As tBindedKey


lC = 0

For lC = 1 To NUMBINDS
    tmpStr = General_Var_Get(file, "USER", str(lC))
    BindKeys(lC).KeyCode = Val(General_Field_Read(1, tmpStr, ","))
    BindKeys(lC).name = General_Field_Read(2, tmpStr, ",")
Next lC



End Sub
Public Sub SaveRAOInit()
Dim lC As Integer, Arch As String
Arch = App.Path & "\..\Recursos\OUTPUT\" & "raoinit.ini"

Call General_Var_Write(Arch, "INIT", "NUMBINDS", Int(NUMBINDS))
Call General_Var_Write(Arch, "INIT", "ServerIndex", Int(ServerIndex))

Call General_Var_Write(Arch, "INIT", "ACCION1", ACCION1)
Call General_Var_Write(Arch, "INIT", "ACCION2", ACCION2)
Call General_Var_Write(Arch, "INIT", "ACCION3", ACCION3)




For lC = 1 To NUMBINDS
    Call General_Var_Write(Arch, "User", str(lC), str(BindKeys(lC).KeyCode) & "," & BindKeys(lC).name)
Next lC

lC = 0

End Sub



'*****************************************************************
'modTimer - ImperiumAO - v1.3.0
'
'Windows API timer functions and handles.
'
'*****************************************************************
'Respective portions copyrighted by contributors listed below.
'
'This library is free software; you can redistribute it and/or
'modify it under the terms of the GNU Lesser General Public
'License as published by the Free Software Foundation version 2.1 of
'the License
'
'This library is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'Lesser General Public License for more details.
'
'You should have received a copy of the GNU Lesser General Public
'License along with this library; if not, write to the Free Software
'Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
'*****************************************************************

'*****************************************************************
'Augusto Jos� Rando (barrin@imperiumao.com.ar)
'   - First Relase
'*****************************************************************




Public Function IntervaloPermiteTrabajar() As Boolean

Dim TActual As Long

TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.Trabajo >= CONST_INTERVALO_TRABAJAR Then
 '   Call AddtoRichTextBox(frmMain.RecTxt, "Trabajar OK.", 255, 0, 0, True, False, False)
    Intervalos.Trabajo = TActual
    IntervaloPermiteTrabajar = True
Else
    IntervaloPermiteTrabajar = False
End If

End Function
Public Function IntervaloPermiteAtacar(Optional ByVal Actualizar As Boolean = True) As Boolean
Dim TActual As Long


TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.Ataque >= CONST_INTERVALO_ATAQUE Then
    If Actualizar Then
        Intervalos.Ataque = TActual
        IntervaloPermiteComboGolpeMagia (True)
        IntervaloPermiteUsarDespuestDeAtacar (True)
    End If
    IntervaloPermiteAtacar = True
Else
    IntervaloPermiteAtacar = False
End If
End Function

Public Function IntervaloPermiteComboGolpeMagia(Optional ByVal Actualizar As Boolean = True) As Boolean
Dim TActual As Long


TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.ComboGolpeMagia >= CONST_INTERVALO_COMBO Then
    If Actualizar Then
        Intervalos.ComboGolpeMagia = TActual
    End If
    IntervaloPermiteComboGolpeMagia = True
    'Call AddtoRichTextBox(frmMain.RecTxt, "Golpe - Magia OK.", 255, 0, 0, True, False, False)
Else
    IntervaloPermiteComboGolpeMagia = False
    'Call AddtoRichTextBox(frmMain.RecTxt, "Golpe - Magia NO.", 255, 0, 0, True, False, False)
End If
End Function
Public Function IntervaloPermiteClick(Optional ByVal Actualizar As Boolean = True) As Boolean
Dim TActual As Long


TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.Click >= CONST_INTERVALO_CLICK Then
    If Actualizar Then
        Intervalos.Click = TActual
    End If
    IntervaloPermiteClick = True
    'Call AddtoRichTextBox(frmMain.RecTxt, "Golpe - Magia OK.", 255, 0, 0, True, False, False)
Else
    IntervaloPermiteClick = False
    'Call AddtoRichTextBox(frmMain.RecTxt, "Golpe - Magia NO.", 255, 0, 0, True, False, False)
End If
End Function
Public Function IntervaloPermiteHeading(Optional ByVal Actualizar As Boolean = True) As Boolean
Dim TActual As Long


TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.Heading >= CONST_INTERVALO_HEADING Then
    If Actualizar Then
        Intervalos.Heading = TActual
    End If
    IntervaloPermiteHeading = True
    'Call AddtoRichTextBox(frmMain.RecTxt, "Golpe - Magia OK.", 255, 0, 0, True, False, False)
Else
    IntervaloPermiteHeading = False
    'Call AddtoRichTextBox(frmMain.RecTxt, "Golpe - Magia NO.", 255, 0, 0, True, False, False)
End If
End Function
Public Function IntervaloPermiteComboMagiaGolpe(Optional ByVal Actualizar As Boolean = True) As Boolean
Dim TActual As Long


TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.ComboMagiaGolpe >= CONST_INTERVALO_COMBO Then
    If Actualizar Then
        Intervalos.ComboMagiaGolpe = TActual
    End If
    IntervaloPermiteComboMagiaGolpe = True
   ' Call AddtoRichTextBox(frmMain.RecTxt, "Magia - Golpe OK.", 255, 0, 0, True, False, False)
    
Else
    IntervaloPermiteComboMagiaGolpe = False
    'Call AddtoRichTextBox(frmMain.RecTxt, "Magia - Golpe NO.", 255, 0, 0, True, False, False)
End If
End Function

Public Function IntervaloPermiteUsar() As Boolean


If IntervaloPermiteUsarDespuestDeAtacar(False) Then
    Dim TActual As Long
    
    TActual = GetTickCount() And &H7FFFFFFF
    
    If TActual - Intervalos.Uso >= CONST_INTERVALO_USAR Then
        
      '  Call AddtoRichTextBox(frmMain.RecTxt, "Usar OK.", 255, 0, 0, True, False, False)
        Intervalos.Uso = TActual
        IntervaloPermiteUsar = True
    Else
        IntervaloPermiteUsar = False
    End If
Else
IntervaloPermiteUsar = False
End If

End Function

Public Function IntervaloPermiteUsarDespuestDeAtacar(Optional ByVal Actualizar As Boolean = True) As Boolean
Dim TActual As Long


TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.UsarDespuesDeAtacar >= CONST_INTERVALO_USARDESPUESDEATACAR Then
    If Actualizar Then
        Intervalos.UsarDespuesDeAtacar = TActual
    End If
    IntervaloPermiteUsarDespuestDeAtacar = True
   ' Call AddtoRichTextBox(frmMain.RecTxt, "Magia - Golpe OK.", 255, 0, 0, True, False, False)
    
Else
    IntervaloPermiteUsarDespuestDeAtacar = False
    'Call AddtoRichTextBox(frmMain.RecTxt, "Magia - Golpe NO.", 255, 0, 0, True, False, False)
End If
End Function
Public Function IntervaloPermiteLLamadaClan() As Boolean

Dim TActual As Long

TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.LLamadaClan >= CONST_INTERVALO_LLAMADACLAN Then
    
  '  Call AddtoRichTextBox(frmMain.RecTxt, "Usar OK.", 255, 0, 0, True, False, False)
    Intervalos.LLamadaClan = TActual
    IntervaloPermiteLLamadaClan = True
Else
    IntervaloPermiteLLamadaClan = False
   ' Call AddtoRichTextBox(frmMain.RecTxt, "Debes aguardar unos instantes para volver a llamar a tu clan.", 255, 0, 0, True, False, False)
End If

End Function
Public Function IntervaloPermiteAnim() As Boolean

Dim TActual As Long

TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.Anim >= CONST_INTERVALO_ANIM Then
    
  '  Call AddtoRichTextBox(frmMain.RecTxt, "Usar OK.", 255, 0, 0, True, False, False)
    Intervalos.Anim = TActual
    IntervaloPermiteAnim = True
Else
    IntervaloPermiteAnim = False
End If

End Function
Public Function IntervaloPermiteConectar() As Boolean

Dim TActual As Long

TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.Conectar >= CONST_INTERVALO_Conectar Then
    
   ' Call AddtoRichTextBox(frmmain.RecTxt, "Usar OK.", 255, 0, 0, True, False, False)
    Intervalos.Conectar = TActual
    IntervaloPermiteConectar = True
Else
    IntervaloPermiteConectar = False
End If

End Function

Public Function IntervaloPermiteTirar() As Boolean

Dim TActual As Long

TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.tirar >= CONST_INTERVALO_TIRAR Then
    
   ' Call AddtoRichTextBox(frmMain.RecTxt, "Tirar OK.", 255, 0, 0, True, False, False)
    Intervalos.tirar = TActual
    IntervaloPermiteTirar = True
Else
    IntervaloPermiteTirar = False
End If

End Function



Public Function IntervaloPermiteLanzarSpell() As Boolean

Dim TActual As Long

TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.Hechizo >= CONST_INTERVALO_CASTEO Then
 '   Call AddtoRichTextBox(frmMain.RecTxt, "Lanzar OK.", 255, 0, 0, True, False, False)
    Intervalos.Hechizo = TActual
    IntervaloPermiteLanzarSpell = True
    IntervaloPermiteComboMagiaGolpe (True)
    IntervaloPermiteUsarDespuestDeAtacar (True)
Else
    IntervaloPermiteLanzarSpell = False
   ' If UsaLanzar Then
        'Call AddtoRichTextBox(frmMain.RecTxt, "Debes aguardar para lanzar el hechizo.", 255, 0, 0, True, False, False)
    'End If
End If

End Function
Public Function IntervaloPermiteLanzarSpellMacro() As Boolean

Dim TActual As Long

TActual = GetTickCount() And &H7FFFFFFF

If TActual - Intervalos.HechizoMacro >= CONST_INTERVALO_CASTEOMACRO Then
 '   Call AddtoRichTextBox(frmMain.RecTxt, "Lanzar OK.", 255, 0, 0, True, False, False)
    Intervalos.HechizoMacro = TActual
    IntervaloPermiteLanzarSpellMacro = True
    IntervaloPermiteComboMagiaGolpe (True)
    IntervaloPermiteUsarDespuestDeAtacar (True)
Else
    IntervaloPermiteLanzarSpellMacro = False
    If UsaLanzar Then
        'Call AddtoRichTextBox(frmMain.RecTxt, "Debes aguardar para lanzar el hechizo.", 255, 0, 0, True, False, False)
    End If
End If

End Function



Sub CargarOpciones()
On Error Resume Next

        Dim Arch As String
    
        Arch = App.Path & "\..\Recursos\OUTPUT\" & "raoinit.ini"
        'Musica
        Musica = GetVar(Arch, "OPCIONES", "Musica")
        VolMusic = Val(GetVar(Arch, "OPCIONES", "VolMusic"))
        
        fX = GetVar(Arch, "OPCIONES", "Fx")
        VolFX = Val(GetVar(Arch, "OPCIONES", "VolFX"))
        VolAmbient = Val(GetVar(Arch, "OPCIONES", "VolAmbient"))
        AmbientalActivated = GetVar(Arch, "OPCIONES", "AmbientalActivated")
        InvertirSonido = GetVar(Arch, "OPCIONES", "InvertirSonido")
        CopiarDialogoAConsola = GetVar(Arch, "OPCIONES", "CopiarDialogoAConsola")
        PermitirMoverse = GetVar(Arch, "OPCIONES", "PermitirMoverse")
        MoverVentana = GetVar(Arch, "OPCIONES", "MoverVentana")
        FPSFLAG = GetVar(Arch, "OPCIONES", "FPSFLAG")
        AlphaMacro = GetVar(Arch, "OPCIONES", "AlphaMacro")
        FxNavega = GetVar(Arch, "OPCIONES", "FxNavega")
        
        OcultarMacrosAlCastear = GetVar(Arch, "OPCIONES", "OcultarMacrosAlCastear")
        MostrarIconosMeteorologicos = GetVar(Arch, "OPCIONES", "MostrarIconosMeteorologicos")
        PantallaCompleta = GetVar(Arch, "OPCIONES", "PantallaCompleta")
        Sonido = GetVar(Arch, "OPCIONES", "Sonido")

        VolMusicFadding = VolMusic

        MacAdress = GetMacAddress
        HDserial = GetDriveSerialNumber
        
        CursoresGraficos = GetVar(Arch, "OPCIONES", "CursoresGraficos")
        
        UtilizarPreCarga = GetVar(Arch, "OPCIONES", "UtilizarPreCarga")
        
        
        
        SensibilidadMouse = GetVar(Arch, "OPCIONES", "SensibilidadMouse")
        If SensibilidadMouse = 0 Then
        SensibilidadMouse = 10
        End If
        
        SensibilidadMouseOriginal = General_Get_Mouse_Speed
        Call General_Set_Mouse_Speed(SensibilidadMouse)
        
Load frmConnect
Load FrmLogear

        
End Sub

Sub GuardarOpciones()
    Dim Arch As String
    Arch = App.Path & "\..\Recursos\OUTPUT\" & "raoinit.ini"
    Call WriteVar(Arch, "OPCIONES", "Musica", Musica)
    Call WriteVar(Arch, "OPCIONES", "Fx", fX)
    Call WriteVar(Arch, "OPCIONES", "VolMusic", VolMusic)
    Call WriteVar(Arch, "OPCIONES", "Volfx", VolFX)
    Call WriteVar(Arch, "OPCIONES", "VolAmbient", VolAmbient)
    Call WriteVar(Arch, "OPCIONES", "MoverVentana", MoverVentana)
    Call WriteVar(Arch, "OPCIONES", "PermitirMoverse", PermitirMoverse)
    Call WriteVar(Arch, "OPCIONES", "CopiarDialogoAConsola", CopiarDialogoAConsola)
    Call WriteVar(Arch, "OPCIONES", "InvertirSonido", InvertirSonido)
    Call WriteVar(Arch, "OPCIONES", "FPSFLAG", FPSFLAG)
    Call WriteVar(Arch, "OPCIONES", "AlphaMacro", AlphaMacro)
    Call WriteVar(Arch, "OPCIONES", "FxNavega", FxNavega)
    Call WriteVar(Arch, "OPCIONES", "AmbientalActivated", AmbientalActivated)
    Call WriteVar(Arch, "OPCIONES", "OcultarMacrosAlCastear", OcultarMacrosAlCastear)
   ' Call WriteVar(Arch, "OPCIONES", "CursoresGraficos", CursoresGraficos)
    Call WriteVar(Arch, "OPCIONES", "SensibilidadMouse", SensibilidadMouse)

End Sub
Public Sub WriteChatOverHeadInConsole(ByVal charindex As Integer, ByVal ChatText As String, ByVal red As Byte, ByVal green As Byte, ByVal blue As Byte)
    Dim NameRed As Byte
    Dim NameGreen As Byte
    Dim NameBlue As Byte
    

    
    If red = 20 And green = 226 And blue = 157 Then
    Exit Sub
    End If
    
    
    With charlist(charindex)
        'Todo: Hacer que los colores se usen de Colores.dat
        'Haciendo uso de ColoresPj ya que el mismo en algun momento lo hace para DX
        Debug.Print .priv
        
        Select Case .priv
            Case 0
                If .status = 0 Then
                    NameRed = 128
                    NameGreen = 128
                    NameBlue = 128
                ElseIf .status = 1 Then
                    NameRed = 0
                    NameGreen = 128
                    NameBlue = 190
                ElseIf .status = 2 Then
                    NameRed = 179
                    NameGreen = 0
                    NameBlue = 4
                ElseIf .status = 3 Then
                    NameRed = 31
                    NameGreen = 139
                    NameBlue = 139
                End If
        Case 1, 2

            NameRed = 2
            NameGreen = 161
            NameBlue = 38
        Case 3, 4
            NameRed = 217
            NameGreen = 164
            NameBlue = 32
        
            
        End Select
        Dim Pos As Integer
        Pos = InStr(.nombre, "<")
            
        If Pos = 0 Then Pos = LenB(.nombre) + 2
        
        Dim name As String
        name = Left$(.nombre, Pos - 2)
        
        
       
        'Si el npc tiene nombre lo escribimos en la consola
        ChatText = Trim$(ChatText)
        If LenB(.nombre) <> 0 And LenB(ChatText) > 0 Then
            Call AddtoRichTextBox2(frmmain.RecTxt, "[" & name & "] ", NameRed, NameGreen, NameBlue, True, False, True, rtfLeft)
            Call AddtoRichTextBox2(frmmain.RecTxt, ChatText, red, green, blue, False, False, False, rtfLeft)
        End If
            Dim i As Byte
 
For i = 2 To MaxLineas
Con(i - 1).T = Con(i).T
'Con(i - 1).Color = Con(i).Color
Con(i - 1).b = Con(i).b
Con(i - 1).g = Con(i).g
Con(i - 1).r = Con(i).r
Next i
 
Con(MaxLineas).T = vbCrLf & "[" & name & "] " & ChatText
Con(MaxLineas).b = blue
Con(MaxLineas).g = green
Con(MaxLineas).r = red
OffSetConsola = 16
 
UltimaLineavisible = False

    End With
    
End Sub
Public Sub CopiarDialogoToConsola(ByVal NickName As String, Dialogo As String, color As Long)

If NickName = "" Then Exit Sub
If Right$(Dialogo, 1) = " " Or Left(Dialogo, 1) = " " Then
Dialogo = Trim(Dialogo)
End If
Dim Pos As Long

Dim Nick As String
 Pos = InStr(NickName, "<")

If Pos = 0 Then Pos = Len(NickName) + 2
'Nick
Nick = Left$(NickName, Pos - 2)

Select Case color
    Case 255255255 ' Blanco comun
        Call AddtoRichTextBox(frmmain.RecTxt, Nick & "> " & Dialogo, 255, 255, 255, False, True, False)
    Case 25513015 'Gritar GMS!
        Call AddtoRichTextBox(frmmain.RecTxt, Nick & "> " & Dialogo, 225, 225, 0, False, True, False)
    Case 25500 ' Gritar!
        Call AddtoRichTextBox(frmmain.RecTxt, Nick & "> " & Dialogo, 255, 0, 0, False, True, False)
    Case 2000 'GM
        Call AddtoRichTextBox(frmmain.RecTxt, Nick & "> " & Dialogo, 0, 200, , False, True, False)
    Case -14117888 ' Global
        Call AddtoRichTextBox(frmmain.RecTxt, Nick & "> " & Dialogo, 0, 201, 197, False, True, False)
    Case 192192192 'Gris
        Call AddtoRichTextBox(frmmain.RecTxt, Nick & "> " & Dialogo, 164, 164, 164, False, True, False)
    Case 15722620 'Privado
        Call AddtoRichTextBox(frmmain.RecTxt, Nick & "> " & Dialogo, 157, 226, 20, False, True, False)

End Select
End Sub
Public Function PonerPuntos(Numero As Long) As String
Dim i As Integer
Dim Cifra As String
 
Cifra = str(Numero)
Cifra = Right$(Cifra, Len(Cifra) - 1)
For i = 0 To 4
    If Len(Cifra) - 3 * i >= 3 Then
        If mid$(Cifra, Len(Cifra) - (2 + 3 * i), 3) <> "" Then
            PonerPuntos = mid$(Cifra, Len(Cifra) - (2 + 3 * i), 3) & "." & PonerPuntos
        End If
    Else
        If Len(Cifra) - 3 * i > 0 Then
            PonerPuntos = Left$(Cifra, Len(Cifra) - 3 * i) & "." & PonerPuntos
        End If
        Exit For
    End If
Next
 
PonerPuntos = Left$(PonerPuntos, Len(PonerPuntos) - 1)
 
End Function

Sub AmbientarAudio(ByVal UserMap As Long)
On Error Resume Next
Dim wav As Integer



'Call Audio.StopWave(AmbientalesBufferIndex)
    If meteo_estado <> 3 Then
   
        wav = ReadField(1, Val(MapDat.ambient), Asc("-"))
        If Sound.AmbienteActual <> wav Then
         Sound.LastAmbienteActual = wav
         
         End If
         
         Sound.Ambient_Play
        If wav = 0 Then
            Sound.Ambient_Stop
        End If
      '  AmbientalesBufferIndex = Audio.PlayWave(Wav & ".wav", , , LoopStyle.Enabled)
    Else
   
         wav = ReadField(2, Val(MapDat.extra1), Asc("-"))
         If wav = 0 Then Exit Sub
       If Sound.AmbienteActual <> wav Then
         Sound.LastAmbienteActual = wav
         End If
        If wav = 0 Then
            Sound.Ambient_Stop
        End If
      '  AmbientalesBufferIndex = Audio.PlayWave(Wav & ".wav", , , LoopStyle.Enabled)
    End If
Sound.Ambient_Volume_Set VolAmbient
'Debug.Print VolAmbient


End Sub
Public Function General_Char_Particle_Create(ByVal ParticulaInd As Long, ByVal char_index As Integer, Optional ByVal particle_life As Long = 0) As Long
If ParticulaInd = 0 Then Exit Function
Dim rgb_list(0 To 3) As Long
rgb_list(0) = RGB(StreamData(ParticulaInd).colortint(0).r, StreamData(ParticulaInd).colortint(0).g, StreamData(ParticulaInd).colortint(0).b)
rgb_list(1) = RGB(StreamData(ParticulaInd).colortint(1).r, StreamData(ParticulaInd).colortint(1).g, StreamData(ParticulaInd).colortint(1).b)
rgb_list(2) = RGB(StreamData(ParticulaInd).colortint(2).r, StreamData(ParticulaInd).colortint(2).g, StreamData(ParticulaInd).colortint(2).b)
rgb_list(3) = RGB(StreamData(ParticulaInd).colortint(3).r, StreamData(ParticulaInd).colortint(3).g, StreamData(ParticulaInd).colortint(3).b)



General_Char_Particle_Create = engine.Char_Particle_Group_Create(char_index, StreamData(ParticulaInd).grh_list, rgb_list(), StreamData(ParticulaInd).NumOfParticles, ParticulaInd, _
    StreamData(ParticulaInd).AlphaBlend, IIf(particle_life = 0, StreamData(ParticulaInd).life_counter, particle_life), StreamData(ParticulaInd).speed, , StreamData(ParticulaInd).x1, StreamData(ParticulaInd).y1, StreamData(ParticulaInd).angle, _
    StreamData(ParticulaInd).vecx1, StreamData(ParticulaInd).vecx2, StreamData(ParticulaInd).vecy1, StreamData(ParticulaInd).vecy2, _
    StreamData(ParticulaInd).life1, StreamData(ParticulaInd).life2, StreamData(ParticulaInd).friction, StreamData(ParticulaInd).spin_speedL, _
    StreamData(ParticulaInd).gravity, StreamData(ParticulaInd).grav_strength, StreamData(ParticulaInd).bounce_strength, StreamData(ParticulaInd).x2, _
    StreamData(ParticulaInd).y2, StreamData(ParticulaInd).XMove, StreamData(ParticulaInd).move_x1, StreamData(ParticulaInd).move_x2, StreamData(ParticulaInd).move_y1, _
    StreamData(ParticulaInd).move_y2, StreamData(ParticulaInd).YMove, StreamData(ParticulaInd).spin_speedH, StreamData(ParticulaInd).spin, StreamData(ParticulaInd).grh_resize, StreamData(ParticulaInd).grh_resizex, StreamData(ParticulaInd).grh_resizey)

End Function


Public Function General_Particle_Create(ByVal ParticulaInd As Long, ByVal X As Integer, ByVal Y As Integer, Optional ByVal particle_life As Long = 0) As Long
If ParticulaInd = 0 Then Exit Function
Dim rgb_list(0 To 3) As Long
rgb_list(0) = RGB(StreamData(ParticulaInd).colortint(0).r, StreamData(ParticulaInd).colortint(0).g, StreamData(ParticulaInd).colortint(0).b)
rgb_list(1) = RGB(StreamData(ParticulaInd).colortint(1).r, StreamData(ParticulaInd).colortint(1).g, StreamData(ParticulaInd).colortint(1).b)
rgb_list(2) = RGB(StreamData(ParticulaInd).colortint(2).r, StreamData(ParticulaInd).colortint(2).g, StreamData(ParticulaInd).colortint(2).b)
rgb_list(3) = RGB(StreamData(ParticulaInd).colortint(3).r, StreamData(ParticulaInd).colortint(3).g, StreamData(ParticulaInd).colortint(3).b)

General_Particle_Create = engine.Particle_Group_Create(X, Y, StreamData(ParticulaInd).grh_list, rgb_list(), StreamData(ParticulaInd).NumOfParticles, ParticulaInd, _
    StreamData(ParticulaInd).AlphaBlend, IIf(particle_life = 0, StreamData(ParticulaInd).life_counter, particle_life), StreamData(ParticulaInd).speed, , StreamData(ParticulaInd).x1, StreamData(ParticulaInd).y1, StreamData(ParticulaInd).angle, _
    StreamData(ParticulaInd).vecx1, StreamData(ParticulaInd).vecx2, StreamData(ParticulaInd).vecy1, StreamData(ParticulaInd).vecy2, _
    StreamData(ParticulaInd).life1, StreamData(ParticulaInd).life2, StreamData(ParticulaInd).friction, StreamData(ParticulaInd).spin_speedL, _
    StreamData(ParticulaInd).gravity, StreamData(ParticulaInd).grav_strength, StreamData(ParticulaInd).bounce_strength, StreamData(ParticulaInd).x2, _
    StreamData(ParticulaInd).y2, StreamData(ParticulaInd).XMove, StreamData(ParticulaInd).move_x1, StreamData(ParticulaInd).move_x2, StreamData(ParticulaInd).move_y1, _
    StreamData(ParticulaInd).move_y2, StreamData(ParticulaInd).YMove, StreamData(ParticulaInd).spin_speedH, StreamData(ParticulaInd).spin, StreamData(ParticulaInd).grh_resize, StreamData(ParticulaInd).grh_resizex, StreamData(ParticulaInd).grh_resizey)

End Function


Public Function General_Var_Get(ByVal file As String, ByVal Main As String, ByVal Var As String) As String
'*****************************************************************
'Author: Aaron Perkins
'Last Modify Date: 10/07/2002
'Get a var to from a text file
'*****************************************************************
    Dim L As Long
    Dim Char As String
    Dim sSpaces As String 'Input that the program will retrieve
    Dim szReturn As String 'Default value if the string is not found
    
    szReturn = ""
    
    sSpaces = Space$(5000)
    
    getprivateprofilestring Main, Var, szReturn, sSpaces, Len(sSpaces), file
    
    General_Var_Get = RTrim$(sSpaces)
    General_Var_Get = Left$(General_Var_Get, Len(General_Var_Get) - 1)
End Function

Public Sub CargarParticulas()
'*************************************
'Coded by OneZero (onezero_ss@hotmail.com)
'Last Modified: 6/4/03
'Loads the Particles.ini file to the ComboBox
'Edited by Juan Mart�n Sotuyo Dodero to add speed and life
'*************************************
    Dim loopc As Long
    Dim i As Long
    Dim GrhListing As String
    Dim TempSet As String
    Dim ColorSet As Long
    Dim temp As Integer
    


#If Compresion = 1 Then
    If Not Extract_File(Scripts, App.Path & "\..\Recursos\OUTPUT\", "particles.ini", Windows_Temp_Dir, False) Then
        Err.Description = "�No se puede cargar el archivo de particles.ini!"
       MsgBox Err.Description
    End If
        StreamFile = Windows_Temp_Dir & "particles.ini"
#Else
        StreamFile = App.Path & "\..\Recursos\init\particles.ini"
#End If





    ParticulasTotales = Val(General_Var_Get(StreamFile, "INIT", "Total"))
    
    'resize StreamData array
    ReDim StreamData(1 To ParticulasTotales) As Stream
    
    'fill StreamData array with info from Particles.ini
    For loopc = 1 To ParticulasTotales
        StreamData(loopc).name = General_Var_Get(StreamFile, Val(loopc), "Name")
        StreamData(loopc).NumOfParticles = General_Var_Get(StreamFile, Val(loopc), "NumOfParticles")
        StreamData(loopc).x1 = General_Var_Get(StreamFile, Val(loopc), "X1")
        StreamData(loopc).y1 = General_Var_Get(StreamFile, Val(loopc), "Y1")
        StreamData(loopc).x2 = General_Var_Get(StreamFile, Val(loopc), "X2")
        StreamData(loopc).y2 = General_Var_Get(StreamFile, Val(loopc), "Y2")
        StreamData(loopc).angle = General_Var_Get(StreamFile, Val(loopc), "Angle")
        StreamData(loopc).vecx1 = General_Var_Get(StreamFile, Val(loopc), "VecX1")
        StreamData(loopc).vecx2 = General_Var_Get(StreamFile, Val(loopc), "VecX2")
        StreamData(loopc).vecy1 = General_Var_Get(StreamFile, Val(loopc), "VecY1")
        StreamData(loopc).vecy2 = General_Var_Get(StreamFile, Val(loopc), "VecY2")
        StreamData(loopc).life1 = General_Var_Get(StreamFile, Val(loopc), "Life1")
        StreamData(loopc).life2 = General_Var_Get(StreamFile, Val(loopc), "Life2")
        StreamData(loopc).friction = General_Var_Get(StreamFile, Val(loopc), "Friction")
        StreamData(loopc).spin = General_Var_Get(StreamFile, Val(loopc), "Spin")
        StreamData(loopc).spin_speedL = General_Var_Get(StreamFile, Val(loopc), "Spin_SpeedL")
        StreamData(loopc).spin_speedH = General_Var_Get(StreamFile, Val(loopc), "Spin_SpeedH")
        StreamData(loopc).AlphaBlend = General_Var_Get(StreamFile, Val(loopc), "AlphaBlend")
        StreamData(loopc).gravity = General_Var_Get(StreamFile, Val(loopc), "Gravity")
        StreamData(loopc).grav_strength = General_Var_Get(StreamFile, Val(loopc), "Grav_Strength")
        StreamData(loopc).bounce_strength = General_Var_Get(StreamFile, Val(loopc), "Bounce_Strength")
        StreamData(loopc).XMove = General_Var_Get(StreamFile, Val(loopc), "XMove")
        StreamData(loopc).YMove = General_Var_Get(StreamFile, Val(loopc), "YMove")
        StreamData(loopc).move_x1 = General_Var_Get(StreamFile, Val(loopc), "move_x1")
        StreamData(loopc).move_x2 = General_Var_Get(StreamFile, Val(loopc), "move_x2")
        StreamData(loopc).move_y1 = General_Var_Get(StreamFile, Val(loopc), "move_y1")
        StreamData(loopc).move_y2 = General_Var_Get(StreamFile, Val(loopc), "move_y2")
        StreamData(loopc).life_counter = General_Var_Get(StreamFile, Val(loopc), "life_counter")
        StreamData(loopc).speed = Val(General_Var_Get(StreamFile, Val(loopc), "Speed"))
        temp = General_Var_Get(StreamFile, Val(loopc), "resize")
        StreamData(loopc).grh_resize = IIf((temp = -1), True, False)
        StreamData(loopc).grh_resizex = General_Var_Get(StreamFile, Val(loopc), "rx")
        StreamData(loopc).grh_resizey = General_Var_Get(StreamFile, Val(loopc), "ry")
        
        
        
        StreamData(loopc).NumGrhs = General_Var_Get(StreamFile, Val(loopc), "NumGrhs")
        ReDim StreamData(loopc).grh_list(1 To StreamData(loopc).NumGrhs)
        GrhListing = General_Var_Get(StreamFile, Val(loopc), "Grh_List")
        
        For i = 1 To StreamData(loopc).NumGrhs
            StreamData(loopc).grh_list(i) = General_Field_Read(str(i), GrhListing, ",")
        Next i
        StreamData(loopc).grh_list(i - 1) = StreamData(loopc).grh_list(i - 1)
        
        For ColorSet = 1 To 4
            TempSet = General_Var_Get(StreamFile, Val(loopc), "ColorSet" & ColorSet)
            StreamData(loopc).colortint(ColorSet - 1).r = General_Field_Read(1, TempSet, ",")
            StreamData(loopc).colortint(ColorSet - 1).g = General_Field_Read(2, TempSet, ",")
            StreamData(loopc).colortint(ColorSet - 1).b = General_Field_Read(3, TempSet, ",")
        Next ColorSet
        
    Next loopc
    
    
        
    #If Compresion = 1 Then
        Delete_File Windows_Temp_Dir & "particles.ini"
    #End If
End Sub
Public Sub CargarParticulasBinary()
'*************************************
'Coded by OneZero (onezero_ss@hotmail.com)
'Last Modified: 6/4/03
'Loads the Particles.ini file to the ComboBox
'Edited by Juan Mart�n Sotuyo Dodero to add speed and life
'*************************************
    Dim loopc As Long
    Dim i As Long
    Dim GrhListing As String
    Dim TempSet As String
    Dim ColorSet As Long
    Dim temp As Integer
    
    Dim handle As Integer

 'Open files
    handle = FreeFile()

    


#If Compresion = 1 Then
    If Not Extract_File(Scripts, App.Path & "\..\Recursos\OUTPUT\", "particles.ind", Windows_Temp_Dir, False) Then
        Err.Description = "�No se puede cargar el archivo de particles.ind!"
       MsgBox Err.Description
    End If
        StreamFile = Windows_Temp_Dir & "particles.ind"
#Else
        StreamFile = App.Path & "\..\Recursos\init\particles.ind"
#End If



  

    Dim N As Integer
    
    N = FreeFile()

    Open StreamFile For Binary Access Read As #N
    'num de cabezas
    Get #N, , ParticulasTotales

    ReDim StreamData(1 To ParticulasTotales) As Stream
    'fill StreamData array with info from Particles.ini
    For loopc = 1 To ParticulasTotales
        Get #N, , StreamData(loopc)
    Next loopc
    
    Close #N



Exit Sub
    ParticulasTotales = Val(General_Var_Get(StreamFile, "INIT", "Total"))
    
    'resize StreamData array
    
    
    'fill StreamData array with info from Particles.ini
    For loopc = 1 To ParticulasTotales

        temp = General_Var_Get(StreamFile, Val(loopc), "resize")
        StreamData(loopc).grh_resize = IIf((temp = -1), True, False)
        StreamData(loopc).grh_resizex = General_Var_Get(StreamFile, Val(loopc), "rx")
        StreamData(loopc).grh_resizey = General_Var_Get(StreamFile, Val(loopc), "ry")
        
        
        
        StreamData(loopc).NumGrhs = General_Var_Get(StreamFile, Val(loopc), "NumGrhs")
        ReDim StreamData(loopc).grh_list(1 To StreamData(loopc).NumGrhs)
        GrhListing = General_Var_Get(StreamFile, Val(loopc), "Grh_List")
        
        For i = 1 To StreamData(loopc).NumGrhs
            StreamData(loopc).grh_list(i) = General_Field_Read(str(i), GrhListing, ",")
        Next i
        StreamData(loopc).grh_list(i - 1) = StreamData(loopc).grh_list(i - 1)
        
        For ColorSet = 1 To 4
            TempSet = General_Var_Get(StreamFile, Val(loopc), "ColorSet" & ColorSet)
            StreamData(loopc).colortint(ColorSet - 1).r = General_Field_Read(1, TempSet, ",")
            StreamData(loopc).colortint(ColorSet - 1).g = General_Field_Read(2, TempSet, ",")
            StreamData(loopc).colortint(ColorSet - 1).b = General_Field_Read(3, TempSet, ",")
        Next ColorSet
        
    Next loopc
    
    
        
    #If Compresion = 1 Then
        Delete_File Windows_Temp_Dir & "particles.ini"
    #End If
End Sub

Public Sub DibujarMiniMapa()

Dim map_x As Long, map_y As Long
Dim termine As Boolean
 frmmain.MiniMap.BackColor = vbBlack
    For map_y = 1 To 100
        For map_x = 1 To 100
            If MapData(map_x, map_y).Graphic(1).GrhIndex > 0 Then
                SetPixel frmmain.MiniMap.hdc, map_x - 1, map_y - 1, GrhData(MapData(map_x, map_y).Graphic(1).GrhIndex).MiniMap_color
            End If
            If MapData(map_x, map_y).Graphic(2).GrhIndex > 0 Then
                SetPixel frmmain.MiniMap.hdc, map_x - 1, map_y - 1, GrhData(MapData(map_x, map_y).Graphic(2).GrhIndex).MiniMap_color
            End If
            If MapData(map_x, map_y).Graphic(4).GrhIndex > 0 Then
                SetPixel frmmain.MiniMap.hdc, map_x - 1, map_y - 1, GrhData(MapData(map_x, map_y).Graphic(4).GrhIndex).MiniMap_color
            End If
            
        Next map_x
    Next map_y
     
    frmmain.MiniMap.Refresh



End Sub

Rem Encripta una cadena de caracteres.
Rem S = Cadena a encriptar
Rem P = Password
Function EncryptStr(ByVal s As String, ByVal p As String) As String
Dim i As Integer, r As String
Dim C1 As Integer, C2 As Integer
r = ""
If Len(p) > 0 Then
For i = 1 To Len(s)
C1 = Asc(mid(s, i, 1))
If i > Len(p) Then
C2 = Asc(mid(p, i Mod Len(p) + 1, 1))
Else
C2 = Asc(mid(p, i, 1))
End If
C1 = C1 + C2 + 64
If C1 > 255 Then C1 = C1 - 256
r = r + Chr(C1)
Next i
Else
r = s
End If
EncryptStr = r
End Function


Rem Desencripta una cadena de caracteres.
Rem S = Cadena a desencriptar
Rem P = Password
Function UnEncryptStr(ByVal s As String, ByVal p As String) As String
Dim i As Integer, r As String
Dim C1 As Integer, C2 As Integer
r = ""
If Len(p) > 0 Then
For i = 1 To Len(s)
C1 = Asc(mid(s, i, 1))
If i > Len(p) Then
C2 = Asc(mid(p, i Mod Len(p) + 1, 1))
Else
C2 = Asc(mid(p, i, 1))
End If
C1 = C1 - C2 - 64
If Sgn(C1) = -1 Then C1 = 256 + C1
r = r + Chr(C1)
Next i
Else
r = s
End If
UnEncryptStr = r
End Function

Public Function Input_Key_Get(ByVal key_code As Byte) As Boolean
'**************************************************************
'Author: Aaron Perkins - Juan Mart�n Sotuyo Dodero
'Modified by Augusto Jos� Rando
'Now we use DirectInput Keyboard
'Last Modify Date: 10/07/2002
'
'**************************************************************
    'Input_Key_Get = (key_state.Key(key_code) > 0)
    Input_Key_Get = (GetKeyState(key_code) < 0)
End Function
Public Function Input_Click_Get(ByVal Botton As Byte) As Boolean
'**************************************************************
'Author: Pablo Mercavides
'Modified by Augusto Jos� Rando
'Now we use DirectInput Keyboard
'Last Modify Date: 10/07/2002
'
'**************************************************************
    'Input_Key_Get = (key_state.Key(key_code) > 0)
    Input_Click_Get = (GetAsyncKeyState(Botton) < 0)
End Function



Public Function General_Get_Temp_Dir() As String
'**************************************************************
'Author: Augusto Jos� Rando
'Last Modify Date: 6/11/2005
'Gets windows temporary directory
'**************************************************************
   Dim s As String
   Dim c As Long
   s = Space$(MAX_LENGTH)
   c = GetTempPath(MAX_LENGTH, s)
   If c > 0 Then
       If c > Len(s) Then
           s = Space$(c + 1)
           c = GetTempPath(MAX_LENGTH, s)
       End If
   End If
   General_Get_Temp_Dir = IIf(c > 0, Left$(s, c), "")
End Function
Public Function General_Get_Mouse_Speed() As Long
'**************************************************************
'Author: Augusto Jos� Rando
'Last Modify Date: 6/11/2005
'
'**************************************************************
 
SystemParametersInfo SPI_GETMOUSESPEED, 0, General_Get_Mouse_Speed, 0
 
End Function
 
Public Sub General_Set_Mouse_Speed(ByVal lngSpeed As Long)
'**************************************************************
'Author: Augusto Jos� Rando
'Last Modify Date: 6/11/2005
'
'**************************************************************
 
SystemParametersInfo SPI_SETMOUSESPEED, 0, ByVal lngSpeed, 0
 
End Sub

Public Sub ResetearUserMacro()
'**************************************************************
'Author: Augusto Jos� Rando
'Last Modify Date: 6/11/2005
'
'**************************************************************
Call WriteFlagTrabajar
frmmain.MacroLadder.Enabled = False
UserMacro.Activado = False
UserMacro.cantidad = 0
UserMacro.Index = 0
UserMacro.Intervalo = 0
UserMacro.TIPO = 0
UserMacro.tX = 0
UserMacro.tY = 0
UserMacro.Skill = 0
If UsingSkill <> 0 Then
UsingSkill = 0
Call FormParser.Parse_Form(frmmain)
End If



AddtoRichTextBox frmmain.RecTxt, "Has dejado de trabajar.", 2, 51, 223, 1, 1

End Sub
Public Sub CargarIndicesOBJBinary()
Dim Obj As Integer
Dim Npc As Integer
Dim Hechizo As Integer
Dim i As Integer



#If Compresion = 1 Then
    If Not Extract_File(Scripts, App.Path & "\..\Recursos\OUTPUT\", "localindex.ind", Windows_Temp_Dir, False) Then
        Err.Description = "�No se puede cargar el archivo de localindex.ind!"
        MsgBox Err.Description
    End If
    
    ObjFile = Windows_Temp_Dir & "localindex.ind"
#Else
    ObjFile = App.Path & "\..\Recursos\init\localindex.ind"
#End If

    Dim handle As Integer

    'Open files
    handle = FreeFile()


    Dim N As Integer
    
    N = FreeFile()

    Open ObjFile For Binary Access Read As #N
    'num de cabezas
    Get #N, , NumOBJs

    ReDim ObjData(0 To NumOBJs) As ObjDatas
    
    'ReDim NpcData(0 To NumNpcs) As NpcDatas
   ' ReDim HechizoData(0 To NumHechizos) As HechizoDatas
    'ReDim Locale_SMG(0 To NumLocaleMsg) As String

    For Obj = 1 To NumOBJs
        DoEvents
        Get #N, , ObjData(Obj)
    Next Obj
    

    Get #N, , NumNpcs

    ReDim NpcData(0 To NumNpcs) As NpcDatas
    
    For Npc = 1 To NumNpcs
        Get #N, , NpcData(Npc)
    Next Npc
    

    Get #N, , NumHechizos
    
    ReDim HechizoData(0 To NumHechizos) As HechizoDatas
    
    
    For Hechizo = 1 To NumHechizos
        DoEvents
        Get #N, , HechizoData(Npc)
    Next Hechizo
    

    Get #N, , NumLocaleMsg
    
    ReDim Locale_SMG(0 To NumLocaleMsg) As String
    
    For i = 1 To NumLocaleMsg
    
    Get #N, , Locale_SMG(i)


    Next i
    
#If Compresion = 1 Then
    Delete_File Windows_Temp_Dir & "localindex.ind"
#End If

    Close #N

    Exit Sub
    

End Sub

Public Sub CargarIndicesOBJ()
    Dim Obj As Integer
    Dim Npc As Integer
    Dim Hechizo As Integer
    Dim i As Integer
    
#If Compresion = 1 Then
    If Not Extract_File(Scripts, App.Path & "\..\Recursos\OUTPUT\", "localindex.dat", Windows_Temp_Dir, False) Then
        Err.Description = "�No se puede cargar el archivo de localindex.dat!"
        MsgBox Err.Description
    End If
    
    ObjFile = Windows_Temp_Dir & "localindex.dat"
#Else
    ObjFile = App.Path & "\..\Recursos\init\localindex.dat"
#End If

            
    Dim Leer As New clsIniReader
    
    Call Leer.Initialize(ObjFile)

    NumOBJs = Val(Leer.GetValue("INIT", "NumObjs"))
    NumNpcs = Val(Leer.GetValue("INIT", "NumNpcs"))
    NumHechizos = Val(Leer.GetValue("INIT", "NumeroHechizo"))
    NumHechizos = Val(Leer.GetValue("INIT", "NumeroHechizo"))
    NumLocaleMsg = Val(Leer.GetValue("INIT", "NumLocaleMsg"))
    
    NumQuest = Val(Leer.GetValue("INIT", "NUMQUESTS"))
    
    NumSug = Val(Leer.GetValue("INIT", "NUMSUGERENCIAS"))
    
    ReDim ObjData(0 To NumOBJs) As ObjDatas
    ReDim NpcData(0 To NumNpcs) As NpcDatas
    ReDim HechizoData(0 To NumHechizos) As HechizoDatas
    ReDim Locale_SMG(0 To NumLocaleMsg) As String
    
    ReDim Quest_Name(1 To NumQuest) As String
    ReDim Quest_Desc(1 To NumQuest) As String
    
    
    ReDim Sugerencia(1 To NumSug) As String
    
    ReDim DESCFINAL(1 To NumQuest) As String
    ReDim NEXTQUEST(1 To NumQuest) As String
    
    ReDim RequiredLevel(1 To NumQuest) As Integer
    
    
    
    ReDim PosMap(1 To NumQuest) As Integer

    For Obj = 1 To NumOBJs
        DoEvents
        ObjData(Obj).GrhIndex = Val(Leer.GetValue("OBJ" & Obj, "grhindex"))
        ObjData(Obj).name = Leer.GetValue("OBJ" & Obj, "Name")
        ObjData(Obj).MinDef = Val(Leer.GetValue("OBJ" & Obj, "MinDef"))
        ObjData(Obj).MaxDef = Val(Leer.GetValue("OBJ" & Obj, "MaxDef"))
        ObjData(Obj).MinHit = Val(Leer.GetValue("OBJ" & Obj, "MinHit"))
        ObjData(Obj).MaxHit = Val(Leer.GetValue("OBJ" & Obj, "MaxHit"))
        ObjData(Obj).ObjType = Val(Leer.GetValue("OBJ" & Obj, "ObjType"))
        ObjData(Obj).info = Leer.GetValue("OBJ" & Obj, "Info")
        ObjData(Obj).Texto = Leer.GetValue("OBJ" & Obj, "Texto")
        ObjData(Obj).CreaGRH = Leer.GetValue("OBJ" & Obj, "CreaGRH")
        ObjData(Obj).CreaLuz = Leer.GetValue("OBJ" & Obj, "CreaLuz")
        ObjData(Obj).CreaParticulaPiso = Val(Leer.GetValue("OBJ" & Obj, "CreaParticulaPiso"))
        ObjData(Obj).proyectil = Val(Leer.GetValue("OBJ" & Obj, "proyectil"))
        ObjData(Obj).Raices = Val(Leer.GetValue("OBJ" & Obj, "Raices"))
        ObjData(Obj).Madera = Val(Leer.GetValue("OBJ" & Obj, "Madera"))
        ObjData(Obj).PielLobo = Val(Leer.GetValue("OBJ" & Obj, "PielLobo"))
        ObjData(Obj).PielOsoPardo = Val(Leer.GetValue("OBJ" & Obj, "PielOsoPardo"))
        ObjData(Obj).PielOsoPolar = Val(Leer.GetValue("OBJ" & Obj, "PielOsoPolar"))
        ObjData(Obj).LingH = Val(Leer.GetValue("OBJ" & Obj, "LingH"))
        ObjData(Obj).LingP = Val(Leer.GetValue("OBJ" & Obj, "LingP"))
        ObjData(Obj).LingO = Val(Leer.GetValue("OBJ" & Obj, "LingO"))
        ObjData(Obj).Destruye = Val(Leer.GetValue("OBJ" & Obj, "Destruye"))
        ObjData(Obj).SkHerreria = Val(Leer.GetValue("OBJ" & Obj, "SkHerreria"))
        ObjData(Obj).SkPociones = Val(Leer.GetValue("OBJ" & Obj, "SkPociones"))
        ObjData(Obj).Sksastreria = Val(Leer.GetValue("OBJ" & Obj, "Sksastreria"))
        ObjData(Obj).Valor = Val(Leer.GetValue("OBJ" & Obj, "Valor"))
        
    Next Obj
    
     Dim aux As String
     Dim loopc As Byte
    
    For Npc = 1 To NumNpcs
        DoEvents
        
        NpcData(Npc).name = Leer.GetValue("npc" & Npc, "Name")
        If NpcData(Npc).name = "" Then
        NpcData(Npc).name = "Vacio"
        End If
        NpcData(Npc).desc = Leer.GetValue("npc" & Npc, "desc")
        NpcData(Npc).Body = Val(Leer.GetValue("npc" & Npc, "Body"))
        NpcData(Npc).exp = Val(Leer.GetValue("npc" & Npc, "exp"))
        NpcData(Npc).Head = Val(Leer.GetValue("npc" & Npc, "Head"))
        NpcData(Npc).Hp = Val(Leer.GetValue("npc" & Npc, "Hp"))
        NpcData(Npc).MaxHit = Val(Leer.GetValue("npc" & Npc, "MaxHit"))
        NpcData(Npc).MinHit = Val(Leer.GetValue("npc" & Npc, "MinHit"))
        NpcData(Npc).oro = Val(Leer.GetValue("npc" & Npc, "oro"))
        
        NpcData(Npc).ExpClan = Val(Leer.GetValue("npc" & Npc, "GiveEXPClan"))
        
        
       
        aux = Val(Leer.GetValue("npc" & Npc, "NumQuiza"))
            If aux = 0 Then
                NpcData(Npc).NumQuiza = 0
            Else
                NpcData(Npc).NumQuiza = Val(aux)
                ReDim NpcData(Npc).QuizaDropea(1 To NpcData(Npc).NumQuiza) As Integer
                For loopc = 1 To NpcData(Npc).NumQuiza
               
                    NpcData(Npc).QuizaDropea(loopc) = Val(Leer.GetValue("npc" & Npc, "QuizaDropea" & loopc))
                   ' Debug.Print NpcData(Npc).QuizaDropea(loopc)
                Next loopc
            End If
            

    Next Npc
    
    
    For Hechizo = 1 To NumHechizos
        DoEvents
        HechizoData(Hechizo).nombre = Leer.GetValue("Hechizo" & Hechizo, "Nombre")
        HechizoData(Hechizo).desc = Leer.GetValue("Hechizo" & Hechizo, "desc")
        HechizoData(Hechizo).PalabrasMagicas = Leer.GetValue("Hechizo" & Hechizo, "PalabrasMagicas")
        HechizoData(Hechizo).HechizeroMsg = Leer.GetValue("Hechizo" & Hechizo, "HechizeroMsg")
        HechizoData(Hechizo).TargetMsg = Leer.GetValue("Hechizo" & Hechizo, "TargetMsg")
        HechizoData(Hechizo).PropioMsg = Leer.GetValue("Hechizo" & Hechizo, "PropioMsg")
        HechizoData(Hechizo).ManaRequerido = Val(Leer.GetValue("Hechizo" & Hechizo, "ManaRequerido"))
        HechizoData(Hechizo).MinSkill = Val(Leer.GetValue("Hechizo" & Hechizo, "MinSkill"))
        HechizoData(Hechizo).StaRequerido = Val(Leer.GetValue("Hechizo" & Hechizo, "StaRequerido"))
        HechizoData(Hechizo).IconoIndex = Val(Leer.GetValue("Hechizo" & Hechizo, "IconoIndex"))
        'HechizoData(Hechizo).IconoIndex = 35696
    Next Hechizo
    
    Hechizo = 1
    
    For Hechizo = 1 To 350
        DoEvents
        NameMaps(Hechizo).name = Leer.GetValue("NameMapa", "Mapa" & Hechizo)
        NameMaps(Hechizo).desc = Leer.GetValue("NameMapa", "Mapa" & Hechizo & "Desc")
    Next Hechizo
    
    
    For Hechizo = 1 To NumQuest
        DoEvents
        Quest_Name(Hechizo) = Leer.GetValue("QUEST" & Hechizo, "NOMBRE")
        Quest_Desc(Hechizo) = Leer.GetValue("QUEST" & Hechizo, "DESC")
        NEXTQUEST(Hechizo) = Leer.GetValue("QUEST" & Hechizo, "NEXTQUEST")
        DESCFINAL(Hechizo) = Leer.GetValue("QUEST" & Hechizo, "DESCFINAL")
        RequiredLevel(Hechizo) = Leer.GetValue("QUEST" & Hechizo, "RequiredLevel")
        PosMap(Hechizo) = Leer.GetValue("QUEST" & Hechizo, "PosMap")
    Next Hechizo
    
    
    For Hechizo = 1 To NumSug
        DoEvents
        Sugerencia(Hechizo) = Leer.GetValue("SUGERENCIAS", "SUGERENCIA" & Hechizo)
    Next Hechizo
    
    
    
    For i = 1 To NumLocaleMsg
        DoEvents
        Locale_SMG(i) = Leer.GetValue("msg", "Msg" & i)
    Next i
    
#If Compresion = 1 Then
    Delete_File Windows_Temp_Dir & "localindex.dat"
#End If

End Sub
Public Sub Cargarmapsworlddata()
Dim MapFile As String
Dim i As Integer

#If Compresion = 1 Then
    If Not Extract_File(Scripts, App.Path & "\..\Recursos\OUTPUT\", "mapsworlddata.dat", Windows_Temp_Dir, False) Then
        Err.Description = "�No se puede cargar el archivo de mapsworlddata.dat!"
        MsgBox Err.Description
    End If
    
    MapFile = Windows_Temp_Dir & "mapsworlddata.dat"
#Else
    MapFile = App.Path & "\..\Recursos\init\mapsworlddata.dat"
#End If

    Dim Leer As New clsIniReader
    Call Leer.Initialize(MapFile)

    
    For i = 1 To 252
       WordMapa(i) = Val(Leer.GetValue("WORLDMAP", i))
    Next i

    For i = 1 To 252
       DungeonData(i) = Val(Leer.GetValue("DUNGEON", i))
    Next i

#If Compresion = 1 Then
    Delete_File Windows_Temp_Dir & "mapsworlddata.dat"
#End If

End Sub

Public Sub CargarLst()

Dim i As Integer

FrmLogear.lstServers.Clear

    For i = 1 To CantServer
        FrmLogear.lstServers.AddItem ServersLst(i).desc
    Next i
    
FrmLogear.lstServers.ListIndex = Int(ServerIndex)
End Sub

Public Sub CrearFantasma(ByVal charindex As Integer)

If charlist(charindex).Body.Walk(charlist(charindex).Heading).GrhIndex = 0 Then Exit Sub

MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Body.framecounter = 1
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Head.framecounter = 1
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Arma.framecounter = 1
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Casco.framecounter = 1
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Escudo.framecounter = 1
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Body.GrhIndex = charlist(charindex).Body.Walk(charlist(charindex).Heading).GrhIndex
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Head.GrhIndex = charlist(charindex).Head.Head(charlist(charindex).Heading).GrhIndex
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Arma.GrhIndex = charlist(charindex).Arma.WeaponWalk(charlist(charindex).Heading).GrhIndex
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Casco.GrhIndex = charlist(charindex).Casco.Head(charlist(charindex).Heading).GrhIndex
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Escudo.GrhIndex = charlist(charindex).Escudo.ShieldWalk(charlist(charindex).Heading).GrhIndex
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Body_Aura = charlist(charindex).Body_Aura
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.AlphaB = 255
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Activo = True
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.OffX = charlist(charindex).Body.HeadOffset.X
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Offy = charlist(charindex).Body.HeadOffset.Y
MapData(charlist(charindex).Pos.X, charlist(charindex).Pos.Y).CharFantasma.Heading = charlist(charindex).Heading
End Sub

Public Sub CompletarAccionBarra(ByVal BarAccion As Byte)
If BarAccion = Accion_Barra.CancelarAccion Then Exit Sub

Call WriteCompletarAccion(BarAccion)

End Sub


Public Sub ComprobarEstado()

Call InitServersList(RawServersList)

Call CargarLst

End Sub


Public Function General_Distance_Get(ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer) As Integer
General_Distance_Get = Abs(x1 - x2) + Abs(y1 - y2)
End Function

Public Sub EndGame(Optional ByVal Closed_ByUser As Boolean = False, Optional ByVal Init_Launcher As Boolean = False)

On Error Resume Next


Sound.Engine_DeInitialize
Sound.Music_Stop
Set Sound = Nothing

prgRun = False

'0. Cerramos el socket
If frmmain.Socket1.State <> sckClosed Then frmmain.Socket1.Disconnect


'2. Eliminamos objetos DX
Call Client_UnInitialize_DirectX_Objects

'3. Cerramos el engine meteorol�gico
Set Meteo_Engine = Nothing



'6. Cerramos los forms y nos vamos
Call UnloadAllForms

'7. Adi�s MuteX - Restauramos MouseSpeed





End

End Sub
Public Sub Client_UnInitialize_DirectX_Objects()

On Error Resume Next

'1. Cerramos el engine de sonido y borramos buffers
Sound.Engine_DeInitialize
Set Sound = Nothing

'2. Cerramos el engine gr�fico y borramos textures




End Sub
Public Sub TextoAlAsistente(ByVal Texto As String)
TextEfectAsistente = 35
TextAsistente = Texto

End Sub
Public Sub CargarMacro(ByVal NumMacro As Byte)

End Sub

Public Sub CargarPasos()

ReDim Pasos(1 To NUM_PASOS) As tPaso

Pasos(CONST_BOSQUE).CantPasos = 2  ' OK
ReDim Pasos(CONST_BOSQUE).wav(1 To Pasos(CONST_BOSQUE).CantPasos) As Integer
Pasos(CONST_BOSQUE).wav(1) = 201
Pasos(CONST_BOSQUE).wav(2) = 69

Pasos(CONST_NIEVE).CantPasos = 2 ' OK
ReDim Pasos(CONST_NIEVE).wav(1 To Pasos(CONST_NIEVE).CantPasos) As Integer
Pasos(CONST_NIEVE).wav(1) = 199
Pasos(CONST_NIEVE).wav(2) = 200

Pasos(CONST_CABALLO).CantPasos = 2
ReDim Pasos(CONST_CABALLO).wav(1 To Pasos(CONST_CABALLO).CantPasos) As Integer
Pasos(CONST_CABALLO).wav(1) = 70
Pasos(CONST_CABALLO).wav(2) = 71

Pasos(CONST_DUNGEON).CantPasos = 2 '
ReDim Pasos(CONST_DUNGEON).wav(1 To Pasos(CONST_DUNGEON).CantPasos) As Integer
Pasos(CONST_DUNGEON).wav(1) = 23
Pasos(CONST_DUNGEON).wav(2) = 24

Pasos(CONST_DESIERTO).CantPasos = 2 ' OK
ReDim Pasos(CONST_DESIERTO).wav(1 To Pasos(CONST_DESIERTO).CantPasos) As Integer
Pasos(CONST_DESIERTO).wav(1) = 197
Pasos(CONST_DESIERTO).wav(2) = 198

Pasos(CONST_PISO).CantPasos = 2 ' OK
ReDim Pasos(CONST_PISO).wav(1 To Pasos(CONST_PISO).CantPasos) As Integer
Pasos(CONST_PISO).wav(1) = 23
Pasos(CONST_PISO).wav(2) = 24

End Sub
Public Function GetTimeFormated(Mins As Integer) As String
Dim Horita As Byte
Dim Minutitos As Byte
Dim a As String

Horita = Fix(Mins / 60)
Minutitos = Mins - 60 * Horita



If Minutitos < 10 Then

    If Horita < 10 Then
    GetTimeFormated = "0" & Horita & ":0" & Minutitos
    Else
    GetTimeFormated = Horita & ":0" & Minutitos
    End If
    
Else
    If Horita < 10 Then
        GetTimeFormated = "0" & Horita & ":" & Minutitos
    Else
        GetTimeFormated = Horita & ":" & Minutitos
    End If
    
End If
End Function
Public Function GetHora(Mins As Integer) As String
Dim Horita As Byte


Horita = Fix(Mins / 60)


GetHora = Horita


End Function

Public Sub PreloadGraphics()

    Dim PreloadFile As String
    Dim strPreload As String
    Dim NumPreload As Integer
    
    Dim i As Integer
    Dim j As Integer
    
    Dim MinVal As Integer
    Dim MaxVal As Integer
    Dim Priority As Byte
    
    Dim TotalPreloads As Integer
    
#If Compresion = 1 Then
    If Not Extract_File(Scripts, App.Path & "\..\Recursos\OUTPUT\", "preload.ind", Windows_Temp_Dir, False) Then
        Err.Description = "No se ha logrado extraer el archivo de recurso."
        GoTo ErrorHandler
    End If
    
    PreloadFile = Windows_Temp_Dir & "Preload.ind"
#Else
    PreloadFile = App.Path & "\..\Recursos\init\Preload.ind"
#End If
    
    TotalPreloads = Val(General_Var_Get(PreloadFile, "GRAPHICS", "TotalPreloads"))
    If TotalPreloads = 0 Then TotalPreloads = 1

    
    NumPreload = Val(General_Var_Get(PreloadFile, "GRAPHICS", "NumGraphics"))
    
    For i = 1 To NumPreload
        strPreload = General_Var_Get(PreloadFile, "GRAPHICS", str(i))
        MinVal = Val(General_Field_Read(1, strPreload, "-"))
        MaxVal = Val(General_Field_Read(2, strPreload, "-"))
        Priority = Val(General_Field_Read(3, strPreload, "-"))
        
        
            For j = MinVal To MaxVal
             Static d3dTextures As D3D8Textures
            Set d3dTextures.texture = SurfaceDB.GetTexture(j, d3dTextures.texwidth, d3dTextures.texheight)
                'Call SurfaceDB.GetTexture(j, 1024, 1024)
                DoEvents
            Next j
 
    Next i
    
#If Compresion = 1 Then
    Delete_File Windows_Temp_Dir & "Preload.ind"
#End If
    
    Exit Sub
    
ErrorHandler:
  '  If General_File_Exists(Windows_Temp_Dir & "Preload.ind", vbNormal) Then Delete_File Windows_Temp_Dir & "Preload.ind"

End Sub

Public Sub CalcularPosicionMAPA()
frmMapaGrande.lblMapInfo(0) = MapDat.map_name & "(" & UserMap & ")"


If NameMaps(UserMap).desc <> "" Then
    frmMapaGrande.Label1.Caption = NameMaps(UserMap).desc
Else
    frmMapaGrande.Label1.Caption = "Sin informaci�n relevante."
End If



Dim i As Integer
Dim Encontre As Boolean

    For i = 1 To 252
        If WordMapa(i) = UserMap Then
            idmap = i
            Encontre = True
            If frmMapaGrande.Visible = False Then
            frmMapaGrande.picMap.Picture = LoadInterface("mapa.bmp")
            frmMapaGrande.Shape3.BackColor = RGB(0, 83, 114)
            End If
            frmMapaGrande.Image2.Picture = Nothing
            Dungeon = False
            PosREAL = 1
            Exit For
        End If
        

    Next i
    
    
    If Encontre = False Then
    
        For i = 1 To 252
        If DungeonData(i) = UserMap Then
            idmap = i
            Encontre = True
            If frmMapaGrande.Visible = False Then
            frmMapaGrande.Image2.Picture = LoadInterface("mapa_boton1.bmp")
            frmMapaGrande.picMap.Picture = LoadInterface("mapadungeon.bmp")
            frmMapaGrande.Shape3.BackColor = RGB(0, 0, 0)
            End If
            PosREAL = 0
            Dungeon = True
            Exit For
        End If
        Next i
    End If
    
    If Encontre = False Then
    If frmMapaGrande.Visible = False Then
        frmMapaGrande.picMap.Picture = LoadInterface("mapa.bmp")
        frmMapaGrande.Shape3.BackColor = RGB(0, 83, 114)
         frmMapaGrande.Image2.Picture = Nothing
    End If
    End If
    
    
 Call CargarDatosMapa(UserMap)
 
 

    

    
    Dim X As Long
    Dim Y As Long
    
    X = (idmap - 1) Mod 14
    Y = Int((idmap - 1) / 14)


frmMapaGrande.lblAllies.Top = Y * 32
frmMapaGrande.lblAllies.Left = X * 32

frmMapaGrande.Shape1.Top = Y * 32 + (UserPos.Y / 4.5)
frmMapaGrande.Shape1.Left = X * 32 + (UserPos.X / 4.5)


End Sub
Public Function GetDriveSerialNumber(Optional ByVal DriveLetter As String) As Long
'***************************************************
'Author: Nahuel Casas (Zagen)
'Last Modify Date: 07/12/2009
' 07/12/2009: Zagen - Convert� las funciones, en formulas mas f�ciles de modificar.
'***************************************************
    On Error Resume Next
          Dim fso As Object, Drv As Object, DriveSerial As Long
         
          'Creamos el objeto FileSystemObject.
          Set fso = CreateObject("Scripting.FileSystemObject")
         
          'Asignamos el driver principal.
          If DriveLetter <> "" Then
              Set Drv = fso.GetDrive(DriveLetter)
          Else
              Set Drv = fso.GetDrive(fso.GetDriveName(App.Path))
          End If
     
          With Drv
              If .IsReady Then
                  DriveSerial = Abs(.SerialNumber)
              Else    '"Si el driver no est� como para empezar ..."
                  DriveSerial = -1
              End If
          End With
         
          'Borramos y limpiamos.
          Set Drv = Nothing
          Set fso = Nothing
    'Seteamos :)
    GetDriveSerialNumber = DriveSerial
         
End Function
Public Function GetMacAddress() As String
    Const OFFSET_LENGTH As Long = 400
    Dim lSize           As Long
    Dim baBuffer()      As Byte
    Dim lIdx            As Long
    Dim sRetVal         As String
    
    Call GetAdaptersInfo(ByVal 0, lSize)
    If lSize <> 0 Then
        ReDim baBuffer(0 To lSize - 1) As Byte
        Call GetAdaptersInfo(baBuffer(0), lSize)
        Call CopyMemory(lSize, baBuffer(OFFSET_LENGTH), 4)
        For lIdx = OFFSET_LENGTH + 4 To OFFSET_LENGTH + 4 + lSize - 1
            sRetVal = IIf(LenB(sRetVal) <> 0, sRetVal & ":", vbNullString) & Right$("0" & Hex$(baBuffer(lIdx)), 2)
        Next
    End If
    GetMacAddress = sRetVal
End Function


Public Sub EstablecerImgEstado()




If HoraFantasia > 0 And HoraFantasia < 60 Then
    frmmain.PicMeteo.Picture = LoadInterface("a29.bmp")
ElseIf HoraFantasia < 120 And HoraFantasia >= 60 Then
    frmmain.PicMeteo.Picture = LoadInterface("a1.bmp")
ElseIf HoraFantasia < 180 And HoraFantasia >= 120 Then
    frmmain.PicMeteo.Picture = LoadInterface("a2.bmp")
ElseIf HoraFantasia < 240 And HoraFantasia >= 180 Then
    frmmain.PicMeteo.Picture = LoadInterface("a3.bmp")
ElseIf HoraFantasia < 270 And HoraFantasia >= 240 Then
    frmmain.PicMeteo.Picture = LoadInterface("a4.bmp")
ElseIf HoraFantasia < 300 And HoraFantasia >= 270 Then
    frmmain.PicMeteo.Picture = LoadInterface("a5.bmp")
ElseIf HoraFantasia < 330 And HoraFantasia >= 300 Then
    frmmain.PicMeteo.Picture = LoadInterface("a6.bmp")
ElseIf HoraFantasia < 360 And HoraFantasia >= 330 Then
    frmmain.PicMeteo.Picture = LoadInterface("a7.bmp")
ElseIf HoraFantasia < 420 And HoraFantasia >= 360 Then
    frmmain.PicMeteo.Picture = LoadInterface("a8.bmp")
ElseIf HoraFantasia < 450 And HoraFantasia >= 420 Then
    frmmain.PicMeteo.Picture = LoadInterface("a9.bmp")
ElseIf HoraFantasia < 480 And HoraFantasia >= 450 Then
    frmmain.PicMeteo.Picture = LoadInterface("a10.bmp")
ElseIf HoraFantasia < 510 And HoraFantasia >= 480 Then
    frmmain.PicMeteo.Picture = LoadInterface("a11.bmp")
ElseIf HoraFantasia < 540 And HoraFantasia >= 510 Then
    frmmain.PicMeteo.Picture = LoadInterface("a12.bmp")
ElseIf HoraFantasia < 600 And HoraFantasia >= 540 Then
    frmmain.PicMeteo.Picture = LoadInterface("a13.bmp")
ElseIf HoraFantasia < 660 And HoraFantasia >= 600 Then
    frmmain.PicMeteo.Picture = LoadInterface("a14.bmp")
ElseIf HoraFantasia < 720 And HoraFantasia >= 660 Then
    frmmain.PicMeteo.Picture = LoadInterface("a15.bmp")
ElseIf HoraFantasia < 780 And HoraFantasia >= 720 Then
    frmmain.PicMeteo.Picture = LoadInterface("a16.bmp")
ElseIf HoraFantasia < 840 And HoraFantasia >= 780 Then
    frmmain.PicMeteo.Picture = LoadInterface("a17.bmp")
ElseIf HoraFantasia < 900 And HoraFantasia >= 840 Then
    frmmain.PicMeteo.Picture = LoadInterface("a18.bmp")
ElseIf HoraFantasia < 960 And HoraFantasia >= 900 Then
    frmmain.PicMeteo.Picture = LoadInterface("a19.bmp")
ElseIf HoraFantasia < 1020 And HoraFantasia >= 960 Then
    frmmain.PicMeteo.Picture = LoadInterface("a20.bmp")
ElseIf HoraFantasia < 1080 And HoraFantasia >= 1020 Then
    frmmain.PicMeteo.Picture = LoadInterface("a21.bmp")
ElseIf HoraFantasia < 1140 And HoraFantasia >= 1080 Then
    frmmain.PicMeteo.Picture = LoadInterface("a22.bmp")
ElseIf HoraFantasia < 1170 And HoraFantasia >= 1140 Then
    frmmain.PicMeteo.Picture = LoadInterface("a23.bmp")
ElseIf HoraFantasia < 1200 And HoraFantasia >= 1170 Then
    frmmain.PicMeteo.Picture = LoadInterface("a24.bmp")
ElseIf HoraFantasia < 1260 And HoraFantasia >= 1200 Then
    frmmain.PicMeteo.Picture = LoadInterface("a25.bmp")
ElseIf HoraFantasia < 1320 And HoraFantasia >= 1260 Then
    frmmain.PicMeteo.Picture = LoadInterface("a26.bmp")
ElseIf HoraFantasia < 1380 And HoraFantasia >= 1320 Then
    frmmain.PicMeteo.Picture = LoadInterface("a27.bmp")
ElseIf HoraFantasia >= 1380 Then
    frmmain.PicMeteo.Picture = LoadInterface("a28.bmp")

End If

Exit Sub


End Sub


Public Function ObtenerIdMapaDeLlamadaDeClan(ByVal mapa As Integer) As Integer

Dim i As Integer
Dim Encontre As Boolean

    For i = 1 To 252
        If WordMapa(i) = mapa Then
            ObtenerIdMapaDeLlamadaDeClan = i
            frmMapaGrande.llamadadeclan.Tag = 0
            Exit Function
            Encontre = True

            PosREAL = 1
            Exit For
        End If
        

    Next i
    
    If Encontre = False Then
    
        For i = 1 To 252
        If DungeonData(i) = mapa Then
            frmMapaGrande.llamadadeclan.Tag = 1
            ObtenerIdMapaDeLlamadaDeClan = i
            Exit Function
            Encontre = True
            PosREAL = 0
            Dungeon = True
            Exit For
        End If
        Next i
    End If
ObtenerIdMapaDeLlamadaDeClan = 0
End Function

Public Sub Auto_Drag(ByVal hwnd As Long)
Call ReleaseCapture
Call SendMessage(hwnd, WM_NCLBUTTONDOWN, HTCAPTION, ByVal 0&)
End Sub
