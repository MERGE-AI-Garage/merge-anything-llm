# Variables
PROJECT_ID = test-anythingllm
IMAGE_NAME = merge-anythingllm
IMAGE_TAG = latest
DEPLOYMENT_NAME = anything-llm-deployment
CONFIG_FILE = cloud-deployments/gcp/deployment/gcp_deploy_anything_llm.yaml
FULL_IMAGE = gcr.io/$(PROJECT_ID)/$(IMAGE_NAME):$(IMAGE_TAG)

# run $make deploy-anythingllm
.PHONY: deploy-anythingllm
deploy-anythingllm:
	@echo "🏗️  Building Docker image..."
	docker build -t $(FULL_IMAGE) -f docker/Dockerfile .
	@echo "📤 Pushing to Google Container Registry..."
	docker push $(FULL_IMAGE)
	@echo "🚀 Updating GCP deployment..."
	gcloud deployment-manager deployments update $(DEPLOYMENT_NAME) --config $(CONFIG_FILE)
	@echo "✅ Deployment complete!"