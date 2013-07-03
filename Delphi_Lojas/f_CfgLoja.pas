unit f_CfgLoja;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, DBCtrls, Buttons, DBXpress, FMTBcd,
  DB, SqlExpr, ShellApi, IniFiles;

type
  Tp_CfgLoja = class(TForm)
    Panel1: TPanel;
    BoxLocalizacao: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    EditDesEndere: TEdit;
    EditDesBairro: TEdit;
    EditDesCidade: TEdit;
    EditDesEstado: TEdit;
    EditCplEndere: TEdit;
    GroupBox1: TGroupBox;
    Label22: TLabel;
    Label26: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    EditDesRazSoc: TEdit;
    EditDesLoja: TEdit;
    GroupBoxConfiguracoes: TGroupBox;
    Label1: TLabel;
    lblTexto: TLabel;
    checkConsolidadora: TCheckBox;
    Panel2: TPanel;
    Label11: TLabel;
    Panel3: TPanel;
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    EditNumCnpj: TMaskEdit;
    EditNumInscri: TMaskEdit;
    EditNumInsMun: TMaskEdit;
    EditNumEndere: TMaskEdit;
    EditNumCep: TMaskEdit;
    EditNumFone: TMaskEdit;
    EditCodLoja: TMaskEdit;
    EditCodLojaCons: TMaskEdit;
    lblConsolidadora: TLabel;
    BitBtn1: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditCodLojaChange(Sender: TObject);
    procedure checkConsolidadoraClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditNumEndereKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    WHostname: String;
    WCentral: Boolean;
    function  Valida: Boolean;
    function  RetornaNomeComputador: String;
    procedure CriaIniServer;
    procedure ConexaoBanco;
    procedure ExecutarScripts(cod_loja: string);
    procedure SetaConfiguracoes;
    procedure StatusTela;
  public
    { Public declarations }
  end;

var
  p_CfgLoja: Tp_CfgLoja;

implementation

uses StrUtils;

{$R *.dfm}

const
  C1 = 52845;
  C2 = 22719;
  key = 021130;

function Decrypt(const S: String; Key: Word): String;
var
  I: byte;
begin
  SetLength(Result,Length(S));
  for I := 1 to Length(S) do begin
    Result[I] := char(byte(S[I]) xor (Key shr 8));
    Key := (byte(S[I]) + Key) * C1 + C2;
  end;
end;

procedure Tp_CfgLoja.ConexaoBanco;
var
  WArqIni: TIniFile;
  WMaquina,
  WInstancia,
  WUserName,
  WPassword, WPassEncrypt: String;
begin
  try
    WArqIni   := TIniFile.Create(ExtractFilePath(Application.ExeName)+'\Config.ini');
    WMaquina  := WArqIni.ReadString('CONEXAO', 'MAQUINA', '');
    WInstancia:= WArqIni.ReadString('CONEXAO', 'INSTANCIA', '');
    WUserName := WArqIni.ReadString('CONEXAO', 'USUARIO', '');
    WPassEncrypt := WArqIni.ReadString('CONEXAO', 'SENHA', '');
    WPassword := Decrypt(WPassEncrypt, key);
    WHostname := WMaquina + IfThen(WInstancia <> '', '\'+WInstancia, '');

    SQLConnection1.Close;
    SQLConnection1.Params.Values['HostName']  := WHostname;
    SQLConnection1.Params.Values['DataBase']  := 'VMD';
    SQLConnection1.Params.Values['User_Name'] := WUserName;
    SQLConnection1.Params.Values['Password']  := WPassword;
    SQLConnection1.Open;
  finally
    WArqIni.Free;
  end;
end;

procedure Tp_CfgLoja.ExecutarScripts(cod_loja: string);
var
  lojaJaCadastrada: Integer;
  WData: String;
begin
  lojaJaCadastrada := 0;
  if SQLConnection1.Connected then
    begin
      try
        // Exclui a loja caso seja central
        if WCentral then
          begin
            SQLQuery1.Close;
            SQLQuery1.SQL.Text := 'USE [VMD] '        +
                                  'DELETE FROM LOJAS';
            SQLQuery1.ExecSQL;
          end
        else
          begin
            SQLQuery1.Close;
            SQLQuery1.SQL.Text := ' select count(cod_loja) qtd from lojas where cod_loja='+quotedstr(cod_loja);
            SQLQuery1.Open;
            lojaJaCadastrada :=  SQLQuery1.fieldByName('qtd').AsInteger;
          end;
        // Insere a loja configurada
        if lojaJaCadastrada = 0 then
          begin
            SQLQuery1.Close;
            WData := QuotedStr(FormatDateTime('YYYYMMDD', Now));
            SQLQuery1.SQL.Text := 'USE [VMD] '             +
                                  'INSERT INTO LOJAS '     +
                                  '  (Cod_Loja, '          +
                                  '   Des_Loja, '          +
                                  '   Num_Cnpj, '          +
                                  '   Num_Inscri, '        +
                                  '   Num_InsMun, '        +
                                  '   Des_RazSoc, '        +
                                  '   Des_Endere, '        +
                                  '   Num_Endere, '        +
                                  '   Cpl_Endere, '        +
                                  '   Des_Bairro, '        +
                                  '   Num_Cep, '           +
                                  '   Des_Cidade, '        +
                                  '   Des_Estado, '        +
                                  '   Num_Fone, '          +
                                  '   Dat_ImpEst, '        +
                                  '   Dat_ImpMov, '        +
                                  '   Dat_Cadast, '        +
                                  '   Par_DatUltFecSem, '  +
                                  '   Par_DatUltFecDia, '  +
                                  '   Par_DatUltImpCad, '  +
                                  '   Par_DatInventSNGPC, '+
                                  '   Par_DatUltMovSNGPC) '+
                                  'VALUES '                +
                                  '  ('+cod_loja                     +','
                                       +QuotedStr(EditDesLoja.Text)  +','
                                       +QuotedStr(EditNumCnpj.Text)  +','
                                       +QuotedStr(EditNumInscri.Text)+','
                                       +QuotedStr(EditNumInsMun.Text)+','
                                       +QuotedStr(EditDesRazSoc.Text)+','
                                       +QuotedStr(EditDesEndere.Text)+','
                                       +EditNumEndere.Text           +','
                                       +QuotedStr(EditCplEndere.Text)+','
                                       +QuotedStr(EditDesBairro.Text)+','
                                       +QuotedStr(EditNumCep.Text)   +','
                                       +QuotedStr(EditDesCidade.Text)+','
                                       +QuotedStr(EditDesEstado.Text)+','
                                       +QuotedStr(EditNumFone.Text)  +','
                                       +WData                        +','
                                       +WData                        +','
                                       +WData                        +','
                                       +WData                        +','
                                       +WData                        +','
                                       +WData                        +','
                                       +WData                        +','
                                       +WData                        +')';
            SQLQuery1.ExecSQL;
        end;
      except
        on e: Exception do
          raise Exception.Create(e.Message);
      end;
    end;
end;

procedure Tp_CfgLoja.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SQLConnection1.Close;
//    if FileExists((ExtractFilePath(Application.ExeName)+'\Config.ini')) then
//      DeleteFile((ExtractFilePath(Application.ExeName)+'\Config.ini'));
end;

function Tp_CfgLoja.Valida: Boolean;
begin
  Result := True;
  if (Trim(EditDesLoja.Text) = '') then
    begin
      Application.MessageBox('Descrição da loja inválida.', 'Instalador infarma', MB_ICONERROR);
      EditDesLoja.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditDesRazSoc.Text) = '') then
    begin
      Application.MessageBox('Razão social inválida.', 'Instalador infarma', MB_ICONERROR);
      EditDesRazSoc.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditNumCnpj.Text) = '') then
    begin
      Application.MessageBox('CNPJ inválido.', 'Instalador infarma', MB_ICONERROR);
      EditNumCnpj.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditNumInscri.Text) = '') then
    begin
      Application.MessageBox('Inscrição estadual inválida.', 'Instalador infarma', MB_ICONERROR);
      EditNumInscri.SetFocus;
      Result := False;
      Exit;
    end;
{  if (Trim(EditNumInsMun.Text) = '') then
    begin
      Application.MessageBox('Inscrição municipal inválida.', 'Instalador infarma', MB_ICONERROR);
      EditNumInsMun.SetFocus;
      Result := False;
      Exit;
    end;  }
  if (Trim(EditDesEndere.Text) = '') then
    begin
      Application.MessageBox('Endereço inválido.', 'Instalador infarma', MB_ICONERROR);
      EditDesEndere.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditNumEndere.Text) = '') then
    begin
      Application.MessageBox('Número inválido.', 'Instalador infarma', MB_ICONERROR);
      EditNumEndere.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditDesBairro.Text) = '') then
    begin
      Application.MessageBox('Bairro inválido.', 'Instalador infarma', MB_ICONERROR);
      EditDesBairro.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditNumCep.Text) = '') then
    begin
      Application.MessageBox('CEP inválido.', 'Instalador infarma', MB_ICONERROR);
      EditNumCep.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditDesCidade.Text) = '') then
    begin
      Application.MessageBox('Cidade inválida.', 'Instalador infarma', MB_ICONERROR);
      EditDesCidade.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditDesEstado.Text) = '') then
    begin
      Application.MessageBox('UF inválida.', 'Instalador infarma', MB_ICONERROR);
      EditDesEstado.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditNumFone.Text) = '') then
    begin
      Application.MessageBox('Fone inválido.', 'Instalador infarma', MB_ICONERROR);
      EditNumFone.SetFocus;
      Result := False;
      Exit;
    end;
    if (EditCodLoja.Text = '') then
      begin
        Application.MessageBox('Código desta loja inválido', 'Instalador inFarma', MB_ICONERROR);
        EditCodLoja.SetFocus;
        Result := False;
        Exit;
      end;
    if (EditCodLojaCons.Text = '') and (not WCentral) then
      begin
        Application.MessageBox('Código da loja consolidadora inválido', 'Instalador inFarma', MB_ICONERROR);
        EditCodLojaCons.SetFocus;
        Result := False;
        Exit;
      end;
    if (StrToIntDef(EditCodLoja.Text, 0) > 0) and
       (WCentral) then
      begin
        if Application.MessageBox('Código padrão do central geralmente é zero. Deseja continuar?', 'Instalador inFarma', MB_ICONWARNING+MB_YESNO) = IDYES then
          begin
            if (StrToIntDef(EditCodLoja.Text, 0) = 0) and
               (not WCentral) then
              begin
                Application.MessageBox('Código padrão do varejo deve ser maior que zero', 'Instalador inFarma', MB_ICONERROR);
                EditCodLoja.SetFocus;
                Result := False;
                Exit;
              end;
          end
        else
          Result := False;
          Exit;
      end;
    if (not checkConsolidadora.Checked) and  (not WCentral) and
       (StrToIntDef(EditCodLoja.Text, 0) = StrToIntDef(EditCodLojaCons.Text, 0)) then
      begin
        Application.MessageBox('Código da loja consolidadora deve ser diferente do código desta loja.', 'Instalador inFarma', MB_ICONERROR);
        EditCodLojaCons.SetFocus;
        Result := False;
        Exit;
      end;
end;

procedure Tp_CfgLoja.FormCreate(Sender: TObject);
begin
  WHostname := '';
  WCentral  := (UpperCase(ParamStr(2)) = 'CENTRAL');
  ConexaoBanco;
  if WCentral then
    begin
      checkConsolidadora.Visible := false;
      lblConsolidadora.Visible := false;
      EditCodLojaCons.Visible := false;
    end
  else
    begin
      checkConsolidadora.Visible := true;
      lblConsolidadora.Visible := true;
      EditCodLojaCons.Visible := true;
    end;
end;

procedure Tp_CfgLoja.FormShow(Sender: TObject);
begin
  // Setar o banco VMD
  SQLQuery1.Close;
  SQLQuery1.SQL.Text := 'USE [VMD]';
  SQLQuery1.ExecSQL;

  // Seta os dados da loja baseado na configuração da empresa
  SQLQuery1.Close;
  SQLQuery1.SQL.Text := 'SELECT Razao_Social, Fantasia, Endereco, Numero, Complemento, '+
                        '       Bairro, CEP, Cidade, Estado, CGC, CGF, Fone '+
                        'FROM EMPRE';
  SQLQuery1.Open;

  if (not SQLQuery1.IsEmpty) then
    begin
      EditDesLoja.Text := SQLQuery1.FieldByName('Fantasia').AsString;
      EditDesRazSoc.Text := SQLQuery1.FieldByName('Razao_Social').AsString;
      EditDesEndere.Text := SQLQuery1.FieldByName('Endereco').AsString;
      EditNumEndere.Text := SQLQuery1.FieldByName('Numero').AsString;
      EditCplEndere.Text := SQLQuery1.FieldByName('Complemento').AsString;
      EditDesBairro.Text := SQLQuery1.FieldByName('Bairro').AsString;
      EditNumCep.Text    := SQLQuery1.FieldByName('CEP').AsString;
      EditDesCidade.Text := SQLQuery1.FieldByName('Cidade').AsString;
      EditDesEstado.Text := SQLQuery1.FieldByName('Estado').AsString;
      EditNumCnpj.Text   := SQLQuery1.FieldByName('CGC').AsString;
      EditNumInscri.Text := SQLQuery1.FieldByName('CGF').AsString;
      EditNumFone.Text   := SQLQuery1.FieldByName('Fone').AsString;
    end;
end;

procedure Tp_CfgLoja.SetaConfiguracoes;
begin
  SQLQuery1.Close;
  if not WCentral then
    SQLQuery1.SQL.Text :=   ' Update PARAM SET                 '+
                            ' CodLojCon='+EditCodLojaCons.Text+
                            ' IF @@ROWCOUNT = 0                '+
                            ' Insert Into PARAM (CodLojCon)    '+
                            ' Values ('+EditCodLojaCons.Text+')'
  else
    SQLQuery1.SQL.Text :=   ' Update PARAM SET                 '+
                            ' CodLojCon='+EditCodLoja.Text+
                            ' IF @@ROWCOUNT = 0                '+
                            ' Insert Into PARAM (CodLojCon)    '+
                            ' Values ('+EditCodLoja.Text+')';
  SQLQuery1.ExecSQL;
end;

procedure Tp_CfgLoja.StatusTela;
begin
  lblTexto.Caption := '';

  EditCodLojaCons.Text     := IfThen(checkConsolidadora.Checked, EditCodLoja.Text, EditCodLojaCons.Text);
  EditCodLojaCons.ReadOnly := checkConsolidadora.Checked;

  if (StrToIntDef(EditCodLoja.Text, -1) = 0) and
     (WCentral) then
    lblTexto.Caption := IfThen(checkConsolidadora.Checked,
                               'Central que controla uma rede',
                               'Central que participa de uma rede');

  if (StrToIntDef(EditCodLoja.Text, -1) > 0) and
     (not WCentral) then
    lblTexto.Caption := IfThen(checkConsolidadora.Checked,
                               'Loja de varejo independente',
                               'Loja de varejo que participa de uma rede');

  lblTexto.Visible := (lblTexto.Caption <> '');
end;

procedure Tp_CfgLoja.EditCodLojaChange(Sender: TObject);
begin
  StatusTela;
end;

procedure Tp_CfgLoja.checkConsolidadoraClick(Sender: TObject);
begin
  StatusTela;
end;

procedure Tp_CfgLoja.CriaIniServer;
var
  WArq: TIniFile;
  WValor: String;
begin
  WArq := TIniFile.Create('C:\Windows\VMDServer.ini');
  try
    WArq.WriteString('SERVIDOR', 'HostName' , WHostname);
    WArq.WriteString('SERVIDOR', 'Database' , 'VMD');
    WArq.WriteString('CENTRAL' , 'Loja'     , IfThen(WCentral, EditCodLoja.Text, '-1'));
    WArq.WriteString('CENTRAL' , 'SQL Lojas', '0');
    WArq.WriteString('VAREJO'  , 'Loja'     , IfThen(not WCentral, EditCodLoja.Text, '-1'));
  finally
    WArq.Free;
  end;
end;

function Tp_CfgLoja.RetornaNomeComputador: String;
var
  Buffer: array [0..255] of Char;  Size: DWORD;  ComputerName: String;begin  Size := MAX_COMPUTERNAME_LENGTH + 1;  GetComputerName(Buffer, Size);  ComputerName := Buffer;  Result := ComputerName;end;

procedure Tp_CfgLoja.BitBtn1Click(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  if Valida then
    begin
      if not WCentral then
        begin
          if checkConsolidadora.checked then
            ExecutarScripts(EditCodLoja.text)
          else
            begin
              ExecutarScripts(EditCodLojaCons.text);
              ExecutarScripts(EditCodLoja.text);
            end;
        end
      else
        ExecutarScripts(EditCodLoja.text);
      SetaConfiguracoes;
      CriaIniServer;
      ShellExecute(Handle, nil, 'VMDServer.ini', '', 'C:\Windows\', SW_SHOWNORMAL);
      Self.Close;
    end;
  Screen.Cursor := crDefault;  
end;

procedure Tp_CfgLoja.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     VK_RETURN: Perform(wm_NextDlgCtl,0,0);
   end;
end;

procedure Tp_CfgLoja.EditNumEndereKeyPress(Sender: TObject; var Key: Char);
begin
   if Not (Key in['0'..'9', #8, #44, #46]) then
     Key := #0;
end;

end.
