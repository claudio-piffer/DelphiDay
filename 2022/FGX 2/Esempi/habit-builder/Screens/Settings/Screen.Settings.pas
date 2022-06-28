unit Screen.Settings;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Screen.Base, FGX.StaticLabel, FGX.Image, FGX.CardPanel, FGX.ScrollBox, FGX.Button.Types, FGX.Button;

type
  TScreenSettings = class(TScreenBase)
    sbContent: TfgVerticalScrollBox;
    cpQuoteBanner: TfgCardPanel;
    imgIllustration: TfgImage;
    lQuote: TfgLabel;
    lQuoteAuthor: TfgLabel;
    btnGetStarted: TfgButton;
    lHabitTitle: TfgLabel;
    fgCardPanel1: TfgCardPanel;
    fgImage1: TfgImage;
    fgLayout1: TfgLayout;
    fgButton1: TfgButton;
    fgLabel1: TfgLabel;
    fgLabel2: TfgLabel;
    fgCardPanel2: TfgCardPanel;
    fgImage2: TfgImage;
    fgLayout2: TfgLayout;
    fgLabel3: TfgLabel;
    fgLabel4: TfgLabel;
    fgButton2: TfgButton;
    fgLabel5: TfgLabel;
    fgCardPanel3: TfgCardPanel;
    fgImage3: TfgImage;
    fgLabel6: TfgLabel;
    fgButton3: TfgButton;
    fgCardPanel4: TfgCardPanel;
    fgImage4: TfgImage;
    fgLabel7: TfgLabel;
    fgButton4: TfgButton;
    fgCardPanel5: TfgCardPanel;
    fgImage5: TfgImage;
    fgLabel8: TfgLabel;
    fgButton5: TfgButton;
    fgCardPanel6: TfgCardPanel;
    fgImage6: TfgImage;
    fgLabel9: TfgLabel;
    fgButton6: TfgButton;
  protected
    function GetTitle: string; override;
  public
    procedure SetSafeAreaPaddings(const ATop, ABottom: Single); override;
  end;

var
  ScreenSettings: TScreenSettings;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log;

{ TScreenSettings }

function TScreenSettings.GetTitle: string;
begin
  Result := 'Settings';
end;

procedure TScreenSettings.SetSafeAreaPaddings(const ATop, ABottom: Single);
begin
  inherited;
  sbContent.Padding.Top := ATop;
  sbContent.Padding.Bottom := ABottom;
end;

end.
