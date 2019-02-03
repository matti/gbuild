#!/usr/bin/env sh
set -e
set -x

cd e2e/simple
  ../../exe/gbuild --debug gcr.io/$GCLOUD_PROJECT/simple
cd ../..

exe/gbuild --debug gcr.io/$GCLOUD_PROJECT/build_args --context e2e/simple --timeout 1

exe/gbuild --debug gcr.io/$GCLOUD_PROJECT/build_args --context e2e/build_args

exe/gbuild --debug gcr.io/$GCLOUD_PROJECT/custom_dockerfile --context e2e/custom_dockerfile --dockerfile Dockerfile.custom
exe/gbuild --debug gcr.io/$GCLOUD_PROJECT/nested_dockerfile --context e2e/nested_dockerfile --dockerfile subdir/Dockerfile

exe/gbuild delete gcr.io/$GCLOUD_PROJECT/simple
exe/gbuild delete gcr.io/$GCLOUD_PROJECT/build_args
exe/gbuild delete gcr.io/$GCLOUD_PROJECT/custom_dockerfile
exe/gbuild delete gcr.io/$GCLOUD_PROJECT/nested_dockerfile

exe/gbuild clean $GCLOUD_PROJECT
