program Project1;

uses
  Vcl.Forms,
  frmListData in 'frmListData.pas' {Form1},
  DataBase in 'DataBase.pas',
  formYeniKayit in 'formYeniKayit.pas' {frmYeniKayit};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmYeniKayit, frmYeniKayit);
  Application.Run;
end.
