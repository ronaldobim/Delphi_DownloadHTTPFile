unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdHttp, IdComponent, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, IdBaseComponent, IdIOHandler, IdIOHandlerStream,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TForm4 = class(TForm)
    ProgressBar: TProgressBar;
    Button1: TButton;
    UrlDownload: TLabeledEdit;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;AWorkCountMax: Int64);
    procedure IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure IdHTTPREdirect(Sender: TObject; var dest: string; var NumRedirect: Integer; var Handled: boolean; var VMethod: TIdHTTPMethod);
  public
    { Public declarations }
    procedure DownloadFile;
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  DownloadFile;
end;

procedure TForm4.DownloadFile;
var
  IdHTTP1: TIdHTTP;
  Stream: TMemoryStream;
  Url, FileName: String;
begin
  Url := UrlDownload.Text;
  Filename := '.\downloaded_file';
  if FileExists(Filename) then
    DeleteFile(FileName);

  IdHTTP1 := TIdHTTP.Create(Self);
  Stream := TMemoryStream.Create;
  try
    IdHTTP1.OnWorkBegin := IdHTTPWorkBegin;
    IdHTTP1.OnWork := IdHTTPWork;
    IdHTTP1.AllowCookies := True;
    IdHTTP1.HandleRedirects := True;
    IdHTTP1.RedirectMaximum := 35;
    IdHTTP1.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
    IdHTTP1.Request.UserAgent :=
      'Mozilla/5.0 (Windows NT 5.1; rv:2.0b8) Gecko/20100101 Firefox/4.' +
      '0b8';
    IdHTTP1.HTTPOptions := [hoForceEncodeParams];
    IdHTTP1.OnRedirect := IdHTTPRedirect;
    //CookieManager := IdCookieManager1;

    IdHTTP1.Get(Url, Stream);
    Stream.SaveToFile(FileName);
  finally
    Stream.Free;
    IdHTTP1.Free;
  end;
end;

procedure TForm4.IdHTTPREdirect(Sender: TObject; var dest: string;
  var NumRedirect: Integer; var Handled: boolean; var VMethod: TIdHTTPMethod);
begin
  Handled := True;
end;

procedure TForm4.IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  ProgressBar.Position := AWorkCount;
  Application.ProcessMessages;
end;

procedure TForm4.IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  ProgressBar.Max := AWorkCountMax;
  ProgressBar.Position := 0;
  Application.ProcessMessages;
end;


end.
