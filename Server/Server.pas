unit Server;
interface uses
System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.Grids, IdContext, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer;

type
TFormServer=class(TForm)
IdTCPServer1:TIdTCPServer;
StringGrid1:TStringGrid;
StringGrid2: TStringGrid;
Button1: TButton;
Label1: TLabel;
Edit1: TEdit;
Button2: TButton;

procedure IdTCPServer1Execute(AContext:TIdContext);
procedure FormCreate(Sender:TObject);
procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
procedure Button1Click(Sender: TObject);
procedure Button2Click(Sender: TObject);
private { Private declarations }
public { Public declarations }
end;

var
FormServer:TFormServer;
askF,//���������� ��� ������� �������
ask, //���������� ��� ������� �������
cID  //�������������� ������� (�� �������)
     :string;
time,//����� ������ (������ �� �������)
i    //���������� ��� ������
     :integer;
implementation {$R *.dfm}

procedure TFormServer.Button1Click(Sender: TObject);
begin //�������/������� �������� �������
if StringGrid2.Visible=false then
 begin
 Button1.Caption:='������� �������� ������� <<';
 StringGrid2.Visible:=true;
 Button2.Width:=697;
 end
else
 begin
 Button1.Caption:='������� �������� ������� >>';
 StringGrid2.Visible:=false;
 Button2.Width:=409;
 end;
end;

procedure TFormServer.Button2Click(Sender: TObject);
begin //����������. ���������.
Application.Minimize;
end;

procedure TFormServer.FormCreate(Sender: TObject);
begin
StringGrid1.Cells[0,0]:='ID ��';
StringGrid1.Cells[1,0]:='�����? ��/���';
StringGrid1.Cells[2,0]:='�����';  //��������
StringGrid2.Cells[0,0]:='ID ��';  //������
StringGrid2.Cells[1,0]:='����� � ���.';
FormServer.AutoSize:=true;
end;

procedure TFormServer.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin //����������� ����� - ������ ����� � �������.
if not (Key in ['0'..'9',#8]) then Key:=#0;
end;

procedure TFormServer.IdTCPServer1Execute(AContext: TIdContext);
label
endsd,//����� ��� ���������� ��������� ������ ������
endtm,//����� ��� ���������� ������� �������
endtc,//����� ��� ���������� ������� ������� ��� ��������
endls,//����� ��� ���������� �������� StringGrid1 ��� ���������� cID'���
endlu;//����� ��� ���������� �������� StringGrid1 ��� ������� TIMEUP
begin
cID:='';ask:='';time:=0;//��������� ����������
askF:=AContext.Connection.IOHandler.ReadLn;//��������� �������
for i:=0 to Length(askF) do//������� AskF �� cID, ASK
if askF[i]<>' ' then cID:=cID+askF[i] else goto endsd;
endsd:
for i:=i+1 to Length(askF) do ask:=ask+askF[i];
//AskF ������ �� cID, ASK
//����������� ������� �������
if ask='GO' then
 begin//��� ������� �� ������ ������
 //�������� TIME �� cID �� ������� StringGrid1
 for i:=1 to StringGrid1.RowCount do
 if StringGrid1.Cells[0,i]=cID
 then begin
 if StringGrid1.Cells[2,i]<>''
 then  begin
       time:=strtoint(StringGrid1.Cells[2,i]);
       StringGrid1.Cells[1,i]:='��';
       end
 else  begin
       time:=0;
       StringGrid1.Cells[1,i]:='���';
       end;
      goto endtm;
      end;
 endtm: //��������� �����
 AContext.Connection.IOHandler.WriteLn('ACCEPT '+inttostr(time))
 end
else
if ask='CHECK' then
 begin//��� �������� �������
 //�������� TIME �� cID �� ������� StringGrid1
 for i:=1 to StringGrid1.RowCount do
 if StringGrid1.Cells[0,i]=cID then
  begin
  if (StringGrid1.Cells[2,i]<>'') and (StrToInt(StringGrid1.Cells[2,i])>0)
  then
   begin//������ �����-1 (���.) � ���� � �������� �������
   StringGrid1.Cells[2,i]:=IntToStr(StrToInt(StringGrid1.Cells[2,i])-1);
   StringGrid2.Cells[1,i]:=IntToStr(StrToInt(StringGrid2.Cells[1,i])+StrToInt(Edit1.Text));
   time:=strtoint(StringGrid1.Cells[2,i]);
   end
  else
   begin
   time:=0;
   StringGrid1.Cells[1,i]:='���';
   end;
  goto endtc;
  end;
 endtc: //���������� ������� �������
 AContext.Connection.IOHandler.WriteLn('CHECKOK '+inttostr(time));
 end
else
if ask='TIMEUP' then
 begin //��� ����������� �� ��������� �������
 AContext.Connection.IOHandler.WriteLn('BLOCK');
 for i:=1 to StringGrid1.RowCount do      //������� ����� � �������
 if StringGrid1.Cells[0,i]=cID then
  begin
  StringGrid1.Cells[2,i]:='';
  StringGrid1.Cells[1,i]:='���';
  goto endlu;
  end;
 endlu:
 end
else
if ask='ONLINE' then
 begin//��� ����������� ����� ������� � �������
 AContext.Connection.IOHandler.WriteLn('OK');
 for i:=1 to StringGrid1.RowCount do
  begin
  if i=StringGrid1.RowCount //���������� �������
  then StringGrid1.RowCount:=StringGrid1.RowCount+1;
  if StringGrid1.Cells[0,i]=cID //���������� ������� cID � �������
  then goto endls
  else
  if StringGrid1.Cells[0,i]=''//� ��������� ������
  then
   begin
   StringGrid1.Cells[0,i]:=cID; //������...
   StringGrid2.Cells[0,i]:=cID;
   StringGrid2.Cells[1,i]:='0';
   StringGrid1.Cells[1,i]:='���';
   goto endls;
   end;
  end;
 end
else
if ask='TRIED_CLOSE' then
 begin//��� ����������� ����� ������� � �������
 AContext.Connection.IOHandler.WriteLn('OK');
 for i:=1 to StringGrid1.RowCount do
  begin
  if StringGrid1.Cells[0,i]=cID //���������� ������� cID � �������
  then
   begin
   StringGrid1.Cells[1,i]:='������� ��������!';
   goto endls;
   end;
  end;
 end
else //��� ������������ ������� ������� ���� �����,
AContext.Connection.IOHandler.WriteLn('CMD_ERROR');//����� �� ����� ������
endls:
end;

end.