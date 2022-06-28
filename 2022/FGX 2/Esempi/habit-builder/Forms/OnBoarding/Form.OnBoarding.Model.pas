unit Form.OnBoarding.Model;

interface

uses
  System.Generics.Collections, FGX.Assets;

type
  TfgPageInfo = record
    Title: string;
    ImageName: TfgAssetName;
    constructor Create(const ATitle: string; const AImageName: TfgAssetName);
  end;

  TOnBoardingModel = class
  private
    FPages: TList<TfgPageInfo>;
    function GetPage(const AIndex: Integer): TfgPageInfo;
    function GetPagesCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    property Pages[const AIndex: Integer]: TfgPageInfo read GetPage;
    property PagesCount: Integer read GetPagesCount;
  end;

implementation

uses
  System.SysUtils, Assets.Consts;

{ TfgPageInfo }

constructor TfgPageInfo.Create(const ATitle: string; const AImageName: TfgAssetName);
begin
  Title := ATitle;
  ImageName := AImageName;
end;

{ TOnBoardingViewModel }

constructor TOnBoardingModel.Create;
begin
  FPages := TList<TfgPageInfo>.Create;

  FPages.Add(TfgPageInfo.Create('WELCOME TO Monumental habits', R.Bitmap.ILLUSTRATION_ON_BOARDING_01_ILLUSTRATION_1X));
  FPages.Add(TfgPageInfo.Create('CREATE NEW HABIT EASILY', R.Bitmap.ILLUSTRATION_ON_BOARDING_02_ILLUSTRATION_1X));
  FPages.Add(TfgPageInfo.Create('KEEP TRACK OF YOUR PROGRESS', R.Bitmap.ILLUSTRATION_ON_BOARDING_03_ILLUSTRATION_1X));
  FPages.Add(TfgPageInfo.Create('JOIN A SUPPORTIVE COMMUNITY', R.Bitmap.ILLUSTRATION_ON_BOARDING_04_ILLUSTRATION_1X));
end;

destructor TOnBoardingModel.Destroy;
begin
  FreeAndNil(FPages);
  inherited;
end;

function TOnBoardingModel.GetPage(const AIndex: Integer): TfgPageInfo;
begin
  Result := FPages[AIndex];
end;

function TOnBoardingModel.GetPagesCount: Integer;
begin
  Result := FPages.Count;
end;

end.
