program ProjectBlocker;

uses
  Vcl.Forms,
  Blocker in 'Blocker.pas' {FormBlocker},
  FormTime in 'FormTime.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TFormBlocker, FormBlocker);
  Application.CreateForm(TForm1, Form1);//Таймер отстатка времени
  Application.Run;
end.
