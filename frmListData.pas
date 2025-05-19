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
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, DataBase;
// baðlantý için gerekli

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure alignColumnDatagrid;
    procedure btnFillGridClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  DB:    DataBaseOracle; // db nesnemizi tanimladik

implementation

{$R *.dfm}

procedure TForm1.btnFillGridClick(Sender: TObject);

begin

end;

// datagrid kolonlarini static olarak hizalar
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
  DB := DataBaseOracle.Create(DBGrid1);
  try
    DB.openDatabase;
    DB.query.SQL.Text := 'Select * from kullanicilar';
    DB.query.Open();
    //alignColumnDatagrid;
  except
    on ex: Exception do
      ShowMessage(ex.Message + ex.StackTrace);
  end;

end;

end.
