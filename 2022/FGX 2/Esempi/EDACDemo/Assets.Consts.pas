{*********************************************************************
 *
 * This unit was generated automatically!
 *
 * DO NOT make changes to this file, as they will be lost after updating the assets in 
 * Project -> FGX Assets Manager.
 *
 * Use these constants instead of entering asset names in the code. This will help you catch
 * situation of assets changes (removing, renaming) in assets designer in compile time.
 *
 *********************************************************************}

unit Assets.Consts;

interface

{$SCOPEDENUMS ON}

type

  /// <summary>Identifiers with application assets.</summary>
  TfgAssetsConstants = record
  private type

    TfgBitmaps = record
    const
      MASK = 'Mask';
      MENU = 'menu';
    end;

    TfgFiles = record
    const
      DB_DEMODB = 'DB\DemoDB';
    end;

    TfgThemeColors = record
    const
      BACKGROUND = 'Theme\Background';
      ERROR = 'Theme\Error';
      ON_ERROR = 'Theme\On Error';
      ON_PRIMARY_DISABLED_TEXT = 'Theme\On Primary\Disabled Text';
      ON_PRIMARY_DIVIDERS = 'Theme\On Primary\Dividers';
      ON_PRIMARY_HINT_TEXT = 'Theme\On Primary\Hint Text';
      ON_PRIMARY_ICON = 'Theme\On Primary\Icon';
      ON_PRIMARY_SECONDARY_TEXT = 'Theme\On Primary\Secondary Text';
      ON_PRIMARY_TEXT = 'Theme\On Primary\Text';
      ON_SECONDARY_DISABLED_TEXT = 'Theme\On Secondary\Disabled Text';
      ON_SECONDARY_DIVIDERS = 'Theme\On Secondary\Dividers';
      ON_SECONDARY_HINT_TEXT = 'Theme\On Secondary\Hint Text';
      ON_SECONDARY_ICON = 'Theme\On Secondary\Icon';
      ON_SECONDARY_SECONDARY_TEXT = 'Theme\On Secondary\Secondary Text';
      ON_SECONDARY_TEXT = 'Theme\On Secondary\Text';
      PRIMARY_COLOR = 'Theme\Primary\Color';
      PRIMARY_DARK_PRIMARY = 'Theme\Primary\Dark Primary';
      PRIMARY_LIGHT_PRIMARY = 'Theme\Primary\Light Primary';
      SECONDARY_COLOR = 'Theme\Secondary\Color';
      SECONDARY_DARK_COLOR = 'Theme\Secondary\Dark Color';
      SECONDARY_LIGHT_COLOR = 'Theme\Secondary\Light Color';
      SURFACE = 'Theme\Surface';
      TEXT_DISABLED_TEXT = 'Theme\Text\Disabled Text';
      TEXT_DIVIDERS = 'Theme\Text\Dividers';
      TEXT_HINT_TEXT = 'Theme\Text\Hint Text';
      TEXT_ICON = 'Theme\Text\Icon';
      TEXT_SECONDARY_TEXT = 'Theme\Text\Secondary Text';
      TEXT_TEXT = 'Theme\Text\Text';
    end;

    TfgTheme = record
      /// <summary>Identifiers with theme colors assets.</summary>
      class var Color: TfgThemeColors;
    end;
  public
    /// <summary>Identifiers with bitmap assets.</summary>
    class var Bitmap: TfgBitmaps;

    /// <summary>Identifiers with custom user's files assets.</summary>
    class var Files: TfgFiles;

    /// <summary>Identifiers with theme assets.</summary>
    class var Theme: TfgTheme;
  end;

var
  R: TfgAssetsConstants;

implementation

end.
