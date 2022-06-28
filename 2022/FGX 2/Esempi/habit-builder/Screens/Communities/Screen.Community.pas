unit Screen.Community;

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.Classes, FGX.Forms, FGX.Forms.Types, FGX.Controls, FGX.Controls.Types, FGX.Layout, 
  FGX.Layout.Types, Frame.Base, FGX.CollectionView, FGX.CardPanel, FGX.Image, FGX.StaticLabel, FGX.GraphicControl,
  FGX.Shape, FGX.Line, Screen.Base, FGX.Assets, System.Generics.Collections;

type
  TPost = record
    AvatarName: TfgAssetName;
    UserName: string;
    Time: string;
    Comment: string;
    Likes: string;
    Comments: string;
  end;

  TScreenCommunity = class(TScreenBase)
    cvPosts: TfgCollectionView;
    cvPosts_Styles: TfgCollectionViewStyles;
    cvPosts_Style1: TfgCollectionViewStyle;
    fgCardPanel1: TfgCardPanel;
    fgLayout1: TfgLayout;
    fgLine1: TfgLine;
    fgLabel1: TfgLabel;
    fgLayout2: TfgLayout;
    fgImage1: TfgImage;
    fgLayout3: TfgLayout;
    fgLabel2: TfgLabel;
    fgLabel3: TfgLabel;
    fgImage2: TfgImage;
    fgLabel4: TfgLabel;
    fgImage3: TfgImage;
    fgLabel5: TfgLabel;
    function cvPostsGetItemCount(Sender: TObject): Integer;
    procedure cvPostsBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
      const AItem: TfgItemWrapper);
  protected
    FPosts: TList<TPost>;
    function GetTitle: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetSafeAreaPaddings(const ATop, ABottom: Single); override;
  end;

var
  ScreenCommunity: TScreenCommunity;

implementation

{$R *.xfm}

uses
  System.SysUtils, System.Math, FGX.Application, FGX.Dialogs, FGX.Log, Assets.Consts;

constructor TScreenCommunity.Create(AOwner: TComponent);
const
  Avatars: array[1..4] of string = (R.Bitmap.AVATARS_28X28_01, R.Bitmap.AVATARS_28X28_02, R.Bitmap.AVATARS_28X28_03, R.Bitmap.AVATARS_28X28_04);
  UserNames: array[1..4] of string = ('Jerome', 'Gretchen', 'Al', 'Colin');
  Comments: array [1..4] of string = ('Man, you''re my new guru! Viewing the lessons for a second time. Thoroughly pleased. And impressed that you draw from scientific literature in telling memorable...',
                                      'I loved the course! I''ve been trying to break all this great stuff down into manageable chunks to help my clients develop healthy habits and achieve their personal... ',
                                      'This course contains the most complete material on habit formation that I''ve seen. There is just enough theory to explain the principles, and not so much...',
                                      'James Clear''s Habit''s Academy course has tremendously changed my life for the better! Having been a self improvement aficionado for decades...');

  function GeneratePost: TPost;
  begin
    Result.AvatarName := Avatars[RandomRange(1, 4)];
    Result.UserName := UserNames[RandomRange(1, 4)];
    Result.Time := Format('%dm ago', [Random(60)]);
    Result.Comment := Comments[RandomRange(1, 4)];
    Result.Likes := '3.1k';
    Result.Comments := Random(100).ToString;
  end;

var
  I: Integer;
begin
  inherited;
  FPosts := TList<TPost>.Create;
  for I := 1 to 20 do
    FPosts.Add(GeneratePost);
end;

procedure TScreenCommunity.cvPostsBindItem(Sender: TObject; const AIndex: Integer; const AStyle: string;
  const AItem: TfgItemWrapper);
var
  AvatarImage: TfgImage;
  UserNameLabel: TfgLabel;
  PostTimeLabel: TfgLabel;
  CommentLabel: TfgLabel;
  LikesLabel: TfgLabel;
  CommentsLabel: TfgLabel;
  Post: TPost;
begin
  inherited;
  Post := FPosts[AIndex];

  AvatarImage := AItem.GetControlByLookupName<TfgImage>('avatar');
  AvatarImage.ImageName := Post.AvatarName;

  UserNameLabel := AItem.GetControlByLookupName<TfgLabel>('username');
  UserNameLabel.Text := Post.UserName;

  PostTimeLabel := AItem.GetControlByLookupName<TfgLabel>('post-time');
  PostTimeLabel.Text := Post.Time;

  CommentLabel := AItem.GetControlByLookupName<TfgLabel>('comment');
  CommentLabel.Text := Post.Comment;

  LikesLabel := AItem.GetControlByLookupName<TfgLabel>('likes');
  LikesLabel.Text := Post.Likes;

  CommentsLabel := AItem.GetControlByLookupName<TfgLabel>('comments');
  CommentsLabel.Text := Post.Comments;
end;

function TScreenCommunity.cvPostsGetItemCount(Sender: TObject): Integer;
begin
  Result := FPosts.Count;
end;

destructor TScreenCommunity.Destroy;
begin
  FreeAndNil(FPosts);
  inherited;
end;

function TScreenCommunity.GetTitle: string;
begin
  Result := 'Community';
end;

procedure TScreenCommunity.SetSafeAreaPaddings(const ATop, ABottom: Single);
begin
  inherited;
  cvPosts.Padding.Top := ATop;
  cvPosts.Padding.Bottom := ABottom;
end;

end.
