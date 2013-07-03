unit f_CfgEmpresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls,
  DBXpress, FMTBcd, SqlExpr, IniFiles;

type
  Tp_CfgEmpresa = class(TForm)
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    BoxIdentificacao: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EditRazaoSocial: TEdit;
    EditFantasia: TEdit;
    BoxLocalizacao: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    EditEndereco: TEdit;
    EditBairro: TEdit;
    EditCidade: TEdit;
    EditEstado: TEdit;
    EditComplemento: TEdit;
    Panel3: TPanel;
    EditCgc: TMaskEdit;
    EditCgf: TMaskEdit;
    EditNumero: TMaskEdit;
    EditCep: TMaskEdit;
    EditFone: TMaskEdit;
    EditFax: TMaskEdit;
    BitBtn1: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditNumeroKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function  Valida: Boolean;
    function  RetornaNomeComputador: String;
    procedure ConexaoBanco;
    procedure ExecutarScripts;
  public
    { Public declarations }
  end;

var
  p_CfgEmpresa: Tp_CfgEmpresa;

implementation

uses StrUtils;

{$R *.dfm}

{ Tp_CfgEmpresa }

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

procedure Tp_CfgEmpresa.ConexaoBanco;
var
  WArqIni: TIniFile;
  WMaquina,
  WInstancia,
  WUserName,
  WPassword, WPassEncrypt: String;
begin
  try
    try
      WArqIni   := TIniFile.Create(ExtractFilePath(Application.ExeName)+'\Config.ini');
      WMaquina  := WArqIni.ReadString('CONEXAO', 'MAQUINA', '');
      WInstancia:= WArqIni.ReadString('CONEXAO', 'INSTANCIA', '');
      WUserName := WArqIni.ReadString('CONEXAO', 'USUARIO', '');
      WPassEncrypt := WArqIni.ReadString('CONEXAO', 'SENHA', '');
      WPassword := Decrypt(WPassEncrypt, key);

      SQLConnection1.Close;
      SQLConnection1.Params.Values['HostName']  := WMaquina + IfThen(WInstancia <> '', '\'+WInstancia, '');
      SQLConnection1.Params.Values['DataBase']  := 'VMD';
      SQLConnection1.Params.Values['User_Name'] := WUserName;
      SQLConnection1.Params.Values['Password']  := WPassword;
      SQLConnection1.Open;
    except
      on e: Exception do
        raise Exception.Create(e.Message);
    end;
  finally
    WArqIni.Free;
  end;
end;

procedure Tp_CfgEmpresa.ExecutarScripts;
begin
  if SQLConnection1.Connected then
    begin
      try
        // Exclui a empresa existente
        SQLQuery1.Close;
        SQLQuery1.SQL.Text := 'USE [VMD] '        +
                              'DELETE FROM EMPRE';
        SQLQuery1.ExecSQL;

        // Insere a empresa configurada
        SQLQuery1.Close;
        SQLQuery1.SQL.Text := 'USE [VMD] '        +
                              'INSERT INTO EMPRE '+
                              '  (Razao_Social, ' +
                              '   Fantasia, '     +
                              '   Endereco, '     +
                              '   Numero, '       +
                              '   Complemento, '  +
                              '   Bairro, '       +
                              '   CEP, '          +
                              '   Cidade, '       +
                              '   Estado, '       +
                              '   CGC, '          +
                              '   CGF, '          +
                              '   Fone, '         +
                              '   Fax) '          +
                              'VALUES '           +
                              '  ('+QuotedStr(EditRazaoSocial.Text)+','
                                   +QuotedStr(EditFantasia.Text)   +','
                                   +QuotedStr(EditEndereco.Text)   +','
                                   +EditNumero.Text                +','
                                   +QuotedStr(EditComplemento.Text)+','
                                   +QuotedStr(EditBairro.Text)     +','
                                   +QuotedStr(EditCep.Text)        +','
                                   +QuotedStr(EditCidade.Text)     +','
                                   +QuotedStr(EditEstado.Text)     +','
                                   +QuotedStr(EditCgc.Text)        +','
                                   +QuotedStr(EditCgf.Text)        +','
                                   +QuotedStr(EditFone.Text)       +','
                                   +QuotedStr(EditFax.Text)        +')';
        SQLQuery1.ExecSQL;
      except
        on e: Exception do raise Exception.Create(e.Message);
      end;
    end;
end;

procedure Tp_CfgEmpresa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SQLConnection1.Close;
end;

procedure Tp_CfgEmpresa.FormCreate(Sender: TObject);
begin
  ConexaoBanco;
end;

function Tp_CfgEmpresa.Valida: Boolean;
begin
  Result := True;
  if (Trim(EditRazaoSocial.Text) = '') then
    begin
      Application.MessageBox('Razão social inválida.', 'Instalador infarma', MB_ICONERROR);
      EditRazaoSocial.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditFantasia.Text) = '') then
    begin
      Application.MessageBox('Nome fantasia inválido.', 'Instalador infarma', MB_ICONERROR);
      EditFantasia.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditCgc.Text) = '') then
    begin
      Application.MessageBox('CNPJ inválido.', 'Instalador infarma', MB_ICONERROR);
      EditCgc.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditEndereco.Text) = '') then
    begin
      Application.MessageBox('Endereço inválido.', 'Instalador infarma', MB_ICONERROR);
      EditEndereco.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditEndereco.Text) = '') then
    begin
      Application.MessageBox('Endereço inválido.', 'Instalador infarma', MB_ICONERROR);
      EditEndereco.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditNumero.Text) = '') then
    begin
      Application.MessageBox('Número inválido.', 'Instalador infarma', MB_ICONERROR);
      EditNumero.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditBairro.Text) = '') then
    begin
      Application.MessageBox('Bairro inválido.', 'Instalador infarma', MB_ICONERROR);
      EditBairro.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditCep.Text) = '') then
    begin
      Application.MessageBox('CEP inválido.', 'Instalador infarma', MB_ICONERROR);
      EditCep.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditCidade.Text) = '') then
    begin
      Application.MessageBox('Cidade inválida.', 'Instalador infarma', MB_ICONERROR);
      EditCidade.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditEstado.Text) = '') then
    begin
      Application.MessageBox('UF inválida.', 'Instalador infarma', MB_ICONERROR);
      EditEstado.SetFocus;
      Result := False;
      Exit;
    end;
  if (Trim(EditFone.Text) = '') then
    begin
      Application.MessageBox('Fone inválido.', 'Instalador infarma', MB_ICONERROR);
      EditFone.SetFocus;
      Result := False;
      Exit;
    end;
end;

function Tp_CfgEmpresa.RetornaNomeComputador: String;
var
  Buffer: array [0..255] of Char;  Size: DWORD;  ComputerName: String;begin  Size := MAX_COMPUTERNAME_LENGTH + 1;  GetComputerName(Buffer, Size);  ComputerName := Buffer;  Result := ComputerName;end;

procedure Tp_CfgEmpresa.BitBtn1Click(Sender: TObject);
begin
  if Valida then
    begin
      ExecutarScripts;
      Self.Close;
    end;
end;

procedure Tp_CfgEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
  case Key of
    VK_RETURN: Perform(wm_NextDlgCtl,0,0);
  end;
end;

procedure Tp_CfgEmpresa.EditNumeroKeyPress(Sender: TObject; var Key: Char);
begin
   if Not (Key in['0'..'9', #8, #44, #46]) then
     Key := #0;
end;

end.
