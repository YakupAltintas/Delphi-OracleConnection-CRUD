unit formUpdateData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DataBase;

type
  TfrmUpdateData = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    editTC: TEdit;
    editAd: TEdit;
    editSoyad: TEdit;
    btnGuncelle: TButton;
    procedure btnGuncelleClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; tc, ad, soyad: string); reintroduce;
  end;

var
  frmUpdateData: TfrmUpdateData;
  db:            TDataBaseOracle;

implementation

{$R *.dfm}
{ TfrmUpdateData }

procedure TfrmUpdateData.btnGuncelleClick(Sender: TObject);
var
  sqlString: string;
begin
  try
    db.query.sql.Clear;
    sqlString :=
      'Update kullanicilar set ad = :ad, soyad = :soyad where tc = :tc ';
    db.query.sql.Text := sqlString;
    db.query.ParamByName('tc').AsWideString := editTC.Text;
    db.query.ParamByName('ad').AsWideString := editAd.Text;
    db.query.ParamByName('soyad').AsWideString := editSoyad.Text;
    db.query.ExecSQL;
    db.openDatabase;
    ShowMessage('Kayýt güncellendi');
    Close();
  except
    on ex: Exception do
      ShowMessage(ex.Message)
  end;

end;

constructor TfrmUpdateData.Create(AOwner: TComponent; tc, ad, soyad: string);
begin
  inherited Create(AOwner);
  editTC.Text := tc;
  editAd.Text := ad;
  editSoyad.Text := soyad;
  db := TDataBaseOracle.Create();

end;

end.
