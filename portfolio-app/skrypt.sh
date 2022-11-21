pushd portfolio-helm
NAME=$1 yq -i '.image.tag = strenv(NAME)' ./threetier/values.yaml
NAME=$1 yq -i '.image.tag = strenv(NAME)' ./threetier/charts/backend-helm/values.yaml

git add .
git commit -m "Added version $1"
git push https://maciob:$2@github.com/Maciob/portfolio-helm
#
popd