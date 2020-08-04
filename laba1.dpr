program laba1;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.Sysutils;

const
  N = 1000;

type
  MyRecord = record // ��� ������
    numb: byte; // ���� 1- ��������
    str: string; // ���� 2- ���������
    logic: boolean; // ���� 3- ����������

  end;

  MyMas = array [1 .. N] of MyRecord; // ������ ������� �� 1000 ���������
  TCompareFunc = function (var a, b: MyRecord): boolean; // ��� �-�� ��� ����������

var
  mas: MyMas;
  VodStr: string; // ��������� ������ ��� ������
  VodNumb: integer; // ��������� ����� ��� ������
  mid: integer;
  OutPut: integer;
  MyTest: boolean;
  kolvo, index: integer;
  N1, N2: integer;
  l, BinTemp, BlockTemp:integer;

procedure TableHead;
begin
  writeln('----------------------------------------------------------------------------------------------');
  writeln('| Part of record |      index    |     record    |    Binary Search    |     Block Search    | ');
  writeln('|----------------|---------------|---------------|---------------------|---------------------|');

end;

procedure Generation(var mas: MyMas); // ��������� ������� �������
var
  i: integer;
begin
  randomize;
  for i := 1 to N do
  begin

    mas[i].numb := random(201);
    mas[i].str := 'my_test_' + inttostr(i);
    mas[i].logic := false;
  end;
end;

procedure print(var mas: MyMas); // ����� �������
var
  i: integer;
begin

  for i := 1 to N do
  begin

    write(mas[i].numb:6);
    write(mas[i].str:20);
    write(mas[i].logic:10);
    writeln;

  end;
end;

procedure Swap(var a, b: MyRecord); // ��������� ������ �������
var
  temp: MyRecord;
begin
  temp := a;
  a := b;
  b := temp;
end;

function CompareStr(var a, b: MyRecord): boolean; // ��������� �����
var
  i, j: integer;
begin
  if a.str > b.str then
    result := a.str > b.str

end;

function CompareNumb(var a, b: MyRecord): boolean; // ��������� �����
var
  i, j: integer;
begin
  if a.numb > b.numb then
    result := a.numb > b.numb;
end;

procedure BubleSort(var mas: MyMas; CompareFunc: TCompareFunc; MyTest: boolean);// ����������
var
  i, j: integer;
begin
  for i := 1 to N - 1 do
    for j := 1 to N - i do
      if CompareFunc(mas[j], mas[j + 1]) then
        Swap(mas[j], mas[j + 1]);

  if MyTest then
    print(mas);
end;

procedure MakeFalse(var mas: MyMas); // ������������ ��. ���� 3 �������� false
var
  i: integer;
begin
  for i := 1 to N do
    mas[i].logic := false;
end;

procedure BinarySearch(var mas: MyMas; const VodStr: string;
const VodNumb: integer; const metka: integer; MyTest: boolean); //�������� ����k
var
  left, right, mid: integer;
  IsFind: boolean;
  temp, RightBorder: integer;
begin
  left := 1;
  right := N;
  IsFind := false;
  case metka of
    1: // ����� � ���� 2
      begin

        while (left <= right) and not(IsFind) do
        begin
          mid := (right + left) div 2;
          mas[mid].logic := true;
          if (mas[mid].str = VodStr) then // �������� ��������
            IsFind := true

          else
          begin

            if (mas[mid].str < VodStr) then
              left := mid + 1 // �������� ������
            else
              right := mid - 1; // �������� �����

          end;
        end;

        if not(IsFind) then
          writeln('Your string is not found')
        else if MyTest then

        begin
          writeln;
          writeln(mas[mid].numb:6, mas[mid].str:20, mas[mid].logic:10);   //����� �������
        end;
      end;
    2: // ����� � ���� 1
      begin

        while (left <= right) and not(IsFind) do
        begin
          mid := (right + left) div 2;
          mas[mid].logic := true;
          if (mas[mid].numb = VodNumb) then
            IsFind := true
          else
          begin
            if (mas[mid].numb < VodNumb) then
              left := mid + 1
            else
              right := mid - 1;
          end;

        end;

        if not(IsFind) then
          writeln('Your number is not found')
        else
        begin
          temp := mid;                    //������� ���-�� ������� �������
          while (mas[temp].numb = VodNumb) do
          begin
            inc(temp);
            mas[temp].logic := true;
          end;
          dec(temp);
          RightBorder := temp;

          while mas[temp].numb = VodNumb do
          begin
            dec(temp);
            mas[temp].logic := true;
          end;
          inc(temp);

          while temp <= RightBorder do
          begin
            writeln(mas[temp].numb:6, mas[temp].str:20, mas[temp].logic:10);  //����� �������
            inc(temp);
          end;

        end;

      end;
  end;
end;

procedure BlockSearch(var mas: MyMas; const VodStr: string;
  const VodNumb: integer; const metka: integer; MyTest: boolean ); // ������� �����

var
  index, step: integer;
  IsFind, flag: boolean;
  temp: integer;
  mid, RightBorder: integer;
begin
  step := Round(sqrt(N)); // ����������� ������ ����� = ���
  index := step;
  flag := true;
  IsFind := false;
  case metka of
    1:  // ����� � ���� 2
      begin

        while not(IsFind) do
        begin
          if index <= N then
          begin
            mas[index].logic := true;
            if mas[index].str = VodStr then
            begin
              IsFind := true;
            end
            else if mas[index].str > VodStr then
            begin

              if step = 1 then
              begin
                IsFind := true;
                flag := false;
              end;
              index := index - step;
              step := Round(sqrt(step));
              index := index + step;
            end
            else
            begin
              if (index = N) or (step = 1) then
              begin
                IsFind := true;
                flag := false;
              end;
              index := index + step;
            end;

          end
          else
          begin
            mas[index].logic := true;
            index := index - step;
            step := N - index;
            index := N;
          end;
        end;

        if MyTest then
        begin
          if flag then
          begin
            writeln(mas[index].numb:6, mas[index].str:20, mas[index].logic:10); //����� �������
          end
          else
            writeln('Your string is not found');
        end;
      end;

    2:  // ����� � ���� 1
      begin

        while not(IsFind) do
        begin
          if index <= N then
          begin
            mas[index].logic := true;
            if mas[index].numb = VodNumb then
            begin
              IsFind := true;
            end
            else if mas[index].numb > VodNumb then
            begin

              if step = 1 then
              begin
                IsFind := true;
                flag := false;
              end;
              index := index - step;
              step := Round(sqrt(step));
              index := index + step;
            end
            else
            begin
              if (index = N) or (step = 1) then
              begin
                IsFind := true;
                flag := false;
              end;
              index := index + step;
            end;

          end
          else
          begin
            mas[index].logic := true;
            index := index - step;
            step := N - index;
            index := N;
          end;
        end;

        mid := index;                         // ������� ���-�� ������� �������
        while mas[index].numb = VodNumb do
        begin
          inc(index);
          mas[index].logic := true;
        end;
        dec(index);
        RightBorder := index;

        while mas[mid].numb = VodNumb do
        begin
          dec(mid);
          mas[mid].logic := true;
        end;
        inc(mid);

        if flag then
        begin
          while mid <= RightBorder do
          begin
            writeln(mas[mid].numb:6, mas[mid].str:20, mas[mid].logic:10); //����� �������
            inc(mid);
          end;
        end
        else
          writeln('Your number is not found');
      end;

  end;
end;

procedure CountNumbOfTrue(var mas: MyMas; MyTest: boolean;  var NumbOfHit: integer);  //������� ������
var
  counter, i: integer;
begin
  counter := 0;
  for i := 1 to N do
  begin
    if mas[i].logic = true then
      inc(counter);
  end;
  if MyTest then
    writeln('Number of true:', counter)
  else
    NumbOfHit := counter;
end;


begin
  writeln('Binary Search(1)       Block Search(2)     Compare Table(3)  ');
  readln(OutPut);
  writeln;
  case OutPut of
    1: //�������� �����
      begin
        MyTest := true;
        Generation(mas); // ������� �������
        print(mas); // ����� �������
        writeln;
        writeln('Sorted massive by the second field :');
        writeln;
        readln;
        BubleSort(mas, CompareStr, true);// ���������� ���� 2
        writeln;
        writeln('write your string:'); // ���� ������ ��� ������
        readln(VodStr);
        BinarySearch(mas, VodStr, VodNumb, 1, MyTest);// �������� ����� � ���� 2
        writeln;
        CountNumbOfTrue(mas, MyTest, N1); // ������� true
        readln;
        print(mas);
        MakeFalse(mas); // ��������� ���� ��. ���� 3 �������� false
        writeln;
        writeln('Sorted massive by the first field :');
        writeln;
        readln;
        BubleSort(mas, CompareNumb, true); // ���������� ���� 1
        writeln;
        writeln('write your number:'); // ���� ����� ��� ������
        readln(VodNumb);
        BinarySearch(mas, VodStr, VodNumb, 2, MyTest); // �������� ����� � ���� 1
        writeln;
        CountNumbOfTrue(mas, MyTest, N1); // ������� true
        readln;
        print(mas);
      end;

    2://������� �����
      begin
        MyTest := true;
        Generation(mas); // ������� �������
        print(mas); // ����� �������
        writeln;
        writeln('Sorted massive by the second field :');
        writeln;
        readln;
        BubleSort(mas, CompareStr, true);// ���������� ���� 2
        writeln;
        writeln('write your string:'); // ���� ������ ��� ������
        readln(VodStr);
        BlockSearch(mas, VodStr, VodNumb, 1, MyTest); // ������� ����� � ���� 2
        writeln;
        CountNumbOfTrue(mas, MyTest, N1); // ������� true
        readln;
        print(mas);
        MakeFalse(mas); // ��������� ���� ��. ���� 3 �������� false
        writeln;
        writeln('Sorted massive by the first field :');
        writeln;
        readln;
        BubleSort(mas, CompareNumb, true); // ���������� ���� 1
        writeln;
        writeln('write your number:'); // ���� ����� ��� ������
        readln(VodNumb);
        BlockSearch(mas, VodStr, VodNumb, 2, MyTest); // ������� ����� � ���� 1
        writeln;
        CountNumbOfTrue(mas, MyTest, N1); // ������� true
        readln;
        print(mas);
      end;

    3: // ������������� �������
      begin
        MyTest := false;
        TableHead;
        Generation(mas);
        BubleSort(mas, CompareStr, MyTest);
        index := 100;
        for kolvo := 1 to 3 do
        begin
         writeln('|    ',kolvo,' part      |               |               |                     |                     |');
         writeln('|                |               |               |                     |                     |');
         N1:=0;
         N2:=0;
         VodStr := mas[index].str;
         for l := 1 to 3 do
          begin
                VodStr := mas[index].str;
                BinarySearch(mas, VodStr, VodNumb, 1, MyTest);
                CountNumbOfTrue(mas, MyTest, BinTemp);
                MakeFalse(mas);
                N1:=N1+BinTemp;
                BlockSearch(mas, VodStr, VodNumb, 1, MyTest);
                CountNumbOfTrue(mas, MyTest, BlockTemp);
                MakeFalse(mas);
                N2:=N2+BlockTemp;
                writeln('|    ',l,' element:  |    ',index:5,'      | ',VodStr:14,'|  ',BinTemp:10,'         |   ', BlockTemp:10, '        |');
                inc(index,10);

          end;
           N1:= round (N1/3);
           N2:= round (N2/3);
           writeln('|----------------|---------------|---------------|---------------------|---------------------|');
           writeln('|    Result:     |               |               |  ',N1:10,'         |   ',N2:10,'        |');
           writeln('|----------------|---------------|---------------|---------------------|---------------------|');
           inc(index, 300);
        end;

      end;
  end;

  readln;

end.
