unit p_CfgImpressora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, FMTBcd, DB, SqlExpr, StdCtrls, Buttons, ExtCtrls, IniFiles,
  ShellApi;

const
  cs_Matricial = 0;
  cs_Termica   = 1;

type
  Tf_CfgImpressora = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    NumSerieEdit: TEdit;
    Panel3: TPanel;
    Label11: TLabel;
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    TipoImpRadio: TRadioGroup;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure CriaIniPDV;
    function  Valida: Boolean;
  public
    { Public declarations }
  end;

var
  f_CfgImpressora: Tf_CfgImpressora;

implementation

{$R *.dfm}

{ Tf_CfgImpressora }

procedure Tf_CfgImpressora.CriaIniPDV;
var
  WArq: TIniFile;
begin
  WArq := TIniFile.Create('C:\Windows\VmdPDV.ini');
  try
    WArq.WriteString('ECF', 'NumSerie' , NumSerieEdit.Text);
    WArq.WriteString('ECF', 'Termica' , IntToStr(TipoImpRadio.ItemIndex));
  finally
    WArq.Free;
  end;
end;

function Tf_CfgImpressora.Valida: Boolean;
begin
  Result := True;
  if (Trim(NumSerieEdit.Text) = '') then
    begin
      Application.MessageBox('Número de série inválido.', 'Instalador inFarma', MB_ICONERROR);
      NumSerieEdit.SetFocus;
      Result := False;
      Exit;
    end;
  if (TipoImpRadio.ItemIndex = -1) then
    begin
      Application.MessageBox('Tipo da impressora inválido.', 'Instalador inFarma', MB_ICONERROR);
      TipoImpRadio.SetFocus;
      Result := False;
      Exit;
    end;
end;

procedure Tf_CfgImpressora.FormShow(Sender: TObject);
begin
  TipoImpRadio.ItemIndex := cs_Termica;
  NumSerieEdit.SetFocus;
end;

procedure Tf_CfgImpressora.BitBtn1Click(Sender: TObject);
begin
  if Valida then
    begin
      CriaIniPDV;
      ShellExecute(Handle, nil, 'VMDPDV.ini', '', 'C:\Windows\', SW_SHOWNORMAL);
      Self.Close;
    end;
end;

procedure Tf_CfgImpressora.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: Perform(wm_NextDlgCtl,0,0);
  end;
end;

end.
