unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    SystemPageControl: TPageControl;
    ZNDTabSheet: TTabSheet;
    SUDIRTabSheet: TTabSheet;
    ZNDCheckLabel: TLabel;
    ZNDWaitLabeledEdit: TLabeledEdit;
    CheckRadioGroup: TRadioGroup;
    ZNDWaitInstructionLabel: TLabel;
    ZNDCountCheckLabeledEdit: TLabeledEdit;
    CountCheckBitBtn: TBitBtn;
    InstructionLabel: TLabel;
    SUDIRWaitInstructionLabel: TLabel;
    SUDIRWaitLabeledEdit: TLabeledEdit;
    SUDIRLoadWndLabeledEdit: TLabeledEdit;
    SUDIRRoleInstructionLabel: TLabel;
    SUDIRRoleLabel: TLabel;
    SUDIRRoleComboBox: TComboBox;
    SUDIROsbLabeledEdit: TLabeledEdit;
    SUDIRVspLabeledEdit: TLabeledEdit;
    SUDIRSysBitBtn1: TBitBtn;
    SUDIRSysBitBtn2: TBitBtn;
    InfobankCheckBox: TCheckBox;
    SverkaCheckBox: TCheckBox;
    TransactCheckBox: TCheckBox;
    SKADCheckBox: TCheckBox;
    procedure ZNDWaitLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure ZNDCountCheckLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure SUDIRWaitLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure SUDIRLoadWndLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure SUDIRRoleComboBoxChange(Sender: TObject);
    procedure SUDIROsbLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure SUDIRVspLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure CountCheckBitBtnClick(Sender: TObject);
    procedure SUDIRSysBitBtn1Click(Sender: TObject);
    procedure SystemPageControlChange(Sender: TObject);
    procedure SUDIRSysBitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

//------------------------------------------------------------------------------
// Функция нахождения окна по части его заголовка. Полностью взята из
// Интернета, поэтому дана без внутренных комментариев.
//------------------------------------------------------------------------------
function FindNextWnd(StartHWND: HWND; AString : String): HWND;
var
  Buffer : array [0..255] of char;
begin
  Result := StartHWND;
  repeat
    Result := FindWindowEx(0, Result, nil, nil);
    GetWindowText(Result, Buffer, SizeOf(Buffer));
    if StrPos(StrUpper(Buffer), PChar(UpperCase(AString))) <> nil
    then  Break;
  until (Result = 0);
end;


//------------------------------------------------------------------------------
// Процедура эмуляции нажатия клавиш на клавиатуре. Полностью взята из
// Интернета, поэтому дана без внутренных комментариев.
//------------------------------------------------------------------------------
procedure PostKeyEx32(key: Word; const shift: TShiftState; specialkey: Boolean);
{PostKeyEx32 function}
 {************************************************************
* Procedure PostKeyEx32 
* 
* Parameters: 
*  key    : virtual keycode of the key to send. For printable 
*           keys this is simply the ANSI code (Ord(character)). 
*  shift  : state of the modifier keys. This is a set, so you 
*           can set several of these keys (shift, control, alt, 
*           mouse buttons) in tandem. The TShiftState type is 
*           declared in the Classes Unit. 
*  specialkey: normally this should be False. Set it to True to 
*           specify a key on the numeric keypad, for example. 
* Description: 
*  Uses keybd_event to manufacture a series of key events matching 
*  the passed parameters. The events go to the control with focus. 
*  Note that for characters key is always the upper-case version of 
*  the character. Sending without any modifier keys will result in 
*  a lower-case character, sending it with [ssShift] will result 
*  in an upper-case character! 
// Code by P. Below 
************************************************************}
 type
   TShiftKeyInfo = record
     shift: Byte;
     vkey: Byte;
   end;
   byteset = set of 0..7;
 const
   shiftkeys: array [1..3] of TShiftKeyInfo =
     ((shift: Ord(ssCtrl); vkey: VK_CONTROL),
     (shift: Ord(ssShift); vkey: VK_SHIFT),
     (shift: Ord(ssAlt); vkey: VK_MENU));
 var
   flag: DWORD;
   bShift: ByteSet absolute shift;
   i: Integer;
 begin
   for i := 1 to 3 do
   begin
     if shiftkeys[i].shift in bShift then
       keybd_event(shiftkeys[i].vkey, MapVirtualKey(shiftkeys[i].vkey, 0), 0, 0);
   end; { For }
   if specialkey then
     flag := KEYEVENTF_EXTENDEDKEY
   else
     flag := 0;

   keybd_event(key, MapvirtualKey(key, 0), flag, 0);
   flag := flag or KEYEVENTF_KEYUP;
   keybd_event(key, MapvirtualKey(key, 0), flag, 0);

   for i := 3 downto 1 do
   begin
     if shiftkeys[i].shift in bShift then
       keybd_event(shiftkeys[i].vkey, MapVirtualKey(shiftkeys[i].vkey, 0),
         KEYEVENTF_KEYUP, 0);
   end; { For }
 end; { PostKeyEx32 }

 
//------------------------------------------------------------------------------
// Обработчик на кнопку простановки "галок" АС Заявка
//------------------------------------------------------------------------------
procedure TForm1.CountCheckBitBtnClick(Sender: TObject);
var
  ZNDCountCheck: integer; // Переменная - количество галок
  ZNDWait: integer; // Переменная - задержка между нажатиями клавиш
  hW: HWND; // Переменная - дескриптор окна
  Buffer : array [0..255] of char;  // Переменная-массив для имени окна
begin

// Определяем кусок заголовка для поиска окна...
  hW := FindNextWnd(0, 'АС "Заявка на доступ"');

// ...Если окно не запущено, выдаём сообщение информации...
  If (hW <= 0) then ShowMessage('Не запущено окно АС "Заявка на доступ". Для продолжения работы запустите это окно.')

// ...Иначе, если не заполнено поле "Задержка, мс", то делаем его красным...
  else
  if (ZNDWaitLabeledEdit.Text = '') then ZNDWaitLabeledEdit.Color := clred

// ...Иначе, если не заполнено поле "Количество "галок"", то делаем его красным...
  else
  if (ZNDCountCheckLabeledEdit.Text = '') then ZNDCountCheckLabeledEdit.Color := clred

// ...Иначе начинаем действовать...
  else
  begin

// ...Считываем значение задержки между нажатияями с формы и записываем в переменную...
    ZNDWait := StrToInt(ZNDWaitLabeledEdit.Text);

// ...Считываем количество "галок" с формы и записываем в переменную...
    ZNDCountCheck := StrToInt(ZNDCountCheckLabeledEdit.Text);
    
// ...Делаем кнопке вид "Отмена" на случай прерывания операции...
    CountCheckBitBtn.Kind := bkCancel;
    CountCheckBitBtn.Caption := 'Заполнить "галки"';

// ...Считываем полное имя окна...
    GetWindowText(hW, Buffer, SizeOf(Buffer));

// ...Делаем его активным...
    SetForegroundWindow(FindWindow(nil, Buffer));

// ...Начинаем цикл непосредственной простановки "галок". До тех пор, пока
// значение счетчика больше 0...
    while (ZNDCountCheck > 0) do
    begin

// ...Если была нажата кнопка ESC, то выходим из подпрограммы...
      if (getasynckeystate($1b) <> 0) then exit;

// ...Нажимаем TAB и ПРОБЕЛ с задержкой, взятой с формы...
      PostKeyEx32(VK_TAB, [], False);
      sleep (ZNDWait);
      PostKeyEx32(VK_SPACE, [], False);
      sleep (ZNDWait);

// ...Если галка устанавливается двойным нажатием TAB, то нажимаем пробел
// ещё раз...
      if (CheckRadioGroup.ItemIndex = 1)
      then
      begin
        PostKeyEx32(VK_SPACE, [], False);
        sleep (ZNDWait);
      end;

// ...Уменьшаем значение счетчика на единицу...
      dec(ZNDCountCheck);
    end;

// ...По завершению цикла делаем кнопку типа "Yes", значит всё прошло успешно...
    CountCheckBitBtn.Kind := bkYes;
    CountCheckBitBtn.Caption := 'Заполнить "галки"';

// ...И выдаём окно программы на передний план.
    SetForegroundWindow(Form1.Handle);
  end;
end;


//------------------------------------------------------------------------------
// Обработчик на кнопку предоставления прав в СУДИР для систем,
// администрируемых через карточку (ИНфобанк, Сверка, и т.д.)
//------------------------------------------------------------------------------
procedure TForm1.SUDIRSysBitBtn1Click(Sender: TObject);
var
  SUDIRWait: integer;  // Переменная - задержка между нажатиями клавиш
  SUDIRLoadWnd: integer;  // Переменная - время загрузки окна
  hW: HWND; // Переменная - дескриптор окна
  Buffer : array [0..255] of char;  // Переменная-массив для имени окна
  i: integer; // Вспомогательная переменная-счетчик
begin

// Определяем кусок заголовка для поиска окна...
  hW := FindNextWnd(0, 'IBM Tivoli Identity Manager');

// ...Если окно не запущено, выдаём сообщение информации...
  If (hW <= 0) then ShowMessage('Не запущено окно АС СУДИР. Для продолжения работы запустите это окно.')

// ...Иначе, если не заполнено поле "Задержка, мс", то делаем его красным...
  else
  if (SUDIRWaitLabeledEdit.Text = '') then SUDIRWaitLabeledEdit.Color := clred

// ...Иначе, если не заполнено поле "Загрузка окна, мс", то делаем его красным...
  else
  if (SUDIRLoadWndLabeledEdit.Text = '') then SUDIRLoadWndLabeledEdit.Color := clred

// ...Иначе, если не выбрана роль из списка, то делаем его подпись красной...
  else
  if (SUDIRRoleComboBox.ItemIndex = -1) then SUDIRRoleLabel.Font.Color := clred

// ...Иначе, если не заполнено поле "Номер ОСБ" или его длина меньше 4, то делаем его красным...
  else
  if (SUDIROsbLabeledEdit.Text = '') or (Length(SUDIROsbLabeledEdit.Text) < 4)
  then SUDIROsbLabeledEdit.Color := clred

// ...Иначе, если не заполнено поле "Номер ВСП" или его длина меньше 5, то делаем его красным...
  else
  if (SUDIRVspLabeledEdit.Text = '') or (Length(SUDIRVspLabeledEdit.Text) < 5)
  then SUDIRVspLabeledEdit.Color := clred

// ...Иначе начинаем действовать...
  else
  begin

// ...Считываем значение задержки между нажатияями с формы и записываем в переменную...
    SUDIRWait := StrToInt(SUDIRWaitLabeledEdit.Text);

// ...Считываем значение задержки между нажатияями с формы и записываем в переменную...
    SUDIRLoadWnd := StrToInt(SUDIRLoadWndLabeledEdit.Text);

// ...Делаем кнопке вид "Отмена" на случай прерывания операции...
    SUDIRSysBitBtn1.Kind := bkCancel;
    SUDIRSysBitBtn1.Caption := 'Дать Инфобанк и Сверку';

// ...Считываем полное имя окна...
    GetWindowText(hW, Buffer, SizeOf(Buffer));

// ...Делаем его активным...
    SetForegroundWindow(FindWindow(nil, Buffer));

// ...Далее идёт блок по раздаче прав в автоматизированных системах...
// ...ИНФОБАНК...
// ...Если проставлена галка "Инфобанк", то...
    if (InfobankCheckBox.Checked) then
    begin

// ...Выбираем вкладку Инфобанк...
      for i := 1 to 5 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Ставим галку "Предоставить доступ к АС Инфобанк"...
      for i := 1 to 22 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ...Открываем окно полномочий в АС Инфобанк и ждём загрузки окна...
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      if (getasynckeystate($1b) <> 0) then exit;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Заполняем вкладку "Участие в группах"...

      for i := 1 to 8 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;

// ...Если выбрана роль "Заместитель руководителя", то ставим роль...
// Аналитик
      if (SUDIRRoleComboBox.ItemIndex = 3) then
      begin
        PostKeyEx32(VK_SPACE, [], False);
        sleep (SUDIRWait);
      end;

// Бухгалтер
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// Контролер
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// Оператор
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);
      
// Читатель
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// Переходим на следующую вкладку
      for i := 1 to 10 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRWait);

// ...Заполняем вкладку "Разрешение на работу с типом клиента"...
// Физлица
      for i := 1 to 5 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// Переходим на следующую вкладку
      for i := 1 to 8 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRWait);

 // ...Заполняем вкладку "Разрешение на работу с валютой"...
 // Рубль
      for i := 1 to 9 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

 // Доллар
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// Евро
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// Переходим на следующую вкладку
      for i := 1 to 7 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRWait);

// ...Заполняем вкладку "Разрешение на работу с денежными переводами"...
// Весь список
       for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// Переходим на следующую вкладку
      for i := 1 to 16 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRWait);

// ...Заполняем вкладку "Разрешение на работу с ценными бумагами"...
// Сбер. сертификаты
      for i := 1 to 4 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// Дорожные чеки
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ...Закрываем окно сведений...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Заполняем число одновременных сессий...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(Ord('1'), [], False);
      sleep (SUDIRWait);

// ...Заполняем подразделение пользователя...
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord('7'), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord('7'), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIROsbLabeledEdit.Text[1]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIROsbLabeledEdit.Text[2]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIROsbLabeledEdit.Text[3]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIROsbLabeledEdit.Text[4]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIRVspLabeledEdit.Text[1]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIRVspLabeledEdit.Text[2]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIRVspLabeledEdit.Text[3]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIRVspLabeledEdit.Text[4]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIRVspLabeledEdit.Text[5]), [], False);
      sleep (SUDIRWait);
    end;

// ...Если выбраны и Инфобанк и Сверка, то делаем возврат к стартовой позиции
// для раздачи прав в Сверке
    if ((InfobankCheckBox.Checked) and (SverkaCheckBox.Checked)) or
       ((InfobankCheckBox.Checked) and (SKADCheckBox.Checked))
    then
    for i := 1 to 42 do
    begin
      if (getasynckeystate($1b) <> 0) then exit;
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
    end;

// ...СВЕРКА...
// ...Если проставлена галка "Сверка", то...
    if (SverkaCheckBox.Checked) then
    begin

// ...Выбираем вкладку Сверка...
      for i := 1 to 16 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Открываем вкладку полномочий в Сверке...
      for i := 1 to 23 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Выбираем "ВСП не Московский ТБ"...
      for i := 1 to 5 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Закрываем окно полномочий...
      for i := 1 to 10 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      if ((SverkaCheckBox.Checked) and (SKADCheckBox.Checked))
      then sleep (SUDIRLoadWnd);
    end;

// ...СКАД...
// ...Если проставлена галка "СКАД", то...
    if (SKADCheckBox.Checked) then
    begin

// ...Выбираем вкладку СКАД...
      for i := 1 to 21 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Ставим галку "Доступ в СКАД"...
      for i := 1 to 22 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ...Открываем вкладку "Роль в системе"...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

 // ...Открываем список полномочий...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

 // ...Ставим галку "Отчету по направлению Сертификация"...
      for i := 1 to 9 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

 // ...Ставим галку "Пользователь СКАД"...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

 // ...Закрываем вкладку полномочий в СКАД...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

 // ...Ставим галку "Доступ к Onlime Documents"...
      for i := 1 to 25 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

  // ...Ставим галку "Доступ к SAP BO"...
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_SPACE, [], False);
    end;

// ...По завершению цикла делаем кнопку типа "Yes", значит всё прошло успешно...
    SUDIRSysBitBtn1.Kind := bkYes;
    SUDIRSysBitBtn1.Caption := 'Дать Инфобанк и Сверку';

// ...И выдаём окно программы на передний план.
    SetForegroundWindow(Form1.Handle);
  end;
end;


//------------------------------------------------------------------------------
// Обработчик на кнопку предоставления прав в СУДИР для систем,
// администрируемых через список уччётных записей (Транзакт)
//------------------------------------------------------------------------------
procedure TForm1.SUDIRSysBitBtn2Click(Sender: TObject);
var
  SUDIRWait: integer;  // Переменная - задержка между нажатиями клавиш
  SUDIRLoadWnd: integer;  // Переменная - время загрузки окна
  hW: HWND; // Переменная - дескриптор окна
  Buffer : array [0..255] of char;  // Переменная-массив для имени окна
  i: integer; // Вспомогательная переменная-счетчик
begin

// Определяем кусок заголовка для поиска окна...
  hW := FindNextWnd(0, 'IBM Tivoli Identity Manager');

// ...Если окно не запущено, выдаём сообщение информации...
  If (hW <= 0) then ShowMessage('Не запущено окно АС СУДИР. Для продолжения работы запустите это окно.')

// ...Иначе, если не заполнено поле "Задержка, мс", то делаем его красным...
  else
  if (SUDIRWaitLabeledEdit.Text = '') then SUDIRWaitLabeledEdit.Color := clred

// ...Иначе, если не заполнено поле "Загрузка окна, мс", то делаем его красным...
  else
  if (SUDIRLoadWndLabeledEdit.Text = '') then SUDIRLoadWndLabeledEdit.Color := clred

// ...Иначе, если не выбрана роль из списка, то делаем его подпись красной...
  else
  if (SUDIRRoleComboBox.ItemIndex = -1) then SUDIRRoleLabel.Font.Color := clred

// ...Иначе, если не заполнено поле "Номер ОСБ" или его длина меньше 4, то делаем его красным...
  else
  if (SUDIROsbLabeledEdit.Text = '') or (Length(SUDIROsbLabeledEdit.Text) < 4)
  then SUDIROsbLabeledEdit.Color := clred

// ...Иначе, если не заполнено поле "Номер ВСП" или его длина меньше 5, то делаем его красным...
  else
  if (SUDIRVspLabeledEdit.Text = '') or (Length(SUDIRVspLabeledEdit.Text) < 5)
  then SUDIRVspLabeledEdit.Color := clred

// ...Иначе начинаем действовать...
  else
  begin

// ...Считываем значение задержки между нажатияями с формы и записываем в переменную...
    SUDIRWait := StrToInt(SUDIRWaitLabeledEdit.Text);

// ...Считываем значение задержки между нажатияями с формы и записываем в переменную...
    SUDIRLoadWnd := StrToInt(SUDIRLoadWndLabeledEdit.Text);

// ...Делаем кнопке вид "Отмена" на случай прерывания операции...
    SUDIRSysBitBtn2.Kind := bkCancel;
    SUDIRSysBitBtn2.Caption := 'Дать Транзакт';

// ...Считываем полное имя окна...
    GetWindowText(hW, Buffer, SizeOf(Buffer));

// ...Делаем его активным...
    SetForegroundWindow(FindWindow(nil, Buffer));

// ...Далее идёт блок по раздаче прав в автоматизированных системах...
// ...Транзакт...
// ...Если проставлена галка "Транзакт", то...
    if (TransactCheckBox.Checked) then
    begin

// ...Переходим в раздел "Требования"...
      for i := 1 to 4 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Делаем поиск службы по начальным буквам "CRE"
      PostKeyEx32(Ord('C'), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord('R'), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord('E'), [], False);
      sleep (SUDIRWait);
      
// ...Нажимаем кнопку "Поиск"...
      for i := 1 to 3 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Нажимаем кнопку "Продолжить"...
      for i := 1 to 9 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Ставим код ТБ - 77...
      for i := 1 to 3 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(Ord('7'), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord('7'), [], False);
      sleep (SUDIRWait);

// ...Ставим считанный код ОСБ...
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIROsbLabeledEdit.Text[1]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIROsbLabeledEdit.Text[2]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIROsbLabeledEdit.Text[3]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIROsbLabeledEdit.Text[4]), [], False);
      sleep (SUDIRWait);

// ...Ставим считанный код ВСП...
      PostKeyEx32(VK_TAB, [], False);
      PostKeyEx32(Ord(SUDIRVspLabeledEdit.Text[1]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIRVspLabeledEdit.Text[2]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIRVspLabeledEdit.Text[3]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIRVspLabeledEdit.Text[4]), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord(SUDIRVspLabeledEdit.Text[5]), [], False);
      sleep (SUDIRWait);

// ...Нажимаем кнопку "Сведения"...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Выибираем из списка роль - Кредитный инспектор...
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_DOWN, [ssAlt], False);
      sleep (SUDIRWait);

      PostKeyEx32(VK_NEXT, [], False);
      sleep (SUDIRWait);

// ...Если роль не "Заместитель руководимтеля ВСП", то выбираем роль
// Кредитный инспектор, иначе - старший кредитный инспектор
      if not (SUDIRRoleComboBox.ItemIndex = 3) then
      begin
        PostKeyEx32(VK_NEXT, [], False);
        sleep (SUDIRWait);

        for i := 1 to 6 do
        begin
          if (getasynckeystate($1b) <> 0) then exit;
          PostKeyEx32(VK_UP, [], False);
          sleep (SUDIRWait);
        end;
      end;
          
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Заполняем команду - все продукты...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_DOWN, [], False);
      sleep (SUDIRLoadWnd);

// ...Нажимаем кнопку "Изменить"...
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...Нажимаем кнопку "Сохранить"...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep(SUDIRWait);
    end;
// ...По завершению цикла делаем кнопку типа "Yes", значит всё прошло успешно...
    SUDIRSysBitBtn2.Kind := bkYes;
    SUDIRSysBitBtn2.Caption := 'Дать Транзакт';

// ...И выдаём окно программы на передний план.
    SetForegroundWindow(Form1.Handle);
  end;
end;


//------------------------------------------------------------------------------
// Обработчик на ввод данных в поле "Задержка, мс" для раздела АС Заявка
//------------------------------------------------------------------------------
procedure TForm1.ZNDWaitLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin

// Делаем поле белого цвета на тот случай, если оно было красного цвета
  ZNDWaitLabeledEdit.Color := clWhite;

// Если в поле нажимаются другие клавиши кроме цифр и BACKSPACE, то
// передаём пустое действие
  if not (key in['0'..'9', #8]) then key := #0;
end;


//------------------------------------------------------------------------------
// Обработчик на ввод данных в поле "Количество галок" для раздела АС Заявка
//------------------------------------------------------------------------------
procedure TForm1.ZNDCountCheckLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin

// Делаем поле белого цвета на тот случай, если оно было красного цвета
  ZNDCountCheckLabeledEdit.Color := clWhite;

// Если в поле нажимаются другие клавиши кроме цифр и BACKSPACE, то
// передаём пустое действие
  if not (key in['0'..'9', #8]) then key := #0;
end;


//------------------------------------------------------------------------------
// Обработчик на ввод данных в поле "Задержка, мс" для раздела СУДИР
//------------------------------------------------------------------------------
procedure TForm1.SUDIRWaitLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin

// Делаем поле белого цвета на тот случай, если оно было красного цвета
  SUDIRWaitLabeledEdit.Color := clWhite;

// Если в поле нажимаются другие клавиши кроме цифр и BACKSPACE, то
// передаём пустое действие
  if not (key in['0'..'9', #8]) then key := #0;
end;


//------------------------------------------------------------------------------
// Обработчик на ввод данных в поле "Загрузка окна, мс" для раздела СУДИР
//------------------------------------------------------------------------------
procedure TForm1.SUDIRLoadWndLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin

// Делаем поле белого цвета на тот случай, если оно было красного цвета
  SUDIRLoadWndLabeledEdit.Color := clWhite;

// Если в поле нажимаются другие клавиши кроме цифр и BACKSPACE, то
// передаём пустое действие
  if not (key in['0'..'9', #8]) then key := #0;
end;


//------------------------------------------------------------------------------
// Обработчик на изменение выпадающего списка ролей для раздела СУДИР
//------------------------------------------------------------------------------
procedure TForm1.SUDIRRoleComboBoxChange(Sender: TObject);
begin

// Делаем текст подписи черного цвета на тот случай, если она была
// красного цвета
  SUDIRRoleLabel.Font.Color := clBlack;

// ... Если роль
//
// "СОЧЛ (Специалист по обслуживанию частных лиц)" или
// "МПП (Менеджер по продажам)"
//
// то активируем выбор систем
//
// Инфобанк,
// Транзакт,
//
// остальные - деактивируем...
  if (SUDIRRoleComboBox.ItemIndex = 0) or (SUDIRRoleComboBox.ItemIndex = 1) then
  begin
    InfobankCheckBox.Checked := True;
    InfobankCheckBox.Visible := True;
    SverkaCheckBox.Checked := False;
    SverkaCheckBox.Visible := False;
    SKADCheckBox.Checked := False;
    SKADCheckBox.Visible := False;
    TransactCheckBox.Checked := True;
    TransactCheckBox.Visible := True;
  end
  else

// ... иначе, если роль
//
// "ВСОЧЛ (Ведущий спец-т по обслуживанию частных лиц)"
//
// то активируем выбор систем
//
// Инфобанк,
// Сверка,
// Транзакт,
//
// остальные - деактивируем...
  if (SUDIRRoleComboBox.ItemIndex = 2) then
  begin
    InfobankCheckBox.Checked := True;
    InfobankCheckBox.Visible := True;
    SverkaCheckBox.Checked := True;
    SverkaCheckBox.Visible := True;
    SKADCheckBox.Checked := False;
    SKADCheckBox.Visible := False;
    TransactCheckBox.Checked := True;
    TransactCheckBox.Visible := True;
  end
    else

// ... иначе, если роль
//
// "Руководитель ВСП / Заместитель"
//
// то активируем выбор систем
//
// Инфобанк,
// Сверка,
// СКАД,
// Транзакт,
//
// остальные - деактивируем...
  if (SUDIRRoleComboBox.ItemIndex = 3) then
  begin
    InfobankCheckBox.Checked := True;
    InfobankCheckBox.Visible := True;
    SverkaCheckBox.Checked := True;
    SverkaCheckBox.Visible := True;
    SKADCheckBox.Checked := True;
    SKADCheckBox.Visible := True;
    TransactCheckBox.Checked := True;
    TransactCheckBox.Visible := True;
  end;
end;


//------------------------------------------------------------------------------
// Обработчик на ввод данных в поле "Номер ОСБ" для раздела СУДИР
//------------------------------------------------------------------------------
procedure TForm1.SUDIROsbLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin

// Делаем поле белого цвета на тот случай, если оно было красного цвета
  SUDIROsbLabeledEdit.Color := clWhite;

// Если в поле нажимаются другие клавиши кроме цифр и BACKSPACE, то
// передаём пустое действие
  if ((length(SUDIROsbLabeledEdit.Text) >= 4) and (key <> #8)) then key := #0
  else
  if not (key in['0'..'9', #8]) then key := #0;
end;


//------------------------------------------------------------------------------
// Обработчик на ввод данных в поле "Номер ВСП" для раздела СУДИР
//------------------------------------------------------------------------------
procedure TForm1.SUDIRVspLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin

// Делаем поле белого цвета на тот случай, если оно было красного цвета
  SUDIRVspLabeledEdit.Color := clWhite;

// Если в поле нажимаются другие клавиши кроме цифр и BACKSPACE, то
// передаём пустое действие
  if ((length(SUDIRVspLabeledEdit.Text) >= 5) and (key <> #8)) then key := #0
  else
  if not (key in['0'..'9', #8]) then key := #0;
end;


//------------------------------------------------------------------------------
// Обработчик на переключение активных вкладок (изменение размера формы)
//------------------------------------------------------------------------------
procedure TForm1.SystemPageControlChange(Sender: TObject);
begin
if (SystemPageControl.ActivePage = ZNDTabSheet) then
  begin
    Form1.Height := 453;  
    SystemPageControl.Height := Form1.Height - 56;
  end
  else
  if (SystemPageControl.ActivePage = SUDIRTabSheet) then
  begin
    Form1.Height := 643;
    SystemPageControl.Height := Form1.Height - 56;
  end
end;

end.
