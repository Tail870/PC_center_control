unit FormTime;
interface uses
System.Classes, Winapi.Windows, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
TForm1 = class(TForm)
Label1: TLabel;
Label2: TLabel;

procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

private { Private declarations }
public { Public declarations }
end;

var
Form1: TForm1;

implementation
{$R *.dfm}
uses Blocker;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
CanClose:=false;//Запрет на закрытие формы - решение для игнорирования ALT+F4
FormBlocker.IdTCPClient1.IOHandler.WriteLn(cID+' '+'TRIED_CLOSE');
ans:=FormBlocker.IdTCPClient1.Socket.ReadLn;
end;

function RtlSetProcessIsCritical(unu:DWORD; proc:POinter; doi:DWORD):LongInt;
stdcall; external 'ntdll.dll';  //сделать процесс "критически важным"

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin //Выкл. пк по сочетанию клавиш SHIFT+S
if (GetKeyState(ord('S'))<0) and (GetKeyState(VK_SHIFT)<0) then
 try
 FormBlocker.TimerTerminator.Enabled:=false;
  asm //Снять статус "критически важный"
  push 0
  push 0
  push 0
  call RtlSetProcessIsCritical
  end;
 WinExec('shutdown /s /f /t 0', SW_HIDE);
 except
 end;
end;

end.