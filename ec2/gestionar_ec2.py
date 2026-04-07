import boto3
import sys

def listar_instancias(ec2):
    response = ec2.describe_instances()
    for reserva in response['Reservations']:
        for instancia in reserva['Instances']:
            print(f"ID: {instancia['InstanceId']} | Estado: {instancia['State']['Name']}")

def iniciar_instancia(ec2, instance_id):
    ec2.start_instances(InstanceIds=[instance_id])
    print(f"Iniciando instancia {instance_id}")

def main():
    if len(sys.argv) < 2:
        print("Uso: python gestionar_ec2.py <accion> [instance_id]")
        sys.exit(1)

    accion = sys.argv[1]
    ec2 = boto3.client('ec2')

    if accion == "listar":
        listar_instancias(ec2)
    elif accion == "iniciar":
        instance_id = sys.argv[2]
        iniciar_instancia(ec2, instance_id)

if __name__ == "__main__":
    main()
