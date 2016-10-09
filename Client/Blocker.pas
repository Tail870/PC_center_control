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
cID,   //ID �������
ans,   //����� �������
cmdANS,//������� �� �������
timeSTR//����� ������ (������)
      :string;
time,  //����� ������ (�����)
i      //���������� ��� ������
      :integer;
wind,  //���������� ��� "����������"
wind2
      :HWND;
ini    //���� � cID � ������� �������
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
CanClose:=false;//������ �� �������� ����� - ������� ��� ������������� ALT+F4
IdTCPClient1.IOHandler.WriteLn(cID+' '+'TRIED_CLOSE');
ans:=IdTCPClient1.Socket.ReadLn;
Label1.Caption:='���� ������ �������, ���������!';
except
end;end;

function RtlSetProcessIsCritical(unu:DWORD; proc:POinter; doi:DWORD):LongInt;
stdcall; external 'ntdll.dll';  //�������� ������/���������� ��������

function RtlAdjustPrivilege(Privilege:ULONG; Enable:BOOL; CurrentThread:BOOL;
out OldPrivilege:BOOL):DWORD; stdcall; external 'ntdll'; //�������� ����������

procedure TFormBlocker.FormCreate(Sender: TObject);
begin
FormBlocker.AutoSize:=true;
WinExec('TaskKill /F /IM explorer*',SW_HIDE); //������� ������� ����
ini:=TiniFile.Create(extractfilepath(paramstr(0))+'sets.ini');//������� �������
cID:=
ini.ReadString('BLOCKER','cID','ERROR');    //�������� cID
IdTCPClient1.Host:=
ini.ReadString('BLOCKER','HOST','255.255.255.255');//� Host
ini.Free;                                //������� ������
 try
 asm //����������� ���� - BSoD ��� ��������
   lea eax, dword [esp+12]
  //������� RtlAdjustPrivilege, 20, 1, 0, eax
  push eax
  push 0
  push 1
  push 20
  call RtlAdjustPrivilege
  //������� RtlSetProcessIsCritical, 1, 0, 0
  push 0
  push 0
  push 1
  call RtlSetProcessIsCritical
  end;
  begin
  IdTCPClient1.Connect;
  IdTCPClient1.IOHandler.WriteLn(cID+' '+'ONLINE');//�������������� �������
  ans:=IdTCPClient1.Socket.ReadLn;//����� ��������� �������
  if ans='OK' then Label1.Caption:='������ � ������!'
  else Label1.Caption:='������� ������ - ���������� � ��������������!';//� ���� �� ��������?
  end
 except
 Label1.Caption:='������ ���������� - ���������� � ��������������!';
 end;
end;

procedure TFormBlocker.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin //����. �� �� ��������� ������ SHIFT+S
if (GetKeyState(ord('S'))<0) and (GetKeyState(VK_SHIFT)<0) then
 try
 TimerTerminator.Enabled:=false;
  asm //����� ������ "���������� ������"
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
    endan,//���������� ��������� ������
    endsd,//���������� ���������� ������
    endst;//����� �� ��������� ������ ������
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

//������� ans �� cmd, timeSTR
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

if cmdANS='ACCEPT' then //���� ������ ���������� ����� �������
  begin
  TimerTerminator.Enabled:=false;//���������� ������������
  if Time>0 then
   begin //���� ���� �����
   WinExec('TaskKill /F /IM taskhostw* /T', SW_HIDE);//����� ������� ���������� ���� (WinAPI)
   FormBlocker.Hide;//������� ������������
   WinExec('c:\windows\explorer.exe',SW_HIDE);//��������� �������� �����
   Form1.Show;
   Form1.Caption:='��������: '+IntToStr(time)+' �����';
   TimerUnlock.Enabled:=true;//�������� ������� ����������� �����
   TrayIcon1.Visible:=True;//���������� ������ � ����
   end
  else
   begin //���� ������ ������ ��� ��� �������
   endst: //�����, ���� ������ �� �����
   Label1.Caption:='���������� � �������������� ��� ������ ������!';
   TimerTerminator.Enabled:=true;
   end;
  end;
end;

procedure TFormBlocker.TimerTerminatorTimer(Sender: TObject);
label
redo;

begin                                  //������������ ����� ���������,
WinExec('TaskKill /F /IM explorer* /T',SW_HIDE);//������� ������� ����
WinExec('TaskKill /F /IM taskmgr* /T',SW_HIDE);//� ��������� �����

wind:=Handle;
 repeat          //������� ��� ����
 wind:=GetNextWindow(wind,GW_HWNDPREV);
 if (0<>wind) and //�� ���� ���������
 (iswindow(wind)) then//� ������ ��� - ����
 PostMessage(wind,WM_ENDSESSION,0,0);
 until wind=0;
wind:=Handle;
 repeat          //������� ��� ����
 wind:=GetNextWindow(wind,GW_HWNDNEXT);
 if (0<>wind) and //�� ���� ���������
 (iswindow(wind)) then//� ������ ��� - ����
 PostMessage(wind,WM_ENDSESSION,0,0);
 until wind=0;

if label2.Caption='--' then//������ ����� ������, ��� ����������� �� �����
label2.Caption:=' |' else
label2.Caption:='--';
label3.Caption:='�����: '+TimeToStr(GetTime)+' ����: '+DateToStr(Date);//�� � ����� �������
end;

procedure TFormBlocker.TimerUnlockTimer(Sender: TObject);
label
    endsd;//���������� ���������� ������
begin //�������� ����������� �����
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
 Form1.Caption:='��������: '+IntToStr(time)+' �����';
 if time=0 then
  begin//���� ����� �����, �� ������������� �������
  Form1.Hide;
  FormBlocker.Show;
  TimerUnlock.Enabled:=false;//��������� ������ ��������
  TrayIcon1.Visible:=False;//������ ������ � ����
  TimerTerminator.Enabled:=true;//...� �������� �������
  IdTCPClient1.IOHandler.WriteLn(cID+' '+'TIMEUP');
  ans:=IdTCPClient1.Socket.ReadLn;
  end
 else if time<=5 then//���� ����� ���������
  begin
  TrayIcon1.BalloonHint:=('� ��� �������� '+IntToStr(time)+' �����!');
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
 Label1.Caption:='������. ���������� � ��������������!';
 end;
end;

procedure TFormBlocker.TrayIcon1MouseMove(Sender:TObject; Shift:TShiftState; X,Y:Integer);
begin
TrayIcon1.BalloonHint:=('� ��� �������� '+IntToStr(time)+' �����!');
TrayIcon1.ShowBalloonHint;
end;

end.