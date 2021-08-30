#! /bin/sh
cd charts

for chart in $(ls -d */); do
  cd $chart;
  helm package .;
  cd ..
done

helm repo index .

for chart in $(find . -name "*.tgz" -type f); do s3cmd put $chart s3://blevesque-helm-charts/$(echo $chart | cut -c3-); done
s3cmd put index.yaml s3://blevesque-helm-charts

# cleanup
rm index.yaml
find . -name "*.tgz" -type f -delete

cd ..
