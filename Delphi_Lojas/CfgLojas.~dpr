program CfgLojas;

uses
  Forms,
  SysUtils,
  Dialogs,
  Windows,
  f_CfgLoja in 'f_CfgLoja.pas' {p_CfgLoja};

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
      Application.CreateForm(Tp_CfgLoja, p_CfgLoja);
      Application.Run;
    end
  else
    begin
      Application.MessageBox('Chamada fora do pacote de instalação.', 'Erro', MB_ICONERROR);
      Exit;
    end;
end.
