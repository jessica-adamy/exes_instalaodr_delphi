program GeraBanco;

uses
  Forms,
  SysUtils,
  Dialogs,
  Windows,
  f_GeraBanco in 'f_GeraBanco.pas' {p_GeraBanco};

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
      Application.CreateForm(Tp_GeraBanco, p_GeraBanco);
      Application.Run;
    end
  else
    begin
      Application.MessageBox('Chamada fora do pacote de instalação.', 'Erro', MB_ICONERROR);
      Exit;
    end;
end.
