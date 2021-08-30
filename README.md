# Helm Charts


## Available Charts

- [Fider](./charts/fider/README.md): self-hosted Product Feedback tool. https://getfider.com/


## Contribute

### Requirements
- [s3cmd](https://s3tools.org/s3cmd) installed and [configured](https://www.scaleway.com/en/docs/tutorials/s3cmd/) for the repository (hosted on a Scaleway Storage Bucket)

Sample configuration (`~/.s3cfg`)
```ini
[default]
access_key = ****
secret_key = ****
host_base = s3.fr-par.scw.cloud
host_bucket = %(bucket)s.s3.fr-par.scw.cloud
bucket_location = fr-par
use_https = True
```

### How to publish the charts
Add or edit a chart, then run `./scripts/publish.sh`.
