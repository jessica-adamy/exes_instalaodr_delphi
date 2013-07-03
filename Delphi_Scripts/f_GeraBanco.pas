unit f_GeraBanco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, FMTBcd, DB, SqlExpr, StdCtrls, ComCtrls, Gauges,
  ExtCtrls, Buttons, IniFiles;

type
  Tp_GeraBanco = class(TForm)
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    NomeMaqEdit: TEdit;
    NomeInstancEdit: TEdit;
    UsuarioEdit: TEdit;
    SenhaEdit: TEdit;
    GroupBox1: TGroupBox;
    Gauge: TGauge;
    Label1: TLabel;
    Panel3: TPanel;
    Label11: TLabel;
    GroupBox2: TGroupBox;
    TestarConexaoBtn: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TestarConexaoBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    WCaminhoDB, WCaminhoTMP: String;
    procedure SetArquivoIni;
    procedure ConexaoBanco;
    procedure ExecutarScripts;
    function  Valida: Boolean;
  public
    { Public declarations }
  end;

var
  p_GeraBanco: Tp_GeraBanco;

implementation

uses Math, StrUtils;

{$R *.dfm}

{ TForm1 }

const
  C1 = 52845;
  C2 = 22719;
  key = 021130;



function Encrypt(const S: String; Key: Word): String;
var
  I: byte;
begin
  SetLength(Result,Length(S));
  for I := 1 to Length(S) do begin
    Result[I] := char(byte(S[I]) xor (Key shr 8));
    Key := (byte(Result[I]) + Key) * C1 + C2;
  end;
end;

function Tp_GeraBanco.Valida: Boolean;
begin
  Result := True;
  if Trim(NomeMaqEdit.Text) = '' then
    begin
      Application.MessageBox('Nome da máquina inválido', PChar(Self.Caption), MB_ICONERROR);
      NomeMaqEdit.SetFocus;
      Result := False;
      Exit;
    end;
{  if Trim(NomeInstancEdit.Text) = '' then
    begin
      Application.MessageBox('Nome da instância inválida', PChar(Self.Caption), MB_ICONERROR);
      NomeInstancEdit.SetFocus;
      Result := False;
      Exit;
    end;}
  if Trim(UsuarioEdit.Text) = '' then
    begin
      Application.MessageBox('Usuário inválido', PChar(Self.Caption), MB_ICONERROR);
      UsuarioEdit.SetFocus;
      Result := False;
      Exit;
    end;
  if Trim(SenhaEdit.Text) = '' then
    begin
      Application.MessageBox('Senha inválida', PChar(Self.Caption), MB_ICONERROR);
      SenhaEdit.SetFocus;
      Result := False;
      Exit;
    end;
end;

procedure Tp_GeraBanco.ConexaoBanco;
begin
  SQLConnection1.Close;
  SQLConnection1.Params.Values['HostName']  := Trim(NomeMaqEdit.Text)+IfThen(Trim(NomeInstancEdit.Text)<>'', '\'+Trim(NomeInstancEdit.Text), '');
  SQLConnection1.Params.Values['DataBase']  := 'master';
  SQLConnection1.Params.Values['User_Name'] := Trim(UsuarioEdit.Text);
  SQLConnection1.Params.Values['Password']  := Trim(SenhaEdit.Text);
  SQLConnection1.Open;
  WCaminhoDB := ParamStr(2);
  WCaminhoTMP:= ParamStr(3);
end;

procedure Tp_GeraBanco.ExecutarScripts;
  procedure IncProgressBar;
  begin
    Gauge.AddProgress(Gauge.Progress+4);
    Application.ProcessMessages;
  end;
  procedure ExecSql(PInstrucao: String);
  begin
    SQLQuery1.Close;
    SQLQuery1.SQL.Text := PInstrucao;
    SQLQuery1.ExecSQL;
  end;
begin
  try
    ConexaoBanco;
    if SQLConnection1.Connected then
      begin
        // Validação se o VMD existe
        SQLQuery1.Close;
        SQLQuery1.SQL.Add('IF EXISTS (SELECT * FROM sys.databases WHERE name=''VMD'') '+
                          '   SELECT 1 AS Retorno '+
                          'ELSE SELECT 0 AS Retorno');
        SQLQuery1.Open;
        if (SQLQuery1.FieldByName('Retorno').AsInteger = 0) then
          begin
            // Script de criação do banco VMD
            Label1.Caption := 'Criação do banco VMD';
            ExecSql('USE MASTER');
            IncProgressBar;
            ExecSql('CREATE DATABASE [VMD]ON '+
                    '  (NAME = N''VMD_DATA'', '+
                    '   FILENAME = N'+QuotedStr(WCaminhoDB+'\VMD.mdf')+' , SIZE = 10, FILEGROWTH = 100) '+
                    'LOG ON '+
                    '  (NAME = N''VMD_LOG'', '+
                    '   FILENAME = N'+QuotedStr(WCaminhoDB+'\VMD.ldf')+' , SIZE = 10, FILEGROWTH = 50) '+
                    'COLLATE Latin1_General_CI_AS');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''autoclose'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''bulkcopy'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''trunc. log'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''torn page detection'', N''true'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''read only'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''dbo use'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''single'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''autoshrink'', N''true'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''ANSI null default'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''recursive triggers'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''ANSI nulls'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''concat null yields null'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''cursor close on commit'', N''true'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''default to local cursor'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''quoted identifier'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''ANSI warnings'', N''false'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''auto create statistics'', N''true'' ');
            IncProgressBar;
            ExecSql('exec sp_dboption N''VMD'', N''auto update statistics'', N''true'' ');
            IncProgressBar;
            ExecSql('use [VMD]');
            IncProgressBar;
            ExecSql('if not exists (select * from master..syslogins where name = N''VMDApp'') '+
                    '  EXEC sp_addlogin N''VMDApp'', N''VMD22041748'', N''VMD'', N''Português'' ');
            IncProgressBar;
            ExecSql('exec sp_addsrvrolemember N''VMDApp'', sysadmin ');
            IncProgressBar;
            ExecSql('if not exists (select * from sysusers where name = N''VMDApp'' and uid < 16382) '+
                    '	 EXEC sp_grantdbaccess N''VMDApp'', N''VMDApp'' ');
            IncProgressBar;

            // Script de restauração do banco VMD
            Label1.Caption := 'Restauração do banco no VMD';
            SQLConnection1.Close;
            SQLConnection1.Open;
            ExecSql('RESTORE DATABASE [VMD] FROM  DISK = N'+QuotedStr(WCaminhoTMP+'\banco_instalador.bak')+' WITH  FILE = 1, '+
                    'MOVE N''VMD_DATA'' TO N'+QuotedStr(WCaminhoDB+'\VMD.mdf')+', '+
                    'MOVE N''VMD_LOG'' TO N'+QuotedStr(WCaminhoDB+'\VMD.ldf')+', '+
                    'NOUNLOAD, REPLACE, STATS = 10');
            IncProgressBar;
          end
        else
          begin
            Gauge.AddProgress(100);
            Application.ProcessMessages;
          end;
        Label1.Caption := 'Banco VMD concluído.';
        Application.ProcessMessages;
      end;
  except
    on e: Exception do
      raise Exception.Create('Erro ao criar o banco VMD.'+#13+e.Message);
  end;
end;

procedure Tp_GeraBanco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SQLConnection1.Close;
end;

procedure Tp_GeraBanco.FormShow(Sender: TObject);
begin
  Label1.Caption := '';
end;

procedure Tp_GeraBanco.SetArquivoIni;
var
  WArqIni: TIniFile;
  WSenha: string;
begin
  try
    WSenha := Encrypt(SenhaEdit.Text, key);
    WArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'\Config.ini');
    WArqIni.WriteString('CONEXAO', 'MAQUINA',   NomeMaqEdit.Text);
    WArqIni.WriteString('CONEXAO', 'INSTANCIA', NomeInstancEdit.Text);
    WArqIni.WriteString('CONEXAO', 'USUARIO',   UsuarioEdit.Text);
    WArqIni.WriteString('CONEXAO', 'SENHA',     WSenha);
  finally
    WArqIni.Free;
  end;
end;

procedure Tp_GeraBanco.TestarConexaoBtnClick(Sender: TObject);
begin
  try
    try
      SQLConnection1.Close;
      SQLConnection1.Params.Values['HostName']  := Trim(NomeMaqEdit.Text)+IfThen(Trim(NomeInstancEdit.Text)<>'', '\'+Trim(NomeInstancEdit.Text), '');
      SQLConnection1.Params.Values['DataBase']  := 'master';
      SQLConnection1.Params.Values['User_Name'] := Trim(UsuarioEdit.Text);
      SQLConnection1.Params.Values['Password']  := Trim(SenhaEdit.Text);
      SQLConnection1.Open;
      Application.MessageBox('Conexão realizada com sucesso.', 'Configuração de acesso', MB_ICONASTERISK);
    except
      on e: Exception do
        Application.MessageBox('Falha ao conectar'+#13#13+'Obs: O nome da instância não deve ser preenchido se o Sql Server '+#13+'for instalado como Instância Padrão.',
                               'Configuração de acesso', MB_ICONERROR);
    end;
  finally
    SQLConnection1.Close;
  end;
end;

procedure Tp_GeraBanco.BitBtn1Click(Sender: TObject);
begin
  if Valida then
    begin
      ExecutarScripts;
      SetArquivoIni;
      Self.Close;
    end;
end;

procedure Tp_GeraBanco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: Perform(wm_NextDlgCtl,0,0);
  end;
end;

end.

