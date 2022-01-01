git clone git@github.com:csLinhart/udacity-azure-2.git
cd udacity-azure-2
make all
az webapp up -n flask-ml-service-cl-udacity -l southcentralus --sku B1
chmod +x make_predict_azure_app.sh && ./make_predict_azure_app.sh
az webapp log tail -g lohner.csl_rg_0179 -n flask-ml-service-CL-udacity
az group delete -n lohner.csl_rg_0179