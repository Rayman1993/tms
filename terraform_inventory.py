import json

# Загружаем данные из JSON-файла
with open('tf_output.json', 'r') as f:
    data = json.load(f)

# Извлекаем адреса сервера и агента
server_ip = data['server_instance_public_ip']['value']
agent_ip = data['agent_instance_public_ip']['value']

# Создание файла inventory
with open('inventory.ini', 'w') as f:
    f.write('[all]\n')
    f.write(f"server ansible_host={server_ip}\n")
    f.write(f"agent ansible_host={agent_ip}\n")

# Создание файла casc
with open('./copy/casc.yaml', 'w') as f:
    f.write('---\n')
    f.write('unclassified:\n')
    f.write('location:\n')
    f.write(f'url: http://{server_ip}:8080/\n')