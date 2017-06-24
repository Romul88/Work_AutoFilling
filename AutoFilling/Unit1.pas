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
// ������� ���������� ���� �� ����� ��� ���������. ��������� ����� ��
// ���������, ������� ���� ��� ���������� ������������.
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
// ��������� �������� ������� ������ �� ����������. ��������� ����� ��
// ���������, ������� ���� ��� ���������� ������������.
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
// ���������� �� ������ ����������� "�����" �� ������
//------------------------------------------------------------------------------
procedure TForm1.CountCheckBitBtnClick(Sender: TObject);
var
  ZNDCountCheck: integer; // ���������� - ���������� �����
  ZNDWait: integer; // ���������� - �������� ����� ��������� ������
  hW: HWND; // ���������� - ���������� ����
  Buffer : array [0..255] of char;  // ����������-������ ��� ����� ����
begin

// ���������� ����� ��������� ��� ������ ����...
  hW := FindNextWnd(0, '�� "������ �� ������"');

// ...���� ���� �� ��������, ����� ��������� ����������...
  If (hW <= 0) then ShowMessage('�� �������� ���� �� "������ �� ������". ��� ����������� ������ ��������� ��� ����.')

// ...�����, ���� �� ��������� ���� "��������, ��", �� ������ ��� �������...
  else
  if (ZNDWaitLabeledEdit.Text = '') then ZNDWaitLabeledEdit.Color := clred

// ...�����, ���� �� ��������� ���� "���������� "�����"", �� ������ ��� �������...
  else
  if (ZNDCountCheckLabeledEdit.Text = '') then ZNDCountCheckLabeledEdit.Color := clred

// ...����� �������� �����������...
  else
  begin

// ...��������� �������� �������� ����� ���������� � ����� � ���������� � ����������...
    ZNDWait := StrToInt(ZNDWaitLabeledEdit.Text);

// ...��������� ���������� "�����" � ����� � ���������� � ����������...
    ZNDCountCheck := StrToInt(ZNDCountCheckLabeledEdit.Text);
    
// ...������ ������ ��� "������" �� ������ ���������� ��������...
    CountCheckBitBtn.Kind := bkCancel;
    CountCheckBitBtn.Caption := '��������� "�����"';

// ...��������� ������ ��� ����...
    GetWindowText(hW, Buffer, SizeOf(Buffer));

// ...������ ��� ��������...
    SetForegroundWindow(FindWindow(nil, Buffer));

// ...�������� ���� ���������������� ����������� "�����". �� ��� ���, ����
// �������� �������� ������ 0...
    while (ZNDCountCheck > 0) do
    begin

// ...���� ���� ������ ������ ESC, �� ������� �� ������������...
      if (getasynckeystate($1b) <> 0) then exit;

// ...�������� TAB � ������ � ���������, ������ � �����...
      PostKeyEx32(VK_TAB, [], False);
      sleep (ZNDWait);
      PostKeyEx32(VK_SPACE, [], False);
      sleep (ZNDWait);

// ...���� ����� ��������������� ������� �������� TAB, �� �������� ������
// ��� ���...
      if (CheckRadioGroup.ItemIndex = 1)
      then
      begin
        PostKeyEx32(VK_SPACE, [], False);
        sleep (ZNDWait);
      end;

// ...��������� �������� �������� �� �������...
      dec(ZNDCountCheck);
    end;

// ...�� ���������� ����� ������ ������ ���� "Yes", ������ �� ������ �������...
    CountCheckBitBtn.Kind := bkYes;
    CountCheckBitBtn.Caption := '��������� "�����"';

// ...� ����� ���� ��������� �� �������� ����.
    SetForegroundWindow(Form1.Handle);
  end;
end;


//------------------------------------------------------------------------------
// ���������� �� ������ �������������� ���� � ����� ��� ������,
// ���������������� ����� �������� (��������, ������, � �.�.)
//------------------------------------------------------------------------------
procedure TForm1.SUDIRSysBitBtn1Click(Sender: TObject);
var
  SUDIRWait: integer;  // ���������� - �������� ����� ��������� ������
  SUDIRLoadWnd: integer;  // ���������� - ����� �������� ����
  hW: HWND; // ���������� - ���������� ����
  Buffer : array [0..255] of char;  // ����������-������ ��� ����� ����
  i: integer; // ��������������� ����������-�������
begin

// ���������� ����� ��������� ��� ������ ����...
  hW := FindNextWnd(0, 'IBM Tivoli Identity Manager');

// ...���� ���� �� ��������, ����� ��������� ����������...
  If (hW <= 0) then ShowMessage('�� �������� ���� �� �����. ��� ����������� ������ ��������� ��� ����.')

// ...�����, ���� �� ��������� ���� "��������, ��", �� ������ ��� �������...
  else
  if (SUDIRWaitLabeledEdit.Text = '') then SUDIRWaitLabeledEdit.Color := clred

// ...�����, ���� �� ��������� ���� "�������� ����, ��", �� ������ ��� �������...
  else
  if (SUDIRLoadWndLabeledEdit.Text = '') then SUDIRLoadWndLabeledEdit.Color := clred

// ...�����, ���� �� ������� ���� �� ������, �� ������ ��� ������� �������...
  else
  if (SUDIRRoleComboBox.ItemIndex = -1) then SUDIRRoleLabel.Font.Color := clred

// ...�����, ���� �� ��������� ���� "����� ���" ��� ��� ����� ������ 4, �� ������ ��� �������...
  else
  if (SUDIROsbLabeledEdit.Text = '') or (Length(SUDIROsbLabeledEdit.Text) < 4)
  then SUDIROsbLabeledEdit.Color := clred

// ...�����, ���� �� ��������� ���� "����� ���" ��� ��� ����� ������ 5, �� ������ ��� �������...
  else
  if (SUDIRVspLabeledEdit.Text = '') or (Length(SUDIRVspLabeledEdit.Text) < 5)
  then SUDIRVspLabeledEdit.Color := clred

// ...����� �������� �����������...
  else
  begin

// ...��������� �������� �������� ����� ���������� � ����� � ���������� � ����������...
    SUDIRWait := StrToInt(SUDIRWaitLabeledEdit.Text);

// ...��������� �������� �������� ����� ���������� � ����� � ���������� � ����������...
    SUDIRLoadWnd := StrToInt(SUDIRLoadWndLabeledEdit.Text);

// ...������ ������ ��� "������" �� ������ ���������� ��������...
    SUDIRSysBitBtn1.Kind := bkCancel;
    SUDIRSysBitBtn1.Caption := '���� �������� � ������';

// ...��������� ������ ��� ����...
    GetWindowText(hW, Buffer, SizeOf(Buffer));

// ...������ ��� ��������...
    SetForegroundWindow(FindWindow(nil, Buffer));

// ...����� ��� ���� �� ������� ���� � ������������������ ��������...
// ...��������...
// ...���� ����������� ����� "��������", ��...
    if (InfobankCheckBox.Checked) then
    begin

// ...�������� ������� ��������...
      for i := 1 to 5 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...������ ����� "������������ ������ � �� ��������"...
      for i := 1 to 22 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ...��������� ���� ���������� � �� �������� � ��� �������� ����...
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      if (getasynckeystate($1b) <> 0) then exit;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...��������� ������� "������� � �������"...

      for i := 1 to 8 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;

// ...���� ������� ���� "����������� ������������", �� ������ ����...
// ��������
      if (SUDIRRoleComboBox.ItemIndex = 3) then
      begin
        PostKeyEx32(VK_SPACE, [], False);
        sleep (SUDIRWait);
      end;

// ���������
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ���������
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ��������
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);
      
// ��������
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ��������� �� ��������� �������
      for i := 1 to 10 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRWait);

// ...��������� ������� "���������� �� ������ � ����� �������"...
// �������
      for i := 1 to 5 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ��������� �� ��������� �������
      for i := 1 to 8 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRWait);

 // ...��������� ������� "���������� �� ������ � �������"...
 // �����
      for i := 1 to 9 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

 // ������
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ����
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ��������� �� ��������� �������
      for i := 1 to 7 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRWait);

// ...��������� ������� "���������� �� ������ � ��������� ����������"...
// ���� ������
       for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ��������� �� ��������� �������
      for i := 1 to 16 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRWait);

// ...��������� ������� "���������� �� ������ � ������� ��������"...
// ����. �����������
      for i := 1 to 4 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// �������� ����
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ...��������� ���� ��������...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...��������� ����� ������������� ������...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(Ord('1'), [], False);
      sleep (SUDIRWait);

// ...��������� ������������� ������������...
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

// ...���� ������� � �������� � ������, �� ������ ������� � ��������� �������
// ��� ������� ���� � ������
    if ((InfobankCheckBox.Checked) and (SverkaCheckBox.Checked)) or
       ((InfobankCheckBox.Checked) and (SKADCheckBox.Checked))
    then
    for i := 1 to 42 do
    begin
      if (getasynckeystate($1b) <> 0) then exit;
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
    end;

// ...������...
// ...���� ����������� ����� "������", ��...
    if (SverkaCheckBox.Checked) then
    begin

// ...�������� ������� ������...
      for i := 1 to 16 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...��������� ������� ���������� � ������...
      for i := 1 to 23 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...�������� "��� �� ���������� ��"...
      for i := 1 to 5 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...��������� ���� ����������...
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

// ...����...
// ...���� ����������� ����� "����", ��...
    if (SKADCheckBox.Checked) then
    begin

// ...�������� ������� ����...
      for i := 1 to 21 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...������ ����� "������ � ����"...
      for i := 1 to 22 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

// ...��������� ������� "���� � �������"...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

 // ...��������� ������ ����������...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

 // ...������ ����� "������ �� ����������� ������������"...
      for i := 1 to 9 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

 // ...������ ����� "������������ ����"...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

 // ...��������� ������� ���������� � ����...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

 // ...������ ����� "������ � Onlime Documents"...
      for i := 1 to 25 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_SPACE, [], False);
      sleep (SUDIRWait);

  // ...������ ����� "������ � SAP BO"...
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_SPACE, [], False);
    end;

// ...�� ���������� ����� ������ ������ ���� "Yes", ������ �� ������ �������...
    SUDIRSysBitBtn1.Kind := bkYes;
    SUDIRSysBitBtn1.Caption := '���� �������� � ������';

// ...� ����� ���� ��������� �� �������� ����.
    SetForegroundWindow(Form1.Handle);
  end;
end;


//------------------------------------------------------------------------------
// ���������� �� ������ �������������� ���� � ����� ��� ������,
// ���������������� ����� ������ �������� ������� (��������)
//------------------------------------------------------------------------------
procedure TForm1.SUDIRSysBitBtn2Click(Sender: TObject);
var
  SUDIRWait: integer;  // ���������� - �������� ����� ��������� ������
  SUDIRLoadWnd: integer;  // ���������� - ����� �������� ����
  hW: HWND; // ���������� - ���������� ����
  Buffer : array [0..255] of char;  // ����������-������ ��� ����� ����
  i: integer; // ��������������� ����������-�������
begin

// ���������� ����� ��������� ��� ������ ����...
  hW := FindNextWnd(0, 'IBM Tivoli Identity Manager');

// ...���� ���� �� ��������, ����� ��������� ����������...
  If (hW <= 0) then ShowMessage('�� �������� ���� �� �����. ��� ����������� ������ ��������� ��� ����.')

// ...�����, ���� �� ��������� ���� "��������, ��", �� ������ ��� �������...
  else
  if (SUDIRWaitLabeledEdit.Text = '') then SUDIRWaitLabeledEdit.Color := clred

// ...�����, ���� �� ��������� ���� "�������� ����, ��", �� ������ ��� �������...
  else
  if (SUDIRLoadWndLabeledEdit.Text = '') then SUDIRLoadWndLabeledEdit.Color := clred

// ...�����, ���� �� ������� ���� �� ������, �� ������ ��� ������� �������...
  else
  if (SUDIRRoleComboBox.ItemIndex = -1) then SUDIRRoleLabel.Font.Color := clred

// ...�����, ���� �� ��������� ���� "����� ���" ��� ��� ����� ������ 4, �� ������ ��� �������...
  else
  if (SUDIROsbLabeledEdit.Text = '') or (Length(SUDIROsbLabeledEdit.Text) < 4)
  then SUDIROsbLabeledEdit.Color := clred

// ...�����, ���� �� ��������� ���� "����� ���" ��� ��� ����� ������ 5, �� ������ ��� �������...
  else
  if (SUDIRVspLabeledEdit.Text = '') or (Length(SUDIRVspLabeledEdit.Text) < 5)
  then SUDIRVspLabeledEdit.Color := clred

// ...����� �������� �����������...
  else
  begin

// ...��������� �������� �������� ����� ���������� � ����� � ���������� � ����������...
    SUDIRWait := StrToInt(SUDIRWaitLabeledEdit.Text);

// ...��������� �������� �������� ����� ���������� � ����� � ���������� � ����������...
    SUDIRLoadWnd := StrToInt(SUDIRLoadWndLabeledEdit.Text);

// ...������ ������ ��� "������" �� ������ ���������� ��������...
    SUDIRSysBitBtn2.Kind := bkCancel;
    SUDIRSysBitBtn2.Caption := '���� ��������';

// ...��������� ������ ��� ����...
    GetWindowText(hW, Buffer, SizeOf(Buffer));

// ...������ ��� ��������...
    SetForegroundWindow(FindWindow(nil, Buffer));

// ...����� ��� ���� �� ������� ���� � ������������������ ��������...
// ...��������...
// ...���� ����������� ����� "��������", ��...
    if (TransactCheckBox.Checked) then
    begin

// ...��������� � ������ "����������"...
      for i := 1 to 4 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...������ ����� ������ �� ��������� ������ "CRE"
      PostKeyEx32(Ord('C'), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord('R'), [], False);
      sleep (SUDIRWait);
      PostKeyEx32(Ord('E'), [], False);
      sleep (SUDIRWait);
      
// ...�������� ������ "�����"...
      for i := 1 to 3 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...�������� ������ "����������"...
      for i := 1 to 9 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...������ ��� �� - 77...
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

// ...������ ��������� ��� ���...
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

// ...������ ��������� ��� ���...
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

// ...�������� ������ "��������"...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...��������� �� ������ ���� - ��������� ���������...
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_DOWN, [ssAlt], False);
      sleep (SUDIRWait);

      PostKeyEx32(VK_NEXT, [], False);
      sleep (SUDIRWait);

// ...���� ���� �� "����������� ������������� ���", �� �������� ����
// ��������� ���������, ����� - ������� ��������� ���������
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

// ...��������� ������� - ��� ��������...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_DOWN, [], False);
      sleep (SUDIRLoadWnd);

// ...�������� ������ "��������"...
      PostKeyEx32(VK_TAB, [], False);
      sleep (SUDIRWait);
      PostKeyEx32(VK_RETURN, [], False);
      sleep (SUDIRLoadWnd);

// ...�������� ������ "���������"...
      for i := 1 to 2 do
      begin
        if (getasynckeystate($1b) <> 0) then exit;
        PostKeyEx32(VK_TAB, [], False);
        sleep (SUDIRWait);
      end;
      PostKeyEx32(VK_RETURN, [], False);
      sleep(SUDIRWait);
    end;
// ...�� ���������� ����� ������ ������ ���� "Yes", ������ �� ������ �������...
    SUDIRSysBitBtn2.Kind := bkYes;
    SUDIRSysBitBtn2.Caption := '���� ��������';

// ...� ����� ���� ��������� �� �������� ����.
    SetForegroundWindow(Form1.Handle);
  end;
end;


//------------------------------------------------------------------------------
// ���������� �� ���� ������ � ���� "��������, ��" ��� ������� �� ������
//------------------------------------------------------------------------------
procedure TForm1.ZNDWaitLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin

// ������ ���� ������ ����� �� ��� ������, ���� ��� ���� �������� �����
  ZNDWaitLabeledEdit.Color := clWhite;

// ���� � ���� ���������� ������ ������� ����� ���� � BACKSPACE, ��
// ������� ������ ��������
  if not (key in['0'..'9', #8]) then key := #0;
end;


//------------------------------------------------------------------------------
// ���������� �� ���� ������ � ���� "���������� �����" ��� ������� �� ������
//------------------------------------------------------------------------------
procedure TForm1.ZNDCountCheckLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin

// ������ ���� ������ ����� �� ��� ������, ���� ��� ���� �������� �����
  ZNDCountCheckLabeledEdit.Color := clWhite;

// ���� � ���� ���������� ������ ������� ����� ���� � BACKSPACE, ��
// ������� ������ ��������
  if not (key in['0'..'9', #8]) then key := #0;
end;


//------------------------------------------------------------------------------
// ���������� �� ���� ������ � ���� "��������, ��" ��� ������� �����
//------------------------------------------------------------------------------
procedure TForm1.SUDIRWaitLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin

// ������ ���� ������ ����� �� ��� ������, ���� ��� ���� �������� �����
  SUDIRWaitLabeledEdit.Color := clWhite;

// ���� � ���� ���������� ������ ������� ����� ���� � BACKSPACE, ��
// ������� ������ ��������
  if not (key in['0'..'9', #8]) then key := #0;
end;


//------------------------------------------------------------------------------
// ���������� �� ���� ������ � ���� "�������� ����, ��" ��� ������� �����
//------------------------------------------------------------------------------
procedure TForm1.SUDIRLoadWndLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin

// ������ ���� ������ ����� �� ��� ������, ���� ��� ���� �������� �����
  SUDIRLoadWndLabeledEdit.Color := clWhite;

// ���� � ���� ���������� ������ ������� ����� ���� � BACKSPACE, ��
// ������� ������ ��������
  if not (key in['0'..'9', #8]) then key := #0;
end;


//------------------------------------------------------------------------------
// ���������� �� ��������� ����������� ������ ����� ��� ������� �����
//------------------------------------------------------------------------------
procedure TForm1.SUDIRRoleComboBoxChange(Sender: TObject);
begin

// ������ ����� ������� ������� ����� �� ��� ������, ���� ��� ����
// �������� �����
  SUDIRRoleLabel.Font.Color := clBlack;

// ... ���� ����
//
// "���� (���������� �� ������������ ������� ���)" ���
// "��� (�������� �� ��������)"
//
// �� ���������� ����� ������
//
// ��������,
// ��������,
//
// ��������� - ������������...
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

// ... �����, ���� ����
//
// "����� (������� ����-� �� ������������ ������� ���)"
//
// �� ���������� ����� ������
//
// ��������,
// ������,
// ��������,
//
// ��������� - ������������...
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

// ... �����, ���� ����
//
// "������������ ��� / �����������"
//
// �� ���������� ����� ������
//
// ��������,
// ������,
// ����,
// ��������,
//
// ��������� - ������������...
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
// ���������� �� ���� ������ � ���� "����� ���" ��� ������� �����
//------------------------------------------------------------------------------
procedure TForm1.SUDIROsbLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin

// ������ ���� ������ ����� �� ��� ������, ���� ��� ���� �������� �����
  SUDIROsbLabeledEdit.Color := clWhite;

// ���� � ���� ���������� ������ ������� ����� ���� � BACKSPACE, ��
// ������� ������ ��������
  if ((length(SUDIROsbLabeledEdit.Text) >= 4) and (key <> #8)) then key := #0
  else
  if not (key in['0'..'9', #8]) then key := #0;
end;


//------------------------------------------------------------------------------
// ���������� �� ���� ������ � ���� "����� ���" ��� ������� �����
//------------------------------------------------------------------------------
procedure TForm1.SUDIRVspLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin

// ������ ���� ������ ����� �� ��� ������, ���� ��� ���� �������� �����
  SUDIRVspLabeledEdit.Color := clWhite;

// ���� � ���� ���������� ������ ������� ����� ���� � BACKSPACE, ��
// ������� ������ ��������
  if ((length(SUDIRVspLabeledEdit.Text) >= 5) and (key <> #8)) then key := #0
  else
  if not (key in['0'..'9', #8]) then key := #0;
end;


//------------------------------------------------------------------------------
// ���������� �� ������������ �������� ������� (��������� ������� �����)
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
