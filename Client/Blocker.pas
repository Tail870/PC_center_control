unit Blocker;
interface uses
System.SysUtils, System.Classes, Winapi.Windows, Winapi.Messages, IniFiles, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
TFormBlocker=class(TForm)
TimerTerminator:TTimer;
TimerUnlock:TTimer;
IdTCPClient1:TIdTCPClient;
TrayIcon1:TTrayIcon;
  GroupBox1:TGroupBox;
  GroupBox2:TGroupBox;
Label1:TLabel;
Label2:TLabel;
Label3:TLabel;
Label4:TLabel;
Label5:TLabel;
Label6:TLabel;
Label7:TLabel;
  Button1:TButton;
  Button2:TButton;

procedure FormCreate(Sender: TObject);
procedure FormCloseQuery(Sender:TObject; var CanClose:Boolean);
procedure Button1Click(Sender:TObject);
procedure TimerUnlockTimer(Sender: TObject);
procedure TimerTerminatorTimer(Sender:TObject);
procedure TrayIcon1MouseMove(Sender:TObject; Shift:TShiftState; X,Y:Integer);
procedure Button2Click(Sender: TObject);
procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

private { Private declarations }
public { Public declarations }
end;

var
FormBlocker: TFormBlocker;
cID,   //ID клиента
ans,   //Ответ сервера
cmdANS,//Команда от сервера
timeSTR//Время работы (строка)
      :string;
time,  //Время работы (число)
i      //Переменная для циклов
      :integer;
wind,  //Переменная для "закрывашки"
wind2
      :HWND;
ini    //Файл с cID и адресом сервера
      :TiniFile;

implementation
{$R *.dfm}

uses FormTime;

procedure TFormBlocker.Button2Click(Sender: TObject);
begin
if GroupBox2.Visible=false then
GroupBox2.Show else
GroupBox2.Hide;
end;

procedure TFormBlocker.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin try
CanClose:=false;//Запрет на закрытие формы - решение для игнорирования ALT+F4
IdTCPClient1.IOHandler.WriteLn(cID+' '+'TRIED_CLOSE');
ans:=IdTCPClient1.Socket.ReadLn;
Label1.Caption:='Меня нельзя закрыть, уважаемый!';
except
end;end;

function RtlSetProcessIsCritical(unu:DWORD; proc:POinter; doi:DWORD):LongInt;
stdcall; external 'ntdll.dll';  //изменить статус/привилегии процесса

function RtlAdjustPrivilege(Privilege:ULONG; Enable:BOOL; CurrentThread:BOOL;
out OldPrivilege:BOOL):DWORD; stdcall; external 'ntdll'; //изменить привилегии

procedure TFormBlocker.FormCreate(Sender: TObject);
begin
FormBlocker.AutoSize:=true;
WinExec('TaskKill /F /IM explorer*',SW_HIDE); //Закрыть рабочий стол
ini:=TiniFile.Create(extractfilepath(paramstr(0))+'sets.ini');//Открыть конфиги
cID:=
ini.ReadString('BLOCKER','cID','ERROR');    //получить cID
IdTCPClient1.Host:=
ini.ReadString('BLOCKER','HOST','255.255.255.255');//и Host
ini.Free;                                //Закрыть конфиг
 try
 asm //радикальная мера - BSoD при закрытии
   lea eax, dword [esp+12]
  //вызвать RtlAdjustPrivilege, 20, 1, 0, eax
  push eax
  push 0
  push 1
  push 20
  call RtlAdjustPrivilege
  //вызвать RtlSetProcessIsCritical, 1, 0, 0
  push 0
  push 0
  push 1
  call RtlSetProcessIsCritical
  end;
  begin
  IdTCPClient1.Connect;
  IdTCPClient1.IOHandler.WriteLn(cID+' '+'ONLINE');//Представляемся серверу
  ans:=IdTCPClient1.Socket.ReadLn;//Ответ вежливого сервера
  if ans='OK' then Label1.Caption:='Готово к работе!'
  else Label1.Caption:='Сетевая ошибка - обратитесь к администратору!';//А если не вежливый?
  end
 except
 Label1.Caption:='Сервер недоступен - Обратитесь к администратору!';
 end;
end;

procedure TFormBlocker.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin //Выкл. пк по сочетанию клавиш SHIFT+S
if (GetKeyState(ord('S'))<0) and (GetKeyState(VK_SHIFT)<0) then
 try
 TimerTerminator.Enabled:=false;
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

procedure TFormBlocker.Button1Click(Sender: TObject);
label
    endan,//Прерывание получения ответа
    endsd,//Прерывание разделения ответа
    endst;//Выход из процедуры начала работы
begin
 try if IdTCPClient1.Connected=false then
  begin
  IdTCPClient1.Connect;
  IdTCPClient1.IOHandler.WriteLn(cID+' '+'ONLINE');
  if IdTCPClient1.Socket.ReadLn='OK' then
  else goto endan;
  end;
 IdTCPClient1.IOHandler.WriteLn(cID+' '+'GO');
 ans:=IdTCPClient1.Socket.ReadLn;
 endan:
 except
 end;

//Разбить ans на cmd, timeSTR
cmdANS:=''; timeSTR:='';
 for i:=1 to Length(ans) do
  if ans[i]<>' ' then
  cmdANS:=cmdANS+ans[i]
  else goto endsd;
endsd:
 for i:=i+1 to Length(ans) do
  timeSTR:=timeSTR+ans[i];
       try
       time:=StrToInt(timeSTR);
except end;

if cmdANS='ACCEPT' then //Если пришёл корректный ответ сервера
  begin
  TimerTerminator.Enabled:=false;//Отключение автозакрытия
  if Time>0 then
   begin //Если есть время
   WinExec('TaskKill /F /IM taskhostw* /T', SW_HIDE);//Убить процесс завершения окон (WinAPI)
   FormBlocker.Hide;//Скрытие блокировщика
   WinExec('c:\windows\explorer.exe',SW_HIDE);//включение рабочего стола
   Form1.Show;
   Form1.Caption:='Осталось: '+IntToStr(time)+' минут';
   TimerUnlock.Enabled:=true;//Включить счётчик драгоценных минут
   TrayIcon1.Visible:=True;//Отобразить иконку в трее
   end
  else
   begin //Если ошибка ответа или нет времени
   endst: //Метка, если ВООБЩЕ всё плохо
   Label1.Caption:='Обратитесь к администратору для начала работы!';
   TimerTerminator.Enabled:=true;
   end;
  end;
end;

procedure TFormBlocker.TimerTerminatorTimer(Sender: TObject);
label
redo;

begin                                  //Автозакрытие всего открытого,
WinExec('TaskKill /F /IM explorer* /T',SW_HIDE);//включая рабочий стол
WinExec('TaskKill /F /IM taskmgr* /T',SW_HIDE);//и диспетчер задач

wind:=Handle;
 repeat          //Закрыть все окна
 wind:=GetNextWindow(wind,GW_HWNDPREV);
 if (0<>wind) and //Не наша программа
 (iswindow(wind)) then//И вообще это - окно
 PostMessage(wind,WM_ENDSESSION,0,0);
 until wind=0;
wind:=Handle;
 repeat          //Закрыть все окна
 wind:=GetNextWindow(wind,GW_HWNDNEXT);
 if (0<>wind) and //Не наша программа
 (iswindow(wind)) then//И вообще это - окно
 PostMessage(wind,WM_ENDSESSION,0,0);
 until wind=0;

if label2.Caption='--' then//Просто чтобы видеть, что блокировщик не завис
label2.Caption:=' |' else
label2.Caption:='--';
label3.Caption:='Время: '+TimeToStr(GetTime)+' Дата: '+DateToStr(Date);//Ну и время выводил
end;

procedure TFormBlocker.TimerUnlockTimer(Sender: TObject);
label
    endsd;//Прерывание разделение ответа
begin //Проверка драгоценных минут
 try
 IdTCPClient1.IOHandler.WriteLn(cID+' '+'CHECK');
 ans:=IdTCPClient1.Socket.ReadLn;
 cmdANS:=''; timeSTR:='';
 for i:=1 to Length(ans) do
  if ans[i]<>' ' then
  cmdANS:=cmdANS+ans[i]
  else goto endsd;
 endsd:
 for i:=i+1 to Length(ans) do
  timeSTR:=timeSTR+ans[i];
 time:=StrToInt(timeSTR);
 Form1.Caption:='Осталось: '+IntToStr(time)+' минут';
 if time=0 then
  begin//Если время вышло, то заблокировать систему
  Form1.Hide;
  FormBlocker.Show;
  TimerUnlock.Enabled:=false;//Отключить таймер разлочки
  TrayIcon1.Visible:=False;//Скрыть иконку в трее
  TimerTerminator.Enabled:=true;//...и включить залочку
  IdTCPClient1.IOHandler.WriteLn(cID+' '+'TIMEUP');
  ans:=IdTCPClient1.Socket.ReadLn;
  end
 else if time<=5 then//Если время поджимает
  begin
  TrayIcon1.BalloonHint:=('У вас осталось '+IntToStr(time)+' минут!');
  TrayIcon1.ShowBalloonHint;
  end
 else;
 except
 time:=0;
 timerUnlock.Enabled:=false;
 TrayIcon1.Visible:=false;
 Form1.Hide;
 FormBlocker.Show;
 timerTerminator.Enabled:=true;
 Label1.Caption:='Ошибка. Обратитесь к администратору!';
 end;
end;

procedure TFormBlocker.TrayIcon1MouseMove(Sender:TObject; Shift:TShiftState; X,Y:Integer);
begin
TrayIcon1.BalloonHint:=('У вас осталось '+IntToStr(time)+' минут!');
TrayIcon1.ShowBalloonHint;
end;

end.