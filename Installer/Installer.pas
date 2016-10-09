unit Installer;
interface uses
Winapi.Windows, System.Variants, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Registry, IniFiles;

type
TForm1 = class(TForm)
  Label1:TLabel;
  Label2:TLabel;
  Label3:TLabel;
  Label4:TLabel;
  Label6:TLabel;
  Label7:TLabel;
  Label8:TLabel;
  Label10:TLabel;
  Label11:TLabel;
GroupBox1:TGroupBox;
GroupBox2:TGroupBox;
GroupBox3:TGroupBox;
  Button1:TButton;
  ButtonDelSer:TButton;
  ButtonDelCli:TButton;
  ButtonSer:TButton;
  ButtonCli:TButton;
  ButtonCliF:TButton;
  ButtonSeDeTo: TButton;
  ButtonEsc: TButton;
Edit3:TEdit;
Edit4:TEdit;
  Memo1:TMemo;

procedure ButtonCliClick(Sender: TObject);
procedure ButtonCliFClick(Sender: TObject);
procedure ButtonSerClick(Sender: TObject);
procedure ButtonDelCliClick(Sender: TObject);
procedure ButtonDelSerClick(Sender: TObject);
procedure ButtonEscClick(Sender: TObject);
procedure ButtonSeDeToClick(Sender: TObject);
procedure FormCreate(Sender: TObject);
procedure Button1Click(Sender: TObject);
procedure Edit4KeyPress(Sender: TObject; var Key: Char);
procedure Edit3KeyPress(Sender: TObject; var Key: Char);

private { Private declarations }
public { Public declarations }
end;

var
Form1:TForm1;
RegIn:Tregistry;
IniIn:TIniFile;
implementation
uses ServerDebugerTool;
{$R *.dfm}

procedure TForm1.ButtonSerClick(Sender: TObject);
begin //��������� �������
 try
//����������� �����
 CopyFile('.\ins\Server.exe_','C:\Windows\Server.exe', true);
//��������� ����������� 
 RegIn:=TRegistry.create;
 RegIn.RootKey:=HKEY_CURRENT_USER;
 RegIn.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', true);
 RegIn.WriteString('Server','"C:\Windows\server.exe"');
 RegIn.Destroy;
 MessageBox(0, '�������� ������ �������!', '������', MB_ICONINFORMATION or MB_OK);
 except //��� ������ - ���������
 MessageBox(0, '��������� ������ �� ����� ���������! ��������� ����������� ������������ ������!', '������', MB_ICONERROR or MB_OK);
 end;
end;

procedure TForm1.ButtonCliFClick(Sender: TObject);
begin //��������� �������
 if (Edit3.Text<>'') and (edit4.text<>'') then
 try //���� ���� ��������� ���������:
//����������� �����
 CopyFile('.\ins\Client.exe_','C:\Windows\Client.exe', true);
//��������� �����������
 RegIn:=TRegistry.create;
 RegIn.RootKey:=HKEY_CURRENT_USER;
 RegIn.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', true);
 RegIn.WriteString('Client','"C:\Windows\Client.exe"');
 RegIn.Destroy;
//������������ �������
 iniIn:=TiniFile.Create('C:\Windows\sets.ini');//�������/������� �������
 iniIn.WriteString('Blocker','cID',edit3.Text);//������� cID
 iniIn.WriteString('Blocker','HOST',edit4.Text);//� Host
 iniIn.Free;
 MessageBox(0, '�������� ������ �������!', '������', MB_ICONINFORMATION or MB_OK);
 GroupBox3.Visible:=false;
 except //��� ������ - ���������
 MessageBox(0, '��������� ������ �� ����� ���������! ��������� ����������� ������������ ������!', '������', MB_ICONERROR or MB_OK);
 GroupBox3.Visible:=false;
 end 
 //��� ������ ���� �����
 else MessageBox(0, '������� ID ������� � IP �������!', '������', MB_ICONERROR or MB_OK);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin //�������� ���������� "� ���������"
if memo1.Visible=false then
 begin
 memo1.Visible:=true;
 button1.Caption:='� ��������� <<<' end
 else begin
  memo1.Visible:=false;
  button1.Caption:='� ��������� >>>';
  end;
end;

procedure TForm1.ButtonCliClick(Sender: TObject);
begin
 GroupBox3.Show;//���� ��������� �������
end;

procedure TForm1.ButtonDelCliClick(Sender: TObject);
begin
 try
//������� ����������
 RegIn:=TRegistry.create;
 RegIn.RootKey:=HKEY_CURRENT_USER;
 RegIn.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', true);
 RegIn.DeleteValue('Client');
 RegIn.Destroy;
//������� ����. ������ �������.
 DeleteFile('C:\Windows\Client.exe');
 MessageBox(0, '�������� ������ �������!', '������', MB_ICONINFORMATION or MB_OK);
 except //��� ������ - ���������
 MessageBox(0, '��������� ������ �� ����� ���������! ��������� ����������� ������������ ������!', '������', MB_ICONERROR or MB_OK);
 end;
end;

procedure TForm1.ButtonDelSerClick(Sender: TObject);
begin
 try
//������� ����������
 RegIn:=TRegistry.create;
 RegIn.RootKey:=HKEY_CURRENT_USER;
 RegIn.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', true);
 RegIn.DeleteValue('Server');
 RegIn.Destroy;
//������� ����
 DeleteFile('C:\Windows\Server.exe');
 MessageBox(0, '�������� ������ �������!', '������', MB_ICONINFORMATION or MB_OK);
 except //��� ������ - ���������
 MessageBox(0, '��������� ������ �� ����� ���������! ��������� ����������� ������������ ������!', '������', MB_ICONERROR or MB_OK);
 end;
end;

procedure TForm1.ButtonEscClick(Sender: TObject);
begin //�����
Application.Terminate;
end;

procedure TForm1.ButtonSeDeToClick(Sender: TObject);
begin //������ ��������� �����������
ServerDebugerTool.Form2.Show;
Form1.Hide;
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
begin     //������������ ������
if (GetKeyState(VK_SPACE) < 0)
then key:= #0;
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
begin     //������������ ������
if (GetKeyState(VK_SPACE) < 0)
then key:= #0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin    //���������� ���� "� ���������"
memo1.Text:='';
memo1.Lines.Add('����� ���������� � ��������� ���������!');
memo1.Lines.Add('');
memo1.Lines.Add('��������� ��������������� "��� ����", ������ �� �������� ����������� ��������� ������ �������� ������ ������ �1-12 - �������� �������� ��������������.');
memo1.Lines.Add('');
memo1.Lines.Add('');
memo1.Lines.Add('��� ����� ��������. ���������� ������� �� � �������� ������������, � ����� ��� �����������, ����� � �������� ������������ �� ������.');
end;

end.