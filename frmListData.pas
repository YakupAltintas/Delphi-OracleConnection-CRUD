unit frmListData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.FMTBcd, Data.SqlExpr, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, DataBase,
  formYeniKayit;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    editAd: TEdit;
    Label1: TLabel;
    editTC: TEdit;
    Label2: TLabel;
    editSoyad: TEdit;
    Label3: TLabel;
    btnInsertUser: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure alignColumnDatagrid;
    procedure btnInsertUserClick(Sender: TObject);
    procedure editTCChange(Sender: TObject);
    procedure listGrid;
    procedure searchInListGrid;
    procedure editAdChange(Sender: TObject);
    procedure editSoyadChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  DB:    TDataBaseOracle; // db nesnemizi tanimladik

implementation

{$R *.dfm}

procedure TForm1.btnInsertUserClick(Sender: TObject);
var
  formNewUser: TfrmYeniKayit;
begin
  try
    formNewUser := TfrmYeniKayit.Create(self);
    formNewUser.ShowModal; // form kapanana kadar kod devam etmez
    listGrid;

  except
    on ex: Exception do
      ShowMessage(ex.Message);
  end;

end;

procedure TForm1.editAdChange(Sender: TObject);
begin
  searchInListGrid;
end;

procedure TForm1.editSoyadChange(Sender: TObject);
begin
  searchInListGrid;
end;

procedure TForm1.editTCChange(Sender: TObject);
begin
  searchInListGrid;
end;

// datagrid kolonlarini static olarak hizalar
// veriler tabloya sigmiyorsa kullanabilirsin
procedure TForm1.alignColumnDatagrid;
var
  i: integer;
begin
  for i := 0 to DBGrid1.Columns.Count - 1 do // kolon geniþliði ayarlama
    DBGrid1.Columns[i].Width := 5 + DBGrid1.Canvas.TextWidth
      (DBGrid1.Columns[i].Title.Caption) + 50;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // veritabanini kapatip bellekten siler
  DB.closeDatabase;
  DB.Free; //

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // db nesnemizi olusturduk, listelenecek gridi verdik
  DB := TDataBaseOracle.Create(DBGrid1);
  listGrid;

end;

procedure TForm1.listGrid;
begin
  try
    DB.openDatabase;
    DB.query.SQL.Clear;
    DB.query.SQL.Text := 'Select * from kullanicilar';
    DB.query.Open();
  except
    on ex: Exception do
      ShowMessage(ex.Message + ex.StackTrace);
  end;
end;

procedure TForm1.searchInListGrid;
var
  sqlString: string;
begin
  try
    DB.openDatabase;
    DB.query.SQL.Clear;
    sqlString := 'select * from kullanicilar where 1 = 1';

    if editTC.Text <> '' then
      sqlString := sqlString + ' and lower(tc) LIKE lower(:tc)';
    if editAd.Text <> '' then
      sqlString := sqlString + '  and lower(ad) LIKE lower(:ad)';
    if editSoyad.Text <> '' then
      sqlString := sqlString + ' and lower(soyad) LIKE lower(:soyad)';

    DB.query.SQL.Text := sqlString;

    if editTC.Text <> '' then
      DB.query.ParamByName('tc').AsString := '%' + editTC.Text + '%';
    if editAd.Text <> '' then
      DB.query.ParamByName('ad').AsString := '%' + editAd.Text + '%';
    if editSoyad.Text <> '' then
      DB.query.ParamByName('soyad').AsString := '%' + editSoyad.Text + '%';
    DB.query.Open();


  except
    on ex: Exception do
      ShowMessage(ex.Message);
  end;

end;

end.
