# Makefile
up:
	sudo sed -i '$$d' ~/.ssh/known_hosts
	terraform init
	terraform plan
	terraform apply -auto-approve
	terraform output -json > tf_output.json
	python3 terraform_inventory.py
	ansible-playbook -i inventory.ini install_docker.yaml 
	ansible-playbook -l server -i inventory.ini playbook_server.yaml 
	ansible-playbook -l agent -i inventory.ini playbook_agent.yaml --vault-password-file front
	