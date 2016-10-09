unit ServerDebugerTool;
interface uses
System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
  TForm2 = class(TForm)
    IdTCPClient1: TIdTCPClient;
    Label1: TLabel;
    ButtonGO: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ButtonConnect: TButton;
    ButtonDisconnect: TButton;
    Button1: TButton;
    Button2: TButton;
    procedure ButtonGOClick(Sender: TObject);
    procedure ButtonConnectClick(Sender: TObject);
    procedure ButtonDisconnectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private { Private declarations }
  public { Public declarations }
  end;

var
  Form2: TForm2;
  id,
  ansF:String;
  ans:TStringList;

implementation
uses Installer;
{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin //Вернуться к программе установки
Form1.Show;
ServerDebugerTool.Form2.Hide;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin //Полный выход
Application.Terminate;
end;

procedure TForm2.ButtonConnectClick(Sender: TObject);
begin try        //Соединение с сервером
idtcpclient1.Host:=Edit3.Text;
if idtcpclient1.Connected=false then
            begin
            idtcpclient1.Connect;
            Label1.Caption:='Соединение открыто.';
            end;
ButtonGO.Enabled:=true;
ButtonDisconnect.Enabled:=true;
ButtonConnect.Enabled:=false;
except  //Заглушка
end;  end;

procedure TForm2.ButtonDisconnectClick(Sender: TObject);
begin   //Отсоединение от сервера
idtcpclient1.Disconnect;
Label1.Caption:='Соединение закрыто.';
ButtonConnect.Enabled:=true;
ButtonDisconnect.Enabled:=false;
ButtonGO.Enabled:=false;
end;

procedure TForm2.ButtonGOClick(Sender: TObject);
begin //Отравка запроса
IdTCPClient1.IOHandler.WriteLn(edit1.text+' '+edit2.text);
ansF:=IdTCPClient1.Socket.ReadLn;
Label1.Caption:=(ansF);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Installer.Form1.Show; //Назад к установщику
end;

end.