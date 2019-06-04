unit Unit_data;

interface

uses Windows, Types, ExtCtrls, Graphics, Chart, Classes, sysutils;


type
txyz=record
x, y, z :integer;
end;{txyz}


tangle=record
 fix, fiy, fiz : integer;
end;{tangle}

TXYZPoint=record
 Pcoord : txyz;
 Pimage : tPoint;
 Pangle : tangle;
 PAxis : txyz;
end;{TXYZPoint}

TlineXYZ=record
 _beg, _end : TXYZPoint;
end;{TlineXYZ}


{-------declare records--------}

Ukazelems=^Telems;

Telems=record
_point : TXYZPoint;
_Next : Ukazelems;
end;{Telems}

{-------declare records--------}


Function Assign_point(x,y,z,fix,fiy,fiz,_x,_y,_z : integer):TXYZPoint;
Function Assign_Line(P1,P2 : TXYZPoint):TlineXYZ;
Procedure Line_Image (Image : Timage; L1 : TlineXYZ);
Procedure Line_ImageA (L1 : TlineXYZ);
function _Vector(x,y,z : integer;p : TXYZPoint):TXYZPoint;
function _Axis(x,y,z : integer;p : TXYZPoint):TXYZPoint;
Procedure My_line(x0, y0, x1, y1 : integer; var MyPoints : Ukazelems);
Procedure My_lineA(x0, y0, x1, y1 : integer; Image1 : TImage; var MyPoints : Ukazelems);
Procedure Output_pointsA(_Canvas : Tcanvas;var MyPoints : Ukazelems);
Procedure Output_points(var MyPoints : Ukazelems);
Procedure Clear_points(var MyPoints : Ukazelems);
Procedure Init_points(var MyPoints : Ukazelems);
Procedure My_line3d(x0, y0, z0, x1, y1, z1 : integer;  var MyPoints : Ukazelems);
Procedure Output_points3d(spis : Tstrings; var MyPoints : Ukazelems);


var
  _p : array[1..8] of TXYZPoint;
  _Lines : array[1..100] of TlineXYZ;
  MyPoints : Ukazelems;

  HDCcanvas : HDC;
  ColorCanvas : Tcolor;

implementation

Function _cos(Fi : real):real;
begin
 Result:=Cos(Fi*Pi/180);
end;{_cos}

Function _sin(Fi : real):real;
begin
 Result:=Sin(Fi*Pi/180);
end;{_sin}

Function xyztopoint(P : txyzpoint):Tpoint;
begin
 with P.Pcoord, P.Pangle do
   begin
    x:=Round(x);
    y:=Round(y*_cos(fix)-z*_sin(fix));
    z:=Round(y*_sin(fix)+z*_cos(fix));
   end;{with}

 with P.Pcoord, P.Pangle do
   begin
    x:=Round(x*_cos(fiy)-z*_sin(fiy));
    y:=Round(y);
    z:=Round(z*_cos(fiy)-x*_sin(fiy));
   end;{with}


 with P.Pcoord do 
   begin
    x:=x+P.PAxis.x;
    y:=y+P.PAxis.y;
    z:=z+P.PAxis.z;
   end;{with}


if True then
 begin
   Result.X:=Round(P.pcoord.x+P.pcoord.z*sqrt(0.5));
   Result.Y:=Round(P.pcoord.y+P.pcoord.z*sqrt(0.5));
 end{if}
else
 begin
   Result.X:=Round((P.pcoord.x-P.pcoord.z)*sqrt(0.75));
   Result.Y:=Round(P.pcoord.y+(P.pcoord.x+P.pcoord.z)*0.5);

 end;{else}

end;{xyztopoint}

Procedure Line_Image (Image : Timage; L1 : TlineXYZ);
var
  p1, p2 : Tpoint;
begin
 p1:=xyztopoint(L1._beg);
 p2:=xyztopoint(L1._end);
 with Image.canvas do
   begin
    Moveto(p1.X, p1.y);
    Lineto(p2.X, p2.y);
   end;
end;{Line_Image}


Procedure Line_ImageA (L1 : TlineXYZ);
var
  p1, p2 : Tpoint;
begin
 p1:=xyztopoint(L1._beg);
 p2:=xyztopoint(L1._end);
 {
 with Image.canvas do
   begin
    Moveto(p1.X, p1.y);
    Lineto(p2.X, p2.y);
   end;
   }
 My_line(p1.X, p1.y, p2.X, p2.y, MyPoints);
end;{Line_ImageA}


Function Assign_point(x,y,z,fix,fiy,fiz,_x,_y,_z : integer):TXYZPoint;
begin
 Result.Pcoord.x:=x;
 Result.Pcoord.y:=y;
 Result.Pcoord.z:=z;
 Result.Pangle.fix:=fix;
 Result.Pangle.fiy:=fiy;
 Result.Pangle.fiz:=fiz;
 Result.PAxis.x:=_x;
 Result.PAxis.y:=_y;
 Result.PAxis.z:=_z;
end;{Assign_point}

Function Assign_Line(P1,P2 : TXYZPoint):TlineXYZ;
begin
 Result._beg:=P1;
 Result._end:=P2;
end;

function _Vector(x,y,z : integer;p : TXYZPoint):TXYZPoint;
begin
 Result:=p;
 Result.Pcoord.x:=p.Pcoord.x+x;
 Result.Pcoord.y:=p.Pcoord.y+y;
 Result.Pcoord.z:=p.Pcoord.z+z;

end;{_Vector}

function _Axis(x,y,z : integer;p : TXYZPoint):TXYZPoint;
begin
 Result:=p;
 Result.Paxis.x:=x;
 Result.Paxis.y:=y;
 Result.Paxis.z:=z;

end;{_Axis}

Procedure Add_PointA(x,y,z,fix,fiy,fiz,_x,_y,_z : integer;var MyPoints : Ukazelems);
begin
  if MyPoints=Nil then
    begin
     New(MyPoints);
     MyPoints^._point:=Assign_point(x,y,z,fix,fiy,fiz,_x,_y,_z);
     MyPoints^._Next:=Nil;
    end
  else Add_PointA(x,y,z,fix,fiy,fiz,_x,_y,_z, MyPoints^._Next);
end;{Add_PointA}

Procedure Add_Point(x,y,z,fix,fiy,fiz,_x,_y,_z : integer;var MyPoints : Ukazelems);
var
   Cpoint : Ukazelems;
begin
  New(Cpoint);
  Cpoint^._point:=Assign_point(x,y,z,fix,fiy,fiz,_x,_y,_z);
  Cpoint^._Next:=MyPoints;
  MyPoints:=Cpoint;
end;{Add_Point}




Procedure Output_pointsA(_Canvas : Tcanvas;var MyPoints : Ukazelems);
begin
  if Mypoints=Nil then Exit;
  _Canvas.Pixels[Mypoints^._point.Pcoord.x, Mypoints^._point.Pcoord.y]:=_Canvas.Pen.Color;
  Output_pointsA(_Canvas, MyPoints^._Next);
end;{Output_pointsA}

Procedure Output_pointsB(var MyPoints : Ukazelems);
Label  _beg;

var
  _p : Ukazelems;
begin
  _p:=MyPoints;
_beg:
  if _p=Nil then Exit;
  SetPixel(HDCcanvas, _p^._point.Pcoord.x, _p^._point.Pcoord.y, ColorCanvas);
  _p:=_p^._Next;
  goto _beg;
//  Output_points(_p^._Next);
end;{Output_pointsB}

Procedure Output_points(var MyPoints : Ukazelems);
begin
  if Mypoints=Nil then Exit;
//  _Canvas.Pixels[Mypoints^._point.Pcoord.x, Mypoints^._point.Pcoord.y]:=_Canvas.Pen.Color;
  SetPixel(HDCcanvas, MyPoints^._point.Pcoord.x, MyPoints^._point.Pcoord.y, ColorCanvas);
  Output_points(MyPoints^._Next);
end;{Output_points}

Procedure Output_points3d(spis : Tstrings; var MyPoints : Ukazelems);
begin
  if Mypoints=Nil then Exit;
//  _Canvas.Pixels[Mypoints^._point.Pcoord.x, Mypoints^._point.Pcoord.y]:=_Canvas.Pen.Color;
//  SetPixel(HDCcanvas, MyPoints^._point.Pcoord.x, MyPoints^._point.Pcoord.y, ColorCanvas);
  spis.Add(inttostr(MyPoints^._point.Pcoord.x)+' '+inttostr(MyPoints^._point.Pcoord.y)+ ' '+inttostr(MyPoints^._point.Pcoord.z));
  Output_points3d(spis, MyPoints^._Next);
end;{Output_points}

Procedure Clear_points(var MyPoints : Ukazelems);
begin
  if Mypoints=Nil then Exit;
  Clear_points(MyPoints^._Next);
  Dispose(Mypoints);
  Init_points(Mypoints);
end;{Clear_points}

Procedure Init_points(var MyPoints : Ukazelems);
begin
  MyPoints:=Nil;
end;{Init_points}


Procedure My_line(x0, y0, x1, y1 : integer;  var MyPoints : Ukazelems);
var
  deltax, deltay, error, deltaerr, y, diry, dirx, x  : integer;
begin
   deltax := abs(x1 - x0);
   deltay := abs(y1 - y0);
   error := 0;
   deltaerr := deltay;
   y:=y0;
   x:=x0;

   diry := y1 - y0;
   if diry>0 then diry:=1;
   if diry<0 then diry:=-1;

   dirx := x1 - x0;
   if dirx>0 then dirx:=1;
   if dirx<0 then dirx:=-1;


   while (x<>x1) or (y<>y1) do
    begin
     if 2 * error >= deltax then
        begin
             y := y + diry;
             error := error - deltax;
        end; {if}
     if x<>x1 then  if 2 * error < deltax then
          begin
            x:=x+dirx;
            error := error + deltaerr;
          end;{if}
//     _Canvas.Pixels[x,y]:=_color;
     Add_Point(x, y, 0, 0,0,0,0,0,0,Mypoints);
    end;{while}


(* OLD Variant
   while (x<>x1) or (y<>y1) do
    begin
     if 2 * error >= deltax then
        begin
             y := y + diry;
             error := error - deltax;
        end {if}
     else
        begin
         x:=x+dirx;
         error := error + deltaerr;
        end;{else}
//     _Canvas.Pixels[x,y]:=_color;
     Add_Point(x, y, 0, 0,0,0,0,0,0,Mypoints);
    end;{while}

OLD Variant*)

(*
int deltax := abs(x1 - x0)
     int deltay := abs(y1 - y0)
     int error := 0
     int deltaerr := deltay
     int y := y0
     int diry := y1 - y0
     if diry > 0
         diry = 1
     if diry < 0 
         diry = -1
     for x from x0 to x1
         plot(x,y)
         error := error + deltaerr
         if 2 * error >= deltax
             y := y + diry
             error := error - deltax

*)

end;{My_line}


Procedure My_lineA(x0, y0, x1, y1 : integer; Image1 : TImage; var MyPoints : Ukazelems);
var
  deltax, deltay, error, deltaerr, y, y_, diry, dirx, x  : integer;
  _color : Tcolor;
  h1 : HDC;
  _b : boolean;
begin
   deltax := abs(x1 - x0);
   deltay := abs(y1 - y0);
   error := 0;
   deltaerr := deltay;
   y:=y0;
   x:=x0;
   diry := y1 - y0;
   if diry>0 then diry:=1;
   if diry<0 then diry:=-1;

   dirx := x1 - x0;
   if dirx>0 then dirx:=1;
   if dirx<0 then dirx:=-1;

   h1:=(Image1.canvas.Handle);
   _color:=ColorToRGB(Image1.Canvas.Pen.Color);

   while (x<>x1) or (y<>y1) do
    begin
     if 2 * error >= deltax then
        begin
             y := y + diry;
             error := error - deltax;
        end {if}
     else
        begin
         x:=x+dirx;
         error := error + deltaerr;
        end;{else}
//     Image1.Canvas.Pixels[x,y]:= Image1.Canvas.Pen.Color;
     SetPixel(h1, x, y, _color);

    end;{while}

//UpDateWindow(GetWindowDC(h1));
(*
int deltax := abs(x1 - x0)
     int deltay := abs(y1 - y0)
     int error := 0
     int deltaerr := deltay
     int y := y0
     int diry := y1 - y0
     if diry > 0
         diry = 1
     if diry < 0 
         diry = -1
     for x from x0 to x1
         plot(x,y)
         error := error + deltaerr
         if 2 * error >= deltax
             y := y + diry
             error := error - deltax

*)

end;{My_lineA}


Procedure My_line3d(x0, y0, z0, x1, y1, z1 : integer;  var MyPoints : Ukazelems);
var
  deltax, deltay, deltaz, x, y, z, dirx, diry, dirz, e_yx, e_yz, e_xz, e_xy, e_zx, e_zy   : integer;
begin
   deltax := abs(x1 - x0);
   deltay := abs(y1 - y0);
   deltaz := abs(z1 - z0);
   y:=y0;
   x:=x0;
   z:=z0;

   diry := y1 - y0;
   if diry>0 then diry:=1;
   if diry<0 then diry:=-1;

   dirx := x1 - x0;
   if dirx>0 then dirx:=1;
   if dirx<0 then dirx:=-1;

   dirz := z1 - z0;
   if dirz>0 then dirz:=1;
   if dirz<0 then dirz:=-1;

   if (deltay>=deltax) and (deltay>=deltaz) then
     begin
        e_yx:=(deltax-deltay);
        e_yz:=(deltaz-deltay);
        while (x<>x1) or (y<>y1) or (z<>z1) do
          begin
           if e_yx>=0 then if (x<>x1) then
              begin
               x:=x+dirx;
               e_yx:=e_yx-2*deltay;
              end;{if}
           if e_yz>=0 then if (z<>z1) then
              begin
               z:=z+dirz;
               e_yz:=e_yz-2*deltay;
              end;{if}
           if y<>y1 then
             begin
               y:=y+diry;
               e_yx:=e_yx+2*deltax;
               e_yz:=e_yz+2*deltaz;
             end;
           Add_Point(x, y, z, 0,0,0,0,0,0,Mypoints);
          end;{while}
        Exit;
     end;{if   delta  y}


   if (deltax>=deltay) and (deltax>=deltaz) then
     begin
        e_xy:=(deltay-deltax);
        e_xz:=(deltaz-deltax);
        while (x<>x1) or (y<>y1) or (z<>z1) do
          begin
           if e_xy>=0 then if (y<>y1) then
              begin
               y:=y+diry;
               e_xy:=e_xy-2*deltax;
              end;{if}
           if e_xz>=0 then if (z<>z1) then
              begin
               z:=z+dirz;
               e_xz:=e_xz-2*deltax;
              end;{if}
           if x<>x1 then
             begin
               x:=x+dirx;
               e_xy:=e_xy+2*deltay;
               e_xz:=e_xz+2*deltaz;
             end;
           Add_Point(x, y, z, 0,0,0,0,0,0,Mypoints);
          end;{while}
        Exit;
     end;{if   delta  x}



   if (deltaz>=deltay) and (deltaz>=deltax) then
     begin
        e_zx:=(deltax-deltaz);
        e_zy:=(deltay-deltaz);
        while (x<>x1) or (y<>y1) or (z<>z1) do
          begin
           if e_zx>=0 then if (x<>x1) then
              begin
               x:=x+dirx;
               e_zx:=e_zx-2*deltaz;
              end;{if}
           if e_zy>=0 then if (y<>y1) then
              begin
               y:=y+diry;
               e_zy:=e_zy-2*deltaz;
              end;{if}
           if z<>z1 then
             begin
               y:=y+diry;
               e_zx:=e_zx+2*deltax;
               e_zy:=e_zy+2*deltay;
             end;
           Add_Point(x, y, z, 0,0,0,0,0,0,Mypoints);
          end;{while}
        Exit;
     end;{if   delta  z}

end;{My_line3d}




end.
