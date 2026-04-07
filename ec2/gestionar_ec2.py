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

def detener_instancia(ec2, instance_id):
    ec2.stop_instances(InstanceIds=[instance_id])
    print(f"Deteniendo instancia {instance_id}")

def terminar_instancia(ec2, instance_id):
    ec2.terminate_instances(InstanceIds=[instance_id])
    print(f"Terminando instancia {instance_id}")

def main():
    if len(sys.argv) < 2:
        print("Uso: python gestionar_ec2.py <accion> [instance_id]")
        sys.exit(1)

    accion = sys.argv[1]
    ec2 = boto3.client('ec2')

    if accion == "listar":
        listar_instancias(ec2)

    elif accion in ["iniciar", "detener", "terminar"]:
        if len(sys.argv) < 3:
            print("Falta instance_id")
            sys.exit(1)

        instance_id = sys.argv[2]

        if accion == "iniciar":
            iniciar_instancia(ec2, instance_id)
        elif accion == "detener":
            detener_instancia(ec2, instance_id)
        elif accion == "terminar":
            terminar_instancia(ec2, instance_id)
    else:
        print("Acción no válida")

if __name__ == "__main__":
    main()
