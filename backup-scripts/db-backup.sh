#!/usr/bin/env bash
# database backup job, pushes to a versioned S3 bucket
set -e
if [ $# -ne 1 ]; then
  echo "[ERROR] pass the S3 bucket as the first param"
  echo "usage: $0 <s3 bucket name>"
  echo "   eg: $0 some-bucket"
  exit 1
fi

bucket=s3://$1
the_dir=/tmp/db-backup
dump_file=$the_dir/soils2sat.dump
db_name=soils2sat
extracts_dir=/mnt/data/soils2sat/extracts/
unique_id=`date +%Y%m%d_%H%M`

mkdir -p $the_dir
cd $the_dir
sudo chgrp -R postgres .
sudo chmod -R g+rw .
if [ ! -f $dump_file ]; then
  touch $dump_file
fi
old=$dump_file.old
mv $dump_file $old
old_size=`bash -c "du -b $old | cut -f1"`
sudo su -c "pg_dump -Fc -f $dump_file $db_name" postgres
sudo chown `id -un` $dump_file
new_size=`bash -c "du -b $dump_file | cut -f1"`
if [ $old_size -eq $new_size ]; then
  echo "[$unique_id] no change to DB, exiting"
  exit 0
fi
echo "[$unique_id] changes detected, performing backup"
sudo ntpdate-debian
/usr/local/bin/aws s3 cp $dump_file $bucket/

cd $extracts_dir
/usr/local/bin/aws s3 sync . $bucket/extracts/
