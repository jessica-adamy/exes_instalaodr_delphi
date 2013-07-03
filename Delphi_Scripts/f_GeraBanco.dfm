object p_GeraBanco: Tp_GeraBanco
  Left = 475
  Top = 295
  BorderStyle = bsNone
  Caption = 'Conex'#227'o com o banco'
  ClientHeight = 309
  ClientWidth = 309
  Color = 16767935
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 309
    Height = 309
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 3
    ParentColor = True
    TabOrder = 0
    object Panel2: TPanel
      Left = 6
      Top = 268
      Width = 297
      Height = 35
      Align = alBottom
      BevelOuter = bvNone
      Color = 12078348
      TabOrder = 3
      TabStop = True
      DesignSize = (
        297
        35)
      object BitBtn1: TBitBtn
        Left = 216
        Top = 7
        Width = 75
        Height = 23
        Anchors = [akRight, akBottom]
        Caption = 'Executar'
        TabOrder = 0
        OnClick = BitBtn1Click
        OnKeyDown = FormKeyDown
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000010000FF00FF007246
          2A002D414800354141003E434000304B50005066640079766600863E1B00A629
          0200A92B0200A92D0300B43307009341180091411F00AC400600B0410000B254
          1700874F3100B8663000BC693300C65D0C00D8771D00BF73400067827A00DC8F
          4700CE8C5900F3B56A00E7B47900EEB77A000764900005669500086B9A000274
          A9000479AF000788BC000386C100058BC7000791C5001CAAD3002DAFCC002CA7
          D30031B5D30030B0DA0013CAFB0012CBFE0030C9E90020CEFE003FE3FE0048CF
          F20055D8F60054DEFF0055F6FE005FFEFF0074E0F80068F6FF0073FAFE0078FB
          FE007FFEFF00FCD39600C5C2BA00FEE0A70083FAFB0089FBFE0092FFFF009FFB
          FE0098FFFF00A7E9F300A3F3FF00A0FFFF00B6F2FF00B7FFFF00C6FFFF00DAF8
          FF00DCFFFF00E5FAFF00EDFAFC00F0FFFF00FBFFFF0000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000000C
          00000000000000000000000000001F050C031F1F000000000000000000212E2C
          010C07291F000000000000002138302C28080F06241F0000000000002138302C
          2F180D0C041F0000000000002138302C2F321213090200000000000021414446
          494B3C0D1C09000000000000214327262310100F1A3D090000000000212A302C
          2F10173B1D0B0909000000002138302C2F3310141B190900000000002138302C
          2F3336101116150B000000002138302C2F33362B101010090900000021393734
          35393F31251F000000000000214E4D4845414140341F00000000000000224C49
          47413F3E20000000000000000000212121212121000000000000}
      end
    end
    object GroupBox2: TGroupBox
      Left = 6
      Top = 45
      Width = 297
      Height = 164
      Align = alTop
      Caption = ' Dados SQL Server '
      TabOrder = 1
      object Label2: TLabel
        Left = 8
        Top = 16
        Width = 89
        Height = 13
        Caption = 'Nome da m'#225'quina:'
      end
      object Label3: TLabel
        Left = 8
        Top = 44
        Width = 91
        Height = 13
        Caption = 'Nome da inst'#226'ncia:'
      end
      object Label4: TLabel
        Left = 8
        Top = 73
        Width = 39
        Height = 13
        Caption = 'Usu'#225'rio:'
      end
      object Label5: TLabel
        Left = 8
        Top = 102
        Width = 34
        Height = 13
        Caption = 'Senha:'
      end
      object NomeMaqEdit: TEdit
        Left = 104
        Top = 12
        Width = 187
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
        OnKeyDown = FormKeyDown
      end
      object NomeInstancEdit: TEdit
        Left = 104
        Top = 40
        Width = 187
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
        OnKeyDown = FormKeyDown
      end
      object UsuarioEdit: TEdit
        Left = 104
        Top = 69
        Width = 187
        Height = 21
        TabOrder = 2
        OnKeyDown = FormKeyDown
      end
      object SenhaEdit: TEdit
        Left = 104
        Top = 98
        Width = 187
        Height = 21
        PasswordChar = '*'
        TabOrder = 3
        OnKeyDown = FormKeyDown
      end
      object TestarConexaoBtn: TBitBtn
        Left = 200
        Top = 130
        Width = 91
        Height = 25
        Caption = 'Testar conex'#227'o'
        TabOrder = 4
        OnClick = TestarConexaoBtnClick
        OnKeyDown = FormKeyDown
      end
    end
    object GroupBox1: TGroupBox
      Left = 6
      Top = 209
      Width = 297
      Height = 59
      Align = alClient
      TabOrder = 2
      object Gauge: TGauge
        Left = 8
        Top = 14
        Width = 280
        Height = 23
        BackColor = 16767935
        ForeColor = 5562660
        Progress = 0
      end
      object Label1: TLabel
        Left = 8
        Top = 45
        Width = 32
        Height = 13
        Caption = 'Label1'
      end
    end
    object Panel3: TPanel
      Left = 6
      Top = 6
      Width = 297
      Height = 39
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = True
      ParentColor = True
      TabOrder = 0
      object Label11: TLabel
        Left = 7
        Top = 6
        Width = 285
        Height = 29
        Caption = 'Configura'#231#227'o de Acesso'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'SQLServerConnection'
    DriverName = 'SQLServer'
    GetDriverFunc = 'getSQLDriverSQLServer'
    LibraryName = 'dbexpsda.dll'
    LoginPrompt = False
    Params.Strings = (
      'BlobSize=-1'
      'HostName='
      'DataBase='
      'DriverName=SQLServer'
      'User_Name=sa'
      'Password='
      'LongStrings=True'
      'EnableBCD=True'
      'FetchAll=True')
    VendorLib = 'sqloledb.dll'
    Left = 192
    Top = 73
  end
  object SQLQuery1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnection1
    Left = 240
    Top = 72
  end
end
