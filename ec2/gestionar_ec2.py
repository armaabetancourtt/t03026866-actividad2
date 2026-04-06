import boto3
import sys

def listar_instancias(ec2):
    response = ec2.describe_instances()
    for reserva in response['Reservations']:
        for instancia in reserva['Instances']:
            print(f"ID: {instancia['InstanceId']} | Estado: {instancia['State']['Name']}")

def main():
    if len(sys.argv) < 2:
        print("Uso: python gestionar_ec2.py <accion> [instance_id]")
        sys.exit(1)

    accion = sys.argv[1]
    ec2 = boto3.client('ec2')

    if accion == "listar":
        listar_instancias(ec2)

if __name__ == "__main__":
    main()
