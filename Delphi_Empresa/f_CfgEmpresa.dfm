object p_CfgEmpresa: Tp_CfgEmpresa
  Left = 697
  Top = 406
  BorderStyle = bsNone
  Caption = 'Configura'#231#227'o da empresa'
  ClientHeight = 331
  ClientWidth = 343
  Color = 16767935
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 343
    Height = 331
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 3
    ParentColor = True
    TabOrder = 0
    object Panel2: TPanel
      Left = 6
      Top = 6
      Width = 331
      Height = 39
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = True
      ParentColor = True
      TabOrder = 0
      object Label3: TLabel
        Left = 12
        Top = 6
        Width = 303
        Height = 29
        Caption = 'Configura'#231#227'o da Empresa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object BoxIdentificacao: TGroupBox
      Left = 6
      Top = 45
      Width = 331
      Height = 91
      Align = alTop
      Caption = ' Identifica'#231#227'o '
      TabOrder = 1
      object Label2: TLabel
        Left = 7
        Top = 41
        Width = 40
        Height = 13
        Caption = 'Fantasia'
      end
      object Label1: TLabel
        Left = 7
        Top = 19
        Width = 63
        Height = 13
        Caption = 'Raz'#227'o Social'
      end
      object Label4: TLabel
        Left = 7
        Top = 63
        Width = 48
        Height = 13
        Caption = 'C. N. P. J.'
      end
      object Label5: TLabel
        Left = 190
        Top = 63
        Width = 23
        Height = 13
        Caption = 'Inscr'
      end
      object EditRazaoSocial: TEdit
        Left = 75
        Top = 16
        Width = 249
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 35
        TabOrder = 0
        OnKeyDown = FormKeyDown
      end
      object EditFantasia: TEdit
        Left = 75
        Top = 38
        Width = 249
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 25
        TabOrder = 1
        OnKeyDown = FormKeyDown
      end
      object EditCgc: TMaskEdit
        Left = 75
        Top = 60
        Width = 108
        Height = 21
        CharCase = ecUpperCase
        EditMask = '99.999.999/9999-99;0; '
        MaxLength = 18
        TabOrder = 2
        OnKeyDown = FormKeyDown
      end
      object EditCgf: TMaskEdit
        Left = 216
        Top = 60
        Width = 108
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 15
        TabOrder = 3
        OnKeyDown = FormKeyDown
      end
    end
    object BoxLocalizacao: TGroupBox
      Left = 6
      Top = 136
      Width = 331
      Height = 156
      Align = alClient
      Caption = ' Localiza'#231#227'o '
      TabOrder = 2
      object Label6: TLabel
        Left = 7
        Top = 19
        Width = 46
        Height = 13
        Caption = 'Endere'#231'o'
      end
      object Label7: TLabel
        Left = 7
        Top = 63
        Width = 27
        Height = 13
        Caption = 'Bairro'
      end
      object Label8: TLabel
        Left = 223
        Top = 63
        Width = 33
        Height = 13
        Caption = 'C. E. P'
      end
      object Label9: TLabel
        Left = 7
        Top = 85
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object Label10: TLabel
        Left = 235
        Top = 85
        Width = 20
        Height = 13
        Caption = 'U.F.'
      end
      object Label12: TLabel
        Left = 7
        Top = 107
        Width = 24
        Height = 13
        Caption = 'Fone'
      end
      object Label11: TLabel
        Left = 8
        Top = 130
        Width = 17
        Height = 13
        Caption = 'Fax'
      end
      object Label14: TLabel
        Left = 7
        Top = 41
        Width = 37
        Height = 13
        Caption = 'N'#250'mero'
      end
      object Label15: TLabel
        Left = 133
        Top = 41
        Width = 46
        Height = 13
        Caption = 'Complem.'
      end
      object EditEndereco: TEdit
        Left = 75
        Top = 16
        Width = 249
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 35
        TabOrder = 0
        OnKeyDown = FormKeyDown
      end
      object EditBairro: TEdit
        Left = 75
        Top = 60
        Width = 144
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 20
        TabOrder = 3
        OnKeyDown = FormKeyDown
      end
      object EditCidade: TEdit
        Left = 75
        Top = 82
        Width = 144
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 25
        TabOrder = 5
        OnKeyDown = FormKeyDown
      end
      object EditEstado: TEdit
        Left = 259
        Top = 82
        Width = 25
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 2
        TabOrder = 6
        OnKeyDown = FormKeyDown
      end
      object EditComplemento: TEdit
        Left = 181
        Top = 38
        Width = 143
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 22
        TabOrder = 2
        OnKeyDown = FormKeyDown
      end
      object EditNumero: TMaskEdit
        Left = 75
        Top = 38
        Width = 54
        Height = 21
        AutoSize = False
        CharCase = ecUpperCase
        TabOrder = 1
        OnKeyDown = FormKeyDown
        OnKeyPress = EditNumeroKeyPress
      end
      object EditCep: TMaskEdit
        Left = 259
        Top = 60
        Width = 65
        Height = 21
        CharCase = ecUpperCase
        EditMask = '99.999-999;0; '
        MaxLength = 10
        TabOrder = 4
        OnKeyDown = FormKeyDown
      end
      object EditFone: TMaskEdit
        Left = 75
        Top = 104
        Width = 105
        Height = 21
        CharCase = ecUpperCase
        EditMask = '(99)9999.9999;0; '
        MaxLength = 13
        TabOrder = 7
        OnKeyDown = FormKeyDown
      end
      object EditFax: TMaskEdit
        Left = 75
        Top = 126
        Width = 105
        Height = 21
        CharCase = ecUpperCase
        EditMask = '(99)9999.9999;0; '
        MaxLength = 13
        TabOrder = 8
        OnKeyDown = FormKeyDown
      end
    end
    object Panel3: TPanel
      Left = 6
      Top = 292
      Width = 331
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      Color = 12078348
      TabOrder = 3
      DesignSize = (
        331
        33)
      object BitBtn1: TBitBtn
        Left = 249
        Top = 5
        Width = 75
        Height = 23
        Anchors = [akRight, akBottom]
        Caption = 'Avan'#231'ar'
        TabOrder = 0
        OnClick = BitBtn1Click
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF046209035F09035606014F04014C0401
          4C04014C04014C04014C04014C04014C04013D03FF00FFFF00FFFF00FF078216
          0C9C23099A1D07961505920F03900B038F0A038F0A03900A03900A038F0A0396
          0B027407013D03FF00FFFF00FF0D982513B53A0FAF2D0CAC2309AB1C06A71504
          A50E03A50C03A50C03A50C03A40C03AC0D03960A014C04FF00FFFF00FF10A02D
          1CB44916AD3911A92F0DA7260AA41E07A016059F10039E0C039D0B039C0B03A4
          0C03900A014D04FF00FFFF00FF11A12F28B85B1FB24CFEFEFE12AA350EA72A0B
          A522FEFEFE05A013039F0D039D0B03A50C03900A014C04FF00FFFF00FF11A12F
          3EC2702DBA5FFEFEFEFEFEFE13AB360FA92DFEFEFEFEFEFE06A016049E0F03A4
          0C03900A014C04FF00FFFF00FF11A12F5CCC8838BD6724B757FEFEFEFEFEFE14
          AC3A11AB31FEFEFEFEFEFE08A11905A71203910B014D04FF00FFFF00FF11A12F
          70D49742C2702AB85B21B553FEFEFEFEFEFE15AD3E11AB35FEFEFEFEFEFE09A9
          1C059311025405FF00FFFF00FF11A12F7DD79F4AC5762FBB5FFEFEFEFEFEFE1C
          B24E1AB14AFEFEFEFEFEFE0FA92D0DAC2709991B035F09FF00FFFF00FF11A12F
          86DAA654C97FFEFEFEFEFEFE28B85923B555FEFEFEFEFEFE18B04515AD3B12AF
          350D9E25056B0CFF00FFFF00FF11A12F93DEB166CF8CFEFEFE3FC16D34BD642C
          BA5DFEFEFE23B5551DB25019B04817B14210A12F06760FFF00FFFF00FF11A130
          99E1B590DDAD78D59A6CD0915DCB864CC6783FC16D2CBA5D20B5531DB2511CB5
          4F15A93D088414FF00FFFF00FF11A12F79D79F99E1B69DE2B893DEB183DAA56D
          D3954FC97E35BF6824B75920B5551FB85818AD43098E16FF00FFFF00FFFF00FF
          22A94037B55539B55637B55433B2502AAF4921AA401AA63913A43112A13212A4
          310C9A23FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
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
    Left = 240
    Top = 57
  end
  object SQLQuery1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnection1
    Left = 288
    Top = 56
  end
end
