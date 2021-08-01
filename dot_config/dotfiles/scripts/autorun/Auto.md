# Auto

## Google Drive Sync

A helpful link with more information can be found [here](https://www.howtogeek.com/451262/how-to-use-rclone-to-back-up-to-google-drive-on-linux/)

`gdrive_backup.sh` is a script that backups files of your Google Drive accounts locally to disk.

### Instructions

#### TL;DR

``` bash
rclone config
n
drive
[Enter]
[Enter]
1
[Enter]
[Enter]
[Enter]
[Enter]
y
[Enter]
>Login to Google Drive and authorize rclone
n
y
[Enter]
[q]
[Enter]
```

#### Steps

![rclone config](docs/4-4.webp "Rclone Config")
![new drive](docs/5-4.webp 'New Drive')
![config gdrive](docs/6-7.webp 'Configure Google Drive')
![select gdrive1](docs/7-5.webp 'Select Google Drive')
![select gdrive2](docs/8-5.webp 'Select Google Drive')
![config client_id](docs/9-4.webp 'Configure Client ID')
![config client_secret](docs/10-4.webp 'Configure Client Secret')
![config access](docs/11-2.webp 'Configure Rclone Access')
![config root_folder](docs/12-2.webp 'Configure root folder of Google Drive for Rclone')
![config service_account](docs/13-1.webp 'Configure Service Account for Unattended Backups')
![autoconfig](docs/15.webp 'Auto configure remote/headless machine')
![authorize rclone](docs/16-1.webp 'Login to Google Drive and Authorize Rclone')

There are more resources listed below that will help you get started setting up your own backups.

[Rclone Google Drive Docs](https://rclone.org/drive/ "Rclone Docs")
