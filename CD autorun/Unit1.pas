unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ShellAPI, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
Label1: TLabel; Label2: TLabel;
Label3: TLabel; Label5: TLabel;
Label7: TLabel;
Button1: TButton; Button2: TButton; Button3: TButton;
Button4: TButton; Button5: TButton; Button6: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
private { Private declarations }
public { Public declarations }
end;

var
Form1: TForm1;

implementation
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin //Открыть папку с запиской
WinExec('EXPLORER .\Text data', SW_SHOW);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin //Открыть папку с исходным кодом
WinExec('EXPLORER .\Source code', SW_SHOW);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin //Запуск программы диплома       installer.exe
ShellExecute(Handle, 'open', '.\Executable code\ПРОЧТИ МЕНЯ! СРОЧНО!.txt', nil, nil, SW_SHOWNORMAL);
WinExec('.\Executable code\installer.exe', SW_SHOW);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin //Открыть папку с готовым проектом
WinExec('EXPLORER .\Executable code', SW_SHOW);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin //Информация о дипломе
if Memo1.Visible=false then Memo1.Show else Memo1.Hide;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin //Выход
Application.Terminate;
end;

end.
