unit test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;
const
  R = 40;
  N = 12;

type
 TBConnection1 = array [1..11,1..12] of byte;
  TStatus = (stBlue, stRed, stBlack);
  TArray = array [1..N] of Tstatus;
  TPeak = record
    x,y:integer;
    status:TStatus;
  end;
  TPeakList = array[1..N] of TPeak;
  TForm1 = class(TForm)
    Image1: TImage;
    pnlSidebar: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonRestartClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  Level1:array[1..2, 1..N] of integer = ((180,300,420,300,60,180,300,420,540,420,300,180),(110,40,110,200,400,320,320,320,400,500,500,500));
  Level1XShift = 100;
  Level1YShift = 20;
  Answer1:TArray =
  (stRed,stBlue,stBlue,stBlue,stRed,stBlue,stBlue,stBlue,stRed,stRed,stBlue,stBlue);
  Answer2:TArray =
  (stBlue,stBlue,stRed,stBlue,stRed,stRed,stBlue,stBlue,stRed,stBlue,stBlue,stBlue);
  const   // 2 3 4 5 6 7 8 9 0 1 2
	BConnection:TBConnection1 =
           ((0,1,0,1,1,0,0,0,0,0,0,0),
				    (0,0,1,1,0,0,0,0,0,0,0,0),
				    (0,0,0,1,0,0,0,0,0,1,0,0),
				    (0,0,0,0,0,0,0,0,0,0,0,0),
				    (0,0,0,0,0,1,0,0,0,0,0,1),
				    (0,0,0,0,0,0,1,0,0,0,1,0),
				    (0,0,0,0,0,0,0,1,0,1,0,0),
				    (0,0,0,0,0,0,0,0,1,0,0,1),
				    (0,0,0,0,0,0,0,0,0,1,0,0),
				    (0,0,0,0,0,0,0,0,0,0,1,0),
				    (0,0,0,0,0,0,0,0,0,0,0,1));
var
  Form1: TForm1;
  PeakList:TPeakList;
  x0,y0:integer;
  gameState: boolean;

implementation

{$R *.dfm}

procedure TForm1.ButtonRestartClick(Sender: TObject);
var i:integer;
begin
for i := 1 to N do
  begin
  PeakList[i].status :=stBlue;
  x0:= PeakList[i].x;
  y0:= PeakList[i].y;
  Image1.Canvas.Ellipse(x0-R,Y0-R,X0+R,Y0+R)
  end;
button2.Visible:=False;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i:integer;

begin
gameState:=true;
  for i := 1 to 12 do
    if (Peaklist[i].Status <> Answer1[i])
      then
       gameState:=False;
       if not(gameState) then
       begin
        gameState:=True;
        for i := 1 to 12 do
           if (Peaklist[i].Status <> Answer2[i]) then
        gameState:=False;
       end;
       if gameState then
       ShowMessage('You win');

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i,j: Integer;
begin
  for i := 1 to 12 do
  begin
    PeakList[i].x := level1[1,i] + Level1XShift;
    PeakList[i].y := level1[2,i] + Level1YShift;
  end;
  Image1.Canvas.Pen.Width := 10;
  for i := 2 to 12 do
  begin
    for j := i-1 to 12 do
    begin
      if BConnection[i,j] = 1 then

    end;
  end;
  {Image1.Canvas.MoveTo(PeakList[1].x, PeakList[1].y);
  for i := 1 to 12 do
  begin
    PeakList[i].x := level1[1,i];
    PeakList[i].y := level1[2,i];
    Image1.Canvas.LineTo(PeakList[i].x, PeakList[i].y);
  end;              }
  Image1.Canvas.Brush.Color := clBlue;
  Image1.Canvas.Pen.Width := 1;
  for i := 1 to 12 do
  begin
    Image1.Canvas.Ellipse(PeakList[i].x-R,PeakList[i].y-R,PeakList[i].x+R,PeakList[i].y+R);
  end;


  //Image1.Canvas.MoveTo(X0,Y0);
  //Image1.Canvas.LineTo(x0+100, y0+100);
  //Image1.Canvas.LineTo(x0+200, y0);
  {Image1.Canvas.Brush.Color := clBlue;
  Image1.Canvas.Ellipse(x0-R,Y0-R,X0+R,Y0+R);
  Image1.Canvas.Ellipse(x0+200-R,Y0-R,X0+200+R,Y0+R);}

end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i:integer;
begin
    //ShowMessage(IntToStr(x) + ' ' + IntToStr(y));
    if  Button=mbLeft then
      begin
      Image1.Canvas.Brush.Color := clRed;
      for i:=1 to N do
        begin
        if (PeakList[i].x-x)*(PeakList[i].x-x) + (PeakList[i].y-y)*(PeakList[i].y-y) <= R*R then
          begin
          x0:= PeakList[i].x;
          y0:= PeakList[i].y;
          PeakList[i].status :=stRed;
          end;
        end;
      end
    else if Button=mbRight then
      begin
      Image1.Canvas.Brush.Color := clBlack;
      for i:=1 to N do
        begin
        if (PeakList[i].x-x)*(PeakList[i].x-x) + (PeakList[i].y-y)*(PeakList[i].y-y) <= R*R then
          begin
          x0:= PeakList[i].x;
          y0:= PeakList[i].y;
          PeakList[i].status :=stBlack;
          end;
        end;
      end;
    Image1.Canvas.Ellipse(x0-R,Y0-R,X0+R,Y0+R);

end;

end.
