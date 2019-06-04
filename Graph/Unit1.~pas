unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, TeEngine, Series, TeeProcs;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure Paint_figure(_color : Tcolor);
  end;

var
  Form1: TForm1;
   __Tst : TstringList;

implementation

uses Unit_data;

{$R *.dfm}

Procedure _cube(Lsize, x, y, z, _x, _y, _z, fix, fiy, fiz : integer; Pencolor : Tcolor;flag_meth : boolean);
var
   i : integer;
begin
 _p[1]:=Assign_point(0, 0, 0, fix, fiy, fiz,0,0,0);
 _p[2]:=Assign_point(0,Lsize,0, fix, fiy, fiz,0,0,0);
 _p[3]:=Assign_point(Lsize,Lsize,0, fix, fiy, fiz,0,0,0);
 _p[4]:=Assign_point(Lsize,0,0, fix, fiy, fiz,0,0,0);

 _p[5]:=Assign_point(0,0,Lsize, fix, fiy, fiz,0,0,0);
 _p[6]:=Assign_point(0,Lsize,Lsize, fix, fiy, fiz,0,0,0);
 _p[7]:=Assign_point(Lsize,Lsize,Lsize, fix, fiy, fiz,0,0,0);
 _p[8]:=Assign_point(Lsize,0,Lsize, fix, fiy, fiz,0,0,0);

 for i:=1 to 8 do _p[i]:=_Vector(x,y,z,_p[i]);
 for i:=1 to 8 do _p[i]:=_Axis(_x,_y,_z,_p[i]);

 _lines[1]:=Assign_Line(_p[1], _p[2]);
 _lines[2]:=Assign_Line(_p[2], _p[3]);
 _lines[3]:=Assign_Line(_p[3], _p[4]);
 _lines[4]:=Assign_Line(_p[4], _p[1]);

 _lines[5]:=Assign_Line(_p[5], _p[6]);
 _lines[6]:=Assign_Line(_p[6], _p[7]);
 _lines[7]:=Assign_Line(_p[7], _p[8]);
 _lines[8]:=Assign_Line(_p[8], _p[5]);

 _lines[9]:=Assign_Line(_p[1], _p[5]);
 _lines[10]:=Assign_Line(_p[2], _p[6]);
 _lines[11]:=Assign_Line(_p[3], _p[7]);
 _lines[12]:=Assign_Line(_p[4], _p[8]);

 _lines[13]:=Assign_Line(_p[1], _p[7]);
 _lines[14]:=Assign_Line(_p[2], _p[8]);

 form1.Image1.Canvas.Pen.Color:=Pencolor;
 for i:=1 to 14 do
   begin
     if flag_meth then Line_Image(form1.Image1, _lines[i])
     else Line_ImageA(_lines[i]);
   end;
end;{_cube}


procedure TForm1.Button1Click(Sender: TObject);
var
   i : integer;
   beg_time : TdateTime;
   __dlit : integer;
begin
beg_time:=Now;
for i:=1 to 3600 do
   begin
     _cube(100,0,0,0,
     200,100,0,
     0,i,0,clblack, true);
     Application.ProcessMessages;
//     sleep(100);

     _cube(100,0,0,0,
     200,100,0,
     0,i,0,clwhite, true);

     Application.ProcessMessages;
   end;
__dlit:=Round((Now-beg_time)*86400*1000);
if __dlit=0 then;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   i : integer;
begin
 Init_points(MyPoints);
 Image1.Canvas.Pen.Color:=clblack;
 i:=getheapstatus.overhead;
 if i=0 then;
 My_line(420, 200, 200, 0,  MyPoints);
// My_line(200, 0, 420, 200,  MyPoints);
 HDCcanvas:=Image1.canvas.Handle;
 ColorCanvas:=ColorToRGB(Image1.Canvas.Pen.Color);
 Output_points(MyPoints);
 i:=getheapstatus.overhead;
 if i=0 then;
 Clear_points(MyPoints);
 i:=getheapstatus.overhead;
 if i=0 then;
 form1.Image1.Repaint;

 Image1.Canvas.Pen.Color:=clred;
 Image1.Canvas.MoveTo(430,200);
 Image1.Canvas.LineTo(210,0);
 __Tst := TstringList.Create;
 __Tst.Add('dgvgxdfgjvj,.bj/k;"?ML;jfcgnjcfjghkhvulkljbil;njo;');
 i:=getheapstatus.overhead;
 if i=0 then;
 __Tst.Free;

 i:=getheapstatus.overhead;
 if i=0 then;

end;



procedure TForm1.Button3Click(Sender: TObject);
var
   i : integer;
   beg_time : TdateTime;
   __dlit : integer;
begin
beg_time:=Now;
for i:=1 to 3600 do
   begin

 Init_points(MyPoints);

     _cube(100,0,0,0,
     200,100,0,
     0,i,0,clblack, False);

 Paint_figure(clblack);
//     sleep(10);
 Paint_figure(clwhite);

 Clear_points(MyPoints);

   end;
__dlit:=Round((Now-beg_time)*86400*1000);
if __dlit=0 then;
end;

procedure TForm1.Paint_figure(_color : Tcolor);
begin
 HDCcanvas:=Image1.canvas.Handle;
 ColorCanvas:=_color;
 Output_points(MyPoints);
 form1.Image1.Repaint;
 Application.ProcessMessages;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 Memo1.Lines.Clear;
 Init_points(MyPoints);
 Image1.Canvas.Pen.Color:=clblack;
 My_line3d(0, 0, 0, 200, 200, 100,  MyPoints);
 HDCcanvas:=Image1.canvas.Handle;
 ColorCanvas:=ColorToRGB(Image1.Canvas.Pen.Color);
 Output_points3d(memo1.lines,   MyPoints);
 Clear_points(MyPoints);
 form1.Image1.Repaint;

end;

end.
