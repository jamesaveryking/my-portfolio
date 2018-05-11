import boto3
s3 = boto3.resource('s3')
portfolio_bucket = s3.Bucket('portfolio.jamesaveryking.com')
for obj in portfolio_bucket.objects.all():
     print (obj.key)
portfolio_bucket.download_file('index.html', '/tmp/index.html')
build_bucket = s3.Bucket('portfoliobuild.jamesaveryking.com')
build_bucket.download_file('portfoliobuild.zip', '/tmp/portfoliobuild.zip')
from io import StringIO
portfolio_zip = io.BytesIO()
build_bucket.download_fileobj('portfoliobuild.zip', portfolio_zip)
import zipfile
with zipfile.ZipFile(portfolio_zip) as myzip:
    for nm in myzip.namelist():
        print (nm)
