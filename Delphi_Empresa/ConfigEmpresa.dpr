program ConfigEmpresa;

uses
  Forms,
  SysUtils,
  Dialogs,
  Windows,  f_CfgEmpresa in 'f_CfgEmpresa.pas' {p_CfgEmpresa};

CONST
  CExecuta = 'PYKJWH';

{$R *.res}

var
  cmd : string;

begin
  cmd := CmdLine;
  if (ParamStr(1) = CExecuta) then
    begin
      Application.Initialize;
      Application.CreateForm(Tp_CfgEmpresa, p_CfgEmpresa);
      Application.Run;
    end
  else
    begin
      Application.MessageBox('Chamada fora do pacote de instalação.', 'Erro', MB_ICONERROR);
      Exit;
    end;
end.
