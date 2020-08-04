# **Анализ поисковых алгоритмов**

Шаг1: сгенерировать массив записей на 1000 элементов. Каждая запись состоит из трех полей

Числовое поле – целое случайное число из диапазона 0-200
Строковое поле – ‘My_Test_ ’ + k, где k – строковое представление номера записи по порядку ее создания (1>=k>=1000)
Логическое поле = false
Шаг 2: Вывести сгенерированный массив

Шаг3: Отсортировать полученный массив по возрастанию поля 2 (строковое поле)

Шаг 4: Вывести полученный массив

Шаг 5: произвести поиск в массиве записи со значением поля 2, равным строке, введенной с клавиатуры. Использовать алгоритм по-иска, выданный преподавателем. Каждый раз, когда происходит сравнение значения поля текущей записи с введенным значением, меняет-ся значение логического поля текущей записи на true. Результаты поиска вывести на экран

Шаг 6: Вывести полученный массив и посчитать, сколько записей имеют значение поля 3 = true

Шаг 7: присвоить всем элементам массива значение поля 3 = false

Шаг 8: Отсортировать полученный массив по возрастанию поля 1 (Числовое поле)

Шаг 9: Вывести полученный массив

Шаг 10: произвести поиск в массиве всех записей с числовым полем, равным числу, введенному с клавиатуры. Использовать алгоритм поиска, выданный преподавателем. Каждый раз, когда происходит сравнение числового поля текущей записи с введенным числом, меняет-ся значение логического поля текущей записи на true. Результаты поиска вывести на экран в следующем виде: Искомые записи с числом, равным 27: Поле 1 Поле 2 Поле 3 27 my_test_3 true 27 my_test_471 true 27 my_test_500 true 27 my_test_782 true

Шаг 11: Вывести полученный массив и посчитать, сколько записей имеют значение поля 3 = true

## **Бинарный и блочный поиск**
>Delphi

```Delphi
program laba1;

{$APPTYPE CONSOLE}
{$R *.res}

uses System.Sysutils;

const
  N = 1000;

type
  MyRecord = record // моя запись
    numb: byte; // поле 1- числовое
    str: string; // поле 2- строковое
    logic: boolean; // поле 3- логическое

  end;

  MyMas = array [1 .. N] of MyRecord; // массив записей на 1000 элементов
  TCompareFunc = function (var a, b: MyRecord): boolean; // тип ф-ии для сортировки

var
  mas: MyMas;
  VodStr: string; // введенная строка для поиска
  VodNumb: integer; // введенное число для поиска
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

procedure Generation(var mas: MyMas); // генерация массива записей
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

procedure print(var mas: MyMas); // вывод массива
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

procedure Swap(var a, b: MyRecord); // процедура обмена записей
var
  temp: MyRecord;
begin
  temp := a;
  a := b;
  b := temp;
end;

function CompareStr(var a, b: MyRecord): boolean; // сравнение строк
var
  i, j: integer;
begin
  if a.str > b.str then
    result := a.str > b.str

end;

function CompareNumb(var a, b: MyRecord): boolean; // сравнение чисел
var
  i, j: integer;
begin
  if a.numb > b.numb then
    result := a.numb > b.numb;
end;

procedure BubleSort(var mas: MyMas; CompareFunc: TCompareFunc; MyTest: boolean);// сортировка
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

procedure MakeFalse(var mas: MyMas); // присваивание эл. поля 3 значения false
var
  i: integer;
begin
  for i := 1 to N do
    mas[i].logic := false;
end;

procedure BinarySearch(var mas: MyMas; const VodStr: string;
const VodNumb: integer; const metka: integer; MyTest: boolean); //бинарный поисk
var
  left, right, mid: integer;
  IsFind: boolean;
  temp, RightBorder: integer;
begin
  left := 1;
  right := N;
  IsFind := false;
  case metka of
    1: // поиск в поле 2
      begin

        while (left <= right) and not(IsFind) do
        begin
          mid := (right + left) div 2;
          mas[mid].logic := true;
          if (mas[mid].str = VodStr) then // просмотр середины
            IsFind := true

          else
          begin

            if (mas[mid].str < VodStr) then
              left := mid + 1 // сдвигаем вправо
            else
              right := mid - 1; // сдвигаем влево

          end;
        end;

        if not(IsFind) then
          writeln('Your string is not found')
        else if MyTest then

        begin
          writeln;
          writeln(mas[mid].numb:6, mas[mid].str:20, mas[mid].logic:10);   //вывод записей
        end;
      end;
    2: // поиск в поле 1
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
          temp := mid;                    //подсчет кол-ва искомых записей
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
            writeln(mas[temp].numb:6, mas[temp].str:20, mas[temp].logic:10);  //вывод записей
            inc(temp);
          end;

        end;

      end;
  end;
end;

procedure BlockSearch(var mas: MyMas; const VodStr: string;
  const VodNumb: integer; const metka: integer; MyTest: boolean ); // блочный поиск

var
  index, step: integer;
  IsFind, flag: boolean;
  temp: integer;
  mid, RightBorder: integer;
begin
  step := Round(sqrt(N)); // размерность одного блока = шаг
  index := step;
  flag := true;
  IsFind := false;
  case metka of
    1:  // поиск в поле 2
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
            writeln(mas[index].numb:6, mas[index].str:20, mas[index].logic:10); //вывод записей
          end
          else
            writeln('Your string is not found');
        end;
      end;

    2:  // поиск в поле 1
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

        mid := index;                         // подсчет кол-ва искомых записей
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
            writeln(mas[mid].numb:6, mas[mid].str:20, mas[mid].logic:10); //вывод записей
            inc(mid);
          end;
        end
        else
          writeln('Your number is not found');
      end;

  end;
end;

procedure CountNumbOfTrue(var mas: MyMas; MyTest: boolean;  var NumbOfHit: integer);  //подсчет трушек
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
    1: //бинарный поиск
      begin
        MyTest := true;
        Generation(mas); // задание массива
        print(mas); // вывод массива
        writeln;
        writeln('Sorted massive by the second field :');
        writeln;
        readln;
        BubleSort(mas, CompareStr, true);// сортировка поля 2
        writeln;
        writeln('write your string:'); // ввод строки для поиска
        readln(VodStr);
        BinarySearch(mas, VodStr, VodNumb, 1, MyTest);// двоичный поиск в поле 2
        writeln;
        CountNumbOfTrue(mas, MyTest, N1); // подсчет true
        readln;
        print(mas);
        MakeFalse(mas); // присвание всем эл. поля 3 значение false
        writeln;
        writeln('Sorted massive by the first field :');
        writeln;
        readln;
        BubleSort(mas, CompareNumb, true); // сортировка поля 1
        writeln;
        writeln('write your number:'); // ввод числа для поиска
        readln(VodNumb);
        BinarySearch(mas, VodStr, VodNumb, 2, MyTest); // двоичный поиск в поле 1
        writeln;
        CountNumbOfTrue(mas, MyTest, N1); // подсчет true
        readln;
        print(mas);
      end;

    2://блочный поиск
      begin
        MyTest := true;
        Generation(mas); // задание массива
        print(mas); // вывод массива
        writeln;
        writeln('Sorted massive by the second field :');
        writeln;
        readln;
        BubleSort(mas, CompareStr, true);// сортировка поля 2
        writeln;
        writeln('write your string:'); // ввод строки для поиска
        readln(VodStr);
        BlockSearch(mas, VodStr, VodNumb, 1, MyTest); // блочный поиск в поле 2
        writeln;
        CountNumbOfTrue(mas, MyTest, N1); // подсчет true
        readln;
        print(mas);
        MakeFalse(mas); // присвание всем эл. поля 3 значение false
        writeln;
        writeln('Sorted massive by the first field :');
        writeln;
        readln;
        BubleSort(mas, CompareNumb, true); // сортировка поля 1
        writeln;
        writeln('write your number:'); // ввод числа для поиска
        readln(VodNumb);
        BlockSearch(mas, VodStr, VodNumb, 2, MyTest); // блочный поиск в поле 1
        writeln;
        CountNumbOfTrue(mas, MyTest, N1); // подсчет true
        readln;
        print(mas);
      end;

    3: // сравнительная таблица
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
```
