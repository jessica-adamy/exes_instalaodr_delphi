unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, ShellAPI;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    procedure CriaIniServer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.CriaIniServer;
var
  WArq: TIniFile;
begin
  if not FileExists('C:\Windows\VMDServer.ini') then
    begin
      WArq := TIniFile.Create('C:\Windows\VMDServer.ini');
      try
        WArq.WriteString('SERVIDOR', 'HostName' , 'SERVIDOR');
        WArq.WriteString('SERVIDOR', 'DataBase' , 'VMD');
        WArq.WriteString('CENTRAL', 'Loja' , '0');
        WArq.WriteString('CENTRAL', 'SQL Lojas' , '0');
        WArq.WriteString('VAREJO', 'Loja' , '1');
      finally
        WArq.Free;
      end;
    end;
    ShellExecute(Handle, nil, 'VMDServer.ini', '', 'C:\Windows\', SW_SHOWNORMAL);
    Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CriaIniServer;
end;

end.
