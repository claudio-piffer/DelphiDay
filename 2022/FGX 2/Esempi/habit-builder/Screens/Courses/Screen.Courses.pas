unit Screen.Courses;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Frame.Base, FGX.Button.Types, FGX.Button, FGX.StaticLabel, FGX.Image, FGX.CollectionView,
  FGX.CardPanel, Screen.Base, Assets.Consts;

type
  TScreenCourses = class(TScreenBase)
    fgCardPanel1: TfgCardPanel;
    cvCourses: TfgCollectionView;
    cvCourses_Styles: TfgCollectionViewStyles;
    StyleCourse: TfgCollectionViewStyle;
    fgCardPanel2: TfgCardPanel;
    fgImage1: TfgImage;
    fgLabel1: TfgLabel;
    fgLayout1: TfgLayout;
    fgLabel2: TfgLabel;
    fgLabel3: TfgLabel;
    fgButton1: TfgButton;
    fgImage2: TfgImage;
    lQuote: TfgLabel;
    fgLabel4: TfgLabel;
    StyleBanner: TfgCollectionViewStyle;
    function cvCoursesGetItemCount(Sender: TObject): Integer;
    function cvCoursesGetItemStyle(Sender: TObject; const AIndex: Integer): string;
    procedure cvCoursesBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
  protected
    function GetTitle: string; override;
  public
    procedure SetSafeAreaPaddings(const ATop, ABottom: Single); override;
  end;

var
  ScreenCourses: TScreenCourses;

implementation

{$R *.xfm}

uses
  System.SysUtils, FGX.Application, FGX.Dialogs, FGX.Log;

procedure TScreenCourses.cvCoursesBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
var
  PreviewImage: TfgImage;
  TitleLabel: TfgLabel;
  DurationLabel: TfgLabel;
  CountLabel: TfgLabel;
begin
  if AIndex = 0 then
    Exit;

  PreviewImage := AItem.GetControlByLookupName<TfgImage>('preview');
  TitleLabel := AItem.GetControlByLookupName<TfgLabel>('title');
  DurationLabel := AItem.GetControlByLookupName<TfgLabel>('duration');
  CountLabel := AItem.GetControlByLookupName<TfgLabel>('count');

  if Random(100) > 50 then
  begin
    PreviewImage.ImageName := R.Bitmap.PHOTOS_COURSES_01_COURSE_PREVIEW;
    TitleLabel.Text := '30 Day Journal Challenge - Establish a Habit of Daily Journaling';
    DurationLabel.Text := '2h 41m';
    CountLabel.Text := '37 Lessons';
  end
  else
  begin
    PreviewImage.ImageName := R.Bitmap.PHOTOS_COURSES_02_COURSE_PREVIEW;
    TitleLabel.Text := 'Self Help Series: How to Create and Maintain Good Habits';
    DurationLabel.Text := '4h 6m';
    CountLabel.Text := '24 Lessons';
  end;
end;

function TScreenCourses.cvCoursesGetItemCount(Sender: TObject): Integer;
begin
  Result := 10;
end;

function TScreenCourses.cvCoursesGetItemStyle(Sender: TObject; const AIndex: Integer): string;
begin
  inherited;
  if AIndex = 0 then
    Result := StyleBanner.StyleName
  else
    Result := StyleCourse.StyleName;
end;

function TScreenCourses.GetTitle: string;
begin
  Result := 'Courses';
end;

procedure TScreenCourses.SetSafeAreaPaddings(const ATop, ABottom: Single);
begin
  cvCourses.Padding.Top := ATop;
  cvCourses.Padding.Bottom := ABottom;
end;

end.
