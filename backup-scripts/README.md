Some scripts that you can use during operation of this app to maintain backups.

## `db-backup.sh`
The only prerequisites is that [awscli](https://github.com/aws/aws-cli) is installed and configured for the user that will run this job. See below for a minimal IAM policy to use.

This script will:
 1. create a database dump
 1. see if the size has changed (a rough metric) from the previous dump
 1. if so, push a new version to an S3 bucket
 1. sync all the extract files

Ideally you'd install it into the `ubuntu` user's crontab with something like:
```
12 * * * * /bin/bash /home/ubuntu/db-backup.sh some-s3-bucket >> /home/ubuntu/db-backup.sh.log 2>&1
```
...and remember to replace `some-s3-bucket` with your bucket name.


### AWS IAM policy for the backup user

The script will run with the following AWS IAM policy:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectVersionTagging"
            ],
            "Resource": "arn:aws:s3:::some-s3-bucket/*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::some-s3-bucket"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": "s3:ListObjects",
            "Resource": "*"
        }
    ]
}
```
Again, remember to replace `some-s3-bucket` with your bucket name.
