program Project1;

uses
  Vcl.Forms,
  frmListData in 'frmListData.pas' {Form1},
  DataBase in 'DataBase.pas',
  formInsertData in 'formInsertData.pas' {frmYeniKayit},
  formUpdateData in 'formUpdateData.pas' {frmUpdateData};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmYeniKayit, frmYeniKayit);
  Application.CreateForm(TfrmUpdateData, frmUpdateData);
  Application.Run;
end.
