program ProjectInstaller;



uses
  Vcl.Forms,
  Installer in 'Installer.pas' {Form1},
  ServerDebugerTool in 'SeDeTo\ServerDebugerTool.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
