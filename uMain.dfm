object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 242
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar: TProgressBar
    Left = 48
    Top = 80
    Width = 385
    Height = 17
    TabOrder = 0
  end
  object Button1: TButton
    Left = 176
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Download'
    TabOrder = 1
    OnClick = Button1Click
  end
  object UrlDownload: TLabeledEdit
    Left = 56
    Top = 48
    Width = 409
    Height = 21
    EditLabel.Width = 60
    EditLabel.Height = 13
    EditLabel.Caption = 'UrlDownload'
    TabOrder = 2
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 352
    Top = 136
  end
end
