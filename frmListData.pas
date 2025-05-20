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
  formInsertData, formUpdateData;

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
    procedure btnInsertUserClick(Sender: TObject);
    procedure editTCChange(Sender: TObject);
    procedure editAdChange(Sender: TObject);
    procedure editSoyadChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    // gride listeyi getirir
    procedure listGrid;
    // tc, ad, soyad kýsýmlarýnýn herhangi biri ile özel arama yapar
    procedure searchInListGrid;
    // kolonun geniþlik ayaramasýný manuel yapar
    procedure alignColumnDatagrid(width: integer);

    procedure deleteData(tc,ad,soyad: string);

  public

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

procedure TForm1.DBGrid1CellClick(Column: TColumn);
var
  tc,ad,soyad:  string;
begin
  // tikladigim satirin kolonu sil ise asagidaki islemleri yap
  if Column.Title.Caption = 'Sil' then
    begin
      // 1. kolonu tc degiskenine aktar
      tc := DB.datasource.DataSet.Fields[0].AsString;
      ad := DB.datasource.DataSet.Fields[1].AsString;
      soyad := DB.datasource.DataSet.Fields[2].AsString;
      deleteData(tc,ad,soyad);

    end;
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
var
  formUpdate: TfrmUpdateData;
  tc:         string;
  ad:         string;
  soyad:      string;
begin
  tc := DB.datasource.DataSet.Fields[0].AsString;
  ad := DB.datasource.DataSet.Fields[1].AsString;
  soyad := DB.datasource.DataSet.Fields[2].AsString;

  formUpdate := TfrmUpdateData.Create(self, tc, ad, soyad);
  formUpdate.ShowModal;
  listGrid;

end;

procedure TForm1.deleteData(tc,ad,soyad: string);
var
  sqlString: string;
begin
  if MessageDlg(ad+ ' '+soyad+' kaydýný silmek istediðinize emin misin?', mtConfirmation,
    [TMsgDlgBtn.mbYes, mbNo], 0) = mrYes then
    begin
      try
        sqlString := 'Delete from kullanicilar where tc = :tc';
        DB.openDatabase;
        DB.query.sql.Clear;
        DB.query.sql.Text := sqlString;
        DB.query.ParamByName('tc').AsString := tc;
        DB.query.ExecSQL;
        ShowMessage('Kayýt silindi!');
        listGrid;

      except
        on ex: Exception do
          ShowMessage(ex.Message);
      end;
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
procedure TForm1.alignColumnDatagrid(width: integer);
var
  i: integer;
begin
  for i := 0 to DBGrid1.Columns.Count - 1 do // kolon geniþliði ayarlama
    DBGrid1.Columns[i].width := 5 + DBGrid1.Canvas.TextWidth
      (DBGrid1.Columns[i].Title.Caption) + width;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // veritabanini kapatip bellekten siler
  DB.closeDatabase;
  DB.Free;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // db nesnemizi olusturduk, listelenecek gridi verdik
  DB := TDataBaseOracle.Create(DBGrid1);
  listGrid;

end;

procedure TForm1.listGrid;
var
  i:          Integer;
  fieldCount: Integer;
begin
  try

    DBGrid1.Columns.Clear;
    DB.openDatabase;

    DB.query.sql.Clear;
    DB.query.sql.Text := 'Select * from kullanicilar';
    DB.query.Open();

    DBGrid1.Columns.Clear;

    // Tüm alanlarý otomatik olarak kolona çevir
    fieldCount := DB.query.fieldCount;
    for i := 0 to fieldCount - 1 do
      begin
        with DBGrid1.Columns.Add do
          begin
            FieldName := DB.query.Fields[i].FieldName;
            Title.Caption := DB.query.Fields[i].DisplayName;
            width := 150;
          end;
      end;

    // En sona manuel "Sil" kolonu ekle
    with DBGrid1.Columns.Add do
      begin
        Title.Caption := 'Sil';
        width := 50;

      end;

  except
    on ex: Exception do
      ShowMessage(ex.Message);
  end;
end;

procedure TForm1.searchInListGrid;
var
  sqlString: string;
begin
  try
    DB.openDatabase;
    DB.query.sql.Clear;
    sqlString := 'select * from kullanicilar where 1 = 1';

    if editTC.Text <> '' then
      sqlString := sqlString + ' and lower(tc) LIKE lower(:tc)';
    if editAd.Text <> '' then
      sqlString := sqlString + '  and lower(ad) LIKE lower(:ad)';
    if editSoyad.Text <> '' then
      sqlString := sqlString + ' and lower(soyad) LIKE lower(:soyad)';

    DB.query.sql.Text := sqlString;

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
