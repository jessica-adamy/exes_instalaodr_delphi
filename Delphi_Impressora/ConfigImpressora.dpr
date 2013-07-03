program ConfigImpressora;

uses
  Forms,
  SysUtils,
  Dialogs,
  Windows,
  p_CfgImpressora in 'p_CfgImpressora.pas' {f_CfgImpressora};

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
      Application.CreateForm(Tf_CfgImpressora, f_CfgImpressora);
      Application.Run;
    end
  else
    begin
      Application.MessageBox('Chamada fora do pacote de instalação.', 'Erro', MB_ICONERROR);
      Exit;
    end;
end.
