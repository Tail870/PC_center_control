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
askF,//Переменная для полного запроса
ask, //Переменная для команды запроса
cID  //Индентификатор клиента (из запроса)
     :string;
time,//Время работы (берётся из таблицы)
i    //Переменные для циклов
     :integer;
implementation {$R *.dfm}

procedure TFormServer.Button1Click(Sender: TObject);
begin //Открыть/закрыть кассовую таблицу
if StringGrid2.Visible=false then
 begin
 Button1.Caption:='Закрыть кассовую таблицу <<';
 StringGrid2.Visible:=true;
 Button2.Width:=697;
 end
else
 begin
 Button1.Caption:='Открыть кассовую таблицу >>';
 StringGrid2.Visible:=false;
 Button2.Width:=409;
 end;
end;

procedure TFormServer.Button2Click(Sender: TObject);
begin //Свернуться. Калачиком.
Application.Minimize;
end;

procedure TFormServer.FormCreate(Sender: TObject);
begin
StringGrid1.Cells[0,0]:='ID пк';
StringGrid1.Cells[1,0]:='Занят? Да/Нет';
StringGrid1.Cells[2,0]:='Время';  //Разметка
StringGrid2.Cells[0,0]:='ID пк';  //таблиц
StringGrid2.Cells[1,0]:='Время в руб.';
FormServer.AutoSize:=true;
end;

procedure TFormServer.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin //Ограничение ввода - только цифры в таблице.
if not (Key in ['0'..'9',#8]) then Key:=#0;
end;

procedure TFormServer.IdTCPServer1Execute(AContext: TIdContext);
label
endsd,//Метка для прерывания разбиение строки ответа
endtm,//Метка для прерывания подбора времени
endtc,//Метка для прерывания подбора времени при проверке
endls,//Метка для прерывания листинга StringGrid1 при заполнении cID'ами
endlu;//Метка для прерывания листинга StringGrid1 при запросе TIMEUP
begin
cID:='';ask:='';time:=0;//Обнуление переменных
askF:=AContext.Connection.IOHandler.ReadLn;//Получение запроса
for i:=0 to Length(askF) do//Разбить AskF на cID, ASK
if askF[i]<>' ' then cID:=cID+askF[i] else goto endsd;
endsd:
for i:=i+1 to Length(askF) do ask:=ask+askF[i];
//AskF разбит на cID, ASK
//Определение запроса клиента
if ask='GO' then
 begin//При запросе на начало работе
 //Получаем TIME по cID из таблицы StringGrid1
 for i:=1 to StringGrid1.RowCount do
 if StringGrid1.Cells[0,i]=cID
 then begin
 if StringGrid1.Cells[2,i]<>''
 then  begin
       time:=strtoint(StringGrid1.Cells[2,i]);
       StringGrid1.Cells[1,i]:='Да';
       end
 else  begin
       time:=0;
       StringGrid1.Cells[1,i]:='Нет';
       end;
      goto endtm;
      end;
 endtm: //Отправить время
 AContext.Connection.IOHandler.WriteLn('ACCEPT '+inttostr(time))
 end
else
if ask='CHECK' then
 begin//При проверке времени
 //Получаем TIME по cID из таблицы StringGrid1
 for i:=1 to StringGrid1.RowCount do
 if StringGrid1.Cells[0,i]=cID then
  begin
  if (StringGrid1.Cells[2,i]<>'') and (StrToInt(StringGrid1.Cells[2,i])>0)
  then
   begin//Вводим время-1 (мин.) и счёт в кассовую таблицу
   StringGrid1.Cells[2,i]:=IntToStr(StrToInt(StringGrid1.Cells[2,i])-1);
   StringGrid2.Cells[1,i]:=IntToStr(StrToInt(StringGrid2.Cells[1,i])+StrToInt(Edit1.Text));
   time:=strtoint(StringGrid1.Cells[2,i]);
   end
  else
   begin
   time:=0;
   StringGrid1.Cells[1,i]:='Нет';
   end;
  goto endtc;
  end;
 endtc: //Отправляем остаток времени
 AContext.Connection.IOHandler.WriteLn('CHECKOK '+inttostr(time));
 end
else
if ask='TIMEUP' then
 begin //При уведомлении об истечении времени
 AContext.Connection.IOHandler.WriteLn('BLOCK');
 for i:=1 to StringGrid1.RowCount do      //Стираем время в таблице
 if StringGrid1.Cells[0,i]=cID then
  begin
  StringGrid1.Cells[2,i]:='';
  StringGrid1.Cells[1,i]:='Нет';
  goto endlu;
  end;
 endlu:
 end
else
if ask='ONLINE' then
 begin//При подключении внесём клиента в таблицу
 AContext.Connection.IOHandler.WriteLn('OK');
 for i:=1 to StringGrid1.RowCount do
  begin
  if i=StringGrid1.RowCount //Расширение таблицы
  then StringGrid1.RowCount:=StringGrid1.RowCount+1;
  if StringGrid1.Cells[0,i]=cID //Определяем наличие cID в таблице
  then goto endls
  else
  if StringGrid1.Cells[0,i]=''//и свободной ячейки
  then
   begin
   StringGrid1.Cells[0,i]:=cID; //Вносим...
   StringGrid2.Cells[0,i]:=cID;
   StringGrid2.Cells[1,i]:='0';
   StringGrid1.Cells[1,i]:='Нет';
   goto endls;
   end;
  end;
 end
else
if ask='TRIED_CLOSE' then
 begin//При подключении внесём клиента в таблицу
 AContext.Connection.IOHandler.WriteLn('OK');
 for i:=1 to StringGrid1.RowCount do
  begin
  if StringGrid1.Cells[0,i]=cID //Определяем наличие cID в таблице
  then
   begin
   StringGrid1.Cells[1,i]:='ПОПЫТКА ЗАКРЫТИЯ!';
   goto endls;
   end;
  end;
 end
else //При неправильном запросе клиента дать ответ,
AContext.Connection.IOHandler.WriteLn('CMD_ERROR');//чтобы не завис клиент
endls:
end;

end.