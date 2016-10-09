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
begin //Установка сервера
 try
//Копирование файла
 CopyFile('.\ins\Server.exe_','C:\Windows\Server.exe', true);
//Установка автозапуска 
 RegIn:=TRegistry.create;
 RegIn.RootKey:=HKEY_CURRENT_USER;
 RegIn.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', true);
 RegIn.WriteString('Server','"C:\Windows\server.exe"');
 RegIn.Destroy;
 MessageBox(0, 'Операция прошла успешно!', 'Статус', MB_ICONINFORMATION or MB_OK);
 except //При ошибке - сообщение
 MessageBox(0, 'Произошла ошибка во время установки! Проверьте целостность установочных файлов!', 'Статус', MB_ICONERROR or MB_OK);
 end;
end;

procedure TForm1.ButtonCliFClick(Sender: TObject);
begin //Установка клиента
 if (Edit3.Text<>'') and (edit4.text<>'') then
 try //Если поля заполнены правильно:
//Копирование файла
 CopyFile('.\ins\Client.exe_','C:\Windows\Client.exe', true);
//Установка автозапуска
 RegIn:=TRegistry.create;
 RegIn.RootKey:=HKEY_CURRENT_USER;
 RegIn.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', true);
 RegIn.WriteString('Client','"C:\Windows\Client.exe"');
 RegIn.Destroy;
//Формирование конфига
 iniIn:=TiniFile.Create('C:\Windows\sets.ini');//Открыть/создать конфиги
 iniIn.WriteString('Blocker','cID',edit3.Text);//вписать cID
 iniIn.WriteString('Blocker','HOST',edit4.Text);//и Host
 iniIn.Free;
 MessageBox(0, 'Операция прошла успешно!', 'Статус', MB_ICONINFORMATION or MB_OK);
 GroupBox3.Visible:=false;
 except //При ошибке - сообщение
 MessageBox(0, 'Произошла ошибка во время установки! Проверьте целостность установочных файлов!', 'Статус', MB_ICONERROR or MB_OK);
 GroupBox3.Visible:=false;
 end 
 //При пустом поле ввода
 else MessageBox(0, 'Введите ID клиента и IP сервера!', 'Статус', MB_ICONERROR or MB_OK);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin //Показать информацию "О программе"
if memo1.Visible=false then
 begin
 memo1.Visible:=true;
 button1.Caption:='О программе <<<' end
 else begin
  memo1.Visible:=false;
  button1.Caption:='О программе >>>';
  end;
end;

procedure TForm1.ButtonCliClick(Sender: TObject);
begin
 GroupBox3.Show;//Меню установки клиента
end;

procedure TForm1.ButtonDelCliClick(Sender: TObject);
begin
 try
//Удалить автозапуск
 RegIn:=TRegistry.create;
 RegIn.RootKey:=HKEY_CURRENT_USER;
 RegIn.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', true);
 RegIn.DeleteValue('Client');
 RegIn.Destroy;
//Удалить файл. Конфиг остаётся.
 DeleteFile('C:\Windows\Client.exe');
 MessageBox(0, 'Операция прошла успешно!', 'Статус', MB_ICONINFORMATION or MB_OK);
 except //При ошибке - сообщение
 MessageBox(0, 'Произошла ошибка во время установки! Проверьте целостность установочных файлов!', 'Статус', MB_ICONERROR or MB_OK);
 end;
end;

procedure TForm1.ButtonDelSerClick(Sender: TObject);
begin
 try
//Удалить автозапуск
 RegIn:=TRegistry.create;
 RegIn.RootKey:=HKEY_CURRENT_USER;
 RegIn.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', true);
 RegIn.DeleteValue('Server');
 RegIn.Destroy;
//Удалить файл
 DeleteFile('C:\Windows\Server.exe');
 MessageBox(0, 'Операция прошла успешно!', 'Статус', MB_ICONINFORMATION or MB_OK);
 except //При ошибке - сообщение
 MessageBox(0, 'Произошла ошибка во время установки! Проверьте целостность установочных файлов!', 'Статус', MB_ICONERROR or MB_OK);
 end;
end;

procedure TForm1.ButtonEscClick(Sender: TObject);
begin //Выход
Application.Terminate;
end;

procedure TForm1.ButtonSeDeToClick(Sender: TObject);
begin //Запуск программы диагностики
ServerDebugerTool.Form2.Show;
Form1.Hide;
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
begin     //Игнорировать пробел
if (GetKeyState(VK_SPACE) < 0)
then key:= #0;
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
begin     //Игнорировать пробел
if (GetKeyState(VK_SPACE) < 0)
then key:= #0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin    //Заполнение поля "О программе"
memo1.Text:='';
memo1.Lines.Add('Добро пожаловать в программу установки!');
memo1.Lines.Add('');
memo1.Lines.Add('Программа предоставляется "как есть", данное ПО является результатом дипломной работы студента МГКЭИТ группы П1-12 - Шатилова Анатолия Александровича.');
memo1.Lines.Add('');
memo1.Lines.Add('');
memo1.Lines.Add('Все права защищены. Применение данного ПО в качестве вредоносного, а также его модификация, кража и подделка преследуется по закону.');
end;

end.