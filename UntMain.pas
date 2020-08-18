unit UntMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.Effects, FMX.Filter.Effects,
  FMX.Objects, FMX.TabControl, FMX.Layouts, FMX.StdCtrls,

  System.RegularExpressions;


const
  C_White    = $FFF3F3F3;
  C_CorRed   = $FFE63636;
  C_CorGreen = $FF01EF01;
  {Expressões Regulares}
  C_EXP_CPF        = '([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}'     +
                     '[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}'    +
                     '[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})' ;

  C_EXP_EMAIL      = '^((?>[a-zA-Z\d!#$%&''*+\-/=?^_`{|}~]+\x20*' +
                     '|"((?=[\x01-\x7f])[^"\\]|\\[\x01-\x7f])*"\' +
                     'x20*)*(?<angle><))?((?!\.)(?>\.?[a-zA-Z\d!' +
                     '#$%&''*+\-/=?^_`{|}~]+)+|"((?=[\x01-\x7f])' +
                     '[^"\\]|\\[\x01-\x7f])*")@(((?!-)[a-zA-Z\d\' +
                     '-]+(?<!-)\.)+[a-zA-Z]{2,}|\[(((?(?<!\[)\.)' +
                     '(25[0-5]|2[0-4]\d|[01]?\d?\d)){4}|[a-zA-Z\' +
                     'd\-]*[a-zA-Z\d]:((?=[\x01-\x7f])[^\\\[\]]|' +
                     '\\[\x01-\x7f])+)\])(?(angle)>)$';

type
  TTipoCampo = (tcCPF, tcEmail, tcSenha);

  TForm1 = class(TForm)
    Layout1: TLayout;
    tbCtrl: TTabControl;
    tbiLogin: TTabItem;
    tbiPerfil: TTabItem;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Image1: TImage;
    FillRGBEffect1: TFillRGBEffect;
    Layout3: TLayout;
    Layout4: TLayout;
    Rectangle2: TRectangle;
    edtEmail: TEdit;
    StyleBook1: TStyleBook;
    Layout5: TLayout;
    Rectangle3: TRectangle;
    edtSenha: TEdit;
    Layout6: TLayout;
    Layout7: TLayout;
    Rectangle4: TRectangle;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Layout8: TLayout;
    Rectangle5: TRectangle;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    lytCheckEmail: TLayout;
    lytCheckSenha: TLayout;
    pthEmail: TPath;
    pthSenha: TPath;
    fillEmail: TFillRGBEffect;
    fillSenha: TFillRGBEffect;
    Rectangle6: TRectangle;
    Image2: TImage;
    Layout10: TLayout;
    GaussianBlurEffect1: TGaussianBlurEffect;
    Circle1: TCircle;
    Layout9: TLayout;
    Label4: TLabel;
    Layout11: TLayout;
    Layout12: TLayout;
    Layout13: TLayout;
    Path1: TPath;
    Label5: TLabel;
    Layout14: TLayout;
    Layout15: TLayout;
    Path2: TPath;
    Label6: TLabel;
    Layout16: TLayout;
    Layout17: TLayout;
    Path3: TPath;
    Label7: TLabel;
    Layout18: TLayout;
    Layout19: TLayout;
    Path4: TPath;
    Label8: TLabel;
    procedure edtEmailTyping(Sender: TObject);
    procedure edtSenhaTyping(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ValidarCampo(const ACampo: TEdit; const ATipoCampo: TTipoCampo;
      const AFillRGB: TFillRGBEffect = nil);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{ TForm1 }

procedure TForm1.edtEmailTyping(Sender: TObject);
begin
  ValidarCampo(edtEmail, tcEmail, fillEmail);
end;

procedure TForm1.edtSenhaTyping(Sender: TObject);
begin
  ValidarCampo(edtSenha, tcSenha, fillSenha);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    edtEmail.TextSettings.FontColor := TAlphaColorRec.Black;
    edtSenha.TextSettings.FontColor := TAlphaColorRec.Black;
  {$ELSE}
    edtEmail.TextSettings.FontColor := TAlphaColorRec.White;
    edtSenha.FontColor := TAlphaColorRec.White;
  {$ENDIF}

  tbCtrl.TabPosition := TTabPosition.None;
  tbCtrl.ActiveTab   := tbiLogin;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  tbCtrl.Next;
end;

procedure TForm1.ValidarCampo(const ACampo: TEdit; const ATipoCampo: TTipoCampo;
  const AFillRGB: TFillRGBEffect);
begin
  case ATipoCampo of
    tcCPF   :
      begin
        if (TEdit(ACampo).Text.Equals(EmptyStr)) and (Assigned(AFillRGB)) then
          AFillRGB.Color := C_White
        else if TRegEx.IsMatch(TEdit(ACampo).Text, C_EXP_CPF) then
          AFillRGB.Color := C_CorGreen
        else
          AFillRGB.Color := C_CorRed
      end;
    tcEmail :
      begin
        if (TEdit(ACampo).Text.Equals(EmptyStr)) and (Assigned(AFillRGB)) then
          AFillRGB.Color := C_White
        else if TRegEx.IsMatch(TEdit(ACampo).Text, C_EXP_EMAIL) then
          AFillRGB.Color := C_CorGreen
        else
          AFillRGB.Color := C_CorRed
      end;
    tcSenha :
      begin
        if (TEdit(ACampo).Text.Equals(EmptyStr)) and (Assigned(AFillRGB)) then
          AFillRGB.Color := C_White
        else if ACampo.Text.Length > 4 then
          AFillRGB.Color := C_CorGreen
        else
          AFillRGB.Color := C_CorRed
      end;
  end;
end;

end.
