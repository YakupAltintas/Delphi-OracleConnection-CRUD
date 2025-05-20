unit formInsertData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DataBase;

type
  TfrmYeniKayit = class(TForm)
    Label1: TLabel;
    editTC: TEdit;
    Label2: TLabel;
    editAd: TEdit;
    Label3: TLabel;
    editSoyad: TEdit;
    btnKaydet: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmYeniKayit: TfrmYeniKayit;
  db:           TDataBaseOracle;

implementation

{$R *.dfm}

procedure TfrmYeniKayit.btnKaydetClick(Sender: TObject);
begin
  try
     db.query.sql.Clear;
  db.query.sql.Text :=
    'INSERT INTO kullanicilar (tc,ad,soyad) VALUES (:tc,:ad,:soyad)';
  db.query.ParamByName('tc').AsWideString := editTC.Text;
  db.query.ParamByName('ad').AsWideString := editAd.Text;
  db.query.ParamByName('soyad').AsWideString := editSoyad.Text;
  db.query.ExecSQL;
  ShowMessage('Kayit eklendi!');
  except on ex: Exception do
     ShowMessage('Ekleme Baþarýsýz!');
  end;

end;

procedure TfrmYeniKayit.FormCreate(Sender: TObject);
begin
  db := TDataBaseOracle.Create;
end;

end.
