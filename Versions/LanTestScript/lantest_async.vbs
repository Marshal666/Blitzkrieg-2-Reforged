Set objEmail = CreateObject("CDO.Message") 
objEmail.From = "game@yourserver.com"
objEmail.To = "admin@yourserver.com"
objEmail.Subject = "������ ����: ASYNC!!" 
objEmail.Textbody = "��������� �����. ����� ����������� � YOUR_TEMP_PATH\LanTest"
objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 
objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "YOUR_SMTP_SERVER" 
objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
objEmail.Configuration.Fields.Update
objEmail.Send
