program Project1;

uses
  Vcl.Forms,
  frmListData in 'frmListData.pas' {Form1},
  DataBase in 'DataBase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
